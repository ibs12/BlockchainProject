const state = {
  adminAccount: "0xD902131d68467A4F408003e10D10ff296ec2D87e",
  playerAccount: "",
  goldCoinContractAddress: "0xa14425407fa65b82C44b0475C51C19A665323c71",
  uniqueCardsContractAddress: "0x14F99024ed3de3499fD7C260c49694Fa12F41a64",
  gameItemsContractAddress: "0xb1e672e36da4D3B168EA111d047395078c6065D7",
  playerRegistrationContractAddress: "0xFa42D965B4e8a12E0CdFDdC2B0D286cF5dd02672",
  readOnlyGoldCoinContract: null,
  readOnlyGameItemsContract: null,
  readOnlyUniqueCardsContract: null,
  readOnlyPlayerRegistrationContract: null,
  writeGoldCoinContract: null,
  writeGameItemsContract: null,
  writeUniqueCardsContract: null,
  writePlayerRegistrationContract: null,
  web3Provider: null,
  web3: null
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
  SET_WEB3_PROVIDER(state, value) {
    state.web3Provider = value;
  },
  SET_WEB3(state, value) {
    state.web3 = value;
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
  updateWeb3Provider({ commit }, payload) {
    commit("SET_WEB3_PROVIDER", payload);
  },
  updateWeb3({ commit }, payload) {
    commit("SET_WEB3", payload);
  },
};

export default {
  namespaced: true,
  state,
  mutations,
  actions,
};
