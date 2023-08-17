// imports
const { ethers } = require("hardhat")

// async main func
async function main() {
  const SimpleStorageFactory = await ethers.getContractFactory("SimpleStorage");
  console.log("Deploying contract...");
  const simpleStorage = await SimpleStorageFactory.deploy();
  // await simpleStorage.deployed();
  console.log(`Deployed Contract to ${simpleStorage.target}`)
}

// main
main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
