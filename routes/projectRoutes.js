import express from "express";
import {
  getAllProjects,
  createProject,
  getProjectManagers,
} from "../controllers/projectController.js";
import { createProjectSchema } from "../validation/projectValidation.js";

const router = express.Router();

router.get("/projects", getAllProjects);

router.get("/project-managers", getProjectManagers);

router.post("/projects", async (req, res) => {
  try {
    const validatedData = createProjectSchema.parse(req.body);
    return await createProject({ ...req, body: validatedData }, res);
  } catch (error) {
    return res.status(400).json({
      error: "Validation failed",
      details: error.errors || error.message,
    });
  }
});

export default router;
