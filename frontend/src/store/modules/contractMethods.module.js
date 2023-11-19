const state = {
  currentPhase: null,
  currentPhaseMapped: {
    0: 'Register',
    1: 'Play',
    2: 'Game Over',
    3: 'Register2',
    4: 'Play2',
    5: 'Game Over2',
    6: 'Register3',
    7: 'Play3',
    8: 'Game Over3',
    9: 'Register4',
    10: 'Play4',
    11: 'Game Over4'
  }
};

const mutations = {
  SET_CURRENT_PHASE(state, value) {
    state.currentPhase = value;
  },
  SET_CURRENT_PHASE_MAPPED(state, value) {
    state.currentPhaseMapped = state.currentPhaseMapped[state.currentPhase];
  },
};

const getters = {
  getCurrentPhase() {
    return state.currentPhase;
  },
  getCurrentPhaseMapped() {
    return state.currentPhaseMapped[state.currentPhase];
  }
};

const actions = {
  updateCurrentPhase({ commit }, payload) {
    commit("SET_CURRENT_PHASE", payload);
  },
  updateCurrentPhaseMapped({ commit }, payload) {
    commit("SET_CURRENT_PHASE_MAPPED", payload);
  },
};

export default {
  namespaced: true,
  state,
  mutations,
  getters,
  actions,
};
