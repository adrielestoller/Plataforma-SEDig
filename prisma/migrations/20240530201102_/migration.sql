/*
  Warnings:

  - You are about to drop the `Account` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `Budget` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `Courtyard` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `EquipmentModules` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `ShuntModules` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `Substation` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `User` table. If the table is not empty, all the data it contains will be lost.

*/
-- DropForeignKey
ALTER TABLE "Account" DROP CONSTRAINT "Account_userId_fkey";

-- DropForeignKey
ALTER TABLE "Budget" DROP CONSTRAINT "Budget_userId_fkey";

-- DropForeignKey
ALTER TABLE "Courtyard" DROP CONSTRAINT "Courtyard_substationId_fkey";

-- DropForeignKey
ALTER TABLE "EquipmentModules" DROP CONSTRAINT "EquipmentModules_courtyardId_fkey";

-- DropForeignKey
ALTER TABLE "ShuntModules" DROP CONSTRAINT "ShuntModules_courtyardId_fkey";

-- DropForeignKey
ALTER TABLE "Substation" DROP CONSTRAINT "Substation_budgetId_fkey";

-- DropTable
DROP TABLE "Account";

-- DropTable
DROP TABLE "Budget";

-- DropTable
DROP TABLE "Courtyard";

-- DropTable
DROP TABLE "EquipmentModules";

-- DropTable
DROP TABLE "ShuntModules";

-- DropTable
DROP TABLE "Substation";

-- DropTable
DROP TABLE "User";

-- CreateTable
CREATE TABLE "users" (
    "id" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "password" TEXT NOT NULL,
    "email" TEXT,

    CONSTRAINT "users_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "accounts" (
    "userId" TEXT NOT NULL,
    "type" TEXT NOT NULL,
    "provider" TEXT NOT NULL,
    "providerAccountId" TEXT NOT NULL,
    "refresh_token" TEXT,
    "access_token" TEXT,
    "expires_at" INTEGER,
    "token_type" TEXT,
    "scope" TEXT,
    "id_token" TEXT,
    "session_state" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "accounts_pkey" PRIMARY KEY ("provider","providerAccountId")
);

-- CreateTable
CREATE TABLE "budgets" (
    "id" SERIAL NOT NULL,
    "title" TEXT NOT NULL,
    "userId" TEXT,

    CONSTRAINT "budgets_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "substations" (
    "id" SERIAL NOT NULL,
    "reference_date" TIMESTAMP(3) NOT NULL,
    "region" TEXT NOT NULL,
    "state" TEXT NOT NULL,
    "installationType" TEXT NOT NULL,
    "budgetId" INTEGER,

    CONSTRAINT "substations_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "courtyards" (
    "id" SERIAL NOT NULL,
    "primaryTension" TEXT NOT NULL,
    "arrangement" TEXT NOT NULL,
    "cbSync" BOOLEAN NOT NULL DEFAULT true,
    "appType" TEXT NOT NULL DEFAULT 'Med./Prot.',
    "substationId" INTEGER,

    CONSTRAINT "courtyards_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "shunts" (
    "id" SERIAL NOT NULL,
    "type" TEXT NOT NULL,
    "amount" INTEGER NOT NULL,
    "courtyardId" INTEGER,

    CONSTRAINT "shunts_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "equipments" (
    "id" SERIAL NOT NULL,
    "type" TEXT NOT NULL,
    "amount" INTEGER NOT NULL,
    "courtyardId" INTEGER,

    CONSTRAINT "equipments_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "users_name_key" ON "users"("name");

-- CreateIndex
CREATE UNIQUE INDEX "users_email_key" ON "users"("email");

-- AddForeignKey
ALTER TABLE "accounts" ADD CONSTRAINT "accounts_userId_fkey" FOREIGN KEY ("userId") REFERENCES "users"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "budgets" ADD CONSTRAINT "budgets_userId_fkey" FOREIGN KEY ("userId") REFERENCES "users"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "substations" ADD CONSTRAINT "substations_budgetId_fkey" FOREIGN KEY ("budgetId") REFERENCES "budgets"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "courtyards" ADD CONSTRAINT "courtyards_substationId_fkey" FOREIGN KEY ("substationId") REFERENCES "substations"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "shunts" ADD CONSTRAINT "shunts_courtyardId_fkey" FOREIGN KEY ("courtyardId") REFERENCES "courtyards"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "equipments" ADD CONSTRAINT "equipments_courtyardId_fkey" FOREIGN KEY ("courtyardId") REFERENCES "courtyards"("id") ON DELETE SET NULL ON UPDATE CASCADE;
