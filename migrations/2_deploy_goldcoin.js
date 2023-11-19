const GoldCoin = artifacts.require("GoldCoin");

module.exports = function(deployer, network, accounts) {
    const initialOwner = accounts[0];
    const initialOwnerSupply = 1000000; // Adjust as needed
    const initialContractSupply = 500000; // Adjust as needed

    deployer.deploy(GoldCoin, initialOwner, initialOwnerSupply, initialContractSupply);
};
