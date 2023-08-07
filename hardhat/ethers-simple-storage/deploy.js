const ethers = require("ethers");
const fs = require("fs");

async function main() {
  // CONNECTING SCRIPT TO LOCAL BLOCKCHAIN
  // http://127.0.0.1:7545
  const provider = new ethers.providers.JsonRpcProvider(
    "HTTP://127.0.0.1:7545" //get the chain
  );
  const wallet = new ethers.Wallet(
    "0x7ac49dcc3a7235e61de7dfc15b5f4e74a778d927e73dd2b249682f112d56121c", //get the wallet
    provider
  );
  const abi = fs.readFileSync("./SimpleStorage_sol_SimpleStorage.abi", "utf8"); //get abi
  const binary = fs.readFileSync(
    "./SimpleStorage_sol_SimpleStorage.bin", //get binary
    "utf8"
  );
  const contractFactory = new ethers.ContractFactory(abi, binary, wallet); //create contractfac pbject connected to wallet using abi and bin
  console.log("Deploying please wait ...");
  const contract = await contractFactory.deploy(); //DEPLOYING THE CONTRACT
  await contract.deployTransaction.wait(1); //wait for dep contract to come on block
  // console.log(contract.deployTransaction);
  // console.log(transactionReceipt);
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

  // functions on the deployed contract
  const currentFavoriteNumber = await contract.retrieve(); //view, no gas no transaction
  console.log(`Current Fav Number: ${currentFavoriteNumber.toString()}`);
  const transactionResponse = await contract.store("7"); //pass numbers as string to prevent issue incase too big
  const transactionReceipt = await transactionResponse.wait(1); //updating, so gas cost, so transaction, so transaction reciept
  const updatedFavoriteNumber = await contract.retrieve();
  console.log(`Updated Fav Number: ${updatedFavoriteNumber}`);
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.log(error);
    process.exit(1);
  });
