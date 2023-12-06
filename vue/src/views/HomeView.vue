<template>
  <!-- <v-navigation-drawer v-model="drawer" app>
    <v-list>
        <v-list-item title="Navigation drawer"></v-list-item>
        </v-list>
        
      <router-link v-bind:to="{ name: 'home' }">Home</router-link>&nbsp;|&nbsp;
      <router-link v-bind:to="{ name: 'logout' }" v-if="$store.state.token != ''">Logout</router-link>
    </v-navigation-drawer> -->

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
  
  <v-sheet class="d-flex flex-wrap grey-lighten pa-24">
    <v-sheet class="flex-1-0 ma-24 pa-24">
    <main-section />

    </v-sheet>
    
    <v-sheet class="ma-2 pa-2 sidebar">
      <side-bar v-bind:forums="forums"/>

    </v-sheet>

    
  </v-sheet>
  
</template>


<script>
import MainSection from '../components/MainSection.vue'
import SideBar from '../components/SideBar.vue';

export default {
  components: {
    MainSection,
    SideBar,
  },
  data: () => ({ drawer: null }),
};
</script>

<style>
.sidebar {
position: sticky
}
div.home {
  flex-flow: row;
}

.main {
  display: flex;
}

</style>