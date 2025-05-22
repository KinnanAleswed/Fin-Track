
import { lookupSchema } from "../validation/master-lookupValidation.js";
import prisma from "../prisma/prismaClient.js";

export const createLookupController = async (req, res) => {
  try {
    const parsed = lookupSchema.safeParse(req.body);

    if (!parsed.success) {
      return res.status(400).json({ error: parsed.error.flatten() });
    }

    const { value, description_AR, description_EN, isActive, createdBy } = parsed.data;

    const newLookup = await prisma.FT_MasterLookup.create({
      data: {
        value,
        description_EN,
        description_AR,
        // comments,
        isActive,
        createdBy
      }
    });

    return res.status(201).json(newLookup);
  } catch (error) {
    console.error("[createLookupController]", error);
    return res.status(500).json({ error: "Internal Server Error" });
  }
};
