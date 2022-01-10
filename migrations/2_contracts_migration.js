const Defi = artifacts.require("Defi");

module.exports = function (deployer) {
  deployer.deploy(Defi);
};
