const { ethers } = require("hardhat");

async function deployFlashLoanArbitrageContract() {
  try {
    // Get signer (deployer account)
    const signers = await ethers.getSigners();
    if (signers.length === 0) throw new Error("No signers found. Make sure you have configured accounts in Hardhat.");

    const deployer = signers[0];
    console.log(`Deploying with account: ${await deployer.getAddress()}`);

    // Get the contract factory and connect to signer
    const FlashLoanArbitrage = await ethers.getContractFactory("FlashLoanArbitrage", deployer);

    // Deploy the contract
    const flashLoanArbitrage = await FlashLoanArbitrage.deploy("0x012bAC54348C0E635dCAc9D5FB99f06F24136C9A");
    await flashLoanArbitrage.waitForDeployment();

    // Get contract address
    const contractAddress = await flashLoanArbitrage.getAddress();
    console.log(`FlashLoanArbitrage Contract deployed to: ${contractAddress}`);
  } catch (error) {
    console.error("Error during deployment:", error);
    process.exit(1);
  }
}

// Call the deployment function
deployFlashLoanArbitrageContract().then(() => process.exit(0));
