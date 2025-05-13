import prisma from "../prisma/prismaClient.js";

export const createProject = async (req, res) => {
  try {
    const {
      name,
      code,
      clientId,
      status,
      managerId,
      billingRateTimePeriod,
      startDate,
      endDate,
      totalContract,
      approvedBudget,
      allocatedBudget,
    } = req.body;

    const newProject = await prisma.projects.create({
      data: {
        name,
        code,
        clientId,
        status,
        managerId,
        billingRateTimePeriod,
        startDate ,
        endDate,
        totalContract,
        approvedBudget,
        allocatedBudget,
      },
    });

    return res.status(201).json(newProject);
  } catch (error) {
    console.error("Error creating project:", error);
    return res.status(500).json({ message: "Failed to create project" });
  }
};
