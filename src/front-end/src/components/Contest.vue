<template>
  <div id="contest-page">
		<div class="contest-header">
			<h1>{{contest.title}}</h1>
			<div class="button-group">
				<a-popconfirm v-if="!isParticipator" placement="left" title="参与比赛需要支付一定的金额，确定参与？" okText="Yes" cancelText="No" @confirm="participate">
					<a-button style="color: white; background: chocolate;" class="positive-btn">参与</a-button>
				</a-popconfirm>
				<a-button v-else class="positive-btn" disabled>已参与</a-button>
				<a-button v-if="isParticipator" type="primary" @click="jumpToAnswer" :disabled="!isParticipator || isSubmitted">答题</a-button>
			</div>
		</div>
		<a-divider></a-divider>
		<!-- <a-divider orientation="left">统计信息</a-divider> -->
		<div class="base-info">
			<div class="major-info">
				<p>{{contest.desc}}</p>
				<div class="secondary-text">发起人：{{contest.sponsor}}</div>
			</div>
			<div class="text-info">
				<icon-text iconType="plus-circle" hint="参与费用" :text="contest.cost"></icon-text>
				<icon-text iconType="money-collect" hint="奖励金" :text="contest.bonus"></icon-text>
				<icon-text iconType="clock-circle" hint="截止时间" :text="contest.ddl"></icon-text>
				<icon-text iconType="thunderbolt" hint="是否结束" :text="contest.isFinished"></icon-text>
			</div>
		</div>
		<a-divider orientation="left">解答</a-divider>
		<div v-if="contest.isFinished">
			<template v-for="question in resolveContent" >
				<problem-card :key="question.id" class="question-item"
					:question="question"
					:answer="resolveAnswer[question.id]"
					:type="0">
				</problem-card>
			</template>
		</div>
		<div v-else>
			<p>比赛结束后才能看到答案哦～</p>
		</div>
		<a-divider orientation="left">提交记录</a-divider>
		<div v-if="isSubmitted">
			<template v-for="question in resolveContent" >
				<problem-card :key="question.id" class="question-item"
					:question="question"
					:answer="resolveAnswer[question.id]"
					:type="1">
				</problem-card>
			</template>
		</div>
		<div v-else>
			<p>当前还没有提交记录～</p>
		</div>
  </div>
</template>

<script>
import { 
	Divider,
	Button,
	Popconfirm
} from 'ant-design-vue';
import IconText from './share/IconText';
import ProblemCard from './share/ProblemCard';

export default {
  name: 'contest',
  props: {
    // msg: String
  },
  components: {
		ADivider: Divider,
		AButton: Button,
		APopconfirm: Popconfirm,
		IconText,
		ProblemCard
	},
	data: function () {
		return {
			contest: {
				contestid: 111,
				// 以下是基本信息
				desc: '这是描述信息这是描述信息这是描述信息这是描述信息这是描述信息这是描述信息',
				isFinished: false,
				title: '孔Bob举办的第一场pk赛',
				cost: 10,
				bonus: 1000,
				ddl: '2018-12-20/20:30',
				sponsor: '0x12321312313',
				// 题目内容
				content: '[{"id":0,"title":"大气中的水汽主要来源于","choice":["太阳","植物蒸腾","地球表面水体蒸发","大气本身"]},{"id":1,"title":"世界上各月降水量都很多的地区在：","choice":["南北纬300—400大陆东岸","南北回归线附近","南北纬400—600大陆东岸","赤道附近"]},{"id":2,"title":"我国庐山成为避暑胜地的主要因素是","choice":["纬度因素","海陆因素","洋流因素","地形因素"]}]',
				// 答案
				answer: '{"0":2,"1":0,"2":3}',
				// 赢家
				winner: '0x12312312312312312312'
			},
			isSubmitted: false
		}
	},
	computed: {
		resolveContent: function () {
			return JSON.parse(this.contest.content);
		},
		resolveAnswer: function () {
			return JSON.parse(this.contest.answer);
		},
		isParticipator () {
			return true;
		}
	},
  methods: {
		jumpToAnswer () {
			this.$router.push({name: 'submit', params: { contestId: this.$route.params.contestId }});
		},
		getContestInfo () {
			console.log('dispatch get info')
		},
		participate () {
			// 参与该场比赛
		}
	},
	mounted () {
		this.$contracts.Contest.at("0x7317fa42e85a36f8411a459b34e70c95806b8d6b").then(function(instance){
			console.log(instance);
			return instance.getContestBaseInfo.call();
		}).then(function(balance){
				console.log(balance);
		}).catch(function(err){
				console.log(err);
		});
	}
}
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped lang="less">
#contest-page {
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

	.button-group {
		align-self: flex-end;

	}

	.positive-btn {
		display: block;
		margin-bottom: 8px;
	}
	
	.base-info {
		display: flex;
		flex-direction: row;
		.major-info {
			flex-grow: 1;
			text-align: left;
		}
		.secondary-text {
			color: #787878;
		}
	}
	.question-item {
		margin: 24px 0;
	}
}
</style>
<style lang="less">
#contest-page {

}
</style>
