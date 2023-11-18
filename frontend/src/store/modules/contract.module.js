const state = {
  currentAccount: "0x8AfA8198273Ca1113961514F4195DD6Ab740a3B1",
  goldCoinContractAddress: "0x2262AEf5f227d9810DBdE592e2698dd930fF13f1",
  gameItemsContractAddress: "0x5686786C964f564cd50395abFB5E0153F2078600",
  uniqueCardsContractAddress: "0xB87445f09ffD4D244b9381F2E872F3bFdB0f5d36",
  readOnlyGoldCoinContract: null,
  readOnlyGameItemsContract: null,
  readOnlyUniqueCardsContract: null,
  writeGoldCoinContract: null,
  writeGameItemsContract: null,
  writeUniqueCardsContract: null,
};

const mutations = {
  SET_CURRENT_ACCOUNT(state, value) {
    state.currentAccount = value;
  },
  SET_GOLD_COIN_CONTRACT_ADDRESS(state, value) {
    state.goldCoinContractAddress = value;
  },
  SET_GAME_ITEMS_CONTRACT_ADDRESS(state, value) {
    state.gameItemsContractAddress = value;
  },
  SET_UNIQUE_CARDS_CONTRACT_ADDRESS(state, value) {
    state.uniqueCardsContractAddress = value;
  },
  SET_READ_ONLY_GOLD_COIN_CONTRACT(state, value) {
    state.readOnlyGoldCoinContract = value;
  },
  SET_READ_ONLY_GAME_ITEMS_CONTRACT(state, value) {
    state.readOnlyGameItemsContract = value;
  },
  SET_READ_ONLY_UNIQUE_CARDS_CONTRACT(state, value) {
    state.readOnlyUniqueCardsContract = value;
  },
  SET_WRITE_GOLD_COIN_CONTRACT(state, value) {
    state.writeGoldCoinContract = value;
  },
  SET_WRITE_GAME_ITEMS_CONTRACT(state, value) {
    state.writeGameItemsContract = value;
  },
  SET_WRITE_UNIQUE_CARDS_CONTRACT(state, value) {
    state.writeUniqueCardsContract = value;
  },
};

const actions = {
  updateCurrentAccount({ commit }, payload) {
    commit("SET_CURRENT_ACCOUNT", payload);
  },
  updateGoldCoinContractAddress({ commit }, payload) {
    commit("SET_GOLD_COIN_CONTRACT_ADDRESS", payload);
  },
  updateGameItemsContractAddress({ commit }, payload) {
    commit("SET_GAME_ITEMS_CONTRACT_ADDRESS", payload);
  },
  updateUniqueCardsContractAddress({ commit }, payload) {
    commit("SET_UNIQUE_CARDS_CONTRACT_ADDRESS", payload);
  },
  updateReadOnlyGoldCoinContract({ commit }, payload) {
    commit("SET_READ_ONLY_GOLD_COIN_CONTRACT", payload);
  },
  updateReadOnlyGameItemsContract({ commit }, payload) {
    commit("SET_READ_ONLY_GAME_ITEMS_CONTRACT", payload);
  },
  updateReadOnlyUniqueCardsContract({ commit }, payload) {
    commit("SET_READ_ONLY_UNIQUE_CARDS_CONTRACT", payload);
  },
  updateWriteGoldCoinContract({ commit }, payload) {
    commit("SET_WRITE_GOLD_COIN_CONTRACT", payload);
  },
  updateWriteGameItemsContract({ commit }, payload) {
    commit("SET_WRITE_GAME_ITEMS_CONTRACT", payload);
  },
  updateWriteUniqueCardsContract({ commit }, payload) {
    commit("SET_WRITE_UNIQUE_CARDS_CONTRACT", payload);
  },
};

export default {
  namespaced: true,
  state,
  mutations,
  actions,
};
