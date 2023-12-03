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

      <v-card elevation="3" class="mt-5 py-5 ">
        <v-card-title class="text-h5 font-weight-bold">Create Materials</v-card-title>
        <v-btn color="primary" class="my-6 ml-8" @click="createPowerUp">
          Create 10 Power Ups
        </v-btn>
        <span class="ml-8 font-weight-bold">{{ powerUps }} power ups available</span>
        <div></div>
        <v-btn color="primary" class="my-6 ml-8" @click="createMods">
          Create 10 Mods
        </v-btn>
        <span class="ml-8 font-weight-bold">{{ mods }} mods available</span>
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
    },
    // powerUps: 0,
    // mods: 0
  }),
  async mounted() {
  },
  computed: {
    ...mapState('contract', ['adminAccount', 'playerAccount', 'goldCoinContractAddress', 'gameItemsContractAddress', 'uniqueCardsContractAddress', 'playerRegistrationContractAddress', 'readOnlyGoldCoinContract', 'readOnlyGameItemsContract', 'readOnlyUniqueCardsContract', 'readOnlyPlayerRegistrationContract', 'writeGoldCoinContract', 'writeGameItemsContract', 'writeUniqueCardsContract', 'writePlayerRegistrationContract']),//, 'web3Provider', 'web3']),
    ...mapState('contractMethods', ['currentPhase', 'playerRegistered', 'powerUps', 'mods']),
    ...mapGetters('contractMethods', ['getCurrentPhase', 'getPlayerRegistered']),
  },
  methods: {
    ...mapActions('contract', ['updateAdminAccount', 'updatePlayerAccount', 'updateGoldCoinContractAddress', 'updateGameItemsContractAddress', 'updateUniqueCardsContractAddress', 'updatePlayerRegistrationContractAddress', 'updateReadOnlyGoldCoinContract', 'updateReadOnlyGameItemsContract', 'updateReadOnlyUniqueCardsContract', 'updateReadOnlyPlayerRegistrationContract', 'updateWriteGoldCoinContract', 'updateWriteGameItemsContract', 'updateWriteUniqueCardsContract', 'updateWritePlayerRegistrationContract']),//, 'updateWeb3Provider', 'updateWeb3']),
    ...mapActions('contractMethods', ['updateCurrentPhase', 'updatePlayerRegistered', 'updatePowerUps', 'updateMods']),
    async nextGamePhase() {
      let phase = this.currentPhase
      await this.writeGameItemsContract.changePhase(++phase)
      await web3.eth.sendTransaction({
        from: this.playerAccount,
        to: this.goldCoinContractAddress,
        value: 10000000
      })
        .then(function (receipt) {
          console.log(receipt)
        })

      this.updateCurrentPhase(await this.readOnlyGameItemsContract.currPhase())
      if (this.currentPhase == 2) {
        this.endgame()
      }
    },
    async createPowerUp() {
      await this.writeGameItemsContract.createItem(0, 'power up 0', 'this is a power up')
      
      await web3.eth.sendTransaction({
        from: this.playerAccount,
        to: this.gameItemsContractAddress,
        value: 10000000
      })
        .then(function (receipt) {
          console.log(receipt)
        })


      // var code = "0x603d80600c6000396000f3007c01000000000000000000000000000000000000000000000000000000006000350463c6888fa18114602d57005b6007600435028060005260206000f3";


      // // using the callback
      // await web3.eth.sendTransaction({
      //   from: this.playerAccount,
      //   data: code // deploying a contracrt
      // });

      this.updatePowerUps(this.powerUps + 10)
    },
    async createMods() {
      await this.writeGameItemsContract.createItem(1, 'Mod 0', 'this is a mod')
      await web3.eth.sendTransaction({
        from: this.playerAccount,
        to: this.gameItemsContractAddress,
        value: 10000000
      })
        .then(function (receipt) {
          console.log(receipt)
        })
      this.updateMods(this.mods + 10)
      // await web3.eth.sendTransaction({
      //   from: this.playerAccount,
      //   to: this.goldCoinContractAddress,
      //   value: 10000000
      // })
      //   .then(function (receipt) {
      //     console.log(receipt)
      //   })

      // console.log(await this.readOnlyGameItemsContract.items())
    },
    async endgame() {
    },
  },
}
</script>
