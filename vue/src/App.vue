<template>
  
  <v-app class="grey lighten-4">
    <navbar></navbar>

    <v-content>
      <router-view />
    </v-content>

  </v-app>
  
</template>

<script>
import Navbar from './components/Navbar.vue'

export default {
  name: 'App',
  components: {Navbar
  },
  data () {
    return {

    }
  }
}

</script>

<style>
div.nav{
  flex-flow: row;
}
</style>