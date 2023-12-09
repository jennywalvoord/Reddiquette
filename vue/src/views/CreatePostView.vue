<template>
      <v-main class="bg-grey-lighten-3">
      <v-container>
        <v-row>
          
          <v-col>
            <v-sheet
              min-height="70vh"
              rounded="lg"
            >
            <div class="custom-padding">
        <v-content>
        <div>
        <v-text class="text-h4">Create a Post</v-text>
        <v-select
        label="Choose a forum"
        :items="['Forum1', 'Forum2', 'Forum3', 'Forum4', 'Forum5', 'Forum6']"
        ></v-select>
    </div>
    <v-card>
        <v-tabs v-model="tab" align-tabs="center">
          <v-tab :value="1">Post</v-tab>
          <v-tab :value="2">Image</v-tab>
        </v-tabs>
        <v-window v-model="tab">
          <v-window-item v-for="n in 3" :key="n" :value="n">
            <!-- Content for Tab 1: Post -->
            <v-container fluid v-if="tab === 1">
                <v-sheet width="400" class="mx-auto">
                    <v-form fast-fail @submit.prevent>
                    <v-text-field
                        v-model="title"
                        label="Title"
                        :rules="titleRules"
                    ></v-text-field>
                    <v-row>
                    <v-textarea label="Text (Optional)"></v-textarea>
                    </v-row>

                    <v-btn type="submit" block class="mt-2">Post</v-btn>
                    </v-form>
                    <div>
                    
                      <tiptap-rich-text-editor />

                    </div>
                </v-sheet>
             
            </v-container>

            <!-- Content for Tab 2: Image -->
            <v-container fluid v-else-if="tab === 2">
              <v-row>
               
                  <v-file-input
                    label="File input"
                    variant="filled"
                    prepend-icon="mdi-camera"
                ></v-file-input>
               
              </v-row>
            </v-container>

          
          </v-window-item>
        </v-window>
      </v-card>
    </v-content>
    </div>
            </v-sheet>
          </v-col>

          <v-col cols="2">
            <v-sheet rounded="lg">
              <v-list rounded="lg">
                <v-list-item
                  v-for="n in 5"
                  :key="n"
                  link
                  :title="`List Item ${n}`"
                ></v-list-item>

                <v-divider class="my-2"></v-divider>

                <v-list-item
                  color="grey-lighten-4"
                  link
                  title="Refresh"
                ></v-list-item>
              </v-list>
            </v-sheet>
          </v-col>

        </v-row>
      </v-container>
    </v-main>
   
    
    
</template>

<script>
import TiptapRichTextEditor from '../components/TiptapRichTextEditor.vue';

export default {
  components: { TiptapRichTextEditor },
  data() {
    return {
      components: {
        TiptapRichTextEditor
      },
      tab: 1, // Set the initial value to 1 for the "Post" tab
    };
  },
};
</script>

<style>
.custom-padding {
  padding: 100px;
}
</style>