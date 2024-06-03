-- CreateTable
CREATE TABLE "User" (
    "id" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "password" TEXT NOT NULL,
    "email" TEXT NOT NULL,

    CONSTRAINT "User_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Budget" (
    "id" SERIAL NOT NULL,
    "title" TEXT NOT NULL,
    "userId" TEXT,

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
CREATE UNIQUE INDEX "User_email_key" ON "User"("email");

-- AddForeignKey
ALTER TABLE "Budget" ADD CONSTRAINT "Budget_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Substation" ADD CONSTRAINT "Substation_budgetId_fkey" FOREIGN KEY ("budgetId") REFERENCES "Budget"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Courtyard" ADD CONSTRAINT "Courtyard_substationId_fkey" FOREIGN KEY ("substationId") REFERENCES "Substation"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ShuntModules" ADD CONSTRAINT "ShuntModules_courtyardId_fkey" FOREIGN KEY ("courtyardId") REFERENCES "Courtyard"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "EquipmentModules" ADD CONSTRAINT "EquipmentModules_courtyardId_fkey" FOREIGN KEY ("courtyardId") REFERENCES "Courtyard"("id") ON DELETE SET NULL ON UPDATE CASCADE;
