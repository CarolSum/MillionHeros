import Web3 from "web3"
import $ from 'jquery'
const TruffleContract = require("truffle-contract");

export default {
  install: async function (Vue) {
    // Modern dapp browsers...
		var web3Provider = null;
		var contracts = {};
    if (window.ethereum) {
			web3Provider = window.ethereum;
			try {
				// Request account access
				await window.ethereum.enable();
			} catch (error) {
				// User denied account access...
				// eslint-disable-next-line no-console
				console.error("User denied account access")
			}
		}
		// Legacy dapp browsers...
		else if (window.web3) {
			web3Provider = window.web3.currentProvider;
		}
		// If no injected web3 instance is detected, fall back to Ganache
		else {
			web3Provider = new Web3.providers.HttpProvider('http://localhost:7545');
		}
		let web3 = new Web3(web3Provider);
		Vue.prototype.$web3 = web3;

		$.getJSON('Playground.json', function(data) {
			// eslint-disable-next-line no-console
			console.log(data);
      // Get the necessary contract artifact file and instantiate it with truffle-contract
      var PlaygroundArtifact = data;
      contracts.Playground = TruffleContract(PlaygroundArtifact);
      // Set the provider for our contract
			contracts.Playground.setProvider(web3Provider);
			Vue.prototype.$contracts = contracts;
    });
	}
}