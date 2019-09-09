const HDWalletProvider = require('truffle-hdwallet-provider');
const Web3 = require('web3');
const { interface, bytecode } = require('./compile');

const provider = new HDWalletProvider(
	'gesture dolphin chronic possible shoulder lazy confirm affair vault alter walk yellow', // mnemonic 12 słów z metamask
	'https://ropsten.infura.io/v3/3bd1ee176cfd4cb8986dd162d2139645' // dojście do infrastruktury Ethereum bez konieczności odpalania full node'a
);
const web3 = new Web3(provider);

const deploy = async () => {
	const accounts = await web3.eth.getAccounts();

	console.log('Attempting to deploy from account', accounts[0]);

	const result = await new web3.eth.Contract(JSON.parse(interface))
	.deploy({ data: bytecode })
	.send({ gas: '1000000', from: accounts[0] }); // gas [opłata] za transakcję

	console.log(interface);
	console.log('Contract deployed to', result.options.address);
};
deploy();