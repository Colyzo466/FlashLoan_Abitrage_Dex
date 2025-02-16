# Flash Loan Arbitrage Using Aave & Dex

## 📌 Project Overview
This project demonstrates how to perform **Flash Loan Arbitrage** using **Aave v3** and a custom **Dex (Decentralized Exchange)**. The smart contracts are deployed using **Hardhat**, and the scripts automate the deployment process.

The arbitrage strategy involves borrowing funds from **Aave's Flash Loan**, executing trades on the **Dex**, and repaying the loan while keeping the profit.

## 🏗 Project Structure
```
hardhat-project/
├── contracts/                  # Solidity Smart Contracts
│   ├── Dex.sol                 # Custom Decentralized Exchange
│   ├── FlashLoan.sol           # Aave Flash Loan implementation
│   ├── FlashLoanArbitrage.sol  # Arbitrage logic using Aave & Dex
│
├── scripts/                    # Deployment scripts
│   ├── deploy.js               # Deploy all contracts
│   ├── deployDex.js            # Deploy Dex contract
│   ├── deployFlashLoanArbitrage.js # Deploy Arbitrage contract
│
├── test/                       # Unit tests
│   ├── Dex.test.js             # Tests for Dex
│   ├── FlashLoan.test.js       # Tests for Flash Loan
│   ├── FlashLoanArbitrage.test.js # Tests for Arbitrage logic
│
├── hardhat.config.js           # Hardhat Configuration
├── package.json                # Dependencies
├── .env                        # Environment Variables (API keys, private keys)
├── README.md                   # Project Documentation
```

---

## 🛠 Setup and Installation

### **1️⃣ Prerequisites**
Ensure you have the following installed:
- [Node.js](https://nodejs.org/) (v16+ recommended)
- [Hardhat](https://hardhat.org/)
- [Metamask](https://metamask.io/) (For testing)
- A **Sepolia Testnet** wallet with ETH
- [Infura](https://infura.io/) or [Alchemy](https://www.alchemy.com/) API Key

### **2️⃣ Clone the Repository**
```bash
git clone https://github.com/Colyzo466/Flashloan_Arbitrage_Dex.git
cd flash-loan-arbitrage
```

### **3️⃣ Install Dependencies**
```bash
npm install
```

### **4️⃣ Configure Environment Variables**
Create a `.env` file and add:
```
INFURA_API_KEY=your_infura_key
PRIVATE_KEY=your_wallet_private_key
```

---

## 🚀 Deployment

### **1️⃣ Compile the Contracts**
```bash
npx hardhat compile
```

### **2️⃣ Deploy Contracts to Sepolia Testnet**
```bash
npx hardhat run scripts/deployFlashLoanArbitrage.js --network sepolia
```

This will deploy:
- **Dex.sol**
- **FlashLoan.sol**
- **FlashLoanArbitrage.sol**

You should see contract addresses printed in the console.

---

## 🧪 Testing

### **Run Unit Tests**
```bash
npx hardhat test
```
This will execute test cases inside the `test/` directory.

---

## 📜 Smart Contracts

### **Dex.sol**
A custom **Decentralized Exchange** that allows:
- Depositing USDC and DAI
- Swapping USDC for DAI and vice versa

### **FlashLoan.sol**
Integrates **Aave v3** to request a **Flash Loan**.

### **FlashLoanArbitrage.sol**
Handles the **Arbitrage Execution** by:
1. Borrowing funds from Aave
2. Buying DAI from Dex
3. Selling DAI for profit
4. Repaying the Flash Loan

---

## 📡 Interacting with Contracts

### **1️⃣ Approve Tokens Before Trading**
```js
const contract = await ethers.getContractAt("FlashLoanArbitrage", "0xContractAddress");
await contract.approveUSDC("1000000000"); // Approve 1000 USDC
```

### **2️⃣ Request a Flash Loan**
```js
await contract.requestFlashLoan("0xUSDC_Address", "1000000000");
```

---

## 🔗 Useful Links
- **Aave v3 Docs**: https://docs.aave.com/
- **Hardhat Docs**: https://hardhat.org/docs/
- **Infura API**: https://infura.io/

## 🛠 Troubleshooting
If you encounter **ERC20: transfer amount exceeds balance**, ensure:
1. Your Dex contract has enough funds (`getBalance()` should return a value greater than your trade amount).
2. You approved enough tokens before calling `depositUSDC()` or `depositDAI()`.

---

## 📜 License
This project is licensed under the **MIT License**.

---

## 👤 Author
**Your Name**  
🔗 GitHub: [Colyzo466](https://github.com/Colyzo466)  
🔗 Twitter: victor oguike(https://twitter.com/@oguike_vic26351)  

---

## 🌟 Support
Give a ⭐ if you like this project!

