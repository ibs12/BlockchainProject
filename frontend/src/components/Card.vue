<template>
  <v-sheet color="grey lighten-5" max-width="280" rounded class="pt-3 pb-3" elevation="1">
    <!-- <v-img :height="300" :width="250" :aspect-ratio="4 / 5"
      :src="image != '' ? `${publicPath}images/people/${image}` : `${publicPath}images/people/placeholder.jpeg`"
      class="mx-4 mt-4 mb-1 grey lighten-2">
    </v-img> -->
    <v-alert class="mx-4 text-center" color="purple" width="250" outlined>
      <v-btn text v-if="link != ''" :href="link ? link : null" target="_blank" class="indigo--text text-overline">
        {{ name }}
      </v-btn>
      <div text v-else class="black--text text-overline">
        {{ name }}
      </div>
      <div class="black--text text-caption">
        {{ title }}
      </div>
      <div class="black--text text-caption">
        {{ department }}
      </div>
    </v-alert>
  </v-sheet>
</template>

<script>
export default {
  name: 'Card',

  data: () => ({
    publicPath: process.env.BASE_URL
  }),
  props: ['image', 'link', 'name', 'title', 'department']
}
</script>