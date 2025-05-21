// /server/validation/projectValidation.js
import { z } from "zod";

export const createProjectSchema = z.object({
  name: z.string().min(1, "Name is required"),
  clientId: z.string().optional().nullable(), // client foreign key id
  code: z.string().min(1, "Code is required"),
  status: z.string().min(1, "Status is required"),
  Managers: z.string().optional().nullable(), // project manager user id
  billingRateTimePeriod: z
    .string()
    .min(1, "Billing rate time period is required"),
  startDate: z.string().refine((val) => !isNaN(Date.parse(val)), {
    message: "Invalid start date",
  }),
  endDate: z
    .string()
    .refine((val) => !isNaN(Date.parse(val)), { message: "Invalid end date" }),
  totalContract: z.number().positive("Total contract must be positive"),
  approvedBudget: z.number().positive("Approved budget must be positive"),
  allocatedBudget: z.number().positive("Allocated budget must be positive"),
  billingType: z.enum(["Fixed Bid", "Time and Material", "Non-Billable"]),
});
