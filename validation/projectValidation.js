// /server/validation/projectValidation.js
import { z } from "zod";

export const createProjectSchema = z.object({
  name: z.string().min(1),
  code: z.string().min(1),
  clientId: z.string().min(1), // Changed from uuid()
  status: z.string().min(1),
  managerId: z.string().min(1), // Changed from uuid()
  billingRateTimePeriod: z.string().min(1),
  startDate: z.string(), // Changed from datetime()
  endDate: z.string(), // Changed from datetime()
  totalContract: z.coerce.number().nonnegative(),
  approvedBudget: z.coerce.number().nonnegative(),
  allocatedBudget: z.coerce.number().nonnegative(),
});

// export const createProjectSchema = z.object({
//   name: z.string().min(1),
//   code: z.string().min(1),
//   clientId: z.string().uuid().optional().nullable(),
//   status: z.string().min(1),
//   managerId: z.string().uuid().optional().nullable(),
//   billingRateTimePeriod: z.string().min(1),
//   startDate: z.string().datetime(),
//   endDate: z.string().datetime(),
//   totalContract: z.coerce.number().nonnegative(),
//   approvedBudget: z.coerce.number().nonnegative(),
//   allocatedBudget: z.coerce.number().nonnegative(),
// });
