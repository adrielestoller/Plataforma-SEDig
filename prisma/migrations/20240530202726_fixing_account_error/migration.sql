/*
  Warnings:

  - You are about to drop the column `accountProvider` on the `User` table. All the data in the column will be lost.
  - You are about to drop the column `accountProviderAccountId` on the `User` table. All the data in the column will be lost.

*/
-- AlterTable
ALTER TABLE "User" DROP COLUMN "accountProvider",
DROP COLUMN "accountProviderAccountId";

-- AddForeignKey
ALTER TABLE "Account" ADD CONSTRAINT "Account_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE CASCADE ON UPDATE CASCADE;
