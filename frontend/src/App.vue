<template>
  <v-app>
    <v-app-bar app color="primary" dark>
      <h2>Card Game</h2>
      <v-btn-toggle class="ml-8">
        <v-btn block rounded color="green" class="" @click="goToAdmin">ADMIN PAGE
        </v-btn>
        <v-btn block depressed color="orange" @click="goToUser">USER PAGE
        </v-btn>
      </v-btn-toggle>
      <v-spacer></v-spacer>
      <div v-if="currentRouteName == 'user'">
        <v-btn v-if="!playerAccount" color="error" @click="connectWallet">
          Connect Wallet
        </v-btn>
        <div v-else>
          <h4>Current Player Account: </h4> {{ playerAccount }}
        </div>
      </div>
      <div v-else>
        <!-- <v-btn v-if="!playerAccount" color="error" @click="connectWallet">
          Connect Wallet
        </v-btn> -->
        <!-- <div v-else> -->
          <h4>Admin Player Account: </h4> {{ adminAccount }}
        <!-- </div> -->
      </div>
    </v-app-bar>

    <v-main>
      <router-view />
    </v-main>
  </v-app>
</template>

<script>
import GoldCoin from './../../build/contracts/GoldCoin.json'
import GameItems from './../../build/contracts/GameItems.json'
import UniqueCards from './../../build/contracts/UniqueCards.json'
import PlayerRegistration from './../../build/contracts/PlayerRegistration.json'

import { routerPush } from './utils/constants';
import { mapState, mapActions } from 'vuex';
export default {
  name: 'App',

  data: () => ({}),
  computed: {
    ...mapState('contract', ['adminAccount', 'playerAccount', 'goldCoinContractAddress', 'gameItemsContractAddress', 'uniqueCardsContractAddress', 'playerRegistrationContractAddress', 'readOnlyGoldCoinContract', 'readOnlyGameItemsContract', 'readOnlyUniqueCardsContract', 'readOnlyPlayerRegistrationContract', 'writeGoldCoinContract', 'writeGameItemsContract', 'writeUniqueCardsContract', 'writePlayerRegistrationContract']),
    ...mapState('contractMethods', ['currentPhase']),
    currentRouteName() {
      return this.$route.name;
    }
  },
  async mounted() {
    console.log(this.$ethers)
    await this.attachContracts()
    this.initializeContractFunctions()
    this.checkConnectedWalletExist();
  },
  methods: {
    ...mapActions('contract', ['updateAdminAccount', 'updatePlayerAccount', 'updateGoldCoinContractAddress', 'updateGameItemsContractAddress', 'updateUniqueCardsContractAddress', 'updatePlayerRegistrationContractAddress', 'updateReadOnlyGoldCoinContract', 'updateReadOnlyGameItemsContract', 'updateReadOnlyUniqueCardsContract', 'updateReadOnlyPlayerRegistrationContract', 'updateWriteGoldCoinContract', 'updateWriteGameItemsContract', 'updateWriteUniqueCardsContract', 'updateWritePlayerRegistrationContract']),
    ...mapActions('contractMethods', ['updateCurrentPhase']),
    goToAdmin() {
      routerPush(this, "admin")
    },
    goToUser() {
      routerPush(this, "user")
    },
    checkConnectedWalletExist: async function () {
      try {
        const { ethereum } = window;
        if (!ethereum) {
          alert("Make sure you have metamask!");
          return false;
        } else {
          console.log("We have the ethereum object", ethereum);
        }
        const accounts = await ethereum.request({ method: "eth_accounts" });
        if (accounts.length !== 0) {
          const account = accounts[0];
          console.log("Found an authorized account:", account);
          this.updatePlayerAccount(account)
          return true;
        } else {
          console.log("No authorized account found");
          return false;
        }
      } catch (error) {
        console.log(error);
        return false;
      }
    },
    connectWallet: async function () {
      try {
        const { ethereum } = window;
        if (!ethereum) {
          alert("Get MetaMask!");
          return;
        }
        const accounts = await ethereum.request({
          method: "eth_requestAccounts",
        });
        console.log("Connected", accounts[0]);
        this.updatePlayerAccount(accounts[0])
      } catch (error) {
        console.log(error);
      }
    },
    attachContracts: async function () {
      const provider = new this.$ethers.JsonRpcProvider("http://127.0.0.1:7545");
      const signer = await provider.getSigner()
      // const network = await provider.getNetwork();
      // console.log(network);

      const goldCoinAbi = GoldCoin.abi;
      const readOnlyGc = await new this.$ethers.Contract(this.goldCoinContractAddress, goldCoinAbi, provider);
      const writeGc = await new this.$ethers.Contract(this.goldCoinContractAddress, goldCoinAbi, signer);
      this.updateReadOnlyGoldCoinContract(readOnlyGc)
      this.updateWriteGoldCoinContract(writeGc)

      const uniqueCardsAbi = UniqueCards.abi;
      const readOnlyUc = await new this.$ethers.Contract(this.uniqueCardsContractAddress, uniqueCardsAbi, provider);
      const writeUc = await new this.$ethers.Contract(this.uniqueCardsContractAddress, uniqueCardsAbi, signer);
      this.updateReadOnlyUniqueCardsContract(readOnlyUc)
      this.updateWriteUniqueCardsContract(writeUc)

      const gameItemsAbi = GameItems.abi;
      const readOnlyGi = await new this.$ethers.Contract(this.gameItemsContractAddress, gameItemsAbi, provider);
      const writeGi = await new this.$ethers.Contract(this.gameItemsContractAddress, gameItemsAbi, signer);
      await this.updateReadOnlyGameItemsContract(readOnlyGi)
      await this.updateWriteGameItemsContract(writeGi)

      const playerRegistrationAbi = PlayerRegistration.abi;
      const readOnlyPr = await new this.$ethers.Contract(this.playerRegistrationContractAddress, playerRegistrationAbi, provider);
      const writePr = await new this.$ethers.Contract(this.playerRegistrationContractAddress, playerRegistrationAbi, signer);
      await this.updateReadOnlyPlayerRegistrationContract(readOnlyPr)
      await this.updateWritePlayerRegistrationContract(writePr)
    },
    initializeContractFunctions: async function () {
      console.log(this.readOnlyGameItemsContract)
      this.updateCurrentPhase(await this.readOnlyGameItemsContract.currPhase())
    }
  },
};
</script>
