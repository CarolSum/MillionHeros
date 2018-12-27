<template>
  <div id="space">
		<a-divider>已参与的比赛🚀</a-divider>
		<div class="item-group">
			<template v-for="(contest,index) in participateContests">
				<contest-card :key="contestsAddressList[participateContestsIndex[index]]" 
					:contest="contest"
					@clickEvent="onContestCardClick(contestsAddressList[participateContestsIndex[index]])"></contest-card>	
			</template>
		</div>
		<a-divider>发起的比赛🎉</a-divider>
		<div class="item-group">
			<template v-for="(contest,index) in sponsorContests">
				<contest-card :key="contestsAddressList[sponsorContestsIndex[index]]" 
					:contest="contest"
					@clickEvent="onContestCardClick(contestsAddressList[sponsorContestsIndex[index]])"></contest-card>	
			</template>
		</div>
  </div>
</template>

<script>
import { Divider } from 'ant-design-vue';
import { baseInfoWrapper } from '../utils/ObjectWrapper';
import { GET_CONTEST_ADDRESS } from '../store/actions';
import ContestCard from './share/ContestCard';

export default {
  name: 'space',
  props: {
    // msg: String
  },
  components: {
		ContestCard,
		ADivider: Divider
	},
	data: function () {
		return {
			participateContests: [],
			participateContestsIndex: [],
			sponsorContests: [],
			sponsorContestsIndex: [],
		}
	},
  methods: {
    onContestCardClick(id) {
			this.$router.push({ name:'contest', params: { contestId: id }});
		}
	},
	computed: {
		contestsAddressList: function () {
			return this.$store.state.contestAddress;
		}
	},
	watch: {
    contestsAddressList: function (newList, oldList) {
			try {
				let that = this;
				// 查看用户是否已经参与这次比赛
				this.$web3.eth.getAccounts(async (error, accounts) => {
					if (error) {
						console.log(error);
					}
					let account = accounts[0];
					for (let index = 0; index < newList.length; index++) {
						let instance = await that.$contracts.Contest.at(newList[index]);
						// 获取用户参与的比赛
						let isParticipator = await instance.isParticipant.call({from: account});
						if (isParticipator) {
							let info = await instance.getContestBaseInfo.call();
							let res = baseInfoWrapper(info);
							res.ddl = new Date(res.ddl);
							console.log(res);
							that.participateContestsIndex.push(index);
							that.participateContests.push(res);
						}
						// 获取用户发起的比赛
						let isSponsor = await instance.isSponsor.call({from: account});
						if (isSponsor) {
							let info = await instance.getContestBaseInfo.call();
							let res = baseInfoWrapper(info);
							res.ddl = new Date(res.ddl);
							console.log(res);
							that.sponsorContestsIndex.push(index);
							that.sponsorContests.push(res);
						}
					}
				});
			} catch (error) {
				console.log(error);
			}
		}
  },
	mounted () {
		this.$store.dispatch(GET_CONTEST_ADDRESS);
	}
}
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped lang="less">
#space {
	
	.item-group {
		display: flex;
		flex-wrap: wrap;
		justify-content: space-between;
	}
}
</style>
<style lang="less">
#space {
	.ant-divider-horizontal {
		font-size: 1.3rem;
  	font-family:'Trebuchet MS', 'Lucida Sans Unicode', 'Lucida Grande', 'Lucida Sans', Arial, sans-serif;
	}
}
</style>
