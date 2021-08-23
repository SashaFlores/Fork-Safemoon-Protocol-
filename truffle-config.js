
const HDWalletProvider = require('@truffle/hdwallet-provider');
const fs = require('fs');
const mnemonic = fs.readFileSync(".secret").toString().trim();
const ApiKey = require("./env.js");

module.exports = {
  networks: {
    // development: {
    //   // host: "127.0.0.1",     // Localhost (default: none)
    //   // port: 8545,            // Standard BSC port (default: none)
    //   // network_id: "*",       // Any network (default: none)
    // },
    testnet: {
      provider: () => new HDWalletProvider(mnemonic, `https://data-seed-prebsc-1-s1.binance.org:8545`),
      network_id: 97,
      confirmations: 10,
      timeoutBlocks: 200,
      gas: 6897127,
      skipDryRun: true
    },
    bsc: {
      provider: () => new HDWalletProvider(mnemonic, `https://bsc-dataseed1.binance.org`),
      network_id: 56,
      confirmations: 10,
      timeoutBlocks: 200,
      gasPrice: 5 * 10 ** 9,
      gas: 8164631,
      skipDryRun: true
    },
  },

  // Set default mocha options here, use special reporters etc.
  mocha: {
    // timeout: 100000
  },

  // Configure your compilers
  compilers: {
    solc: {
      version: "^0.6.12", // A version or constraint - Ex. "^0.5.0"
    }
  },
  plugins: [
    'truffle-plugin-verify'
  ],
 api_keys: {
   bscscan: "ApiKey"
 }
}