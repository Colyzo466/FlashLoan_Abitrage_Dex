const { ethers } = require("hardhat");

async function deployDexContract() {
  try {
    // Get signer (deployer account)
    const [deployer] = await ethers.getSigners();
    console.log(`Deploying with account: ${await deployer.getAddress()}`);

    // Get the contract factory
    const Dex = await ethers.getContractFactory("Dex", deployer);

    // Deploy the contract
    const dex = await Dex.deploy();
    await dex.waitForDeployment(); // ✅ Required for Ethers v6

    console.log(`Dex Contract deployed to: ${await dex.getAddress()}`);
  } catch (error) {
    console.error("Error during deployment:", error);
    process.exit(1);
  }
}

// Execute deployment
deployDexContract()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
