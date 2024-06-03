/*
  Warnings:

  - You are about to drop the `Accounts` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `Budgets` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `Courtyards` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `Equipments` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `Shunts` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `Substations` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `Users` table. If the table is not empty, all the data it contains will be lost.

*/
-- DropForeignKey
ALTER TABLE "Accounts" DROP CONSTRAINT "Accounts_userId_fkey";

-- DropForeignKey
ALTER TABLE "Budgets" DROP CONSTRAINT "Budgets_userId_fkey";

-- DropForeignKey
ALTER TABLE "Courtyards" DROP CONSTRAINT "Courtyards_substationId_fkey";

-- DropForeignKey
ALTER TABLE "Equipments" DROP CONSTRAINT "Equipments_courtyardId_fkey";

-- DropForeignKey
ALTER TABLE "Shunts" DROP CONSTRAINT "Shunts_courtyardId_fkey";

-- DropForeignKey
ALTER TABLE "Substations" DROP CONSTRAINT "Substations_budgetId_fkey";

-- DropTable
DROP TABLE "Accounts";

-- DropTable
DROP TABLE "Budgets";

-- DropTable
DROP TABLE "Courtyards";

-- DropTable
DROP TABLE "Equipments";

-- DropTable
DROP TABLE "Shunts";

-- DropTable
DROP TABLE "Substations";

-- DropTable
DROP TABLE "Users";

-- CreateTable
CREATE TABLE "User" (
    "id" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "password" TEXT NOT NULL,
    "email" TEXT,
    "accountProvider" TEXT NOT NULL,
    "accountProviderAccountId" TEXT NOT NULL,

    CONSTRAINT "User_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Account" (
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

    CONSTRAINT "Account_pkey" PRIMARY KEY ("provider","providerAccountId")
);

-- CreateTable
CREATE TABLE "Budget" (
    "id" SERIAL NOT NULL,
    "title" TEXT NOT NULL,
    "userId" TEXT,
    "accountProvider" TEXT,
    "accountProviderAccountId" TEXT,

    CONSTRAINT "Budget_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Substation" (
    "id" SERIAL NOT NULL,
    "reference_date" TIMESTAMP(3) NOT NULL,
    "region" TEXT NOT NULL,
    "state" TEXT NOT NULL,
    "installationType" TEXT NOT NULL,
    "budgetId" INTEGER,

    CONSTRAINT "Substation_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Courtyard" (
    "id" SERIAL NOT NULL,
    "primaryTension" TEXT NOT NULL,
    "arrangement" TEXT NOT NULL,
    "cbSync" BOOLEAN NOT NULL DEFAULT true,
    "appType" TEXT NOT NULL DEFAULT 'Med./Prot.',
    "substationId" INTEGER,

    CONSTRAINT "Courtyard_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "ShuntModules" (
    "id" SERIAL NOT NULL,
    "type" TEXT NOT NULL,
    "amount" INTEGER NOT NULL,
    "courtyardId" INTEGER,

    CONSTRAINT "ShuntModules_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "EquipmentModules" (
    "id" SERIAL NOT NULL,
    "type" TEXT NOT NULL,
    "amount" INTEGER NOT NULL,
    "courtyardId" INTEGER,

    CONSTRAINT "EquipmentModules_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "User_name_key" ON "User"("name");

-- CreateIndex
CREATE UNIQUE INDEX "User_email_key" ON "User"("email");

-- AddForeignKey
ALTER TABLE "User" ADD CONSTRAINT "User_accountProvider_accountProviderAccountId_fkey" FOREIGN KEY ("accountProvider", "accountProviderAccountId") REFERENCES "Account"("provider", "providerAccountId") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Budget" ADD CONSTRAINT "Budget_accountProvider_accountProviderAccountId_fkey" FOREIGN KEY ("accountProvider", "accountProviderAccountId") REFERENCES "Account"("provider", "providerAccountId") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Substation" ADD CONSTRAINT "Substation_budgetId_fkey" FOREIGN KEY ("budgetId") REFERENCES "Budget"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Courtyard" ADD CONSTRAINT "Courtyard_substationId_fkey" FOREIGN KEY ("substationId") REFERENCES "Substation"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ShuntModules" ADD CONSTRAINT "ShuntModules_courtyardId_fkey" FOREIGN KEY ("courtyardId") REFERENCES "Courtyard"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "EquipmentModules" ADD CONSTRAINT "EquipmentModules_courtyardId_fkey" FOREIGN KEY ("courtyardId") REFERENCES "Courtyard"("id") ON DELETE SET NULL ON UPDATE CASCADE;
