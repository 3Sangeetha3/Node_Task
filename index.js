const express = require('express');
require('dotenv').config();
const app = express();
const PORT = process.env.PORT || 4000;

app.get('/', (req, res) => {
  res.json('Hello from Node.js App on AWS ECS!');
});

app.listen(PORT, () => {
  console.log(`Server running on port http://localhost:${PORT}`);
});
