<template>
    <div id="search">
        <div class="search-container">
            <div class="row">
                <div class="col-auto">
                    <form class="form-inline" @submit.prevent="searchInformation">
                        <input class="form-control mr-sm-2" v-model="requiredInformation" type="search" placeholder="Search" aria-label="Search" required>
                        <input type="submit" class="btn btn-outline-success my-2 my-sm-0" value="Search" />
                        <input type="button" class="btn btn-outline-success my-2 my-sm-0" @click="reset" value="Reset" />
                    </form>   
                </div>
                <div class="col">
                    <SearchFilter @unselectCondition="unselectCondition" @setSelectedCondition="setSelectedCondition" :requiredConditions="conditions" />
                </div>
            </div>
        </div>
    </div>
</template>

<script>
import SearchFilter from './SearchFilter.vue';

export default {
    name: 'Search',
    components: {
        SearchFilter,
    },
    props: {
        conditions: {
            type: Array,
        }
    },
    data() {
        return {
            requiredInformation: '',
            selectedConditions: [],
        }
    },
    methods: {
        searchInformation() {
            if(this.requiredInformation !== '') {
                this.$emit('displaySearchResult', this.requiredInformation, this.selectedConditions);
            }
        },
        reset() {
            this.requiredInformation = '';
            this.$emit('reset');
        },
        unselectCondition(condition) {
            if(this.selectedConditions) {
                for (var i = 0; i < this.selectedConditions.length; i++) {
                    if(this.selectedConditions[i] === condition) {
                        this.selectedConditions.splice(i, 1);
                        break;
                    }
                }
            }
        },
        setSelectedCondition(condition) {
            this.selectedConditions.push(condition);
        },
    }
}
</script>

<style lang="scss" scoped>
    #search {
        .search-container {
            text-align: center;
            margin-bottom: 10px;
        }
    }
</style>