import Web3 from "web3"
// import $ from 'jquery'
import { contracts } from '../utils/contractsImportor';

export default {
  install: async function (Vue) {
    // Modern dapp browsers...
		var web3Provider = null;
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

		// TODO: 同步读取JSON文件
		// $.ajaxSettings.async = false;
		// $.getJSON('Playground.json', function(data) {
		// 	// eslint-disable-next-line no-console
		// 	console.log(data);
		// 	// Get the necessary contract artifact file and instantiate it with truffle-contract
		// 	var PlaygroundArtifact = data;
		// 	contracts.Playground = TruffleContract(PlaygroundArtifact);
		// 	// Set the provider for our contract
		// 	contracts.Playground.setProvider(web3Provider);
		// 	Vue.prototype.$contracts = contracts;
		// });

		// 初始化合约对象
		contracts.Playground.setProvider(web3Provider);
		contracts.Contest.setProvider(web3Provider);
		Vue.prototype.$contracts = contracts;
	}
}