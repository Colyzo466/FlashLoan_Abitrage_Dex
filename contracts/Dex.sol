// contracts/Dex.sol
// SPDX-License-Identifier: MIT
pragma solidity 0.8.28;

import {IERC20} from "@aave/core-v3/contracts/dependencies/openzeppelin/contracts/IERC20.sol";

contract Dex {
    address payable public owner;

    // Aave ERC20 Token addresses on SEPOLIA network
    address private immutable daiAddress = 0xFF34B3d4Aee8ddCd6F9AFFFB6Fe49bD371b8a357;
    address private immutable usdcAddress = 0x94a9D9AC8a22534E3FaCa9F4e7F2E2cf85d5E4C8;

    IERC20 private dai;
    IERC20 private usdc;

    // Exchange rate indexes
    uint256 dexARate = 90;
    uint256 dexBRate = 100;

    // Keeps track of individuals' token balances
    mapping(address => uint256) public daiBalances;
    mapping(address => uint256) public usdcBalances;

    constructor() {
        owner = payable(msg.sender);
        dai = IERC20(daiAddress);
        usdc = IERC20(usdcAddress);
    }

    function depositUSDC(uint256 _amount) external {
        require(_amount > 0, "Deposit amount must be greater than zero");
        require(usdc.allowance(msg.sender, address(this)) >= _amount, "Check the token allowance");
        
        usdc.transferFrom(msg.sender, address(this), _amount);
        usdcBalances[msg.sender] += _amount;
    }

    function depositDAI(uint256 _amount) external {
        require(_amount > 0, "Deposit amount must be greater than zero");
        require(dai.allowance(msg.sender, address(this)) >= _amount, "Check the token allowance");
        
        dai.transferFrom(msg.sender, address(this), _amount);
        daiBalances[msg.sender] += _amount;
    }

    function buyDAI() external {
        require(usdcBalances[msg.sender] > 0, "Insufficient USDC balance");
        
        uint256 daiToReceive = (usdcBalances[msg.sender] * 100) / dexARate * (10**12);
        require(dai.balanceOf(address(this)) >= daiToReceive, "Insufficient DAI in contract");
        
        usdcBalances[msg.sender] = 0;
        dai.transfer(msg.sender, daiToReceive);
    }

    function sellDAI() external {
        require(daiBalances[msg.sender] > 0, "Insufficient DAI balance");
        
        uint256 usdcToReceive = (daiBalances[msg.sender] * dexBRate) / 100 / (10**12);
        require(usdc.balanceOf(address(this)) >= usdcToReceive, "Insufficient USDC in contract");
        
        daiBalances[msg.sender] = 0;
        usdc.transfer(msg.sender, usdcToReceive);
    }

    function getBalance(address _tokenAddress) external view returns (uint256) {
        return IERC20(_tokenAddress).balanceOf(address(this));
    }

    function withdraw(address _tokenAddress) external onlyOwner {
        IERC20 token = IERC20(_tokenAddress);
        token.transfer(msg.sender, token.balanceOf(address(this)));
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Only the contract owner can call this function");
        _;
    }

    receive() external payable {}
}
