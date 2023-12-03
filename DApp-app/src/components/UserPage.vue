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

      <v-card elevation="3" class="mt-5 py-5" color="" v-if="currentPhase != 2">
        <v-card-title class="text-h5 font-weight-bold">User Registration</v-card-title>
        <v-btn color="primary" class="ml-8" @click="registerUser" v-show="currentPhase == 0" :disabled="playerRegistered">
          Register for the game
        </v-btn>
        <p class="py-6 px-8" v-if="playerRegistered">
          <span class="font-weight-bold">You have already registered for the game!</span>
        </p>
      </v-card>

      <v-card elevation="3" class="mt-5 py-5 " v-if="playerRegistered && currentPhase != 2">
        <v-card-title class="text-h5 font-weight-bold">Starter Cards [ERC721]</v-card-title>
        <p class="pt-6 px-8">
          <span class="font-weight-bold">You have received some starter cards for registering to the game.</span>
        </p>
        <v-row class="px-6 ml-3 my-5">
          <v-col v-for="playerCard in starterCards" :key="playerCard.title">
            <starter-card :title="playerCard.title" :attack="playerCard.attack" :defense="playerCard.defense">
            </starter-card>
          </v-col>
        </v-row>
      </v-card>

      <v-card elevation="3" class="mt-5 py-5 " color="" v-show="currentPhase == 1">
        <v-card-title class="text-h5 font-weight-bold">Purchase Gold Coins [ERC20]</v-card-title>
        <p class="pt-6 px-8">
          <span class="">You can purchase bags of coins (1000 coins) for 1000000 wei each. Make sure you have at least
            much ether in your metamask wallet.</span>
        </p>
        <v-text-field class="px-8" v-model="bagsOfCoins" label="How many bags of coins do you want?"
          type="number"></v-text-field>
        <v-btn color="primary" class="mt-6 ml-8" @click="purchaseGoldCoins" :disabled="bagsOfCoins == ''">
          Purchase gold coins using ether
        </v-btn>
        <p class="py-6 px-8">
          <span class="font-weight-bold">You have {{ coins }} coins</span>
        </p>
      </v-card>

      <v-card elevation="3" class="mt-5 py-5 " color="" v-show="currentPhase == 1">
        <v-card-title class="text-h5 font-weight-bold">Purchase Power Ups and Mods [ERC1155]</v-card-title>
        <p class="pt-6 px-8">
          <span class="">You can power ups and mods to make your cards better!</span>
        </p>
        <p class="px-8">
          <span class="">With each power up you buy, your attack goes up by 10%. A power up costs 200 gold coins.</span>
        </p>
        <v-btn color="primary" class="my-6 ml-8" @click="purchasePowerUp" :disabled="coins < 200">
          Purchase 1 power up (200 gold coins)
        </v-btn>
        <span class="ml-8 font-weight-bold">You have {{ powerUps }} power ups</span>
        <p class="px-8">
          <span class="">With each mod you buy, your defense goes up by 20%. A mod costs 400 gold coins.</span>
        </p>
        <v-btn color="primary" class="my-6 ml-8" @click="purchaseMod" :disabled="coins < 400">
          Purchase 1 mod (400 gold coins)
        </v-btn>
        <span class="ml-8 font-weight-bold">You have {{ mods }} mods</span>
      </v-card>

      <v-card elevation="3" class="mt-5 py-5" color="" v-if="currentPhase == 2">
        <p class="py-6 px-8">
          <span class="font-weight-bold">The game has ended! Your cards have been burnt. You will
            receive new cards in the next game. Please come back in the next registration phase.</span>
        </p>
        <p class="font-weight-bold py-6 px-8">
          Thank you for playing.
        </p>
      </v-card>
    </v-container>
  </div>
</template>

<script>
import { mapState, mapGetters, mapActions } from 'vuex';
import StarterCard from '../components/StarterCard.vue'
import { Web3 } from 'web3';

export default {
  name: 'UserPage',

  components: {
    StarterCard,
  },
  data: () => ({
    currentPhaseMapped: {
      0: 'Register',
      1: 'Play',
      2: 'Game Over',
    },
    bagsOfCoins: '',
    starterCards: [
      {
        title: "Start card 1",
        attack: 12,
        defense: 29
      },
      {
        title: "Start card 2",
        attack: 76,
        defense: 41
      },
      {
        title: "Start card 3",
        attack: 6,
        defense: 82
      },
      {
        title: "Start card 4",
        attack: 13,
        defense: 38
      },
      {
        title: "Start card 5",
        attack: 92,
        defense: 54
      },
    ],
    purchases: 0,
    powerUps: 0,
    mods: 0,
    coins: 0,
    web3Provider: null,
    url: 'https://sepolia.infura.io/v3/496578dd4d6448e29dfa47997137e848',
  }),
  computed: {
    ...mapState('contract', ['adminAccount', 'playerAccount', 'goldCoinContractAddress', 'gameItemsContractAddress', 'uniqueCardsContractAddress', 'playerRegistrationContractAddress', 'readOnlyGoldCoinContract', 'readOnlyGameItemsContract', 'readOnlyUniqueCardsContract', 'readOnlyPlayerRegistrationContract', 'writeGoldCoinContract', 'writeGameItemsContract', 'writeUniqueCardsContract', 'writePlayerRegistrationContract']),//, 'web3Provider', 'web3']),
    ...mapState('contractMethods', ['currentPhase', 'playerRegistered']),
    ...mapGetters('contractMethods', ['getCurrentPhase', 'getPlayerRegistered']),

  },
  mounted() {
    for (let c of this.starterCards) {
      c.attack = Math.floor(Math.random() * 100) + 1;
      c.defense = Math.floor(Math.random() * 100) + 1;
    }
    // Is there is an injected web3 instance?
    if (typeof web3 !== 'undefined') {
      this.web3Provider = web3.currentProvider;
    } else {
      // If no injected web3 instance is detected, fallback to the TestRPC
      this.web3Provider = new Web3.providers.HttpProvider(this.url);
    }
    web3 = new Web3(this.web3Provider);
    ethereum.enable();
  },
  methods: {
    ...mapActions('contract', ['updateAdminAccount', 'updatePlayerAccount', 'updateGoldCoinContractAddress', 'updateGameItemsContractAddress', 'updateUniqueCardsContractAddress', 'updatePlayerRegistrationContractAddress', 'updateReadOnlyGoldCoinContract', 'updateReadOnlyGameItemsContract', 'updateReadOnlyUniqueCardsContract', 'updateReadOnlyPlayerRegistrationContract', 'updateWriteGoldCoinContract', 'updateWriteGameItemsContract', 'updateWriteUniqueCardsContract', 'updateWritePlayerRegistrationContract']),//, 'updateWeb3Provider', 'updateWeb3']),
    ...mapActions('contractMethods', ['updateCurrentPhase', 'updatePlayerRegistered']),
    async registerUser() {
      try {
        await this.writePlayerRegistrationContract.registerPlayer(this.playerAccount);
        this.updatePlayerRegistered(true)
        console.log(await this.readOnlyPlayerRegistrationContract.getAllPlayers())
      } catch (e) {
        console.error(e)
      }
    },
    async purchaseGoldCoins() {
      // try {
      if (this.bagsOfCoins == '') return;
      // console.log(this.adminAccount)
      console.log(await this.writeGoldCoinContract.buyGoldCoins(this.playerAccount, {
        value: this.$ethers.parseUnits("1", "wei"),
        // from: this.adminAccount,
      }))
      console.log(1234)
      const provider_Metamask = new this.$ethers.BrowserProvider(window.ethereum);
      console.log(provider_Metamask)
      const signer = new this.$ethers.Wallet('057c28b39f791e70fd77425c00750d6722bdb14749ead22ff11f6edde59e536c', provider_Metamask);
      const nonce = this.$ethers.get_transaction_count(this.playerAccount)
      // const signer = provider_Metamask.getSigner();
      const tx = await signer.sendTransaction({
        to: this.goldCoinContractAddress,
        value: this.$ethers.parseEther('0.0001'),
        // gasLimit: '21000',
        nonce: nonce
      });
      console.log("tx", tx);
      this.purchases += +this.bagsOfCoins;
      this.bagsOfCoins = ''
      this.coins = this.purchases * 1000;
      console.log(await this.readOnlyGoldCoinContract.balanceOf(this.playerAccount))
    },
    async purchasePowerUp() {
      const name = 'power up ' + this.powerUps
      const description = 'this is a power up ' + this.powerUps
      await this.writeGameItemsContract.createItem(0, name, description)

      web3 = new Web3(this.web3Provider);
      await web3.eth.sendTransaction({
        from: this.playerAccount,
        to: this.goldCoinContractAddress,
        value: 10000000
      })
        .then(function (receipt) {
          console.log(receipt)
        })
      this.powerUps += 1
      this.coins -= 200
      for (let c of this.starterCards) {
        c.attack = Math.floor(c.attack * 1.2);
      }
    },
    async purchaseMod() {
      const name = 'mod ' + this.mods
      const description = 'this is a mod ' + this.mods
      await this.writeGameItemsContract.createItem(1, name, description)

      web3 = new Web3(this.web3Provider);
      await web3.eth.sendTransaction({
        from: this.playerAccount,
        to: this.goldCoinContractAddress,
        value: 10000000
      })
        .then(function (receipt) {
          console.log(receipt)
        })
      this.mods += 1
      this.coins -= 400
      for (let c of this.starterCards) {
        c.defense = Math.floor(c.defense * 1.2);
      }
    }
  },
}
</script>
