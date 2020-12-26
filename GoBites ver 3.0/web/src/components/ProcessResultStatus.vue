<template>
    <div id="process-result-status">
        <div aria-live="polite" aria-atomic="true" class="d-flex justify-content-center align-items-center" style="height: 200px;">
        <div class="toast" role="alert" aria-live="assertive" aria-atomic="true">
            <div class="toast-header">
                <strong class="mr-auto">{{ "GoBites" }}}</strong>
                <small>now</small>
                <button type="button" class="ml-2 mb-1 close" data-dismiss="toast" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="toast-body process-success" v-if="success">
                {{ message }}
            </div>
            <div class="toast-body process-failed" v-if="!success">
                {{ message }}
            </div>
        </div>
    </div>
    </div>
</template>

<script>
export default {
    name: 'process-result-status',
    props: {
        message: {
            type: String
        },
        success: {
            type: Boolean
        },
    }
}
</script>

<style lang="scss">
    #process-result-status {
        background-color: rgb(92, 83, 83);
        .process-success {
            color: green;
        }

        .process-failed {
            color: red;
        }
    }
</style>