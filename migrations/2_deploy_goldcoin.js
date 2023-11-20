const GoldCoin = artifacts.require("GoldCoin");

module.exports = function(deployer, network, accounts) {
    // Set the initial parameters for deployment
    const initialOwner = accounts[0]; // This sets the first account as the initial owner
    const initialOwnerSupply = 1000000; // The amount of tokens for the initial owner
    const initialContractSupply = 500000; // The amount of tokens for the contract

    const initialOwnerSupplyInWei = web3.utils.toWei('1000000', 'ether'); // Owner supply
    const initialContractSupplyInWei = web3.utils.toWei('500000', 'ether'); // Contract supply
    
    deployer.deploy(GoldCoin, initialOwner, initialOwnerSupplyInWei, initialContractSupplyInWei);
}    
