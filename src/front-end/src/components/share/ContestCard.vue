<template>
	<a-card
		class="contest-card"
		hoverable
		style="width: 30%"
		@click="emitClick">
		<img
			alt="example"
			:src="picPath"
			slot="cover"/>
		<!-- <template class="ant-card-actions" slot="actions">
			<a-icon type="setting" />
			<a-icon type="edit" />
			<a-icon type="ellipsis" />
		</template> -->
		<div class="title">{{contest.title}}</div>
		<span class="status">截止时间: {{contest.ddl}}</span>
		<div class="cb">cost: {{contest.cost}} wei <span style="color: rgb(155, 148, 148)">|</span> bouns: {{contest.bouns}} wei</div>
		<a-divider />
		<div class="description">{{contest.desc}}</div>
	</a-card>
</template>

<script>
import { 
	Card,
	Avatar,
	Icon,
	Divider
} from 'ant-design-vue';

// 导入一些自定义图片
import BrightVault from '../../assets/BrightVault.jpg';
import Dusk from '../../assets/Dusk.jpg';
import GrapefruitSunset from '../../assets/GrapefruitSunset.jpg';
import Jupiter from '../../assets/Jupiter.jpg';
import Limeade from '../../assets/Limeade.jpg';
import Politics from '../../assets/Politics.jpg';
import Sunset from '../../assets/Sunset.jpg';
import SweetMorning from '../../assets/SweetMorning.jpg';

const picSrc = [
	BrightVault,
	Dusk,
	GrapefruitSunset,
	Jupiter,
	Limeade,
	Politics,
	Sunset,
	SweetMorning
]

export default {
  name: 'contest-card',
  props: {
		contest: {},
		picIndex: 0
	},
	data: function () {
		return {
			isHover: false
		}
	},
	computed: {
		picPath: function () {
			return picSrc[this.picIndex];
		}
	},
  components: {
		ACard: Card,
		ACardMeta: Card.Meta,
		AAvatar: Avatar,
		AIcon: Icon,
		ADivider: Divider
  },
  methods: {
    emitClick () {
			this.$emit('clickEvent', this.contest.contestid);
		}
	},
	mounted () {
		this.picIndex = Math.floor(Math.random()*7); 
	}
}
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->

<style lang="less" scoped>
.contest-card {
	.title {
		font-size: 16px;
		font-weight: 500;
	}

	.status {
		color: gray;
		font-size: 12px;
	}

	.description {
		font-size: 14px;
	}
}
</style>

<style lang="less">
.contest-card{
	.ant-card-body{
		padding: 16px 24px;
	}

	.ant-divider-horizontal {
		margin: 10px 0;
	}
}
</style>

