/*
  Warnings:

  - You are about to drop the column `accountProvider` on the `Budget` table. All the data in the column will be lost.
  - You are about to drop the column `accountProviderAccountId` on the `Budget` table. All the data in the column will be lost.

*/
-- DropForeignKey
ALTER TABLE "Budget" DROP CONSTRAINT "Budget_accountProvider_accountProviderAccountId_fkey";

-- DropForeignKey
ALTER TABLE "User" DROP CONSTRAINT "User_accountProvider_accountProviderAccountId_fkey";

-- AlterTable
ALTER TABLE "Budget" DROP COLUMN "accountProvider",
DROP COLUMN "accountProviderAccountId";

-- AddForeignKey
ALTER TABLE "Budget" ADD CONSTRAINT "Budget_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE SET NULL ON UPDATE CASCADE;
