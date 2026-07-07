const {
  SecretsManagerClient,
  GetSecretValueCommand,
} = require("@aws-sdk/client-secrets-manager");

const client = new SecretsManagerClient({
  region: process.env.AWS_REGION || "us-east-1",
});

async function getSecret() {
  console.log("SECRET_NAME =", process.env.SECRET_NAME);

  const response = await client.send(
    new GetSecretValueCommand({
      SecretId: process.env.SECRET_NAME,
    })
  );

  console.log("SUCCESS");

  return JSON.parse(response.SecretString);
}

module.exports = { getSecret };