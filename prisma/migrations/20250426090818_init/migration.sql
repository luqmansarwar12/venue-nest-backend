-- CreateEnum
CREATE TYPE "UserRole" AS ENUM ('SUPER_ADMIN', 'CONTACT_SUPPORT', 'INSPECTOR', 'VENUE_OWNER', 'VENUE_MANAGER', 'CUSTOMER');

-- CreateEnum
CREATE TYPE "UserStatus" AS ENUM ('ACTIVE', 'BANNED', 'DEACTIVATED', 'DELETED');

-- CreateEnum
CREATE TYPE "VenueType" AS ENUM ('WEDDING', 'CONFERENCE', 'BIRTHDAY');

-- CreateEnum
CREATE TYPE "VenueStatus" AS ENUM ('CREATED', 'ASSIGNED_TO_INSPECTOR', 'PENDING_APPROVAL', 'APPROVED', 'DELETED');

-- CreateEnum
CREATE TYPE "MenuType" AS ENUM ('STEAKS', 'CHINEESE', 'BEVERAGES', 'DESSERTS');

-- CreateEnum
CREATE TYPE "DishStatus" AS ENUM ('COMING_SOON', 'AVAILABLE', 'DISCONTINUED');

-- CreateEnum
CREATE TYPE "BookingStatus" AS ENUM ('PENDING_APPROVAL', 'APPROVED', 'CHECKED_OUT', 'PAID');

-- CreateEnum
CREATE TYPE "PaymentType" AS ENUM ('CASH', 'CARD', 'BANK_TRANSFER');

-- CreateEnum
CREATE TYPE "PaymentStatus" AS ENUM ('PENDING', 'PARTIALLY_PAID', 'PAID', 'FAILED', 'REFUNDED');

-- CreateTable
CREATE TABLE "User" (
    "id" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "email" TEXT NOT NULL,
    "password" TEXT NOT NULL,
    "phone" TEXT NOT NULL,
    "role" "UserRole" NOT NULL,
    "status" "UserStatus" NOT NULL DEFAULT 'ACTIVE',
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "User_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "SuperAdmin" (
    "id" TEXT NOT NULL,
    "userId" TEXT NOT NULL,

    CONSTRAINT "SuperAdmin_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "VenueOwner" (
    "id" TEXT NOT NULL,
    "businessLicense" TEXT NOT NULL,
    "experienceYears" INTEGER NOT NULL,
    "userId" TEXT NOT NULL,

    CONSTRAINT "VenueOwner_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Customer" (
    "id" TEXT NOT NULL,
    "userId" TEXT NOT NULL,

    CONSTRAINT "Customer_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Address" (
    "id" TEXT NOT NULL,
    "street" TEXT NOT NULL,
    "city" TEXT NOT NULL,
    "state" TEXT NOT NULL,
    "zip_code" TEXT NOT NULL,
    "country" TEXT NOT NULL,
    "longitude" DOUBLE PRECISION,
    "latitude" DOUBLE PRECISION,
    "isPrimary" BOOLEAN NOT NULL DEFAULT true,
    "user_id" TEXT,
    "venue_id" TEXT,

    CONSTRAINT "Address_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Venue" (
    "id" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "capacity" INTEGER NOT NULL,
    "status" "VenueStatus" NOT NULL DEFAULT 'CREATED',
    "price_per_person" DOUBLE PRECISION NOT NULL,
    "opening_time" TIMESTAMP(3) NOT NULL,
    "closing_time" TIMESTAMP(3) NOT NULL,
    "venue_type" "VenueType" NOT NULL,
    "owner_id" TEXT NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "Venue_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Menu" (
    "id" TEXT NOT NULL,
    "venue_id" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "description" TEXT NOT NULL,
    "menu_type" "MenuType" NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "Menu_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Dish" (
    "id" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "price" DOUBLE PRECISION NOT NULL,
    "price_unit" TEXT NOT NULL,
    "ingredients" TEXT[],
    "status" "DishStatus" NOT NULL DEFAULT 'AVAILABLE',
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "Dish_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "DishOnMenu" (
    "id" TEXT NOT NULL,
    "dish_id" TEXT NOT NULL,
    "menu_id" TEXT NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "DishOnMenu_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Booking" (
    "id" TEXT NOT NULL,
    "customer_id" TEXT NOT NULL,
    "venue_id" TEXT NOT NULL,
    "menu_id" TEXT NOT NULL,
    "guest_count" INTEGER NOT NULL,
    "start_time" TIMESTAMP(3) NOT NULL,
    "end_time" TIMESTAMP(3) NOT NULL,
    "status" TEXT NOT NULL,
    "total_price" DOUBLE PRECISION NOT NULL,
    "negotiated_price" DOUBLE PRECISION NOT NULL,
    "owner_remarks" TEXT NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "Booking_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Payment" (
    "id" TEXT NOT NULL,
    "booking_id" TEXT NOT NULL,
    "payer_id" TEXT NOT NULL,
    "receiver_id" TEXT NOT NULL,
    "advance_paid" DOUBLE PRECISION NOT NULL,
    "pending_bill" DOUBLE PRECISION NOT NULL,
    "payment_type" "PaymentType" NOT NULL,
    "status" "PaymentStatus" NOT NULL DEFAULT 'PENDING',
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Payment_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "User_email_key" ON "User"("email");

-- CreateIndex
CREATE UNIQUE INDEX "User_phone_key" ON "User"("phone");

-- CreateIndex
CREATE UNIQUE INDEX "SuperAdmin_userId_key" ON "SuperAdmin"("userId");

-- CreateIndex
CREATE UNIQUE INDEX "VenueOwner_userId_key" ON "VenueOwner"("userId");

-- CreateIndex
CREATE UNIQUE INDEX "Customer_userId_key" ON "Customer"("userId");

-- CreateIndex
CREATE UNIQUE INDEX "Payment_booking_id_key" ON "Payment"("booking_id");

-- AddForeignKey
ALTER TABLE "SuperAdmin" ADD CONSTRAINT "SuperAdmin_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "VenueOwner" ADD CONSTRAINT "VenueOwner_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Customer" ADD CONSTRAINT "Customer_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Address" ADD CONSTRAINT "Address_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "User"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Address" ADD CONSTRAINT "Address_venue_id_fkey" FOREIGN KEY ("venue_id") REFERENCES "Venue"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Venue" ADD CONSTRAINT "Venue_owner_id_fkey" FOREIGN KEY ("owner_id") REFERENCES "User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Menu" ADD CONSTRAINT "Menu_venue_id_fkey" FOREIGN KEY ("venue_id") REFERENCES "Venue"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "DishOnMenu" ADD CONSTRAINT "DishOnMenu_dish_id_fkey" FOREIGN KEY ("dish_id") REFERENCES "Dish"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "DishOnMenu" ADD CONSTRAINT "DishOnMenu_menu_id_fkey" FOREIGN KEY ("menu_id") REFERENCES "Menu"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Booking" ADD CONSTRAINT "Booking_customer_id_fkey" FOREIGN KEY ("customer_id") REFERENCES "User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Booking" ADD CONSTRAINT "Booking_venue_id_fkey" FOREIGN KEY ("venue_id") REFERENCES "Venue"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Booking" ADD CONSTRAINT "Booking_menu_id_fkey" FOREIGN KEY ("menu_id") REFERENCES "Menu"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Payment" ADD CONSTRAINT "Payment_booking_id_fkey" FOREIGN KEY ("booking_id") REFERENCES "Booking"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Payment" ADD CONSTRAINT "Payment_payer_id_fkey" FOREIGN KEY ("payer_id") REFERENCES "User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Payment" ADD CONSTRAINT "Payment_receiver_id_fkey" FOREIGN KEY ("receiver_id") REFERENCES "User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
