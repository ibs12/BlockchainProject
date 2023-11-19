// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import "@openzeppelin/contracts/access/AccessControl.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

contract UniqueCards is ERC721Enumerable, AccessControl, Ownable {
    address private PlayerRegistration;
    bytes32 public constant CARD_CREATOR_ROLE = keccak256("CARD_CREATOR_ROLE");
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;

    function supportsInterface(
        bytes4 interfaceId
    ) public view override(ERC721Enumerable, AccessControl) returns (bool) {
        return
            ERC721Enumerable.supportsInterface(interfaceId) ||
            AccessControl.supportsInterface(interfaceId);
    }

    struct Card {
        uint256 id;
        string name;
        string description;
        uint256 attack;
        uint256 defense;
    }

    mapping(uint256 => Card) public cards;

    constructor(address playerRegistrationAddress) ERC721("UniqueCards", "UC") {
        _setupRole(CARD_CREATOR_ROLE, playerRegistrationAddress);
    }

    function createUniqueCard(
        string memory name,
        string memory description,
        uint256 attack,
        uint256 defense
    ) external onlyRole(CARD_CREATOR_ROLE) returns (uint256) {
        _tokenIds.increment();
        uint256 newCardId = _tokenIds.current();

        cards[newCardId] = Card({
            id: newCardId,
            name: name,
            description: description,
            attack: attack,
            defense: defense
        });

        _mint(msg.sender, newCardId);
        return newCardId;
    }

    function purchaseUniqueCard(uint256 cardId) external payable {
        // Ensure the card exists
        require(cards[cardId].id == cardId, "Card does not exist.");

        // Check if the card is owned by the contract owner/admin
        require(
            ownerOf(cardId) == owner(),
            "Card is not available for purchase."
        );

        // Implement the logic for the purchase amount (e.g., fixed amount, auction, etc.)
        require(msg.value >= 0.01 ether, "Insufficient ETH sent.");

        // Transfer ownership of the card to the buyer
        _safeTransfer(owner(), msg.sender, cardId, "");

        // Transfer the ETH to the contract owner or another wallet
        payable(owner()).transfer(msg.value);
    }

    function tradeCard(uint256 cardId, address recipient) external {
        // Ensure the caller is the current owner of the card
        require(ownerOf(cardId) == msg.sender, "Not the owner of the card.");

        // Safely transfer the card to the recipient
        _safeTransfer(msg.sender, recipient, cardId, "");
    }

    function increaseCardAttributes(
        uint256 cardId,
        uint256 percentIncrease
    ) external onlyOwner {
        require(cards[cardId].id == cardId, "Card does not exist.");
        cards[cardId].attack =
            (cards[cardId].attack * (100 + percentIncrease)) /
            100;
        cards[cardId].defense =
            (cards[cardId].defense * (100 + percentIncrease)) /
            100;
    }

    function getCardAttributes(
        uint256 cardId
    ) external view returns (uint256 attack, uint256 defense) {
        Card storage card = cards[cardId];
        return (card.attack, card.defense);
    }

    function updateCardDefense(uint256 cardId, uint256 newDefense) external {
        require(msg.sender == address(PlayerRegistration), "Unauthorized"); // Only allow PlayerRegistration contract to call this
        cards[cardId].defense = newDefense;
    }

    function burnCard(uint256 cardId) external {
        require(msg.sender == address(PlayerRegistration), "Unauthorized");
        require(ownerOf(cardId) != address(0), "Card does not exist");
        _burn(cardId);
    }
}
