<template>
  <div>
    <v-app-bar color="red lighten-5" class=" text-h5 font-weight-bold" elevation="1">
      User Page
    </v-app-bar>
    <v-container>
      <v-card elevation="4" class="" color="">
        <p class="ma-4 pa-6 text-center text-h3">
          <span class="font-weight-bold">Current Phase:</span> <span> {{ currentPhaseMapped[currentPhase] }}</span>
        </p>
      </v-card>
      <v-card elevation="3" class="py-5 " color="">
        <v-card-title class="text-h5 font-weight-bold">User Registration</v-card-title>
        <v-btn color="primary" class="ml-8" @click="registerUser" v-show="currentPhase == 0" :disabled="playerRegistered">
          Register for the game {{ playerRegistered }}
        </v-btn>
        <p class="py-6 px-8" v-if="playerRegistered">
          <span class="font-weight-bold">You have already registered for the game!</span>
        </p>
      </v-card>
    </v-container>
  </div>
</template>

<script>
import { mapState, mapGetters, mapActions } from 'vuex';

export default {
  name: 'UserPage',

  data: () => ({
    currentPhaseMapped: {
      0: 'Register',
      1: 'Play',
      2: 'Game Over',
    }
  }),
  computed: {
    ...mapState('contract', ['adminAccount', 'playerAccount', 'goldCoinContractAddress', 'gameItemsContractAddress', 'uniqueCardsContractAddress', 'playerRegistrationContractAddress', 'readOnlyGoldCoinContract', 'readOnlyGameItemsContract', 'readOnlyUniqueCardsContract', 'readOnlyPlayerRegistrationContract', 'writeGoldCoinContract', 'writeGameItemsContract', 'writeUniqueCardsContract', 'writePlayerRegistrationContract']),
    ...mapState('contractMethods', ['currentPhase', 'playerRegistered']),
    ...mapGetters('contractMethods', ['getCurrentPhase', 'getPlayerRegistered']),
  },
  mounted() {
    console.log('user')
  },
  methods: {
    ...mapActions('contract', ['updateAdminAccount', 'updatePlayerAccount', 'updateGoldCoinContractAddress', 'updateGameItemsContractAddress', 'updateUniqueCardsContractAddress', 'updatePlayerRegistrationContractAddress', 'updateReadOnlyGoldCoinContract', 'updateReadOnlyGameItemsContract', 'updateReadOnlyUniqueCardsContract', 'updateReadOnlyPlayerRegistrationContract', 'updateWriteGoldCoinContract', 'updateWriteGameItemsContract', 'updateWriteUniqueCardsContract', 'updateWritePlayerRegistrationContract']),
    ...mapActions('contractMethods', ['updateCurrentPhase', 'updatePlayerRegistered']),
    async registerUser() {
      // console.log(this.playerAccount)
      try {
        await this.writePlayerRegistrationContract.registerPlayer(this.playerAccount);
        this.updatePlayerRegistered(true)
        console.log(await this.readOnlyPlayerRegistrationContract.getAllPlayers())
      } catch (e) {
        console.error(e)
      }
    }
  },
}
</script>
