<template>
  <div>
    <v-app-bar color="red lighten-5" class=" text-h5 font-weight-bold" elevation="1">
      User Page
    </v-app-bar>
    <v-container>
      <v-card elevation="4" class="mt-5 " color="">
        <p class="ma-4 pa-6 text-center text-h3">
          <span class="font-weight-bold">Current Phase:</span> <span> {{ currentPhaseMapped[currentPhase] }}</span>
        </p>
      </v-card>

      <v-card elevation="3" class="mt-5 py-5" color="">
        <v-card-title class="text-h5 font-weight-bold">User Registration</v-card-title>
        <v-btn color="primary" class="ml-8" @click="registerUser" v-show="currentPhase == 0" :disabled="playerRegistered">
          Register for the game
        </v-btn>
        <p class="py-6 px-8" v-if="playerRegistered">
          <span class="font-weight-bold">You have already registered for the game!</span>
        </p>
      </v-card>

      <v-card elevation="3" class="mt-5 py-5 " color="">
        <v-card-title class="text-h5 font-weight-bold">Purchase Gold Coins</v-card-title>
        <p class="pt-6 px-8">
          <span class="">You can purchase bags of coins (1000 coins) for 0.0000001 ether each. Make sure you have at least
            much ether in your metamask wallet.</span>
        </p>
        <v-text-field class="px-8" v-model="bagsOfCoins" label="How many bags of coins do you want?"
          type="number"></v-text-field>
        <v-btn color="primary" class="mt-6 ml-8" @click="purchaseGoldCoins" v-show="currentPhase == 0">
          Purchase gold coins using ether
        </v-btn>
        <p class="py-6 px-8" v-if="playerRegistered">
          <span class="font-weight-bold">You have already registered for the game!</span>
        </p>
      </v-card>

      <v-card>

        <v-row>
          <v-col v-for="playerCard in playerCards" :key="playerCard.title">
            <!-- xl="3" lg="3" md="4" sm="6" xs="12"> -->
            <card :image="person.image" :link="person.link" :name="person.name" :title="person.title"
              :department="person.department">
            </card>
          </v-col>
        </v-row>
      </v-card>

    </v-container>
  </div>
</template>

<script>
import { mapState, mapGetters, mapActions } from 'vuex';
import Card from '../components/Card.vue'

export default {
  name: 'UserPage',

  data: () => ({
    components: {
      Card,
    },
    currentPhaseMapped: {
      0: 'Register',
      1: 'Play',
      2: 'Game Over',
    },
    bagsOfCoins: ''
  }),
  computed: {
    ...mapState('contract', ['adminAccount', 'playerAccount', 'goldCoinContractAddress', 'gameItemsContractAddress', 'uniqueCardsContractAddress', 'playerRegistrationContractAddress', 'readOnlyGoldCoinContract', 'readOnlyGameItemsContract', 'readOnlyUniqueCardsContract', 'readOnlyPlayerRegistrationContract', 'writeGoldCoinContract', 'writeGameItemsContract', 'writeUniqueCardsContract', 'writePlayerRegistrationContract']),
    ...mapState('contractMethods', ['currentPhase', 'playerRegistered', 'starterCards']),
    ...mapGetters('contractMethods', ['getCurrentPhase', 'getPlayerRegistered'])
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
    },
    async purchaseGoldCoins() {
      // console.log(this.playerAccount)
      try {
        console.log(this.bagsOfCoins)
        // await this.writePlayerRegistrationContract.registerPlayer(this.playerAccount);
        console.log(this.bagsOfCoins)
        // this.updatePlayerRegistered(true)
        const playerCards = await this.readOnlyPlayerRegistrationContract.getPlayerCards(this.playerAccount)
        // console.log(playerCards[0])
        for (let card in playerCards) {
          console.log(card)
        }
        console.log(await this.writeGoldCoinContract.buyGoldCoins(this.adminAccount, {
          value: 10000000000000000
          // from: this.adminAccount,
          // from: this.playerAccount,
          // from: '0x5F45Aa4c39E0FfCAE17548C11cB9066b4478Bb22'
        }))
        console.log(await this.readOnlyGoldCoinContract.balanceOf('0x5F45Aa4c39E0FfCAE17548C11cB9066b4478Bb22'))
        console.log()
      } catch (e) {
        console.error(e)
      }
    }
  },
}
</script>
