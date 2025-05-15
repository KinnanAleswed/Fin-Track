// /server/validation/projectValidation.js
import { z } from 'zod';

const dateRegex = /^\d{4}-\d{2}-\d{2}$/;

export const createProjectSchema = z.object({
  name: z.string().min(1),
  code: z.string().min(1),
  clientId: z.string().min(1).optional().nullable(),
  status: z.string().min(1),
  billingType: z.enum(['Fixed Bid', 'Time and Material', 'Non-Billable']),
  managerId: z.string().min(1).optional().nullable(),
  billingRateTimePeriod: z.string().min(1),
  startDate: z.string().refine((val) => dateRegex.test(val), {
    message: 'startDate must be in YYYY-MM-DD format',
  }),
  endDate: z.string().refine((val) => dateRegex.test(val), {
    message: 'endDate must be in YYYY-MM-DD format',
  }),
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
