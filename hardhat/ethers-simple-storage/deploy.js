const ethers = require("ethers");
const fs = require("fs");
require("dotenv").config();

async function main() {
  // CONNECTING SCRIPT TO LOCAL BLOCKCHAIN
  // http://127.0.0.1:7545
  const provider = new ethers.providers.JsonRpcProvider(
    process.env.RPC_URL //get the chain
  );

  const wallet = new ethers.Wallet(
    process.env.PRIVATE_KEY, //get the wallet
    provider
  );
  // const encryptedJson = fs.readFileSync("./.encryptedKey.json", "utf8");
  // let wallet = new ethers.Wallet.fromEncryptedJsonSync( //used elt instead of const cause now have to connect to provider, before it was automatic
  //   encryptedJson,
  //   process.env.PRIVATE_KEY_PASSWORD
  // );
  // wallet = await wallet.connect(provider);

  const abi = fs.readFileSync("./SimpleStorage_sol_SimpleStorage.abi", "utf8"); //get abi
  const binary = fs.readFileSync(
    "./SimpleStorage_sol_SimpleStorage.bin", //get binary
    "utf8"
  );

  const contractFactory = new ethers.ContractFactory(abi, binary, wallet); //create contractfac pbject connected to wallet using abi and bin
  console.log("Deploying please wait ...");
  const contract = await contractFactory.deploy(); //DEPLOYING THE CONTRACT
  await contract.deployTransaction.wait(1); //wait for dep contract to come on block
  console.log(`Contract Address: ${contract.address}`);

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
