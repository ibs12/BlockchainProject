// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract GoldCoin is ERC20, Ownable {
    uint256 public rate = 1000; // Number of GoldCoins per Ether

    // Define events
    event Mint(address indexed to, uint256 amount);
    event GoldCoinPurchase(
        address indexed buyer,
        uint256 etherAmount,
        uint256 goldCoinAmount
    );
    event RateChange(uint256 newRate);
    event Withdrawal(address indexed owner, uint256 amount);

    constructor(
        address initialOwner,
        uint256 initialOwnerSupply,
        uint256 initialContractSupply
    ) ERC20("GoldCoin", "GC") {
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

    function buyGoldCoins() public payable {
        uint256 weiAmount = msg.value;
        uint256 tokensToBuy = (weiAmount * rate) / (10 ** 18); // Adjust for token decimals
        uint256 dexBalance = balanceOf(address(this));
        require(tokensToBuy > 0, "You need to send some Ether");
        require(
            tokensToBuy <= dexBalance,
            "Not enough GoldCoins in the reserve"
        );
        _transfer(address(this), msg.sender, tokensToBuy);

        emit GoldCoinPurchase(msg.sender, weiAmount, tokensToBuy);
    }

    // Function to set the exchange rate, only callable by the owner
    function setRate(uint256 newRate) public onlyOwner {
        rate = newRate;
        emit RateChange(newRate);
    }

    // Function to withdraw Ether from the contract, only callable by the owner
    function withdraw() public onlyOwner {
        uint256 balance = address(this).balance;
        payable(owner()).transfer(balance);
        emit Withdrawal(owner(), balance);
    }
}
