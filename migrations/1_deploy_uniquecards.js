const UniqueCards = artifacts.require("UniqueCards");

module.exports = function (deployer) {
  deployer.deploy(UniqueCards);
};
