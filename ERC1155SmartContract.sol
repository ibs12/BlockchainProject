// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;


import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract GameItems is ERC1155, Ownable {
    using Counters for Counters.Counter;

    Counters.Counter private _itemIds;

    // Define different item types with corresponding item IDs
    enum ItemType {
        PowerUp,
        Mod,
        UniqueAttribute
    }

    // Details of each item
    struct Item {
        uint256 id;
        ItemType itemType;
        string name;
        string description;
    }

    mapping(uint256 => Item) public items;

    constructor() ERC1155("") Ownable(msg.sender) {} 

    function createItem(
        ItemType itemType,
        string memory name,
        string memory description
    ) external onlyOwner returns (uint256) {
        _itemIds.increment();
        uint256 newItemId = _itemIds.current();

        Item memory newItem = Item({
            id: newItemId,
            itemType: itemType,
            name: name,
            description: description
        });

        items[newItemId] = newItem;

        return newItemId;
    }

    function mintItem(
        address to,
        uint256 itemId,
        uint256 amount
    ) external onlyOwner {
        require(items[itemId].id == itemId, "Item does not exist.");
        _mint(to, itemId, amount, "");
    }

    function burnItem(address owner, uint256 itemId, uint256 amount) external {
        require(
            msg.sender == owner || isApprovedForAll(owner, msg.sender),
            "Not authorized."
        );
        _burn(owner, itemId, amount);
    }

    function purchaseItem(uint256 itemId, uint256 amount) external payable {
        require(items[itemId].id == itemId, "Item does not exist.");

        uint256 price;

        if (items[itemId].itemType == ItemType.PowerUp) {
            price = 10 * 1e18; // Price in wei
        } else if (items[itemId].itemType == ItemType.Mod) {
            price = 20 * 1e18;
        } else if (items[itemId].itemType == ItemType.UniqueAttribute) {
            price = 30 * 1e18;
        }

        require(msg.value >= price * amount, "Insufficient ETH sent.");

        _mint(msg.sender, itemId, amount, "");
        payable(owner()).transfer(msg.value);
    }
}
