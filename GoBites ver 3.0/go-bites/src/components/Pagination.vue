<template>
    <div id="pagination">
        <div class="pagination-container">
            <nav aria-label="...">
                <div class="row">
                    <div class="col">
                        <ul class="pagination">
                            <li class="page-item disabled" v-if="currentPage == 1">
                                <a class="page-link" href="#" aria-disabled="true">First</a>
                            </li>
                            <li class="page-item" v-else>
                                <button class="page-link" @click="initialPage">First</button>
                            </li>

                            <li class="page-item disabled" v-if="currentPage == 1">
                                <a class="page-link" href="#" tabindex="-1" aria-disabled="true">Previous</a>
                            </li>
                            <li class="page-item" v-else>
                                <button class="page-link" @click="previousPage">Previous</button>
                            </li>
                            
                            <li class="page-item active" aria-current="page">
                                <a class="page-link" href="#"> {{ currentPage }} <span class="sr-only">(current)</span></a>
                            </li>

                            <li class="page-item" v-if="currentPage != lastPage">
                                <button class="page-link" @click="nextPage">Next</button>
                            </li>
                            <li class="page-item disabled" v-else>
                                <a class="page-link" href="#" aria-disabled="true">Next</a>
                            </li>

                            <li class="page-item" v-if="currentPage != lastPage">
                                <button class="page-link" @click="finalPage">Last</button>
                            </li>
                            <li class="page-item disabled" v-else>
                                <a class="page-link" href="#" aria-disabled="true">Last</a>
                            </li>
                        </ul>
                    </div>
                    <div class="col">
                        <ul class="pagination justify-content-center">
                            <li class="page-item">
                                <form class="form-inline" @submit.prevent="goToChosenPage">
                                    <input class="form-control mr-sm-2" v-model="chosenPage" type="number" placeholder="..." min="1" :max="totalPage"  required>
                                    <input type="submit" class="btn btn-outline-success" value="Go" />
                                </form> 
                            </li>
                        </ul>
                    </div>
                    <div class="col">
                        <ul  class="pagination justify-content-end">
                            <li class="page-item disabled">
                                <button class="page-link total-info-custom">Total {{ userType && totalInformation == 1? userType.toLowerCase(): userType.toLowerCase() + 's'}}: {{ totalInformation }}</button>
                            </li>

                            <li class="page-item disabled">
                                <button class="page-link total-info-custom">Total {{ totalPage > 1? "Pages" : "page" }}: {{ totalPage }}</button>
                            </li>
                        </ul>
                    </div>
                </div>
            </nav>
        </div>
    </div>
</template>

<script>
export default {
    name: 'Pagination',
    props: {
        infoData: {
            type: Array,
        },
        userType: {
            type: String,
        },
        numberOfInformationPerPage: {
            type: Number,
        }
    },
    watch: {
        infoData: function() {
            this.calculateTotalPage();
            this.calculateTotalInformation();
            this.processData();
            this.initializeState();
            this.getProcessedData();
        },
    },
    data() {
        return {
            currentPage: 1,
            totalPage: 1,
            lastPage: 1,
            currentProcessedData: [],
            totalInformation: 1,
            chosenPage: 1,
        }
    },
    methods: {
        goToChosenPage() {
            this.currentPage = this.chosenPage;
            this.processData();
            this.getProcessedData();
        },
        nextPage() {
            this.currentPage++; 
            this.processData();
            this.getProcessedData();
        },
        previousPage() {
            this.currentPage--; 
            this.processData();
            this.getProcessedData();
        },
        finalPage() {
            this.currentPage = this.lastPage; 
            this.processData();
            this.getProcessedData();
        },
        initialPage() {
            this.currentPage = 1; 
            this.processData();
            this.getProcessedData();
        },
        getProcessedData() {
            this.chosenPage = this.currentPage;
            this.$emit('getProcessedData', this.currentProcessedData, this.currentPage);
        },
        processData() {
            this.currentProcessedData.length = 0;
            for(var i = 0; i < this.numberOfInformationPerPage * this.currentPage && i < this.infoData.length; i++) {
                if(this.currentPage > 1 && i == 0) {
                    i = (this.currentPage - 1) * this.numberOfInformationPerPage;
                }
                this.currentProcessedData.push(this.infoData[i]);
            } 
        },
        calculateTotalPage() {
            const pages = this.infoData.length / this.numberOfInformationPerPage;
            
            if(pages == parseInt(pages))
                this.totalPage = parseInt(pages);
            else
                this.totalPage = parseInt(pages) + 1;
        },
        calculateTotalInformation() {
            this.totalInformation = this.infoData.length;
        },
        initializeState() {
            this.lastPage = this.totalPage;
        }
    },
    mounted() {
        this.calculateTotalPage();
        this.calculateTotalInformation();
        this.processData();
        this.initializeState();
        this.getProcessedData();
    },
}
</script>

<style lang="scss" scoped>
    #pagination {
        .pagination-container {
            text-align: center;

            .total-info-custom {
                border: none;
                color: rgb(0, 0, 0);
            }

            .page-navigate-custom {
                float: right;
            }
        }
    }
</style>