// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract GoldCoin is ERC20 {
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

    function mint(address to, uint256 amount) public {
        _mint(to, amount);
        emit Mint(to, amount);
    }

    function buyGoldCoins(address player) external payable {
        uint256 price = 0.1 ether; // Fixed price for buying 1000 GoldCoins
        uint256 goldCoinsPerPurchase = 1000 * 10 ** decimals(); // Fixed amount of GoldCoins per purchase

        uint256 dexBalance = balanceOf(address(this));
        require(
            goldCoinsPerPurchase <= dexBalance,
            "Not enough GoldCoins in the reserve"
        );

        _transfer(address(this), player, goldCoinsPerPurchase);

        emit GoldCoinPurchase(player, msg.value, goldCoinsPerPurchase);
    }

    // Function to withdraw Ether from the contract, only callable by the owner
    // function withdraw() public {
    //     uint256 balance = address(this).balance;
    //     payable(owner()).transfer(balance);
    //     emit Withdrawal(owner(), balance);
    // }
}
