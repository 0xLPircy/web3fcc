const { network } = require("hardhat");

module.exports = async ({ getNamedAccounts, deployments }) => {
  //here named and deployments are actually pulled from hre
  const { deploy, log } = deployments; //here we are pulling deploy and log functions out of deployments
  const { deployer } = await getNamedAccounts();
  const chainId = network.config.chainId;
};
