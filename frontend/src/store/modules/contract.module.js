const state = {
  adminAccount: "0x8AfA8198273Ca1113961514F4195DD6Ab740a3B1",
  playerAccount: "",
  goldCoinContractAddress: "0xC3Af01c70C07543baD9c0e755f4E00F9538d9Fce",
  uniqueCardsContractAddress: "0x7b17820651132aDcC4Dcb685D3157c46F956765E",
  gameItemsContractAddress: "0x422E0C304f0ca7Eb05A1faC940CC9b155278f7B0",
  playerRegistrationContractAddress: "0xF5C72c66a66bFa00aD30F08b49CFE9B74B4c55A4",
  readOnlyGoldCoinContract: null,
  readOnlyGameItemsContract: null,
  readOnlyUniqueCardsContract: null,
  readOnlyPlayerRegistrationContract: null,
  writeGoldCoinContract: null,
  writeGameItemsContract: null,
  writeUniqueCardsContract: null,
  writePlayerRegistrationContract: null,
};

const mutations = {
  SET_ADMIN_ACCOUNT(state, value) {
    state.adminAccount = value;
  },
  SET_PLAYER_ACCOUNT(state, value) {
    state.playerAccount = value;
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
  SET_PLAYER_REGISTRATION_CONTRACT_ADDRESS(state, value) {
    state.playerRegistrationContractAddress = value;
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
  SET_READ_ONLY_PLAYER_REGISTRATION_CONTRACT(state, value) {
    state.readOnlyPlayerRegistrationContract = value;
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
  SET_WRITE_PLAYER_REGISTRATION_CONTRACT(state, value) {
    state.writePlayerRegistrationContract = value;
  },
};

const actions = {
  updateAdminAccount({ commit }, payload) {
    commit("SET_ADMIN_ACCOUNT", payload);
  },
  updatePlayerAccount({ commit }, payload) {
    commit("SET_PLAYER_ACCOUNT", payload);
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
  updatePlayerRegistrationContractAddress({ commit }, payload) {
    commit("SET_PLAYER_REGISTRATION_CONTRACT_ADDRESS", payload);
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
  updateReadOnlyPlayerRegistrationContract({ commit }, payload) {
    commit("SET_READ_ONLY_PLAYER_REGISTRATION_CONTRACT", payload);
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
  updateWritePlayerRegistrationContract({ commit }, payload) {
    commit("SET_WRITE_PLAYER_REGISTRATION_CONTRACT", payload);
  },
};

export default {
  namespaced: true,
  state,
  mutations,
  actions,
};
