<template>
    <div id="search-filter">
        <div class="display-with-filter-container" v-if="requiredConditions">
            <div class="row">
                <div class="input-group col" v-for="cond in requiredConditions" :key="cond.condition">
                    <div class="input-group-prepend">
                        <div class="input-group-text input-group-custom label-custom">
                            <input type="checkbox" v-model="cond.toggle" true-value="yes" false-value="no" @click="selectUnselectCondition(cond)">
                        </div>
                    </div>
                    <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-arrow-right-short arrow-right-short-custom" viewBox="0 0 16 16">
                        <path fill-rule="evenodd" d="M4 8a.5.5 0 0 1 .5-.5h5.793L8.146 5.354a.5.5 0 1 1 .708-.708l3 3a.5.5 0 0 1 0 .708l-3 3a.5.5 0 0 1-.708-.708L10.293 8.5H4.5A.5.5 0 0 1 4 8z"/>
                    </svg>
                    <input type="text" class="form-control input-group-custom label-custom" v-model="cond.condition" readonly>
                </div>
            </div>
        </div>
    </div>
</template>

<script>
export default {
    name: 'SearchFilter',
    props: {
        requiredConditions: {
            type: Array,
        }
    },
    methods: {
        selectUnselectCondition(condition) {
            condition.toggle == 'no'? this.$emit('setSelectedCondition', condition.condition) : this.$emit('unselectCondition', condition.condition);
        }
    }
}
</script>

<style lang="scss" scoped>
    #display-with-filter {
        .display-with-filter-container {
            text-align: left;
        }
    }

    .input-group-custom {
        background-color: rgb(255, 255, 255);
    }

    .label-custom {
        border: none;
        outline: none;
    }

    .arrow-right-short-custom {
        margin-top: 11px;
    }
</style>