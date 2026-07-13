import mongoose from "mongoose";

export const connectDB = async () => {
  if (!process.env.MONGO_URL) {
    console.error("WARNING: MONGO_URL environment variable is not defined!");
    console.error("Please create a .env file in the backend directory and configure MONGO_URL.");
    return;
  }
  await mongoose
    .connect(
      process.env.MONGO_URL
    )
    .then(() =>console.log("DB Connected"));
};
