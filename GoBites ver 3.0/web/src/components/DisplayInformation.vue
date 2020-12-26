<template>
    <div id="userInformation">
        <div class="table-responsive-xl">
            <table v-if="userLabels" class="table">
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
                    <tr v-if="users.length == 0">
                        <td :colspan="userLabels.length" scope="row">
                            <h3>There is no data in the database.</h3>
                        </td>
                    </tr>
                    <tr v-for="(user, index) in users" :key="index">
                        <td scope="row" >
                            {{ index + 1 + initialNo }}
                        </td>
                        <td v-for="(value, propertyName, id) in user" :key="id" scope="row" v-show="propertyName !== unWantedProperty ">
                            {{ value && value.length > 20 ? value.substring(0, 20) + "..." : value}}
                        </td>
                        <td v-if="userLabels[userLabels.length-1].label.toLowerCase().search('manage') != -1">
                            <button type="button" class="btn btn-primary form-control btn-manage-custom" @click="viewUserDetails(user)">Manage</button>
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
            type: Array
        },
        userLabels: {
            type: Array
        },
        unWantedProperty: {
            type: String
        }, 
        initialNo: {
            type: Number,
        },
    },
    methods: {
        viewUserDetails(user) {
            this.$emit('viewUserDetails', user);
        }
    }
}
</script>

<style lang="scss" scoped>
    #userInformation {
        .btn-manage-custom {
            width: 100px;
            height: 30px;
            padding: 1px 1px 1px 1px;
        }

        td,
        th {
            text-align: center;
        }
    }
</style>
