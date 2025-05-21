// server/controllers/projectController.js
import prisma from "../prisma/prismaClient.js";
import { createProjectSchema } from "../validation/projectValidation.js";
/**
 * GET /api/projects
 */
export const getAllProjects = async (req, res) => {
  try {
    const projects = await prisma.projects.findMany({
      select: {
        id: true,
        name: true,
        startDate: true,
        endDate: true,
        clientId: true,
        Managers: true,
      },
    });
    res.json(projects);
  } catch (error) {
    console.error("Error fetching projects:", error);
    res.status(500).json({ error: "Failed to fetch projects" });
  }
};

/**
 * GET /api/project-managers
 */
export const getProjectManagers = async (req, res) => {
  try {
    const managers = await prisma.managers.findMany({
      select: {
        id: true,
        name: true,
      },
    });
    res.json(managers);
  } catch (error) {
    console.error("Error fetching project managers:", error);
    res.status(500).json({ error: "Failed to fetch project managers" });
  }
};

/**
 * POST /api/projects
 */
export const createProject = async (req, res) => {
  try {
    // Validate with zod schema
    const validatedData = createProjectSchema.parse(req.body);

    // Destructure validated data
    const {
      name,
      Clients,
      code,
      status,
      Managers,
      billingRateTimePeriod,
      startDate,
      endDate,
      totalContract,
      approvedBudget,
      allocatedBudget,
      billingType,
      //   timeAndExpenseType,
    } = validatedData;

    const newProject = await prisma.projects.create({
      data: {
        name,
        code,
        status,
        Clients,
        Managers,
        billingRateTimePeriod,
        startDate: new Date(startDate),
        endDate: new Date(endDate),
        totalContract,
        approvedBudget,
        allocatedBudget,
        billingType,
      },
    });

    res.status(201).json(newProject);
  } catch (error) {
    if (error.name === "ZodError") {
      return res.status(400).json({ errors: error.errors });
    }
    console.error(error);
    res.status(500).json({ error: "Internal server error" });
  }
};
