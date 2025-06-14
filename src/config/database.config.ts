import * as dotenv from 'dotenv';

dotenv.config();

export const database = {
  MONGODB_URI: process.env.MONGODB_URI,
};
