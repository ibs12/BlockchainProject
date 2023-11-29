// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import "@openzeppelin/contracts@4.0.0/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts@4.0.0/access/Ownable.sol";
import "@openzeppelin/contracts@4.0.0/utils/Counters.sol";

contract UniqueCards is ERC721Enumerable, Ownable {
    address private PlayerRegistration;
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;

    struct Card {
        uint256 id;
        string name;
        string description;
        uint256 attack;
        uint256 defense;
    }

    event CardCreation(
        uint256 indexed cardId,
        string name,
        uint256 attack,
        uint256 defense
    );
    event CardPurchase(
        address indexed buyer,
        uint256 indexed cardId,
        uint256 amount
    );
    event CardTrade(
        uint256 indexed cardId,
        address indexed from,
        address indexed to
    );
    event CardAttributeIncrease(
        uint256 indexed cardId,
        uint256 percentIncrease
    );
    event CardDefenseUpdate(uint256 indexed cardId, uint256 newDefense);
    event CardBurned(uint256 indexed cardId);

    mapping(uint256 => Card) public cards;

    constructor() ERC721("UniqueCards", "UC") {}

    function createUniqueCard(
        string memory name,
        string memory description,
        uint256 attack,
        uint256 defense
    ) external returns (uint256) {
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
        emit CardCreation(newCardId, name, attack, defense);
        return newCardId;
    }

    function increaseCardAttack(
        uint256 cardId,
        uint256 percentIncrease
    ) external {
        require(cards[cardId].id == cardId, "Card does not exist.");
        cards[cardId].attack =
            (cards[cardId].attack * (100 + percentIncrease)) /
            100;
        // cards[cardId].defense =
        //     (cards[cardId].defense * (100 + percentIncrease)) /
        //     100;
        emit CardAttributeIncrease(cardId, percentIncrease);
    }

    function increaseCardDefense(
        uint256 cardId,
        uint256 percentIncrease
    ) external {
        require(cards[cardId].id == cardId, "Card does not exist.");
        cards[cardId].defense =
            (cards[cardId].defense * (100 + percentIncrease)) /
            100;
        emit CardAttributeIncrease(cardId, percentIncrease);
    }

    function getCardAttributes(
        uint256 cardId
    ) external view returns (uint256 attack, uint256 defense) {
        Card storage card = cards[cardId];
        return (card.attack, card.defense);
    }

    function updateCardDefense(uint256 cardId, uint256 newDefense) external {
        //require(msg.sender == address(PlayerRegistration), "Unauthorized"); // Only allow PlayerRegistration contract to call this
        cards[cardId].defense = newDefense;
        emit CardDefenseUpdate(cardId, newDefense);
    }

    function burnCard(uint256 cardId) external {
        require(ownerOf(cardId) != address(0), "Card does not exist");
        _burn(cardId);
        emit CardBurned(cardId);
    }
}
