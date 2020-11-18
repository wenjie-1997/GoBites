module.exports = {
    HOST: "johnny.heliohost.org",
    USER: "ainalfa_ainal",
    PASSWORD: "ainal@123",
    DB: "ainalfa_go-bites-db",
    dialect: "mysql",
    pool: {
        max: 10,
        min: 0,
        acquire: 30000,
        idle: 10000
    }
};