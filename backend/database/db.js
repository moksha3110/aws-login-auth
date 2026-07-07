const mysql = require("mysql2/promise");
const { getSecret } = require("../utils/secrets");

async function getConnection() {
    const secret = await getSecret();

    return await mysql.createConnection({
        host: secret.DB_HOST,
        user: secret.DB_USER,
        password: secret.DB_PASSWORD,
        database: secret.DB_NAME
    });
}

module.exports = { getConnection };