const express = require("express");
const app = express();

const PORT = process.env.PORT || 3000;
const APP_ENV = process.env.APP_ENV || "unknown";

function envColor(env) {
  if (env === "prod") return "#b30000";   // red
  if (env === "dev") return "#1e90ff";    // blue
  if (env === "test") return "#ff8c00";   // orange
  return "#555";
}

app.get("/", (req, res) => {
  res.send(`
    <html>
      <head>
        <title>AKS POC – St. Jude</title>
        <style>
          body {
            font-family: Arial, sans-serif;
            margin: 0;
            line-height: 1.6;
          }
          .banner {
            background-color: ${envColor(APP_ENV)};
            color: white;
            padding: 12px 40px;
            font-weight: bold;
            text-transform: uppercase;
          }
          .content {
            margin: 40px;
          }
        </style>
      </head>
      <body>
        <div class="banner">
          Environment: ${APP_ENV}
        </div>
        <div class="content">
          <h1>St. Jude Children’s Research Hospital</h1>
          <p>
            This application is running on Azure Kubernetes Service (AKS) as part of
            a containerized platform proof of concept.
          </p>
          <p>
            St. Jude advances cures and prevention methods for pediatric
            catastrophic diseases through research and treatment.
          </p>
          <p>
            Platform stack: AKS, Docker, GitHub Actions, Helm.
          </p>
        </div>
      </body>
    </html>
  `);
});

app.get("/health", (req, res) => {
  res.status(200).send("ok");
});

app.listen(PORT, () => {
  console.log(`App running on port ${PORT} (env: ${APP_ENV})`);
});
