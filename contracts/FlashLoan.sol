// SPDX-License-Identifier: MIT
pragma solidity 0.8.28;

// Importing necessary contracts from Aave V3
import {FlashLoanSimpleReceiverBase} from "@aave/core-v3/contracts/flashloan/base/FlashLoanSimpleReceiverBase.sol";
import {IPool} from "@aave/core-v3/contracts/interfaces/IPool.sol";
import {IPoolAddressesProvider} from "@aave/core-v3/contracts/interfaces/IPoolAddressesProvider.sol";
import {IERC20} from "@aave/core-v3/contracts/dependencies/openzeppelin/contracts/IERC20.sol";

/**
 * @title FlashLoan Contract
 * @author [Your Name]
 * @notice This contract allows users to request flash loans from Aave V3.
 */
 
contract FlashLoan is FlashLoanSimpleReceiverBase {
    address payable public owner;

    /**
     * @param _addressProvider The address of the Aave V3 address provider.
     */
    constructor(address _addressProvider) 
        FlashLoanSimpleReceiverBase(IPoolAddressesProvider(_addressProvider))
    {
        owner = payable(msg.sender);
    }

/**
 * @notice This function is called by Aave V3 after a flash loan is executed.
 * @param asset The address of the flash-borrowed asset.
 * @param amount The amount of the flash-borrowed asset.
 * @param premium The fee of the flash-borrowed asset.
 * @return True if the operation was successful.
 */
function executeOperation(
    address asset,
    uint256 amount,
    uint256 premium,
    address,
    bytes calldata
) external override returns (bool) {
    uint256 amountOwing = amount + premium;
    IERC20(asset).approve(address(POOL), amountOwing);
    return true;
}

/**
 * @notice This function requests a flash loan from Aave V3.
 * @param _token The token to borrow in the flash loan.
 * @param _amount The amount to borrow in the flash loan.
 */
function requestFlashLoan(address _token, uint256 _amount) public {
    address receiverAddress = address(this);
    address[] memory assets = new address[](1);
    assets[0] = _token;

    uint256[] memory amounts = new uint256[](1);
    amounts[0] = _amount;

    uint256[] memory modes = new uint256[](1);
    modes[0] = 0;

    address onBehalfOf = address(this);
    bytes memory params = "";
    uint16 referralCode = 0;

    POOL.flashLoan(
        receiverAddress,
        assets,
        amounts,
        modes,
        onBehalfOf,
        params,
        referralCode
    );
}

/**
 * @notice This function gets the balance of a token in the contract.
 * @param _tokenAddress The address of the token.
 * @return The balance of the token.
 */
function getBalance(address _tokenAddress) external view returns (uint256) {
    return IERC20(_tokenAddress).balanceOf(address(this));
}

/**
 * @notice This function withdraws a token from the contract.
 * @param _tokenAddress The address of the token.
 */
function withdraw(address _tokenAddress) external onlyOwner {
    IERC20(_tokenAddress).transfer(
        msg.sender,
        IERC20(_tokenAddress).balanceOf(address(this))
    );
}

/**
 * @notice This modifier checks if the caller is the contract owner.
 */
modifier onlyOwner() {
    require(
        msg.sender == owner,
        "Only the contract owner can call this function"
    );
    _;
}

/**
 * @notice This function is called when the contract receives Ether.
 */
receive() external payable {}

// Move the receive function inside the contract
// Remove the extra receive function declaration
}