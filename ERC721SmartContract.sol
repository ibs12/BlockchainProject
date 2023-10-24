pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract UniqueCards is ERC721Enumerable, Ownable {
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;

    struct Card {
        uint256 id; // Unique identifier
        string name; // Card name
        string description; // Short description of the card
        // Add other attributes as needed
    }

    mapping(uint256 => Card) public cards; // Mapping from token ID to card details

    constructor() ERC721("UniqueCards", "UC") {}

    function createUniqueCard(
        string memory name,
        string memory description
    ) external onlyOwner {
        _tokenIds.increment();
        uint256 newCardId = _tokenIds.current();

        Card memory newCard = Card({
            id: newCardId,
            name: name,
            description: description
        });

        cards[newCardId] = newCard;
        _mint(owner(), newCardId); // The card is initially owned by the contract owner/admin
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
}
