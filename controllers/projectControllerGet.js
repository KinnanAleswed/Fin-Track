import { PrismaClient } from "@prisma/client";
const prisma = new PrismaClient();

const projectControllerGet = {
  // GET all projects
  getAllProjects: async (req, res) => {
    try {
      const projects = await prisma.projects.findMany({
        select: {
          id: true,
          name: true,
          code: true,
          status: true,
          startDate: true,
          endDate: true,
          Clients: { select: { name: true } },
          Users: { select: { fullName: true } },
        },
      });
      res.json(projects);
    } catch (error) {
      res.status(500).json({ error: "Failed to fetch projects" }, error);
    }
  },
};

module.exports = projectControllerGet;
