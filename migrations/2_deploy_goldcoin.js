const GoldCoin = artifacts.require("GoldCoin");

module.exports = function(deployer, network, accounts) {
    // Set the initial parameters for deployment
    // Convert token amounts to the smallest unit considering decimals (assuming 18 decimals)
    const initialOwnerSupplyInWei = web3.utils.toWei(initialOwnerSupply.toString(), 'ether');
    const initialContractSupplyInWei = web3.utils.toWei(initialContractSupply.toString(), 'ether');

    // Deploy the contract with the specified parameters
    deployer.deploy(GoldCoin, initialOwner, initialOwnerSupplyInWei, initialContractSupplyInWei);
};
