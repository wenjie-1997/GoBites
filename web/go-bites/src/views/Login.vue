<template>
<div class="login">
    <h1>Login</h1>

    <form action="#" method="post">
        <label for="username">Username</label>
        <input type="text" id="username" autocomplete="off" autocorrect="off" autocapitalize="off" spellcheck="false" data-lpignore="true" required />

        <label for="password">Password</label>
        <input type="password" id="password" autocomplete="off" autocorrect="off" autocapitalize="off" spellcheck="false" data-lpignore="true" required />

        <input type="button" id="submit" value="Login" />
    </form>
</div>
</template>

<script>
export default {
    name: 'Login'
}
</script>

<style lang="scss" scoped>
.login {
    padding: 50px 5%;

    form {
        width: 150px;
        margin: 0 auto;

        input {
            margin-bottom: 10px;
        }
    }
}
</style>
