import Vuex from 'vuex';
import Vue from 'vue';
import { mutations } from './mutations';
import { actions } from './actions';
Vue.use(Vuex)

export const store = new Vuex.Store({
	state: {
		count: 0,
		account: null,
		contestAddress: [],
		contestBaseInfo: {}
	},
	actions,
	mutations
})