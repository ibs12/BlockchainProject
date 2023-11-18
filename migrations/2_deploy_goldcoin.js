const GoldCoin = artifacts.require("GoldCoin");

module.exports = function (deployer, network, accounts) {
  // Deploy the contract with the first account as the initial owner
  deployer.deploy(GoldCoin, accounts[0]);
};
