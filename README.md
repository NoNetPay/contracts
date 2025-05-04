# Sample Hardhat Project

This project demonstrates a basic Hardhat use case. It comes with a sample contract, a test for that contract, and a Hardhat Ignition module that deploys that contract.

Try running some of the following tasks:

```shell
npx hardhat help
npx hardhat test
REPORT_GAS=true npx hardhat test
npx hardhat node
npx hardhat ignition deploy ./ignition/modules/Lock.js
```
# contracts
### 💰 Yield-Generating Smart Accounts 

   * User funds are deposited to a **Safe Smart Account**
     ([Factory](https://pharosscan.xyz/address/0x3a689E0bB15655Dd71312AaD8BB734c434193F3b))
   * Deposits (e.g., USDC) are forwarded to a **lending protocol**
     ([Lending Protocol](https://pharosscan.xyz/address/0x0cdc955265276C912824750C66900FFe66cbE17f))
   * Assets are **natively supplied as liquidity** to earn yield automatically.
   * These funds can also be **composed into other protocols** to optimize yield.
