const hre = require("hardhat");

async function main() {
  const [deployer] = await hre.ethers.getSigners();

  const MockUSDC = await hre.ethers.getContractFactory("MockUSDC");
  const usdc = await MockUSDC.deploy();
  await usdc.waitForDeployment();
  console.log("MockUSDC deployed to:",await usdc.getAddress());

  const LendingPool = await hre.ethers.getContractFactory("LendingPool");
  const pool = await LendingPool.deploy(await usdc.getAddress());
  await pool.waitForDeployment();
  console.log("LendingPool deployed to:", await pool.getAddress());
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
