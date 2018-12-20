<template>
  <div id="sponsored">
    <a-divider>发起新的知识竞赛吧🆚</a-divider>
    <div class="button-wrapper">
      <a-button class="editable-add-btn" @click="openModal">增加题目</a-button>
      <a-button type="primary" @click="openContestInfoModal" style="margin-left: 20px;">马上发布</a-button>
    </div>
    <a-table  :dataSource="newContestData" :columns="columns"
      rowKey="id" style="clear: both;">
      <template slot="operation" slot-scope="text, record">
        <a-popconfirm
          v-if="newContestData.length"
          title="删除后将无法找回，确定删除?"
          @confirm="() => onDelete(record)">
          <a-button type="danger">Delete</a-button>
        </a-popconfirm>
      </template>
    </a-table>
    <a-modal
      title="添加题目"
      :visible="addChoiceModalVisible"
      @ok="handleAddChoice"
      :confirmLoading="confirmLoading"
      @cancel="handleCancelAddChoice">
      <a-form layout='vertical' :form="form">
        <a-form-item label='请输入题目：'>
          <a-input
            v-decorator="[
              'title',
              {
                rules: [{ required: true, message: '请输入题目内容！' }],
              }
            ]"
          />
        </a-form-item>
        <a-form-item label='请输入选项A：'>
          <a-input
            v-decorator="[
              'choiceA',
              {
                rules: [{ required: true, message: '请输入选项A～' }],
              }
            ]"
          />
        </a-form-item>
        <a-form-item label='请输入选项B：'>
          <a-input
            v-decorator="[
              'choiceB',
              {
                rules: [{ required: true, message: '请输入选项B～' }],
              }
            ]"
          />
        </a-form-item>
        <a-form-item label='请输入选项C：'>
          <a-input
            v-decorator="[
              'choiceC',
              {
                rules: [{ required: true, message: '请输入选项C～' }],
              }
            ]"
          />
        </a-form-item>
        <a-form-item label='请选择答案：'>
          <a-radio-group name="radioGroup" v-decorator="['answer', {rules: [{ required: true, message: '请选择答案～' }]}]">
            <a-radio :value="0">A</a-radio>
            <a-radio :value="1">B</a-radio>
            <a-radio :value="2">C</a-radio>
          </a-radio-group>
        </a-form-item>
      </a-form>
    </a-modal>
    <contest-info-form ref="contestForm" @submit="handleSubmitSponsor"></contest-info-form>
  </div>
</template>

<script>
import {
  Divider,
  Button,
  Table,
  Popconfirm,
  Modal,
  Input,
  InputNumber,
  DatePicker,
  Form,
  Radio
} from 'ant-design-vue'
import { setTimeout } from 'timers';
import ContestInfoForm from './share/ContestInfoForm';

export default {
  name: 'sponsored',
  props: {
    // msg: String
  },
  components: {
    ADivider: Divider,
    AButton: Button,
    ATable: Table,
    AModal: Modal,
    APopconfirm: Popconfirm,
    AForm: Form,
    AFormItem: Form.Item,
    AInput: Input,
    AInputNumber: InputNumber,
    ARadio: Radio,
    ARadioGroup: Radio.Group,
    ADatePicker: DatePicker,
    ContestInfoForm
  },
  data () {
    return {
      newContestData: [{
        id: 0,
        title: '大气中的水汽主要来源于',
        choice: [
          '太阳',
          '植物蒸腾',
          '地球表面水体蒸发',
          '大气本身'
        ],
        answer: 2
      },{
        id: 1,
        title: '世界上各月降水量都很多的地区在：',
        choice: [
          '南北纬300—400大陆东岸',
          '南北回归线附近',
          '南北纬400—600大陆东岸',
          '赤道附近'
        ],
        answer: 0
      }, {
        id: 2,
        title: '我国庐山成为避暑胜地的主要因素是',
        choice: [
          '纬度因素',
          '海陆因素',
          '洋流因素',
          '地形因素'
        ],
        answer: 3
      }],
      columns: [{
        title: '序号',
        dataIndex: 'id',
        width: '30%'
      }, {
        title: '描述',
        dataIndex: 'title',
      }, {
        title: '操作',
        dataIndex: 'operation',
        scopedSlots: { customRender: 'operation' }
      }],
      submitLoading: false,
      addChoiceModalVisible: false,
      confirmLoading: false,
      form: this.$form.createForm(this),
      newContestContent: [], // 待发布的contest的内容
      newContestAnswer: {},  // 待发布的contest的答案
    }
  },
  methods: {
    // 打开添加题目的modal
    openModal () {
      this.addChoiceModalVisible = true;
    },
    // 提交发布
    handleSubmitSponsor (payload) {
      this.submitLoading = true;
      this.newContestContent = this.newContestData.map(({id, title, choice}) => {
        return { id, title, choice }
      });
      this.newContestData.forEach(item => {
        this.newContestAnswer[item.id] = item.answer;
      })
      // 新contest的答案
      console.log(this.newContestAnswer);
      // 新contest的内容
      console.log(this.newContestContent);
      // payload 中为contest的基本信息    
      payload.ddl = payload.ddl.valueOf();
      console.log(payload);

      setTimeout(() => {
        this.submitLoading = false;
      }, 1000);
      // 清空数据
      this.newContestContent.splice(0);
      this.newContestAnswer = {};
      console.log('发布！');
    },
    // 删除一个题目
    onDelete(record) {
      this.newContestData.splice(record.id,1);
      let count = 0;
      this.newContestData.forEach((item) => {
        item.id = count++;
      })
    },
    handleAddChoice () {
      this.confirmLoading = true;
      this.form.validateFields((err, values) => {
        if (err) {
          this.confirmLoading = false;
          return;
        }
        console.log(values);
        this.newContestData.push({
          id: this.newContestData.length,
          title: values.title,
          choice: [ values.choiceA, values.choiceB, values.choiceC ],
          answer: values.answer
        })
        this.form.resetFields();
        this.addChoiceModalVisible = false;
        this.confirmLoading = false;
      })
    },
    handleCancelAddChoice () {
      this.addChoiceModalVisible = false;
      this.resetForm();
    },
    resetForm () {
      this.form.resetFields()
    },
    openContestInfoModal () {
      this.$refs.contestForm.openContestInfoModal();
    }
  }
}
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped lang="less">
#sponsored {
  .ant-divider-horizontal {
		font-size: 1.3rem;
  	font-family:'Trebuchet MS', 'Lucida Sans Unicode', 'Lucida Grande', 'Lucida Sans', Arial, sans-serif;
  }
  
  .button-wrapper {
    float: right;
    margin-bottom: 16px;
  }

  
}

</style>

<style lang="less">
.ant-table-thead > tr, .ant-table-tbody > tr {
  background: white;
}
</style>

