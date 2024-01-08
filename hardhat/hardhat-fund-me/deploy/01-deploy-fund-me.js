// imports
// main function
// calling of main

// // simple syntax
// function deployFunc() {
//   console.log("heloooo");
// }

// module.exports.default = deployFunc;

// Other syntax with no function name
// module.exports = async (hre) => {
//   //   const { getNamedAccounts, deployments } = hre;
//   //   same as hre.getNamedAccounts or hre.deployments
//   //   we dont use the above we just extrapolate directly as params
// };

const { networkConfig } = require("../helper-hardhat-config");
// OR
// const helperConfig = require("../helper-hardhat-config");
// const networkConfig = helperConfig.networkConfig;

module.exports = async ({ getNamedAccounts, deployments }) => {
  //here named and deployments are actually pulled from hre
  const { deploy, log } = deployments; //here we are pulling deploy and log functions out of deployments
  const { deployer } = await getNamedAccounts();
  const chainId = network.config.chainId;

  // if chain id x use address y etc
  const ethUsdPriceFeedAddress = networkConfig[chainId]["ethUsdPriceFeed"];

  // mock
  const fundMe = await deploy("FundMe", {
    from: deployer, //from who
    args: [], //any args for the constructor ie price feed address here
    log: true, //custom logging (?)
  }); //name of contract, overrides as parans in deploy
};
