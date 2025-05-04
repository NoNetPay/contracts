// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract LendingPool is Ownable {
    IERC20 public immutable token;

    mapping(address => uint256) public collateral;
    mapping(address => uint256) public debt;

    uint256 public constant LTV = 75; // 75%
    uint256 public constant INTEREST_RATE = 5; // 5% interest

    constructor(IERC20 _token) Ownable(msg.sender) {
        token = _token;
    }

    function depositCollateral(uint256 amount) external {
        require(amount > 0, "Amount must be > 0");
        token.transferFrom(msg.sender, address(this), amount);
        collateral[msg.sender] += amount;
    }

    function borrow(uint256 amount) external {
        uint256 maxBorrow = (collateral[msg.sender] * LTV) / 100;
        require(debt[msg.sender] + amount <= maxBorrow, "Exceeds max LTV");

        debt[msg.sender] += amount;
        token.transfer(msg.sender, amount);
    }

    function repay(uint256 amount) external {
        require(amount > 0 && debt[msg.sender] > 0, "Invalid repay");
        token.transferFrom(msg.sender, address(this), amount);
        debt[msg.sender] -= amount;
    }

    function withdrawCollateral(uint256 amount) external {
        require(amount > 0, "Invalid amount");
        uint256 remainingCollateral = collateral[msg.sender] - amount;
        uint256 maxBorrow = (remainingCollateral * LTV) / 100;
        require(debt[msg.sender] <= maxBorrow, "Still under-collateralized");

        collateral[msg.sender] -= amount;
        token.transfer(msg.sender, amount);
    }

    function viewHealth(address user) external view returns (uint256 healthFactor) {
        if (debt[user] == 0) return type(uint256).max;
        healthFactor = (collateral[user] * 100) / debt[user];
    }
}
