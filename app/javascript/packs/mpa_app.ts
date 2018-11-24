import Vue from 'vue'
import Vuex from 'vuex'
import Mpa from '../../assets/javascripts/mpa/ui/mpa.vue'
import {globalStore} from "../../assets/javascripts/mpa/ui/state/GlobalStore";
import {analysisStore} from "../../assets/javascripts/mpa/ui/state/AnalysisStore";

Vue.use(Vuex);

const store = new Vuex.Store({
    modules: {
        global: globalStore,
        analysis: analysisStore
    }
});

document.addEventListener('DOMContentLoaded', () => {
    const app = new Vue({
        el: '#mpa-app',
        components: { Mpa },
        store,
        created: function() {
            this.$store.dispatch('loadStoredDatasets')
        }
    })
});
