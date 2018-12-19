<template>
  <div id="main-layout">
    <a-layout class="layout">
      <a-layout-header>
        <div class="logo">Millon Heros</div>
        <a-menu
          mode="horizontal"
          :defaultSelectedKeys="['1']"
          :style="{ height: '66px', lineHeight: '64px' }">
          <a-menu-item key="1">
						<router-link :to="{ name: 'home'}">Home</router-link>
					</a-menu-item>
          <a-menu-item key="2">
						<router-link :to="{ name: 'space'}">Space</router-link>
					</a-menu-item>
          <a-menu-item key="3">
						<router-link :to="{ name: 'sponsored'}">Add</router-link>
					</a-menu-item>
          <a-menu-item key="4" style="float: right">
						<a href="http://www.github.com/carolsum" target="_blank">
							<a-icon type="github" />About Me
						</a>
          </a-menu-item>
        </a-menu>
      </a-layout-header>
      <a-layout-content style="padding: 0 50px; margin-top: 60px;">
        <div :style="{ background: '#fff', padding: '24px', minHeight: '280px' }">
					<router-view></router-view>
				</div>
      </a-layout-content>
      <a-layout-footer>
        <footer-layout></footer-layout>
      </a-layout-footer>
    </a-layout>
  </div>
</template>

<script>
import { 
  Layout,
  Menu,
  Icon
} from 'ant-design-vue';
import FooterLayout from './FooterLayout';

export default {
  name: 'main-layout',
  props: {
    // msg: String
  },
	components: {
    ALayout: Layout,
    AMenu: Menu,
    ALayoutHeader: Layout.Header,
    ALayoutContent: Layout.Content,
    ALayoutFooter: Layout.Footer,
    AMenuItem: Menu.Item,
		AIcon: Icon,
		// custom components
		FooterLayout
  },
  methods: {
    
  }
}
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style>
#main-layout .layout {
  min-height: 100vh;
}

#main-layout .ant-layout-header {
  background: #fff;
}

#main-layout .logo {
  height: 100%;
  width: 200px;
  float: left;
  font-size: 1.3rem;
  font-family:'Trebuchet MS', 'Lucida Sans Unicode', 'Lucida Grande', 'Lucida Sans', Arial, sans-serif
}
</style>
