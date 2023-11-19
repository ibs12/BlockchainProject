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

    function registerPlayer() public {
        // Loop to create and assign 5 unique cards to the player
        for (uint256 i = 0; i < 5; i++) {
            uint256 attack = pseudoRandom();
            uint256 defense = pseudoRandom();

            // Create a new ERC721 card with random attack and defense
            uint256 newCardId = cardsContract.createUniqueCard(
                "Starter Card",
                "This is a starter card for new players",
                attack,
                defense
            );

            // Transfer the newly created card to the player
            cardsContract.transferFrom(address(this), msg.sender, newCardId);
        }

        // Check if the player has purchased a power-up and assign it
        // if (itemsContract.hasPowerUp(msg.sender)) {
        //     uint256 powerUpItemId = 1; // Assuming 1 is the ID for the power-up
        //     itemsContract.mintItem(msg.sender, powerUpItemId, 1); // Mint one power-up
        //     itemsContract.usePowerUp(msg.sender); // Indicate the power-up is used
        // }
    }

    function startGame(address player1, address player2) external {
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
            // Card is defeated, burn the defender's card
            cardsContract.burnCard(defenderCardId);
        }
    }
}
