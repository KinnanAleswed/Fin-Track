import "dotenv/config";
import express from "express";
import createProjectRouter from "./routes/posts/createprojectPost.js";
import cors from "cors";
const app = express();

app.use(
  cors({
    origin: "http://localhost:5173", //frontend URL
    methods: ["GET", "POST", "PUT", "DELETE"],
    allowedHeaders: ["Content-Type"],
  })
);

// Middleware
app.use(express.json()); // Body parser

// Routes
app.use("/api", createProjectRouter);

// Server
const PORT = 8000;
app.listen(PORT, () => {
  console.log(`Server running on port ${PORT}`);
});
