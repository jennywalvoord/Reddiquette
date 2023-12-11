<template>
  
  <v-app class="grey lighten-4">
    <!-- <navbar></navbar> -->
    <!-- <div style="height: 72px;"></div> -->
   
      <v-app-bar app
      class="px-3 elevation-4"
      color="grey-lighten-4"
      height="72"
      > 
        <v-app-bar-nav-icon>
            <router-link to="/">
              <v-avatar size="48">
                <v-img
                src="./src/assets/Logo_Orange.png"
                width="100"
                height="100"
            />
              </v-avatar>
             
            </router-link>
          </v-app-bar-nav-icon>
          <v-app-bar-title class="font-weight-bold" :style="{color: '#ff4500'}">rediquette</v-app-bar-title>
          <router-link v-bind:to="{ name: 'home' }">Home</router-link>
          <v-btn flat color="grey">
            <span>Sign Out</span>&nbsp;
          <router-link v-bind:to="{ name: 'logout' }" v-if="$store.state.token != ''"></router-link>
            <v-icon icon="mdi-logout"></v-icon>
          </v-btn>
    </v-app-bar>
    
      
    <router-view />
   

  </v-app>
  
</template>

<script>

export default {
  name: 'App',
  components: {  },
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
/* .global-padding {
  padding: 80px;
} */
</style>

