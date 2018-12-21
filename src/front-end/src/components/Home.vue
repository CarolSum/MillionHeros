<template>
  <div id="home">
		<a-divider orientation="left">当前活跃的比赛🔥</a-divider>
		<div class="item-group">
			<contest-card :contest="contest" @clickEvent="onContestCardClick"></contest-card>
			<contest-card :contest="contest" @clickEvent="onContestCardClick"></contest-card>
			<contest-card :contest="contest" @clickEvent="onContestCardClick"></contest-card>
		</div>
  </div>
</template>

<script>
import { Divider } from 'ant-design-vue';
import ContestCard from './share/ContestCard';

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
			contest: {
				contestid: 111,
				desc: '这是描述信息这是描述信息这是描述信息这是描述信息这是描述信息这是描述信息',
				isFinished: false,
				title: '孔Bob举办的第一场pk赛',
				cost: 10,
				bonus: 1000,
				ddl: '2018-12-20/20:30',
				sponsor: '0x12321312313'
			}
		}
	},
  methods: {
    onContestCardClick(id) {
			this.$router.push({ name:'contest', params: { contestId: 1 }});
		}
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
