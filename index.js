import express from "express";

const app = express();

app.get("/", (req, res) => {
  res.status(200).json({ message: "connected successfully" });
});

app.listen(3000, () => console.log(`🟡 LOG -- : Listening on 3000`));
