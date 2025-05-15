/*
  Warnings:

  - You are about to drop the column `role` on the `RoleRates` table. All the data in the column will be lost.
  - You are about to drop the column `role` on the `Users` table. All the data in the column will be lost.
  - Made the column `startDate` on table `Projects` required. This step will fail if there are existing NULL values in that column.
  - Made the column `endDate` on table `Projects` required. This step will fail if there are existing NULL values in that column.
  - Made the column `status` on table `Projects` required. This step will fail if there are existing NULL values in that column.
  - Made the column `billingType` on table `Projects` required. This step will fail if there are existing NULL values in that column.
  - Made the column `totalContract` on table `Projects` required. This step will fail if there are existing NULL values in that column.
  - Made the column `approvedBudget` on table `Projects` required. This step will fail if there are existing NULL values in that column.
  - Made the column `allocatedBudget` on table `Projects` required. This step will fail if there are existing NULL values in that column.
  - Made the column `createdAt` on table `Projects` required. This step will fail if there are existing NULL values in that column.
  - Made the column `updatedAt` on table `Projects` required. This step will fail if there are existing NULL values in that column.
  - Made the column `billingRateTimePeriod` on table `Projects` required. This step will fail if there are existing NULL values in that column.

*/
BEGIN TRY

BEGIN TRAN;

-- AlterTable
ALTER TABLE [dbo].[Projects] ALTER COLUMN [startDate] DATETIME NOT NULL;
ALTER TABLE [dbo].[Projects] ALTER COLUMN [endDate] DATETIME NOT NULL;
ALTER TABLE [dbo].[Projects] ALTER COLUMN [status] NVARCHAR(50) NOT NULL;
ALTER TABLE [dbo].[Projects] ALTER COLUMN [billingType] NVARCHAR(50) NOT NULL;
ALTER TABLE [dbo].[Projects] ALTER COLUMN [totalContract] DECIMAL(18,2) NOT NULL;
ALTER TABLE [dbo].[Projects] ALTER COLUMN [approvedBudget] DECIMAL(18,2) NOT NULL;
ALTER TABLE [dbo].[Projects] ALTER COLUMN [allocatedBudget] DECIMAL(18,2) NOT NULL;
ALTER TABLE [dbo].[Projects] ALTER COLUMN [createdAt] DATETIME NOT NULL;
ALTER TABLE [dbo].[Projects] ALTER COLUMN [updatedAt] DATETIME NOT NULL;
ALTER TABLE [dbo].[Projects] ALTER COLUMN [billingRateTimePeriod] NVARCHAR(50) NOT NULL;

-- AlterTable
ALTER TABLE [dbo].[RoleRates] DROP COLUMN [role];

-- AlterTable
ALTER TABLE [dbo].[Users] DROP COLUMN [role];

-- CreateTable
CREATE TABLE [dbo].[roles] (
    [id] NVARCHAR(1000) NOT NULL,
    [name] NVARCHAR(50) NOT NULL,
    CONSTRAINT [roles_pkey] PRIMARY KEY CLUSTERED ([id])
);

-- CreateTable
CREATE TABLE [dbo].[_RoleRateRoles] (
    [A] UNIQUEIDENTIFIER NOT NULL,
    [B] NVARCHAR(1000) NOT NULL,
    CONSTRAINT [_RoleRateRoles_AB_unique] UNIQUE NONCLUSTERED ([A],[B])
);

-- CreateTable
CREATE TABLE [dbo].[_UserRoles] (
    [A] UNIQUEIDENTIFIER NOT NULL,
    [B] NVARCHAR(1000) NOT NULL,
    CONSTRAINT [_UserRoles_AB_unique] UNIQUE NONCLUSTERED ([A],[B])
);

-- CreateIndex
CREATE NONCLUSTERED INDEX [_RoleRateRoles_B_index] ON [dbo].[_RoleRateRoles]([B]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [_UserRoles_B_index] ON [dbo].[_UserRoles]([B]);

-- AddForeignKey
ALTER TABLE [dbo].[_RoleRateRoles] ADD CONSTRAINT [_RoleRateRoles_A_fkey] FOREIGN KEY ([A]) REFERENCES [dbo].[RoleRates]([id]) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE [dbo].[_RoleRateRoles] ADD CONSTRAINT [_RoleRateRoles_B_fkey] FOREIGN KEY ([B]) REFERENCES [dbo].[roles]([id]) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE [dbo].[_UserRoles] ADD CONSTRAINT [_UserRoles_A_fkey] FOREIGN KEY ([A]) REFERENCES [dbo].[Users]([id]) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE [dbo].[_UserRoles] ADD CONSTRAINT [_UserRoles_B_fkey] FOREIGN KEY ([B]) REFERENCES [dbo].[roles]([id]) ON DELETE CASCADE ON UPDATE CASCADE;

COMMIT TRAN;

END TRY
BEGIN CATCH

IF @@TRANCOUNT > 0
BEGIN
    ROLLBACK TRAN;
END;
THROW

END CATCH
