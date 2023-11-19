const GoldCoin = artifacts.require("GoldCoin");

module.exports = async function(deployer, network, accounts) {
    // Replace 'accounts[0]' with the appropriate address if necessary
    const initialOwner = accounts[0];

    await deployer.deploy(GoldCoin, initialOwner);
};
