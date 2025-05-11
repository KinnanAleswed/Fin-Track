const express = require('express');
const { PrismaClient } = require('@prisma/client');
const bodyParser = require('body-parser');
require('dotenv').config();

const prisma = new PrismaClient();
const app = express();
app.use(bodyParser.json());

// ✅ POST /clients
app.post('/clients', async (req, res) => {
  const { name } = req.body;

  if (!name) {
    return res.status(400).json({ error: 'Name is required' });
  }

  try {
    const client = await prisma.clients.create({
      data: { name },
    });
    res.status(201).json(client);
  } catch (error) {
    console.error(error);
    res
      .status(500)
      .json({ error: 'Failed to create client', details: error.message });
  }
});

// ✅ GET /clients
app.get('/clients', async (req, res) => {
  try {
    const clients = await prisma.clients.findMany();
    res.status(200).json(clients);
  } catch (error) {
    console.error(error);
    res
      .status(500)
      .json({ error: 'Failed to fetch clients', details: error.message });
  }
});

// ✅ POST /projects
app.post('/projects', async (req, res) => {
  const {
    name,
    code,
    clientId,
    startDate,
    endDate,
    status,
    billingType,
    managerId,
    totalContract,
    approvedBudget,
    allocatedBudget,
    billingRateTimePeriod,
  } = req.body;

  if (!name || !code) {
    return res.status(400).json({ error: 'Name and code are required' });
  }

  // 🔍 Validate foreign keys (optional, but good practice)
  try {
    if (clientId) {
      const clientExists = await prisma.clients.findUnique({
        where: { id: clientId },
      });
      if (!clientExists) {
        return res
          .status(400)
          .json({ error: 'Invalid clientId — client does not exist' });
      }
    }

    if (managerId) {
      const userExists = await prisma.users.findUnique({
        where: { id: managerId },
      });
      if (!userExists) {
        return res
          .status(400)
          .json({ error: 'Invalid managerId — user does not exist' });
      }
    }

    const project = await prisma.projects.create({
      data: {
        name,
        code,
        clientId: clientId || undefined,
        managerId: managerId || undefined,
        startDate: startDate ? new Date(startDate) : undefined,
        endDate: endDate ? new Date(endDate) : undefined,
        status,
        billingType,
        totalContract,
        approvedBudget,
        allocatedBudget,
        billingRateTimePeriod,
      },
    });

    res.status(201).json(project);
  } catch (error) {
    console.error(error);
    if (error.code === 'P2002') {
      res.status(400).json({ error: 'Project code must be unique.' });
    } else {
      res
        .status(500)
        .json({ error: 'Failed to create project', details: error.message });
    }
  }
});

// ✅ GET /projects
app.get('/projects', async (req, res) => {
  try {
    const projects = await prisma.projects.findMany({
      include: {
        Clients: true,
        Users: true,
      },
    });
    res.status(200).json(projects);
  } catch (error) {
    console.error(error);
    res
      .status(500)
      .json({ error: 'Failed to fetch projects', details: error.message });
  }
});

app.post('/users', async (req, res) => {
  const { id, fullName, email, role } = req.body;

  if (!fullName || !email || !role) {
    return res
      .status(400)
      .json({ error: 'fullName, email, and role are required' });
  }

  try {
    const newUser = await prisma.users.create({
      data: {
        id,
        fullName,
        email,
        role,
      },
    });
    res.status(201).json(newUser);
  } catch (error) {
    console.error(error);
    if (error.code === 'P2002') {
      res.status(400).json({ error: 'Email must be unique' });
    } else {
      res
        .status(500)
        .json({ error: 'Failed to create user', details: error.message });
    }
  }
});

app.get('/users', async (req, res) => {
  try {
    const newUser = await prisma.users.findMany();
    res.status(200).json(newUser);
  } catch (error) {
    console.error(error);
    res
      .status(500)
      .json({ error: 'Failed to fetch users', details: error.message });
  }
});

// ✅ GET /managers/:managerId
app.get('/managers/:managerId', async (req, res) => {
  const { managerId } = req.params;

  try {
    const manager = await prisma.users.findUnique({
      where: { id: managerId },
    });

    if (!manager) {
      return res.status(404).json({ error: 'Manager not found' });
    }

    res.status(200).json(manager);
  } catch (error) {
    console.error(error);
    res
      .status(500)
      .json({ error: 'Failed to fetch manager', details: error.message });
  }
});

const PORT = 3000;
app.listen(PORT, () => console.log(`Server running on port ${PORT}`));
