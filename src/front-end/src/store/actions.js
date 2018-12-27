/* eslint-disable no-console */
import { contracts } from '../utils/contractsImportor';
import { SET_CONTESTS_ADDRESS } from './mutations';

export const INCREMENT = 'INCREMENT';
export const GET_CONTEST_ADDRESS = 'GET_CONTEST_ADDRESS';

export const actions =	{
	[INCREMENT] ({ dispatch, commit }) {
		return dispatch('actionA').then(() => {
      commit('someOtherMutation')
    })
	},
	[GET_CONTEST_ADDRESS] ({ commit }) {
		contracts.Playground.deployed().then(function(instance) {
			return instance.getContests.call();
		}).then(function(contests) {
			console.log(contests);
			commit(SET_CONTESTS_ADDRESS, contests);
		}).catch(function(err) {
			console.log(err);
		});
	}
}