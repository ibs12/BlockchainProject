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
      <v-btn v-if="!currentAccount" color="error" @click="connectWallet">
        Connect Wallet
      </v-btn>
      <div v-else>
        <h4>Current Account: </h4> {{ currentAccount }}
      </div>
      <!-- <button class="primaryButton" @click="connectWallet">Connect Wallet</button> -->
      <!-- <div class="d-flex  align-center">
        <v-img
          alt="Vuetify Logo"
          class="shrink mr-2"
          contain
          src="https://cdn.vuetifyjs.com/images/logos/vuetify-logo-dark.png"
          transition="scale-transition"
          width="40"
        />

        <v-img
          alt="Vuetify Name"
          class="shrink mt-1 hidden-sm-and-down"
          contain
          min-width="100"
          src="https://cdn.vuetifyjs.com/images/logos/vuetify-name-dark.png"
          width="100"
        />
      </div>

      <v-spacer></v-spacer>

      <v-btn
        href="https://github.com/vuetifyjs/vuetify/releases/latest"
        target="_blank"
        text
      >
        <span class="mr-2">Latest Release</span>
        <v-icon>mdi-open-in-new</v-icon>
      </v-btn> -->
    </v-app-bar>

    <v-main>
      <router-view />
    </v-main>
  </v-app>
</template>

<script>
import GoldCoin from './../../frontend_2/BlockchainProject/build/contracts/GoldCoin.json'
import GameItems from './../../frontend_2/BlockchainProject/build/contracts/GameItems.json'
import UniqueCards from './../../frontend_2/BlockchainProject/build/contracts/UniqueCards.json'

import { routerPush } from './utils/constants';
import { mapState, mapActions } from 'vuex';
export default {
  name: 'App',

  data: () => ({}),
  computed: {
    ...mapState('contract', ['currentAccount', 'goldCoinContractAddress', 'gameItemsContractAddress', 'uniqueCardsContractAddress', 'readOnlyGoldCoinContract', 'readOnlyGameItemsContract', 'readOnlyUniqueCardsContract', 'writeGoldCoinContract', 'writeGameItemsContract', 'writeUniqueCardsContract']),
    ...mapState('contractMethods', ['currentPhase'])
  },
  async mounted() {
    console.log(this.$ethers)
    await this.attachContracts()
    this.initializeContractFunctions()
    // this.checkConnectedWalletExist();
  },
  methods: {
    ...mapActions('contract', ['updateCurrentAccount', 'updateGoldCoinContractAddress', 'updateGameItemsContractAddress', 'updateUniqueCardsContractAddress', 'updateReadOnlyGoldCoinContract', 'updateReadOnlyGameItemsContract', 'updateReadOnlyUniqueCardsContract', 'updateWriteGoldCoinContract', 'updateWriteGameItemsContract', 'updateWriteUniqueCardsContract']),
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
          this.updateCurrentAccount(account)
          // this.currentAccount = account;
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
        this.updateCurrentAccount(accounts[0])
      } catch (error) {
        console.log(error);
      }
    },
    attachContracts: async function () {
      console.log(this.$ethers)
      const provider = new this.$ethers.JsonRpcProvider("http://127.0.0.1:7545");
      console.log(provider)
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

      // console.log(await readOnlyGc);
      // console.log(await readOnlyGc.owner())
      // console.log(await readOnlyGc.balanceOf("0x8AfA8198273Ca1113961514F4195DD6Ab740a3B1"))
      // console.log(await readOnlyGc.balanceOf("0x5F45Aa4c39E0FfCAE17548C11cB9066b4478Bb22"))
      // console.log(await writeGc.transfer("0x5F45Aa4c39E0FfCAE17548C11cB9066b4478Bb22", "100000"))
      // console.log(await readOnlyGc.balanceOf("0x8AfA8198273Ca1113961514F4195DD6Ab740a3B1"))
      // console.log(await readOnlyGc.balanceOf("0x5F45Aa4c39E0FfCAE17548C11cB9066b4478Bb22"))
      // console.log(await gc.symbol());
      // console.log(await this.currentContract.symbol());

      // console.log(await readOnlyGi);
      // console.log(await readOnlyGi.getAllBalances);
      // console.log(await writeGi.owner());
      // console.log(await writeUc.createUniqueCard('test', 'tessst'));
      // console.log(await readOnlyGi.currPhase());
    },
    initializeContractFunctions: async function () {
      this.updateCurrentPhase(await this.readOnlyGameItemsContract.currPhase())
      // console.log(await this.readOnlyGameItemsContract.currPhase())
      // console.log(this.currentPhase)
    }
  },
};
</script>
