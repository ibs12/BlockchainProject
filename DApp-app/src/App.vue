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
        <h4>Admin Player Account: </h4> {{ adminAccount }}
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
import Web3 from 'web3';
export default {
  name: 'App',

  data: () => ({
    web3Provider: null,
    url: 'https://sepolia.infura.io/v3/496578dd4d6448e29dfa47997137e848',
  }),
  computed: {
    ...mapState('contract', ['adminAccount', 'playerAccount', 'goldCoinContractAddress', 'gameItemsContractAddress', 'uniqueCardsContractAddress', 'playerRegistrationContractAddress', 'readOnlyGoldCoinContract', 'readOnlyGameItemsContract', 'readOnlyUniqueCardsContract', 'readOnlyPlayerRegistrationContract', 'writeGoldCoinContract', 'writeGameItemsContract', 'writeUniqueCardsContract', 'writePlayerRegistrationContract']),//, 'web3Provider', 'web3']),
    ...mapState('contractMethods', ['currentPhase']),
    currentRouteName() {
      return this.$route.name;
    }
  },
  async mounted() {
    // Is there is an injected web3 instance?
    if (typeof web3 !== 'undefined') {
      console.log(1111)
      this.web3Provider = web3.currentProvider;
    } else {
      // If no injected web3 instance is detected, fallback to the TestRPC
      console.log(2222)
      this.web3Provider = new Web3.providers.HttpProvider(this.url);
    }
    web3 = new Web3(this.web3Provider);
    ethereum.enable();
    console.log(this.web3Provider)
    console.log(this.$ethers)
    await this.attachContracts()
    await this.checkConnectedWalletExist();
    await this.initializeContractFunctions()
  },
  methods: {
    ...mapActions('contract', ['updateAdminAccount', 'updatePlayerAccount', 'updateGoldCoinContractAddress', 'updateGameItemsContractAddress', 'updateUniqueCardsContractAddress', 'updatePlayerRegistrationContractAddress', 'updateReadOnlyGoldCoinContract', 'updateReadOnlyGameItemsContract', 'updateReadOnlyUniqueCardsContract', 'updateReadOnlyPlayerRegistrationContract', 'updateWriteGoldCoinContract', 'updateWriteGameItemsContract', 'updateWriteUniqueCardsContract', 'updateWritePlayerRegistrationContract']),//, 'updateWeb3Provider', 'updateWeb3']),
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
      console.log(this.url)
      const network = 11155111
      const provider = new this.$ethers.InfuraProvider(
        network,
        '496578dd4d6448e29dfa47997137e848'
      );
      // Creating a signing account from a private key
      const signer = new this.$ethers.Wallet('febcea2171fea9b98638adcc497881210cc30d07b0a49762edcf6d691aac7296', provider);
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

      // this.f(provider, signer)
    },
    initializeContractFunctions: async function () {
      console.log(this.readOnlyGameItemsContract)
      this.updateCurrentPhase(await this.readOnlyGameItemsContract.currPhase())
    },
    async f(provider, signer) {
      // Creating a transaction param
      const tx = {
        from: this.playerAccount,
        to: this.adminAccount,
        value: this.$ethers.parseEther("0.0005"),
        nonce: await provider.getTransactionCount(this.playerAccount, "latest"),
      };

      signer.sendTransaction(tx).then((transaction) => {
        console.dir(transaction);
        alert("Send finished!");
      });
    },
    async sendTransaction(signer) {
      // create transaction
      console.log(this.writeGoldCoinContract)
      const unsignedTrx = await this.writeGoldCoinContract.buyGoldCoins(this.playerAccount, {
        value: 1,
        from: this.playerAccount,
      }).populateTransaction
      console.log('Transaction created');
      // send transaction via signer so it's automatically signed
      const trxResponse = await signer.sendTransaction(unsignedTrx);

      console.log(`Transaction signed and sent: ${txResponse.hash}`);
      // wait for block
      await trxResponse.wait(1);
      console.log(
        `Transaction has been mined at blocknumber: ${txResponse.blockNumber}, transaction hash: ${txResponse.hash}`
      );
    }
  },
};
</script>
