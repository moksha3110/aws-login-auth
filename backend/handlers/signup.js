const { getConnection } = require("../database/db");
const bcrypt = require("bcryptjs");

const corsHeaders = {
  "Access-Control-Allow-Origin": "*",
  "Access-Control-Allow-Headers": "Content-Type",
  "Access-Control-Allow-Methods": "OPTIONS,POST"
};

exports.handler = async (event) => {

  // Handle browser preflight request
  if (event.httpMethod === "OPTIONS") {
    return {
      statusCode: 200,
      headers: corsHeaders,
      body: ""
    };
  }

  try {

    const body = JSON.parse(event.body);

    const { name, email, password } = body;

    if (!name || !email || !password) {
      return {
        statusCode: 400,
        headers: corsHeaders,
        body: JSON.stringify({
          message: "All fields are required"
        })
      };
    }

    const connection = await getConnection();

    const [existing] = await connection.execute(
      "SELECT id FROM users WHERE email=?",
      [email]
    );

    if (existing.length > 0) {
      await connection.end();

      return {
        statusCode: 409,
        headers: corsHeaders,
        body: JSON.stringify({
          message: "User already exists"
        })
      };
    }

    const hash = await bcrypt.hash(password, 10);

    await connection.execute(
      "INSERT INTO users(name,email,password_hash) VALUES(?,?,?)",
      [name, email, hash]
    );

    await connection.end();

    return {
      statusCode: 201,
      headers: corsHeaders,
      body: JSON.stringify({
        message: "Signup successful"
      })
    };

  } catch (err) {

    return {
      statusCode: 500,
      headers: corsHeaders,
      body: JSON.stringify({
        error: err.message
      })
    };

  }
};