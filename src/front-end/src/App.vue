<template>
  <div id="app">
    <router-view></router-view>
  </div>
</template>

<script>
import { GET_CONTEST_ADDRESS } from './store/actions';
export default {
  name: 'app',
  components: {
  },
  mounted () {
    this.$store.dispatch(GET_CONTEST_ADDRESS);
    console.log('获取所有合约地址')
  }
}
</script>

<style>
#app {
  font-family: 'Avenir', Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  text-align: center;
  color: #2c3e50;
  min-height: 100vh;
}

</style>
