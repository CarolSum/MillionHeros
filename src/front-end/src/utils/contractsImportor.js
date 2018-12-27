import PlaygroundArtifact from '../contracts/Playground'
import ContestArtiface from '../contracts/Contest';
const TruffleContract = require("truffle-contract");

export const contracts = {
	Playground: TruffleContract(PlaygroundArtifact),
	Contest: TruffleContract(ContestArtiface)
};