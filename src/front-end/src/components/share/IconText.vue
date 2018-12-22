<template>
	<div class="icon-text">
		<a-icon :type="iconType" class="icon"/>
		<span>{{hint}}: </span>
		<span>{{text}}</span>
	</div>
</template>

<script>
import { 
	Icon
} from 'ant-design-vue';


export default {
  name: 'icon-text',
  props: {
		text: '',
		hint: '',
		iconType: ''
	},
	data: function () {
		return {
		}
	},
	computed: {
		
	},
  components: {
		AIcon: Icon
  },
  methods: {
   
	}
}
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->

<style lang="less" scoped>
.icon-text {
	text-align: left;
	.icon {
		margin-right: 5px;
	}
}
</style>
