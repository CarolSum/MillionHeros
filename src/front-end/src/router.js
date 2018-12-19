import VueRouter from 'vue-router';
import  MainLayout  from './layouts/MainLayout';
import Home from './components/Home';
import Space from './components/Space';
import Sponsored from './components/Sponsored';

const routes = [
	{ path: '/', component: MainLayout,
		children: [
			{
				path: '',
				name: 'home',
				component: Home
			},
			{
				path: 'space',
				name: 'space',
				component: Space
			},
			{
				path: 'sponsor',
				name: 'sponsored',
				component: Sponsored
			}
		]
	}
]

// 3. 创建 router 实例，然后传 `routes` 配置
// 你还可以传别的配置参数, 不过先这么简单着吧。
export default new VueRouter({
	mode: 'history',
	routes // (缩写) 相当于 routes: routes
})
  