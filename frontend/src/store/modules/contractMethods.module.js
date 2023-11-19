const state = {
  currentPhase: null,
  playerRegistered: false,
};

const mutations = {
  SET_CURRENT_PHASE(state, value) {
    state.currentPhase = value;
  },
  SET_PLAYER_REGISTERED(state, value) {
    state.playerRegistered = value;
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
};

export default {
  namespaced: true,
  state,
  mutations,
  getters,
  actions,
};
