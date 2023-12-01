const GoldCoin = artifacts.require("GoldCoin");
const UniqueCards = artifacts.require("UniqueCards");
const GameItems = artifacts.require("GameItems");
const PlayerRegistration = artifacts.require("PlayerRegistration");

module.exports = async function (deployer, network, accounts) {
    // Reference already deployed contracts
    const goldCoinInstance = await GoldCoin.deployed();
    const uniqueCardsInstance = await UniqueCards.deployed();
    const gameItemsInstance = await GameItems.deployed();

    // Deploy PlayerRegistration with references to GoldCoin, UniqueCards, and GameItems
    await deployer.deploy(
        PlayerRegistration, 
        goldCoinInstance.address, 
        uniqueCardsInstance.address, 
        gameItemsInstance.address
    );
};
