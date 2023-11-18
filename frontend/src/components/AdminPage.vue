<template>
  <div>
    <v-app-bar color="red lighten-5" class=" text-h5 font-weight-bold" elevation="1">
      Admin Page
    </v-app-bar>
    <v-container>
      <v-card elevation="4" class="" color="">
        <p class="ma-4 pa-6 text-center text-h3">
          <span class="font-weight-bold">Current Phase:</span> <span> {{ currentPhaseMapped[currentPhase] }}</span>
        </p>
      </v-card>
      <v-card elevation="3" class="py-5 " color="">
        <v-card-title class="text-h5 font-weight-bold">Admin Functions</v-card-title>
        <v-btn color="primary" class="ml-8" @click="nextGamePhase" :disabled="currentPhase > 1">
          Next Phase
        </v-btn>
      </v-card>
    </v-container>
  </div>
</template>

<script>
import { mapState, mapGetters, mapActions } from 'vuex';
export default {
  name: 'AdminPage',

  data: () => ({
    currentPhaseMapped: {
      0: 'Register',
      1: 'Play',
      2: 'Game Over',
    }
  }),
  async mounted() {
  },
  computed: {
    ...mapState('contract', ['currentAccount', 'goldCoinContractAddress', 'gameItemsContractAddress', 'uniqueCardsContractAddress', 'readOnlyGoldCoinContract', 'readOnlyGameItemsContract', 'readOnlyUniqueCardsContract', 'writeGoldCoinContract', 'writeGameItemsContract', 'writeUniqueCardsContract']),
    ...mapState('contractMethods', ['currentPhase']),
    ...mapGetters('contractMethods', ['getCurrentPhase']),
  },
  methods: {
    ...mapActions('contract', ['updateCurrentAccount', 'updateGoldCoinContractAddress', 'updateGameItemsContractAddress', 'updateUniqueCardsContractAddress', 'updateReadOnlyGoldCoinContract', 'updateReadOnlyGameItemsContract', 'updateReadOnlyUniqueCardsContract', 'updateWriteGoldCoinContract', 'updateWriteGameItemsContract', 'updateWriteUniqueCardsContract']),
    ...mapActions('contractMethods', ['updateCurrentPhase']),
    async nextGamePhase() {
      let phase = this.currentPhase
      await this.writeGameItemsContract.changePhase(++phase)
      this.updateCurrentPhase(await this.readOnlyGameItemsContract.currPhase())
    }
  },
}
</script>
