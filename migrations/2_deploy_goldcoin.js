const GoldCoin = artifacts.require("GoldCoin");

module.exports = function(deployer, network, accounts) {
    // Use the first account as the initial owner
    const initialOwner = accounts[0];

    deployer.deploy(GoldCoin, initialOwner);
};
