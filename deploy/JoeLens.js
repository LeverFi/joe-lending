module.exports = async function ({ getNamedAccounts, deployments }) {
  const { deploy } = deployments;

  const { deployer } = await getNamedAccounts();

  const rewardDistributor = await deployments.get("RewardDistributor");

  await deploy("JoeLens", {
    from: deployer,
    args: ["jAVAX", rewardDistributor.address],
    log: true,
    deterministicDeployment: false,
  });
};

module.exports.tags = ["JoeLens"];
