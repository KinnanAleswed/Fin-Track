// routes/projectRoutes.js
import express from "express";
const router = express.Router();
const projectController = require("../../controllers/projectControllerGet");

// GET all projects
router.get("/", projectController.getAllProjects);
