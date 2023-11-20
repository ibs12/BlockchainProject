<template>
  <v-sheet color="grey lighten-5" max-width="280" rounded class="pt-3 pb-3" elevation="1">
    <v-alert class="mx-4 text-center" color="purple" width="250" outlined>
      <div text class="black--text text-overline">
        <b>CARD NAME: </b>{{ title }}
      </div>
      <div class="black--text text-caption">
        <b>ATTACK: </b>{{ attack }}
      </div>
      <div class="black--text text-caption">
        <b>DEFENSE: </b>{{ defense }}
      </div>
    </v-alert>
  </v-sheet>
</template>

<script>
export default {
  name: 'StarterCard',

  data: () => ({
    // publicPath: process.env.BASE_URL
  }),
  props: ['attack', 'title', 'defense']
}
</script>