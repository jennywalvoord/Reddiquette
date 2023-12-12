<template>
    <div class="well">
        <div>
            
        </div>
        <div>
            <h3>
                <router-link  v-bind:to="{ name: 'forum-view', params: {id: forums.id}}">{{forums.title}}</router-link>
            </h3>
            
        
        </div>
    </div>
</template>

<script>
import ForumService from '../services/ForumService.js';

export default {
    props: ['forum'],
}
</script>