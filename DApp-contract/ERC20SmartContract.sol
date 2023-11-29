// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import "@openzeppelin/contracts@4.0.0/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts@4.0.0/access/Ownable.sol";

contract GoldCoin is ERC20, Ownable {
    // Define events
    uint256 initialOwnerSupply = 1000000; // Adjust as needed
    uint256 initialContractSupply = 500000; // Adjust as needed
    event Mint(address indexed to, uint256 amount);
    event GoldCoinPurchase(
        address indexed buyer,
        uint256 etherAmount,
        uint256 goldCoinAmount
    );
    event RateChange(uint256 newRate);
    event Withdrawal(address indexed owner, uint256 amount);

    constructor() ERC20("GoldCoin", "GC") {
        address initialOwner = msg.sender;
        // Mint initial supply to the owner and the contract
        _mint(initialOwner, initialOwnerSupply * 10 ** 18);
        _mint(address(this), initialContractSupply * 10 ** 18);

        // Emit the Mint events
        emit Mint(initialOwner, initialOwnerSupply);
        emit Mint(address(this), initialContractSupply);
    }

    function mint(address to, uint256 amount) public onlyOwner {
        _mint(to, amount);
        emit Mint(to, amount);
    }

    function buyGoldCoins() external payable {
        uint256 price = 0.1 ether; // Fixed price for buying 1000 GoldCoins
        uint256 goldCoinsPerPurchase = 1000 * 10 ** decimals(); // Fixed amount of GoldCoins per purchase

        require(
            msg.value == price,
            "Send exactly 0.00001 Ether to purchase 1000 GoldCoins."
        );

        uint256 dexBalance = balanceOf(address(this));
        require(
            goldCoinsPerPurchase <= dexBalance,
            "Not enough GoldCoins in the reserve"
        );

        _transfer(address(this), msg.sender, goldCoinsPerPurchase);

        emit GoldCoinPurchase(msg.sender, msg.value, goldCoinsPerPurchase);
    }

    // Function to withdraw Ether from the contract, only callable by the owner
    function withdraw() public onlyOwner {
        uint256 balance = address(this).balance;
        payable(owner()).transfer(balance);
        emit Withdrawal(owner(), balance);
    }

    function getUserBalance(address user) public view returns (uint256) {
        return (balanceOf(user) / (10 ** decimals()));
    }
}
