<template>
  <div id="contest-submit">
		<div class="contest-header">
			<h1>{{contest.title}}</h1>
			<div class="button-group">
				<a-popconfirm placement="left" title="只能提交一次并且不能更改，确定提交吗？" okText="Yes" cancelText="No" @confirm="submitContest">
					<a-button type="primary">提交</a-button>
				</a-popconfirm>
			</div>
		</div>
		<a-divider></a-divider>
		<template v-for="question in content" >
			<problem-card :key="question.id" class="question-item"
				:question="question"
				:type="2"
				@setQuestionAnswer="setQuestionAnswer">
			</problem-card>
		</template>
  </div>
</template>

<script>
import { 
	Divider,
	Button,
	Popconfirm,
	notification,
	Icon
} from 'ant-design-vue';
import ProblemCard from './share/ProblemCard';

export default {
  name: 'contest-submit',
  props: {
    // msg: String
  },
  components: {
		ADivider: Divider,
		AButton: Button,
		APopconfirm: Popconfirm,
		AIcon: Icon,
		ProblemCard
	},
	data: function () {
		return {
			content: [],
			userAnswer: {}
		}
	},
	computed: {
		contest: function () {
			return this.$store.state.contestBaseInfo;
		},
	},
  methods: {
		setQuestionAnswer (ans) {
			this.userAnswer[ans.id] = ans.choice;
		},
		submitContest () {
			let answer = JSON.stringify(this.userAnswer).replace(/\"/g,"'");
			try {
				let that = this;
				this.$web3.eth.getAccounts(async (error, accounts) => {
					if (error) {
						console.log(error);
					}
					let account = accounts[0];
					let instance = await that.$contracts.Contest.at(that.$route.params.contestId);
					instance.submit.sendTransaction(answer,{from: account}).then(() => {
						notification.open({
							message: '提交成功',
							description: '比赛详情页可以看到自己的提交情况哦',
							icon: <a-icon type="check-circle" style="color: #108ee9" />,
						});
						setTimeout(()=> {
							that.$router.push({ name:'contest', params: { contestId: that.$route.params.contestId }});
						}, 3000);
					}).catch((error) => {
						notification.open({
							message: '发生未知错误～',
							description: '好像哪里出错了呢～Hero君也不知道咋整>.<',
							icon: <a-icon type="frown" style="color: #f44336" />,
						});
					})
				});
			} catch (error) {
				notification.open({
					message: '发生未知错误～',
					description: '好像哪里出错了呢～Hero君也不知道咋整>.<',
					icon: <a-icon type="frown" style="color: #f44336" />,
				});
			}
		}
	},
	mounted () {
		try {
			let that = this;
			this.$web3.eth.getAccounts(async (error, accounts) => {
				if (error) {
					console.log(error);
				}
				let account = accounts[0];
				console.log(account);
				let instance = await that.$contracts.Contest.at(that.$route.params.contestId);
				let info = await instance.getContestContent.call({from: account}); 
				console.log(JSON.parse(info.replace(/\'/g,"\"")));
				that.content = JSON.parse(info.replace(/\'/g,"\""));
			});
		} catch (error) {
			console.log(err);
		}
	}
}
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped lang="less">
#contest-submit {
	.contest-header {
		min-height: 60px;
		padding: 20px;
		display: flex;
		flex-direction: row;
		justify-content: space-between;

		h1 {
			display: inline;
			align-self: flex-end;
			margin: 0;
		}

		h1::before {
			content: "|";
			color: #a25284;
			width: 5px;
			height: 100%;
			margin-right: 1rem;
		}
	}
	
	.question-item {
		margin: 24px 0;
	}
}
</style>
<style lang="less">
#contest-submit {

}
</style>
