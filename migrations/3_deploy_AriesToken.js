const Aries = artifacts.require("./AriesCode");
const Token = artifacts.require("./AriesToken");

module.exports = function (deployer) {
  deployer.deploy(Token);
};
