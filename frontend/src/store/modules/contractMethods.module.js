const state = {
  currentPhase: null,
  playerRegistered: false,
  starterCards: [
    {
      title: "Start card 1",
      attack: 100,
      defense: 200
    },
    {
      title: "Start card 2",
      attack: 101,
      defense: 201
    },
    {
      title: "Start card 3",
      attack: 102,
      defense: 202
    },
    {
      title: "Start card 4",
      attack: 103,
      defense: 203
    },
    {
      title: "Start card 5",
      attack: 104,
      defense: 204
    },
  ]
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
