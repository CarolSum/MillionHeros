var Adoption = artifacts.require("Adoption");
var Playground = artifacts.require("Playground");

module.exports = function(deployer) {
  // deployer.deploy(Adoption);
  deployer.deploy(Playground);
};