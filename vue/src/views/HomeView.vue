<template>
  <v-navigation-drawer v-model="drawer" app>
    <v-list>
        <v-list-item title="Navigation drawer"></v-list-item>
        </v-list>
        
      <router-link v-bind:to="{ name: 'home' }">Home</router-link>&nbsp;|&nbsp;
      <router-link v-bind:to="{ name: 'logout' }" v-if="$store.state.token != ''">Logout</router-link>
    </v-navigation-drawer>

  <v-app-bar id="inspire">
      <v-app-bar-nav-icon >
       <v-icon @click="drawer = !drawer"  icon="$vuetify"></v-icon >
      </v-app-bar-nav-icon>

      <v-app-bar-title class="text-uppercase">Rediquette</v-app-bar-title>
      <router-link v-bind:to="{ name: 'home' }">Home</router-link>&nbsp;|&nbsp;
      <router-link v-bind:to="{ name: 'logout' }" v-if="$store.state.token != ''">Logout</router-link>
      <v-btn flat color="grey">
        <span>Sign Out</span>
        <v-icon icon="$vuetify"></v-icon >
      </v-btn>
  </v-app-bar>

   
 
    <v-main >
      <v-row>
        <v-column></v-column>
      </v-row>
     
            <featured-post />
     
 
        <side-bar v-bind:forums="forums"/>
      <!-- <forum v-for="forum in activeForums" v-bind:key="forum.id" /> -->
        <main-section />
    </v-main>
  
</template>


<script>
import MainSection from '../components/MainSection.vue'
import SideBar from '../components/SideBar.vue';
// import Forum from '../components/Forum.vue';
export default {
  components: {
    MainSection,
    SideBar
    // Forum
  },
  data: () => ({ drawer: null }),
  
  // computed: {
  //       activeForums() {
  //           const forumsFilter = this.$store.state.forums;
  //           return forumsFilter;
  //       }
  //   }
};
</script>
