import express from "express";
import { createProject } from "../../controllers/projectControllerPost.js";
import { createProjectSchema } from "../../validation/projectValidation.js";

const router = express.Router();

router.post("/projects", async (req, res) => {
  try {
    // 1. Validate with Zod
    const validatedData = createProjectSchema.parse(req.body);

    // 2. If validation passes, call the controller directly
    return await createProject({ ...req, body: validatedData }, res);
  } catch (error) {
    // 3. Handle validation errors
    return res.status(400).json({
      error: "Validation failed",
      details: error.errors || error.message,
    });
  }
});

export default router;
