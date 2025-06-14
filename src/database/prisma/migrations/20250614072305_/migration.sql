/*
  Warnings:

  - You are about to drop the column `isPrimary` on the `Address` table. All the data in the column will be lost.
  - You are about to drop the column `userId` on the `Customer` table. All the data in the column will be lost.
  - You are about to drop the column `businessLicense` on the `VenueOwner` table. All the data in the column will be lost.
  - You are about to drop the column `experienceYears` on the `VenueOwner` table. All the data in the column will be lost.
  - You are about to drop the column `userId` on the `VenueOwner` table. All the data in the column will be lost.
  - A unique constraint covering the columns `[user_id]` on the table `Customer` will be added. If there are existing duplicate values, this will fail.
  - A unique constraint covering the columns `[user_id]` on the table `VenueOwner` will be added. If there are existing duplicate values, this will fail.
  - Added the required column `user_id` to the `Customer` table without a default value. This is not possible if the table is not empty.
  - Added the required column `business_license` to the `VenueOwner` table without a default value. This is not possible if the table is not empty.
  - Added the required column `experience_years` to the `VenueOwner` table without a default value. This is not possible if the table is not empty.
  - Added the required column `user_id` to the `VenueOwner` table without a default value. This is not possible if the table is not empty.

*/
-- AlterEnum
ALTER TYPE "DishStatus" ADD VALUE 'UNAVAILABLE';

-- DropForeignKey
ALTER TABLE "Customer" DROP CONSTRAINT "Customer_userId_fkey";

-- DropForeignKey
ALTER TABLE "VenueOwner" DROP CONSTRAINT "VenueOwner_userId_fkey";

-- DropIndex
DROP INDEX "Customer_userId_key";

-- DropIndex
DROP INDEX "VenueOwner_userId_key";

-- AlterTable
ALTER TABLE "Address" DROP COLUMN "isPrimary",
ADD COLUMN     "is_primary" BOOLEAN NOT NULL DEFAULT true;

-- AlterTable
ALTER TABLE "Customer" DROP COLUMN "userId",
ADD COLUMN     "user_id" TEXT NOT NULL;

-- AlterTable
ALTER TABLE "VenueOwner" DROP COLUMN "businessLicense",
DROP COLUMN "experienceYears",
DROP COLUMN "userId",
ADD COLUMN     "business_license" TEXT NOT NULL,
ADD COLUMN     "experience_years" INTEGER NOT NULL,
ADD COLUMN     "user_id" TEXT NOT NULL;

-- CreateIndex
CREATE UNIQUE INDEX "Customer_user_id_key" ON "Customer"("user_id");

-- CreateIndex
CREATE UNIQUE INDEX "VenueOwner_user_id_key" ON "VenueOwner"("user_id");

-- AddForeignKey
ALTER TABLE "VenueOwner" ADD CONSTRAINT "VenueOwner_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Customer" ADD CONSTRAINT "Customer_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
