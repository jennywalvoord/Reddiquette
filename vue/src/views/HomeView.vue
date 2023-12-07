<template>
  
  <div class="d-flex flex-wrap grey-lighten pa-24">
    <div class="ma-24 pa-24">
      <div class="filter-bar-wrapper">
        <filter-bar />
      </div>
      <main-section />
    </div>

      <v-navigation-drawer fixed permanent location="right">
      <div class="ma-24 pa-24">
        <side-bar v-bind:forums="forums"/>
      </div>
    </v-navigation-drawer>
    
  </div>
</template>

<script>
import MainSection from '../components/MainSection.vue';
import SideBar from '../components/SideBar.vue';
import FilterBar from '../components/FilterBar.vue'

export default {
  components: {
    MainSection,
    SideBar,
    FilterBar
  },
  data: () => ({ drawer: null }),
};
</script>
