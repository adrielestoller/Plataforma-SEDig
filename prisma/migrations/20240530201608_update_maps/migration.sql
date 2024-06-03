/*
  Warnings:

  - You are about to drop the `accounts` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `budgets` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `courtyards` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `equipments` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `shunts` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `substations` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `users` table. If the table is not empty, all the data it contains will be lost.

*/
-- DropForeignKey
ALTER TABLE "accounts" DROP CONSTRAINT "accounts_userId_fkey";

-- DropForeignKey
ALTER TABLE "budgets" DROP CONSTRAINT "budgets_userId_fkey";

-- DropForeignKey
ALTER TABLE "courtyards" DROP CONSTRAINT "courtyards_substationId_fkey";

-- DropForeignKey
ALTER TABLE "equipments" DROP CONSTRAINT "equipments_courtyardId_fkey";

-- DropForeignKey
ALTER TABLE "shunts" DROP CONSTRAINT "shunts_courtyardId_fkey";

-- DropForeignKey
ALTER TABLE "substations" DROP CONSTRAINT "substations_budgetId_fkey";

-- DropTable
DROP TABLE "accounts";

-- DropTable
DROP TABLE "budgets";

-- DropTable
DROP TABLE "courtyards";

-- DropTable
DROP TABLE "equipments";

-- DropTable
DROP TABLE "shunts";

-- DropTable
DROP TABLE "substations";

-- DropTable
DROP TABLE "users";

-- CreateTable
CREATE TABLE "Users" (
    "id" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "password" TEXT NOT NULL,
    "email" TEXT,

    CONSTRAINT "Users_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Accounts" (
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

    CONSTRAINT "Accounts_pkey" PRIMARY KEY ("provider","providerAccountId")
);

-- CreateTable
CREATE TABLE "Budgets" (
    "id" SERIAL NOT NULL,
    "title" TEXT NOT NULL,
    "userId" TEXT,

    CONSTRAINT "Budgets_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Substations" (
    "id" SERIAL NOT NULL,
    "reference_date" TIMESTAMP(3) NOT NULL,
    "region" TEXT NOT NULL,
    "state" TEXT NOT NULL,
    "installationType" TEXT NOT NULL,
    "budgetId" INTEGER,

    CONSTRAINT "Substations_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Courtyards" (
    "id" SERIAL NOT NULL,
    "primaryTension" TEXT NOT NULL,
    "arrangement" TEXT NOT NULL,
    "cbSync" BOOLEAN NOT NULL DEFAULT true,
    "appType" TEXT NOT NULL DEFAULT 'Med./Prot.',
    "substationId" INTEGER,

    CONSTRAINT "Courtyards_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Shunts" (
    "id" SERIAL NOT NULL,
    "type" TEXT NOT NULL,
    "amount" INTEGER NOT NULL,
    "courtyardId" INTEGER,

    CONSTRAINT "Shunts_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Equipments" (
    "id" SERIAL NOT NULL,
    "type" TEXT NOT NULL,
    "amount" INTEGER NOT NULL,
    "courtyardId" INTEGER,

    CONSTRAINT "Equipments_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "Users_name_key" ON "Users"("name");

-- CreateIndex
CREATE UNIQUE INDEX "Users_email_key" ON "Users"("email");

-- AddForeignKey
ALTER TABLE "Accounts" ADD CONSTRAINT "Accounts_userId_fkey" FOREIGN KEY ("userId") REFERENCES "Users"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Budgets" ADD CONSTRAINT "Budgets_userId_fkey" FOREIGN KEY ("userId") REFERENCES "Users"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Substations" ADD CONSTRAINT "Substations_budgetId_fkey" FOREIGN KEY ("budgetId") REFERENCES "Budgets"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Courtyards" ADD CONSTRAINT "Courtyards_substationId_fkey" FOREIGN KEY ("substationId") REFERENCES "Substations"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Shunts" ADD CONSTRAINT "Shunts_courtyardId_fkey" FOREIGN KEY ("courtyardId") REFERENCES "Courtyards"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Equipments" ADD CONSTRAINT "Equipments_courtyardId_fkey" FOREIGN KEY ("courtyardId") REFERENCES "Courtyards"("id") ON DELETE SET NULL ON UPDATE CASCADE;
