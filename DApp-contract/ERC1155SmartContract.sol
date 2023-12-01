// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import "@openzeppelin/contracts@4.0.0/token/ERC1155/ERC1155.sol";
import "@openzeppelin/contracts@4.0.0/utils/Counters.sol";
import "@openzeppelin/contracts@4.0.0/access/Ownable.sol";
import "./ERC20SmartContract.sol"; // Importing the local ERC20 contract.
import "./ERC721SmartContract.sol"; // Importing the local ERC721 contract.

contract GameItems is ERC1155, Ownable {
    using Counters for Counters.Counter;
    Counters.Counter private _itemIds;

    // Addresses of the deployed ERC20 and ERC721 contracts
    GoldCoin private erc20Token;
    UniqueCards private erc721Token;

    enum Phase {
        Register,
        Play,
        Done
    }
    Phase public currPhase = Phase.Register;
    //modifiers
    modifier validPhase(Phase reqPhase) {
        require(currPhase == reqPhase);
        _;
    }

    function changePhase(Phase x) public onlyOwner {
        // require(x > currPhase);
        currPhase = x;
    }

    enum ItemType {
        PowerUp,
        Mod,
        UniqueAttribute
    }
    struct Item {
        uint256 id;
        ItemType itemType;
        string name;
        string description;
    }
    mapping(uint256 => Item) public items;
    mapping(address => uint256) private playerPowerUps;
    mapping(address => uint256) private playerModPowerUps;

    // Event declarations
    event ItemCreated(
        uint256 itemId,
        ItemType itemType,
        string name,
        string description
    );
    event ItemMinted(address indexed to, uint256 itemId, uint256 amount);
    event ItemBurned(address indexed owner, uint256 itemId, uint256 amount);
    event ItemPurchased(
        address indexed buyer,
        uint256 itemId,
        uint256 amount,
        string paymentType
    );
    event PowerUpUsed(address indexed player, uint256[] cardIds);
    event ModPowerUpUsed(address indexed player, uint256[] cardIds);

    constructor(
        address _erc20Address,
        address _erc721Address
    ) ERC1155("") Ownable() {
        erc20Token = GoldCoin(_erc20Address);
        erc721Token = UniqueCards(_erc721Address);
    }

    function createItem(
        ItemType itemType,
        string memory name,
        string memory description
    ) external onlyOwner returns (uint256) {
        _itemIds.increment();
        uint256 newItemId = _itemIds.current();
        items[newItemId] = Item({
            id: newItemId,
            itemType: itemType,
            name: name,
            description: description
        });
        emit ItemCreated(newItemId, itemType, name, description);
        return newItemId;
    }

    function mintItem(
        address to,
        uint256 itemId,
        uint256 amount
    ) external onlyOwner {
        require(items[itemId].id == itemId, "Item does not exist.");
        _mint(to, itemId, amount, "");
        emit ItemMinted(to, itemId, amount);
    }

    function burnItem(address owner, uint256 itemId, uint256 amount) external {
        require(
            msg.sender == owner || isApprovedForAll(owner, msg.sender),
            "Not authorized."
        );
        _burn(owner, itemId, amount);
        emit ItemBurned(owner, itemId, amount);
    }

    function purchaseItem(uint256 itemId) external payable {
        require(items[itemId].id == itemId, "Item does not exist.");
        uint256 price;

        if (items[itemId].itemType == ItemType.PowerUp) {
            price = 1 * 1e18; // Adjust the price as necessary
            playerPowerUps[msg.sender] += 1; // Increment the player's power-up count
        } else if (items[itemId].itemType == ItemType.Mod) {
            price = 2 * 1e18; // Adjust the price as necessary
        }

        require(msg.value >= price, "Insufficient ETH sent.");
        _mint(msg.sender, itemId, 1, "");
        payable(owner()).transfer(msg.value);
        emit ItemPurchased(msg.sender, itemId, 1, "ETH");
    }

    function purchaseWithGoldCoin(uint256 itemId) external {
        uint256 price = 30 * 10 ** 18; // Adjust the price as necessary
        erc20Token.transferFrom(msg.sender, address(this), price);

        if (items[itemId].itemType == ItemType.PowerUp) {
            playerPowerUps[msg.sender] += 1; // Increment the player's power-up count
        }

        _mint(msg.sender, itemId, 1, "");
        emit ItemPurchased(msg.sender, itemId, 1, "GoldCoin");
    }

    function useModPowerUp(address player) external {
        require(playerModPowerUps[player] > 0, "No mod power-ups available");
        playerModPowerUps[player] -= 1;
        uint256 cardCount = erc721Token.balanceOf(player);
        uint256[] memory cardIds = new uint256[](cardCount);
        for (uint256 i = 0; i < cardCount; i++) {
            uint256 cardId = erc721Token.tokenOfOwnerByIndex(player, i);
            erc721Token.increaseCardDefense(cardId, 10); // Modify the attribute increase as needed
            cardIds[i] = cardId;
        }
        emit ModPowerUpUsed(player, cardIds);
    }

    function hasModPowerUp(address player) external view returns (bool) {
        return playerModPowerUps[player] > 0;
    }

    function usePowerUp(address player) external {
        require(playerPowerUps[player] > 0, "No power-ups available");
        playerPowerUps[player] -= 1;
        uint256 cardCount = erc721Token.balanceOf(player);
        uint256[] memory cardIds = new uint256[](cardCount);
        for (uint256 i = 0; i < cardCount; i++) {
            uint256 cardId = erc721Token.tokenOfOwnerByIndex(player, i);
            erc721Token.increaseCardAttack(cardId, 10);
            cardIds[i] = cardId;
        }
        emit PowerUpUsed(player, cardIds);
    }

    function hasPowerUp(address player) external view returns (bool) {
        return playerPowerUps[player] > 0;
    }
}