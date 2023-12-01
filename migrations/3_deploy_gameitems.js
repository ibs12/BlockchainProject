const GoldCoin = artifacts.require("GoldCoin");
const UniqueCards = artifacts.require("UniqueCards");
const GameItems = artifacts.require("GameItems");

module.exports = async function (deployer, network, accounts) {
  // Reference already deployed contracts
  const goldCoin = await GoldCoin.deployed();
  const uniqueCards = await UniqueCards.deployed();

  // Deploy GameItems with the addresses of GoldCoin and UniqueCards
  await deployer.deploy(GameItems, goldCoin.address, uniqueCards.address);
};
