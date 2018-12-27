export const SET_ACCOUNT = 'SET_ACCOUNT';
export const SET_CONTESTS_ADDRESS = 'SET_CONTESTS_ADDRESS';
export const SET_BASEINFO = 'SET_BASEINFO';

export const mutations = {

	[SET_ACCOUNT] (state, payload) {
		state.account = payload;
	},

	[SET_CONTESTS_ADDRESS] (state, payload) {
		state.contestAddress = payload;
	},

	[SET_BASEINFO] (state, payload) {
		state.contestBaseInfo = payload;
	}
}