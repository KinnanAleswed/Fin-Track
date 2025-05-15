import prisma from '../prisma/prismaClient.js';

export const createProject = async (req, res) => {
  try {
    const {
      name,
      code,
      clientId,
      status,
      managerId,
      billingType,
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
        clientId: clientId || null,
        status,
        managerId: managerId || null,
        billingRateTimePeriod,
        startDate: new Date(startDate), // to accept date from front end(converts string to valid javascript one)
        endDate: new Date(endDate),
        totalContract,
        approvedBudget,
        allocatedBudget,
        billingType,
      },
    });

    return res.status(201).json(newProject);
  } catch (error) {
    console.error('Error creating project:', error);
    return res.status(500).json({ message: 'Failed to create project' });
  }
};
