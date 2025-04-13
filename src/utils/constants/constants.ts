import * as dotenv from 'dotenv';

dotenv.config();

export const constants = {
  MONGODB_URI: process.env.MONGODB_URI,
  APP_PORT: process.env.APP_PORT,
  BY_PASS_URLS: ['/user/signup'],
};