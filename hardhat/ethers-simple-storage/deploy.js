const ethers = require("ethers");
const fs = require("fs");

async function main() {
  // CONNECTING SCRIPT TO LOCAL BLOCKCHAIN
  // http://127.0.0.1:7545
  const provider = new ethers.providers.JsonRpcProvider(
    "HTTP://127.0.0.1:7545"
  );
  const wallet = new ethers.Wallet(
    "0x2d6646b94d5075c5d1ba88ea0113002b8a2dad963b56f37fec96da319db923c6",
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
  // console.log("deplying with only transaction data!");
  // const nonce = await wallet.getTransactionCount();
  // const tx = {
  //   nonce: nonce,
  //   gasPrice: 20000000000,
  //   gasLimit: 1000000,
  //   to: null,
  //   value: 0,
  //   data: "add bin file ka data",
  //   chainId: 1337,
  // };
  // // const signedTxResponse = await wallet.signTransaction(tx);
  // const sentTxResponse = await wallet.sendTransaction(tx);
  // await sentTxResponse.wait(1);
  // console.log(sentTxResponse);
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.log(error);
    process.exit(1);
  });
