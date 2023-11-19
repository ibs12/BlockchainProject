const state = {
  adminAccount: "0x8AfA8198273Ca1113961514F4195DD6Ab740a3B1",
  playerAccount: "0x8AfA8198273Ca1113961514F4195DD6Ab740a3B1",
  goldCoinContractAddress: "0xB7e4DE64D6BBA029c4ecB8c161952c83f6b81d66",
  uniqueCardsContractAddress: "0x694b10F621F45aA84f3a42D6F296c0550bdCc9C7",
  gameItemsContractAddress: "0x57B24015905388AaEF11c9e86a0EA9c576F2F4a7",
  playerRegistrationContractAddress: "0xcddd6447D8C161a077c027b78176fA8BE67faC4e",
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
