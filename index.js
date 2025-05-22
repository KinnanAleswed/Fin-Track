// server/index.js
import "dotenv/config";
import express from "express";
import cors from "cors";
import projectRoutes from "./routes/projectRoutes.js"; 
import lookupRoutes from "./routes/master-lookupRoutes.js"; 

const app = express();

// CORS config
app.use(
  cors({
    origin: "http://localhost:5173", // frontend URL
    methods: ["GET", "POST", "PUT", "DELETE"],
    allowedHeaders: ["Content-Type"],
  })
);

// Middleware
app.use(express.json()); // Parse JSON request bodies

// API Routes
app.use("/api", projectRoutes);
app.use("/api", lookupRoutes); 

// Start Server
const PORT = 8000;
app.listen(PORT, () => {
  console.log(`Server running on port ${PORT}`);
});
