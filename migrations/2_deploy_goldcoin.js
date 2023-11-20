const GoldCoin = artifacts.require("GoldCoin");

module.exports = function(deployer, network, accounts) {
    // Set the initial parameters for deployment
    const initialOwner = accounts[0]; // This sets the first account as the initial owner
    const initialOwnerSupply = 1000000; // The amount of tokens for the initial owner
    const initialContractSupply = 500000; // The amount of tokens for the contract

    // Convert token amounts to the smallest unit considering decimals (assuming 18 decimals)
    const initialOwnerSupplyInWei = web3.utils.toWei(initialOwnerSupply.toString(), 'ether');
    const initialContractSupplyInWei = web3.utils.toWei(initialContractSupply.toString(), 'ether');

    // Deploy the contract with the specified parameters
    deployer.deploy(GoldCoin, initialOwner, initialOwnerSupplyInWei, initialContractSupplyInWei);
};
