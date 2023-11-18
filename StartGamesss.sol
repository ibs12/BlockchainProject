// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import "/Users/ibrahimallahbuksh/BlockchainProject/Contracts/ERC20SmartContract.sol";

// contract StartGame {
contract StartGame is ERC20 {
    ERC20 goldCoin;
    address admin;
    struct Player {
        uint playerId;
        bool registered;
    }
    enum Phase {
        Register,
        Play,
        Done
    }
    Phase public currPhase = Phase.Register;
    mapping(address => Player) players;

    // constructor() {
    constructor() ERC20("GoldCoin", "GC") {
        admin = msg.sender;
        // ERC20(msg.sender);
    }

    //modifiers
    modifier validPhase(Phase reqPhase) {
        require(currPhase == reqPhase);
        _;
    }

    modifier onlyAdmin() {
        require(msg.sender == admin);
        _;
    }

    function changePhase(Phase x) public onlyAdmin {
        require(x > currPhase);
        currPhase = x;
    }

    function register(address player) public validPhase(Phase.Register) {
        require(!players[player].registered);
        players[player].registered = true;
        //Give users a few ERC20 tokens (gold coins)
        //Give users a starting card (ERC721)
    }
}
