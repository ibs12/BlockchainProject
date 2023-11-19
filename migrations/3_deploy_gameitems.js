const GoldCoin = artifacts.require("GoldCoin");
const UniqueCards = artifacts.require("UniqueCards");
const GameItems = artifacts.require("GameItems");

module.exports = async function (deployer, network, accounts) {
  const initialOwner = accounts[0];
  const initialOwnerSupply = 1000000;  // Example value, adjust as needed
  const initialContractSupply = 500000; // Example value, adjust as needed

  // Deploy GoldCoin with the necessary constructor parameters
  await deployer.deploy(GoldCoin, initialOwner, initialOwnerSupply, initialContractSupply);
  const goldCoin = await GoldCoin.deployed();

  await deployer.deploy(UniqueCards);
  const uniqueCards = await UniqueCards.deployed();

  // Now deploy GameItems with the addresses of GoldCoin and UniqueCards
  await deployer.deploy(GameItems, goldCoin.address, uniqueCards.address);
};
