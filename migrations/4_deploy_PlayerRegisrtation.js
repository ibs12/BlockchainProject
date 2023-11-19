const GoldCoin = artifacts.require("GoldCoin");
const UniqueCards = artifacts.require("UniqueCards");
const GameItems = artifacts.require("GameItems");
const PlayerRegistration = artifacts.require("PlayerRegistration");

module.exports = async function (deployer, network, accounts) {
    // Deploy the GoldCoin contract
    await deployer.deploy(GoldCoin, accounts[0]);
    const goldCoinInstance = await GoldCoin.deployed();

    // Deploy the UniqueCards contract
    await deployer.deploy(UniqueCards);
    const uniqueCardsInstance = await UniqueCards.deployed();

    // Deploy the GameItems contract
    await deployer.deploy(GameItems, goldCoinInstance.address, uniqueCardsInstance.address);
    const gameItemsInstance = await GameItems.deployed();

    // Finally, deploy the PlayerRegistration contract
    await deployer.deploy(
        PlayerRegistration, 
        goldCoinInstance.address, 
        uniqueCardsInstance.address, 
        gameItemsInstance.address
    );
};
