// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract GoldCoin is ERC20, Ownable {
    uint256 public rate = 1000; // Number of GoldCoins per Ether

    constructor(address initialOwner) ERC20("GoldCoin", "GC") {
        _mint(initialOwner, 1000000 * 10 ** decimals());
    }

    function mint(address to, uint256 amount) public onlyOwner {
        _mint(to, amount);
    }

    // Function to allow users to buy GoldCoins with Ether
    function buyGoldCoins() public payable {
        uint256 amountTobuy = msg.value * rate;
        uint256 dexBalance = balanceOf(address(this));
        require(amountTobuy > 0, "You need to send some Ether");
        require(
            amountTobuy <= dexBalance,
            "Not enough GoldCoins in the reserve"
        );
        _transfer(address(this), msg.sender, amountTobuy);
    }

    // Function to set the exchange rate, only callable by the owner
    function setRate(uint256 newRate) public onlyOwner {
        rate = newRate;
    }

    // Function to withdraw Ether from the contract, only callable by the owner
    function withdraw() public onlyOwner {
        uint256 balance = address(this).balance;
        payable(owner()).transfer(balance);
    }
}
