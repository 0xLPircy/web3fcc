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

module.exports = async ({ getNamedAccounts, deployments }) => {
  const { deploy, log } = deployments;
  const { deployer } = await getNamedAccounts();
  const chainId = network.config.chainId;
};
