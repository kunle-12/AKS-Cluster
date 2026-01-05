const express = require("express");
const app = express();

const PORT = process.env.PORT || 3000;

app.get("/", (req, res) => {
  res.send(`
    <html>
      <head>
        <title>AKS POC – St. Jude</title>
        <style>
          body {
            font-family: Arial, sans-serif;
            margin: 40px;
            line-height: 1.6;
          }
        </style>
      </head>
      <body>
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
      </body>
    </html>
  `);
});

app.get("/health", (req, res) => {
  res.status(200).send("ok");
});

app.listen(PORT, () => {
  console.log(`App running on port ${PORT}`);
});
