// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract StakingPool {
    address public owner;
    uint256 public rewardRate = 100; // Tokens per ETH staked (for example)

    mapping(address => uint256) public stakes;
    mapping(address => uint256) public rewards;

    constructor() {
        owner = msg.sender;
    }

    // Stake ETH into the pool
    function stake() external payable {
        require(msg.value > 0, "Must stake more than 0");
        stakes[msg.sender] += msg.value;
        rewards[msg.sender] += msg.value * rewardRate;
    }

    // Check current rewards
    function checkReward(address user) external view returns (uint256) {
        return rewards[user];
    }

    // Withdraw staked ETH
    function withdrawStake(uint256 amount) external {
        require(stakes[msg.sender] >= amount, "Not enough staked");
        stakes[msg.sender] -= amount;
        payable(msg.sender).transfer(amount);
    }
}

