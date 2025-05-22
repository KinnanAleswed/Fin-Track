
import { z } from "zod";

export const lookupSchema = z.object({
   value: z.string().min(1),
  description_AR: z.string().min(1),
  description_EN: z.string().min(1),
  // comments: z.string().optional(),
  isActive: z.number(),
  createdBy: z.number(),
});
;


