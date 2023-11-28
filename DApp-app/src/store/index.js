import Vue from 'vue'
import Vuex from 'vuex'
import contract from "./modules/contract.module"
import contractMethods from "./modules/contractMethods.module"

Vue.use(Vuex)

export default new Vuex.Store({
  modules: {
    contract,
    contractMethods
  }
})
