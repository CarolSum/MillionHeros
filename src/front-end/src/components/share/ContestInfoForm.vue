<template>
	<a-modal
		title="添加比赛信息"
		:visible="contestInfoModalVisible"
		@ok="handleSubmitInfo"
		@cancel="handleCancelSubmit">
		
		<a-form layout='vertical' :form="form">
			<a-form-item label='请输入标题：'>
				<a-input
					placeholder="标题"
					v-decorator="[
						'title',
						{
							rules: [{ required: true, message: '请输入标题内容！' }],
						}
					]"
				/>
			</a-form-item>
			<a-form-item label='请输入比赛描述信息：'>
				<a-input
					placeholder="描述信息"
					v-decorator="[
						'desc',
						{
							rules: [{ required: true, message: '请输入比赛描述信息～' }],
						}
					]"
				/>
			</a-form-item>
			<a-form-item label="请选择比赛截止时间：">
				<a-date-picker @change="onDatePick" v-decorator="['ddl', {rules: [{ required: true, message: '请选择截止时间～' }]}]"/>
			</a-form-item>
			<a-form-item label="请输入参与费用：">
				<a-input-number 
					placeholder="参与费用"
					v-decorator="['cost', {rules: [{ required: true, message: '请输入参与费用~' }]}]"
				/>
			</a-form-item>
			<a-form-item label="请输入奖励金：">
				<a-input-number
					placeholder="奖励金"
					v-decorator="['bonus', {rules: [{ required: true, message: '请输入奖励金～' }]}]"
				/>
			</a-form-item>
		</a-form>

	</a-modal>
</template>

<script>
import {
  Modal,
  Input,
  InputNumber,
  DatePicker,
  Form
} from 'ant-design-vue'
import { setTimeout } from 'timers';

export default {
  name: 'contest-info-form',
  props: {
    // msg: String
  },
  components: {
    AModal: Modal,
    AForm: Form,
    AFormItem: Form.Item,
    AInput: Input,
    AInputNumber: InputNumber,
    ADatePicker: DatePicker
  },
  data () {
    return {
      contestInfoModalVisible: false,
			form: this.$form.createForm(this),
		}
  },
  methods: {
    handleSubmitInfo () {
      this.form.validateFields((err, values) => {
        if (!err) {
					this.$emit('submit', values);
				}
      })
		},
    openContestInfoModal () {
      this.contestInfoModalVisible = true;
    },
    handleCancelSubmit () {
      this.contestInfoModalVisible = false;
    },
    onDatePick (date, dateString) {
      console.log(date, dateString);
      console.log(date.valueOf())
    }
  }
}
</script>

<style lang="less" scoped>

</style>
