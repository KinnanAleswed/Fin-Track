// Named export (consistent with ES Modules)

const isDataOkay = (requiredFields = []) => {
  return (req, res, next) => {
    try {
      const missingFields = requiredFields.filter((field) => {
        const value = req.body[field];
        return value === undefined || value === null || value === "";
      });

      if (missingFields.length > 0) {
        return res.status(400).json({
          error: `Missing required fields: ${missingFields.join(", ")}`,
        });
      }

      next();
    } catch (error) {
      console.error("Error in isDataOkay middleware:", error);
      res
        .status(500)
        .json({ error: "Internal server error in input validation" });
    }
  };
};

export default isDataOkay;
