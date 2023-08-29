// imports
const { ethers, run, network } = require("hardhat");

// async main func
async function main() {
    const SimpleStorageFactory =
        await ethers.getContractFactory("SimpleStorage");
    console.log("Deploying contract...");
    const simpleStorage = await SimpleStorageFactory.deploy();
    // await simpleStorage.deployed();
    console.log(`Deployed Contract to ${simpleStorage.target}`);
    // checking live network or not
    if (network.config.chainId === 11155111) {
        await simpleStorage.deploymentTransaction().wait(6);
        console.log("6 blocks verified");
        await verify(simpleStorage.target, []);
    }

    const currentValue = await simpleStorage.retrieve();
    console.log(`Current value is: ${currentValue}`);

    // update current value
    const transactionResponse = await simpleStorage.store(7);
    await transactionResponse.wait(1);
    const updatedValue = await simpleStorage.retrieve();
    console.log(`Upadted Value is: ${updatedValue}`);
}

async function verify(contractAddress, args) {
    // works for etherscan only
    console.log("Verifying...");
    try {
        await run("verify:verify", {
            // subtask args
            address: contractAddress,
            constructorArguments: args,
        });
    } catch (e) {
        if (e.message.toLowerCase().includes("already verified")) {
            console.log("Already Verified");
        } else {
            console.log(e);
        }
    }
}

// main
main()
    .then(() => process.exit(0))
    .catch((error) => {
        console.error(error);
        process.exit(1);
    });
