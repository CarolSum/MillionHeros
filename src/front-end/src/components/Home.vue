<template>
  <div id="home">
		<a-divider orientation="left">当前活跃的比赛🔥</a-divider>
		<div class="item-group">
			<template v-for="(contest,index) in contests">
				<contest-card :key="contestsAddressList[index]" :contest="contest" @clickEvent="onContestCardClick(contestsAddressList[contestsIndex[index]])"></contest-card>	
			</template>
		</div>
  </div>
</template>

<script>
import { Divider } from 'ant-design-vue';
import { GET_CONTEST_ADDRESS } from '../store/actions';
import ContestCard from './share/ContestCard';
import { store } from '../store/index';
import { baseInfoWrapper } from '../utils/ObjectWrapper';

export default {
  name: 'home',
  props: {
    // msg: String
  },
  components: {
		ContestCard,
		ADivider: Divider
	},
	data: function () {
		return {
			contests: [],
			contestsIndex: [],
		}
	},
  methods: {
    onContestCardClick(id) {
			this.$router.push({ name:'contest', params: { contestId: id }});
		}
	},
	computed: {
		contestsAddressList: function () {
			return store.state.contestAddress;
		}
	},
	watch: {
    contestsAddressList: function (newList, oldList) {
			let contests = this.contests;
			let contestsIndex = this.contestsIndex;
			for (let index = 0; index < newList.length; index++) {
				this.$contracts.Contest.at(newList[index]).then(function(instance){
					return instance.getContestBaseInfo.call();
				}).then(function(info){
					let res = baseInfoWrapper(info);
					res.ddl = new Date(res.ddl);
					console.log(res);
					contestsIndex.push(index);
					contests.push(res);
				}).catch(function(err){
					console.log(err);
				});
			}
		}
  },
	mounted () {
		// 获得用户地址
		// var account = this.$web3.eth.accounts[0];
		// this.$store.commit('SET_ACCOUNT', account);
		this.$store.dispatch(GET_CONTEST_ADDRESS);
	}
}
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped lang="less">
#home {
	
	.item-group {
		display: flex;
		flex-wrap: wrap;
		justify-content: space-between;
	}
}
</style>
<style lang="less">
#home {
	.ant-divider-horizontal {
		font-size: 1.3rem;
  	font-family:'Trebuchet MS', 'Lucida Sans Unicode', 'Lucida Grande', 'Lucida Sans', Arial, sans-serif;
	}
}
</style>
