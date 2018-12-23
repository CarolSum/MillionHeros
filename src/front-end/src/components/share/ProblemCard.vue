<template>
	<a-card hoverable>
    <div class="question-wrapper">
			<div class="left-info">{{question.id}}</div>
			<div class="right-info">{{question.title}}</div>
		</div>
		<div class="question-wrapper">
			<div class="left-info">本题答案</div>
			<div class="right-info">
				<a-radio-group v-model="q_answer" @change="onChange">
					<a-radio v-for="(q, index) in question.choice" :style="radioStyle" :value="index" :key="index">{{q}}</a-radio>
				</a-radio-group>
			</div>
		</div>
  </a-card>
</template>

<script>
import { 
	Card,
	Radio
} from 'ant-design-vue';
export default {
	name: 'problem-card',
	components: {
		ACard: Card,
		ARadio: Radio,
		ARadioGroup: Radio.Group
  },
  props: {
		question: {},
		answer: 0
	},
	data: function () {
		return {
			radioStyle: {
        display: 'block',
        height: '30px',
        lineHeight: '30px',
			},
			q_answer: 0
		}
	},
	computed: {
		
	},
  methods: {
		onChange (e) {
			this.q_answer = this.answer
		}
	},
	mounted () {
		this.q_answer = this.answer
	}
}
</script>

<style lang="less" scoped>
.question-wrapper {
	display: flex;
	flex-direction: row;
	.left-info {
		min-width: 4rem;
		align-self: center;
	}
	.right-info {
		flex-grow: 1;
		text-align: left;
		margin-left: 2rem;
	}
}
</style>
