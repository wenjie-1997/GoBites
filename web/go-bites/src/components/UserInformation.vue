<template>
    <div id="userInformation">
        <div class="table-responsive-xl">
            <table v-if="users && userLabels" class="table">
                <thead class="thead-dark">
                    <tr>
                        <th :colspan="userLabels.length" scope="col">
                            <h3> {{ userType.substring(0,1).toUpperCase() + userType.substring(1).toLowerCase() }} Information</h3>
                        </th>
                    </tr>
                    <tr>
                        <th v-for="label in userLabels" :key="label.label" scope="col">
                            {{ label.label }}
                        </th>
                    </tr>
                </thead>

                <tbody>
                    <tr v-for="(user, index) in users" :key="index">
                        <td v-for="(value, propertyName, id) in user" :key="id" scope="row" v-show="propertyName !== unWantedProperty ">
                            {{ value && value.length > 20 ? value.substring(0, 20) + "..." : value}}
                        </td>
                        <td>
                            <input type="button" class="btn btn-primary form-control" @click="viewUserDetails(user)" value="Manage" />
                        </td>
                    </tr>
                </tbody>
            </table>
        </div>
    </div>
</template>

<script>
export default {
    name: 'UserInformation',
    props: {
        userType: {
            type: String
        },
        users: {
            type: Object
        },
        userLabels: {
            type: Array
        },
        unWantedProperty: {
            type: String
        }
    },
    methods: {
        viewUserDetails(user) {
            this.$emit('viewUserDetails', user);
        }
    }
}
</script>

<style lang="scss" scoped>
</style>
