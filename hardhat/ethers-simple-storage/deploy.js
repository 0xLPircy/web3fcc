const ethers = require("ethers");

async function main() {
  const provider = new ethers.providers.JsonRpcProvider("");
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.log(error);
    process.exit(1);
  });
