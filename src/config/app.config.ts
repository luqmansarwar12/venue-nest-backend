import * as dotenv from 'dotenv';

dotenv.config();

export const app = {
  MONGODB_URI: process.env.MONGODB_URI,
  APP_PORT: process.env.APP_PORT,
  environment: process.env.ENVIRONMENT,
};
