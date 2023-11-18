// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import "./ERC20SmartContract.sol";
import "./ERC721SmartContract.sol";
import "./ERC1155SmartContract.sol";

contract PlayerRegistration {
    GoldCoin private goldCoinContract;
    UniqueCards private cardsContract;
    GameItems private itemsContract;

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
            ) % 10) + 1;
    }

    function registerPlayer(address playerAddress) public {
        // Mint ERC20 tokens to the player
        goldCoinContract.mint(playerAddress, 1000 * 10 ** 18); // Minting 1000 GoldCoins

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
            cardsContract.transferFrom(address(this), playerAddress, newCardId);
        }

        // Check if the player has purchased a power-up and assign it
        if (itemsContract.hasPowerUp(playerAddress)) {
            uint256 powerUpItemId = 1; // Assuming 1 is the ID for the power-up
            itemsContract.mintItem(playerAddress, powerUpItemId, 1); // Mint one power-up
            itemsContract.usePowerUp(playerAddress); // Indicate the power-up is used
        }
    }
}
