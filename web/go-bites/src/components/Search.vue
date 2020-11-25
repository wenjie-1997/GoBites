<template>
    <div id="search">
        <div class="search-container">
            <form class="form-inline my-2 my-lg-0">
                <input class="form-control mr-sm-2" type="search" placeholder="Search" aria-label="Search">
                <button class="btn btn-outline-success my-2 my-sm-0" type="submit">Search</button>
            </form>
        </div>
    </div>
</template>

<script>
export default {
    name: 'Search'
}
</script>

<style lang="scss" scoped>
    #search {
        .search-container {
            text-align: center;
        }
    }
</style>