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
        <v-card-title class="text-h5 font-weight-bold">Phase Controls</v-card-title>
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
    ...mapState('contract', ['adminAccount', 'playerAccount', 'goldCoinContractAddress', 'gameItemsContractAddress', 'uniqueCardsContractAddress', 'playerRegistrationContractAddress', 'readOnlyGoldCoinContract', 'readOnlyGameItemsContract', 'readOnlyUniqueCardsContract', 'readOnlyPlayerRegistrationContract', 'writeGoldCoinContract', 'writeGameItemsContract', 'writeUniqueCardsContract', 'writePlayerRegistrationContract']),//, 'web3Provider', 'web3']),
    ...mapState('contractMethods', ['currentPhase', 'playerRegistered']),
    ...mapGetters('contractMethods', ['getCurrentPhase', 'getPlayerRegistered']),
  },
  methods: {
    ...mapActions('contract', ['updateAdminAccount', 'updatePlayerAccount', 'updateGoldCoinContractAddress', 'updateGameItemsContractAddress', 'updateUniqueCardsContractAddress', 'updatePlayerRegistrationContractAddress', 'updateReadOnlyGoldCoinContract', 'updateReadOnlyGameItemsContract', 'updateReadOnlyUniqueCardsContract', 'updateReadOnlyPlayerRegistrationContract', 'updateWriteGoldCoinContract', 'updateWriteGameItemsContract', 'updateWriteUniqueCardsContract', 'updateWritePlayerRegistrationContract']),//, 'updateWeb3Provider', 'updateWeb3']),
    ...mapActions('contractMethods', ['updateCurrentPhase', 'updatePlayerRegistered']),
    async nextGamePhase() {
      let phase = this.currentPhase
      await this.writeGameItemsContract.changePhase(++phase)
      this.updateCurrentPhase(await this.readOnlyGameItemsContract.currPhase())
      if (this.currentPhase == 2) {
        this.endgame()
      }
    },
    async createPowerUp() {
      await this.writeGameItemsContract.createItem(0, 'power up 0', 'this is a power up')
      // console.log(await this.readOnlyGameItemsContract.items())
    },
    async endgame() {
      // console.log(await this.readOnlyGameItemsContract.items())
    },
  },
}
</script>
