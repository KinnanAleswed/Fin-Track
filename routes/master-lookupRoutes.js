import express from "express";
import { createLookupController} from "../controllers/master-lookupController.js";

const router = express.Router();

router.post("/lookup", createLookupController);

export default router;
