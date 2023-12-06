<template>
<v-content>
    <div class="well">
        <div>
            
        </div>
        <div>
            <h3>
                <router-link  v-bind:to="{ name: 'forum-view', params: {id: forums.id}}">{{forums.title}}</router-link>
            </h3>
            
        
        </div>
    </div>

</v-content>

    
</template>
<script>

export default {
    props: ['forums']
   
}

</script>