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
		<template v-for="question in resolveContent" >
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
	Popconfirm
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
		ProblemCard
	},
	data: function () {
		return {
			contest: {
				contestid: 111,
				desc: '这是描述信息这是描述信息这是描述信息这是描述信息这是描述信息这是描述信息',
				isFinished: false,
				title: '孔Bob举办的第一场pk赛',
				cost: 10,
				bonus: 1000,
				ddl: '2018-12-20/20:30',
				sponsor: '0x12321312313',
				// 题目内容
				content: '[{"id":0,"title":"大气中的水汽主要来源于","choice":["太阳","植物蒸腾","地球表面水体蒸发","大气本身"]},{"id":1,"title":"世界上各月降水量都很多的地区在：","choice":["南北纬300—400大陆东岸","南北回归线附近","南北纬400—600大陆东岸","赤道附近"]},{"id":2,"title":"我国庐山成为避暑胜地的主要因素是","choice":["纬度因素","海陆因素","洋流因素","地形因素"]}]',
			},
			userAnswer: {}
		}
	},
	computed: {
		resolveContent: function () {
			return JSON.parse(this.contest.content);
		},
	},
  methods: {
    onContestCardClick (id) {
			this.$router.push({ name:'contest', params: { contestId: 1 }});
		},
		setQuestionAnswer (ans) {
			this.userAnswer[ans.id] = ans.choice;
		},
		submitContest () {
			console.log(this.userAnswer);
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
