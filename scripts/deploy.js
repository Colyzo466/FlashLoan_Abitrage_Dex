const { ethers } = require("hardhat");

async function deployFlashLoanContract() {
  try {
    // Get signer (deployer account)
    const signers = await ethers.getSigners();
    if (signers.length === 0) throw new Error("No signers found. Make sure you have configured accounts in Hardhat.");

    const deployer = signers[0];
    console.log(`Deploying with account: ${await deployer.getAddress()}`);

    // Get the contract factory and connect to signer
    const FlashLoan = await ethers.getContractFactory("FlashLoan", deployer);

    // Deploy the contract
    const flashLoan = await FlashLoan.deploy("0x012bAC54348C0E635dCAc9D5FB99f06F24136C9A");
    await flashLoan.waitForDeployment();

    // Get contract address
    const contractAddress = await flashLoan.getAddress();
    console.log(`FlashLoan Contract deployed to: ${contractAddress}`);
  } catch (error) {
    console.error("Error during deployment:", error);
    process.exit(1);
  }
}

// Call the deployment function
deployFlashLoanContract().then(() => process.exit(0));
