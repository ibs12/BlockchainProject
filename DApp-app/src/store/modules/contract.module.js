const state = {
  adminAccount: "0x90d38Ca7Ba750A5dCeEDFC4984FdA8232f802C5e",
  playerAccount: "",
  goldCoinContractAddress: "0x1fD9323E9cbF130842e4C6f684F9F13d4921b215",
  uniqueCardsContractAddress: "0x1b41457f871073F5100787b3eD3df84CeECCB7C2",
  gameItemsContractAddress: "0xFa66251d13BCB659d85E4C160a1Dafd0612A5cB2",
  playerRegistrationContractAddress: "0xb09ACAaE86395E78191dF4B1414b8DCc2B97DF98",
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
