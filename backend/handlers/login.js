const { getConnection } = require("../database/db");
const bcrypt = require("bcryptjs");
const jwt = require("jsonwebtoken");

const corsHeaders = {
  "Access-Control-Allow-Origin": "*",
  "Access-Control-Allow-Headers": "Content-Type",
  "Access-Control-Allow-Methods": "OPTIONS,POST"
};

exports.handler = async (event) => {

  // Handle browser preflight requests
  if (event.httpMethod === "OPTIONS") {
    return {
      statusCode: 200,
      headers: corsHeaders,
      body: ""
    };
  }

  try {
    const body = JSON.parse(event.body);

    const { email, password } = body;

    if (!email || !password) {
      return {
        statusCode: 400,
        headers: corsHeaders,
        body: JSON.stringify({
          message: "Email and password are required"
        }),
      };
    }

    const connection = await getConnection();

    const [users] = await connection.execute(
      "SELECT * FROM users WHERE email = ?",
      [email]
    );

    if (users.length === 0) {
      await connection.end();

      return {
        statusCode: 401,
        headers: corsHeaders,
        body: JSON.stringify({
          message: "Invalid email or password",
        }),
      };
    }

    const user = users[0];

    const validPassword = await bcrypt.compare(
      password,
      user.password_hash
    );

    if (!validPassword) {
      await connection.end();

      return {
        statusCode: 401,
        headers: corsHeaders,
        body: JSON.stringify({
          message: "Invalid email or password",
        }),
      };
    }

    const token = jwt.sign(
      {
        id: user.id,
        email: user.email,
      },
      process.env.JWT_SECRET,
      {
        expiresIn: "1h",
      }
    );

    await connection.end();

    return {
      statusCode: 200,
      headers: corsHeaders,
      body: JSON.stringify({
        message: "Login successful",
        token,
      }),
    };

  } catch (err) {
    return {
      statusCode: 500,
      headers: corsHeaders,
      body: JSON.stringify({
        error: err.message,
      }),
    };
  }
};