const GoldCoin = artifacts.require("GoldCoin");
const UniqueCards = artifacts.require("UniqueCards");
const GameItems = artifacts.require("GameItems");
const PlayerRegistration = artifacts.require("PlayerRegistration");

module.exports = async function (deployer, network, accounts) {
    // Deploy GoldCoin with correct constructor parameters
    await deployer.deploy(GoldCoin, initialOwner, initialOwnerSupply, initialContractSupply);
    const goldCoinInstance = await GoldCoin.deployed();

    // Deploy UniqueCards
    await deployer.deploy(UniqueCards);
    const uniqueCardsInstance = await UniqueCards.deployed();

    // Deploy GameItems with references to GoldCoin and UniqueCards
    await deployer.deploy(GameItems, goldCoinInstance.address, uniqueCardsInstance.address);
    const gameItemsInstance = await GameItems.deployed();

    // Deploy PlayerRegistration with references to GoldCoin, UniqueCards, and GameItems
    await deployer.deploy(
        PlayerRegistration, 
        goldCoinInstance.address, 
        uniqueCardsInstance.address, 
        gameItemsInstance.address
    );
};
