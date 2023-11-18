const GoldCoin = artifacts.require("GoldCoin");
const UniqueCards = artifacts.require("UniqueCards");
const GameItems = artifacts.require("GameItems");
const PlayerRegistration = artifacts.require("PlayerRegistration");

module.exports = function (deployer) {
    deployer.then(async () => {
        const goldCoinInstance = await GoldCoin.deployed();
        const uniqueCardsInstance = await UniqueCards.deployed();
        const gameItemsInstance = await GameItems.deployed();

        return deployer.deploy(
            PlayerRegistration, 
            goldCoinInstance.address, 
            uniqueCardsInstance.address, 
            gameItemsInstance.addresss
        );
    });
};
