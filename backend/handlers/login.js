const { getConnection } = require("../database/db");
const bcrypt = require("bcryptjs");
const jwt = require("jsonwebtoken");

const corsHeaders = {
  "Access-Control-Allow-Origin": "*",
  "Access-Control-Allow-Headers": "Content-Type",
  "Access-Control-Allow-Methods": "OPTIONS,POST"
};

exports.handler = async (event) => {

  if (event.httpMethod === "OPTIONS") {
    return {
      statusCode: 200,
      headers: corsHeaders,
      body: ""
    };
  }

  try {

    console.log("STEP 1: Lambda started");

    const body = JSON.parse(event.body);

    console.log("STEP 2: Request body parsed");

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

    console.log("STEP 3: Connecting to database");

    const connection = await getConnection();

    console.log("STEP 4: Database connected");

    const [users] = await connection.execute(
      "SELECT * FROM users WHERE email = ?",
      [email]
    );

    console.log("STEP 5: Query executed");
    console.log("Users found:", users.length);

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

    console.log("STEP 6: Comparing password");

    const validPassword = await bcrypt.compare(
      password,
      user.password_hash
    );

    console.log("STEP 7: Password comparison complete");

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

    console.log("STEP 8: Generating JWT");

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

    console.log("STEP 9: JWT generated");

    await connection.end();

    console.log("STEP 10: Login successful");

    return {
      statusCode: 200,
      headers: corsHeaders,
      body: JSON.stringify({
        message: "Login successful",
        token,
      }),
    };

  } catch (err) {

    console.error("========== LOGIN ERROR ==========");
    console.error(err);
    console.error(err.stack);
    console.error("=================================");

    return {
      statusCode: 500,
      headers: corsHeaders,
      body: JSON.stringify({
        error: err.message,
        stack: err.stack
      }),
    };
  }
};