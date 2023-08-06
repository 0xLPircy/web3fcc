const ethers = require("ethers");
const fs = require("fs");

async function main() {
  // CONNECTING SCRIPT TO LOCAL BLOCKCHAIN
  // http://127.0.0.1:7545
  const provider = new ethers.providers.JsonRpcProvider(
    "HTTP://127.0.0.1:7545"
  );
  const wallet = new ethers.Wallet(
    "0x1bfd6c11fcec0ef3d33430704f28369f47725cff77d2b6b4327607cab014751c",
    provider
  );
  const abi = fs.readFileSync("./SimpleStorage_sol_SimpleStorage.abi", "utf8");
  const binary = fs.readFileSync(
    "./SimpleStorage_sol_SimpleStorage.bin",
    "utf8"
  );
  const contractFactory = new ethers.ContractFactory(abi, binary, wallet);
  console.log("Deploying please wait ...");
  const contract = await contractFactory.deploy();
  const transactionReceipt = await contract.deployTransaction.wait(1);
  console.log(contract.deployTransaction);
  console.log(transactionReceipt);
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.log(error);
    process.exit(1);
  });
