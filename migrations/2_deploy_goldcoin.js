const GoldCoin = artifacts.require("GoldCoin");

module.exports = function(deployer, network, accounts) {
    deployer.deploy(GoldCoin);
};
