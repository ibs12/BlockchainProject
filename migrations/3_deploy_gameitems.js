const GoldCoin = artifacts.require("GoldCoin");
const UniqueCards = artifacts.require("UniqueCards");
const GameItems = artifacts.require("GameItems");

module.exports = async function (deployer, network, accounts) {
  // Deploy GoldCoin without any constructor parameters
  await deployer.deploy(GoldCoin);
  const goldCoin = await GoldCoin.deployed();

  await deployer.deploy(UniqueCards);
  const uniqueCards = await UniqueCards.deployed();

  // Now deploy GameItems with the addresses of GoldCoin and UniqueCards
  await deployer.deploy(GameItems, goldCoin.address, uniqueCards.address);
};
