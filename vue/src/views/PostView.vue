<template>

    <v-main class="bg-grey-lighten-4">
        <v-container>
            <v-row>
                <v-col>
                    <v-sheet 
                    min-height="90vh"
                    rounded="lg"
                    class="ma-4 pa-4"
                    >
                    <post-section />

                    </v-sheet>
                </v-col>
            </v-row>
        </v-container>
    </v-main>
    <side-bar v-bind:forums="forums" />
    
        <v-sheet class="flex-1-1-100 ma-2 pa-2">
        </v-sheet>
</template>

<script>

import SideBar from '../components/SideBar.vue';
import PostSection from '../components/PostSection.vue';

export default {
    components: {
        SideBar,
        PostSection,
    },
    
}
</script>
