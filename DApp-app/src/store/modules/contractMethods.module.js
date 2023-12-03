const state = {
  currentPhase: null,
  playerRegistered: false,
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
  powerUps: 0,
  mods: 0
};

const mutations = {
  SET_CURRENT_PHASE(state, value) {
    state.currentPhase = value;
  },
  SET_PLAYER_REGISTERED(state, value) {
    state.playerRegistered = value;
  },
  SET_POWER_UPS(state, value) {
    state.powerUps = value;
  },
  SET_MODS(state, value) {
    state.mods = value;
  },
};

const getters = {
  getCurrentPhase() {
    return state.currentPhase;
  },
  getPlayerRegistered() {
    return state.playerRegistered;
  }
};

const actions = {
  updateCurrentPhase({ commit }, payload) {
    commit("SET_CURRENT_PHASE", payload);
  },
  updatePlayerRegistered({ commit }, payload) {
    commit("SET_PLAYER_REGISTERED", payload);
  },
  updatePowerUps({ commit }, payload) {
    commit("SET_POWER_UPS", payload);
  },
  updateMods({ commit }, payload) {
    commit("SET_MODS", payload);
  },
};

export default {
  namespaced: true,
  state,
  mutations,
  getters,
  actions,
};
