// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import "./ERC20SmartContract.sol";
import "./ERC721SmartContract.sol";
import "./ERC1155SmartContract.sol";

contract PlayerRegistration {
    GoldCoin private goldCoinContract;
    UniqueCards private cardsContract;
    GameItems private itemsContract;

    // Define a structure to represent a game
    struct Game {
        address player1;
        address player2;
        uint256 betAmount;
        bool isActive;
    }
    struct PlayerCardDetails {
        uint256 cardId;
        uint256 attack;
        uint256 defense;
    }

    // Mapping to store ongoing games
    mapping(uint256 => Game) public games;
    uint256 public nextGameId;

    // Mapping to store player bets
    mapping(address => uint256) public playerBets;

    constructor(
        address _goldCoinAddress,
        address _cardsAddress,
        address _itemsAddress
    ) {
        goldCoinContract = GoldCoin(_goldCoinAddress);
        cardsContract = UniqueCards(_cardsAddress);
        itemsContract = GameItems(_itemsAddress);
    }

    event PlayerRegistered(address player);
    event GameStarted(
        uint256 gameId,
        address player1,
        address player2,
        uint256 betAmount
    );
    event CardAttack(
        uint256 gameId,
        uint256 attackerCardId,
        uint256 defenderCardId,
        bool defenderDefeated
    );
    event GameEnded(uint256 gameId, address winner);

    function pseudoRandom() private view returns (uint) {
        return
            (uint(
                keccak256(
                    abi.encodePacked(
                        block.timestamp,
                        block.prevrandao,
                        msg.sender
                    )
                )
            ) % 15) + 1;
    }

    struct Player {
        address playerAddress;
        uint256[] cardIds; // Array of owned card IDs
    }

    mapping(address => Player) public players;

    address[] public allPlayers;

    function registerPlayer(address currPlayer) public {
        Player storage player = players[currPlayer];

        // Check if the player is already registered
        if (player.playerAddress == address(0)) {
            player.playerAddress = currPlayer;
            allPlayers.push(currPlayer); // Add new player to the array

            // Assign 5 unique cards to the player
            for (uint256 i = 0; i < 5; i++) {
                uint256 attack = pseudoRandom();
                uint256 defense = pseudoRandom();
                uint256 newCardId = cardsContract.createUniqueCard(
                    "Starter Card",
                    "This is a starter card for new players",
                    attack,
                    defense
                );
                cardsContract.transferFrom(
                    address(this),
                    currPlayer,
                    newCardId
                );
                player.cardIds.push(newCardId); // Add new card ID to the player's card list
            }
            emit PlayerRegistered(currPlayer);
        }
    }

    // Function to get a player's card IDs
    function getPlayerCards(
        address playerAddress
    ) public view returns (uint256[] memory) {
        return players[playerAddress].cardIds;
    }

    function getAllPlayers() public view returns (address[] memory) {
        return allPlayers;
    }

    function startGame(address player1, address player2) external {
        // Mark all player cards as active
        for (uint256 i = 0; i < getPlayerCards(player1).length; i++) {
            activeCards[getPlayerCards(player1)[i]] = true;
        }
        for (uint256 i = 0; i < getPlayerCards(player2).length; i++) {
            activeCards[getPlayerCards(player2)[i]] = true;
        }
        uint256 betAmount = 100 * 10 ** 18; // 100 GoldCoins

        // Ensure both players have sufficient balance and have consented
        require(
            goldCoinContract.balanceOf(player1) >= betAmount,
            "Player 1 has insufficient balance"
        );
        require(
            goldCoinContract.balanceOf(player2) >= betAmount,
            "Player 2 has insufficient balance"
        );

        // Transfer coins to the contract as a bet
        goldCoinContract.transferFrom(player1, address(this), betAmount);
        goldCoinContract.transferFrom(player2, address(this), betAmount);

        // Record the bet for each player
        playerBets[player1] += betAmount;
        playerBets[player2] += betAmount;

        // Create a new game instance
        games[nextGameId] = Game({
            player1: player1,
            player2: player2,
            betAmount: betAmount,
            isActive: true
        });

        nextGameId++; // Increment the game ID for the next game
        emit GameStarted(nextGameId, player1, player2, betAmount);
    }

    mapping(uint256 => bool) public activeCards;

    function isPlayerDefeated(address player) private view returns (bool) {
        Player memory playerData = players[player];
        for (uint256 i = 0; i < playerData.cardIds.length; i++) {
            if (activeCards[playerData.cardIds[i]]) {
                return false; // Player still has active cards
            }
        }
        return true; // All cards are defeated
    }

    function attackCard(
        uint256 gameId,
        uint256 attackerCardId,
        uint256 defenderCardId
    ) external {
        Game storage game = games[gameId];
        require(game.isActive, "Game is not active");

        // Check if the player owns the attacking card
        require(
            cardsContract.ownerOf(attackerCardId) == msg.sender,
            "Not the owner of the attacking card"
        );

        // Fetch card details
        (uint256 attackerAttack, ) = cardsContract.getCardAttributes(
            attackerCardId
        );
        (, uint256 defenderDefense) = cardsContract.getCardAttributes(
            defenderCardId
        );

        // Apply attack logic
        if (defenderDefense > attackerAttack) {
            uint256 newDefense = defenderDefense - attackerAttack;
            cardsContract.updateCardDefense(defenderCardId, newDefense);
        } else {
            // Card is defeated, mark it as inactive
            activeCards[defenderCardId] = false;
        }

        bool defenderDefeated = !activeCards[defenderCardId];
        emit CardAttack(
            gameId,
            attackerCardId,
            defenderCardId,
            defenderDefeated
        );

        // Check if either player has been defeated
        if (isPlayerDefeated(game.player2)) {
            endGame(gameId, game.player1); // Player 1 wins
        } else if (isPlayerDefeated(game.player1)) {
            endGame(gameId, game.player2); // Player 2 wins
        }
    }

    function endGame(uint256 gameId, address winner) private {
        Game storage game = games[gameId];
        uint256 totalBet = game.betAmount * 2;
        goldCoinContract.transfer(winner, totalBet); // Award the winner

        // Burn cards for both players
        burnPlayerCards(game.player1);
        burnPlayerCards(game.player2);

        // Reset game state
        game.isActive = false;
        playerBets[game.player1] = 0;
        playerBets[game.player2] = 0;

        emit GameEnded(gameId, winner);
    }

    function burnPlayerCards(address player) private {
        Player storage playerData = players[player];
        for (uint256 i = 0; i < playerData.cardIds.length; i++) {
            uint256 cardId = playerData.cardIds[i];
            if (cardsContract.ownerOf(cardId) == player) {
                cardsContract.burnCard(cardId);
            }
        }
        delete players[player].cardIds; // Clear the player's card array
    }

    function getPlayerCardDetails(
        address playerAddress
    ) public view returns (PlayerCardDetails[] memory) {
        uint256[] memory cardIds = players[playerAddress].cardIds;
        PlayerCardDetails[] memory details = new PlayerCardDetails[](
            cardIds.length
        );

        for (uint256 i = 0; i < cardIds.length; i++) {
            (uint256 attack, uint256 defense) = cardsContract.getCardAttributes(
                cardIds[i]
            );
            details[i] = PlayerCardDetails({
                cardId: cardIds[i],
                attack: attack,
                defense: defense
            });
        }

        return details;
    }
}
