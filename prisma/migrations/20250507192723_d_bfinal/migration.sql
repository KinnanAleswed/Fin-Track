BEGIN TRY

BEGIN TRAN;

-- DropForeignKey
ALTER TABLE [dbo].[Projects] DROP CONSTRAINT [FK__Projects__client__123EB7A3];

-- DropForeignKey
ALTER TABLE [dbo].[Projects] DROP CONSTRAINT [FK__Projects__manage__1332DBDC];

-- AlterTable
ALTER TABLE [dbo].[Projects] ALTER COLUMN [clientId] UNIQUEIDENTIFIER NULL;
ALTER TABLE [dbo].[Projects] ALTER COLUMN [startDate] DATETIME NULL;
ALTER TABLE [dbo].[Projects] ALTER COLUMN [endDate] DATETIME NULL;
ALTER TABLE [dbo].[Projects] ALTER COLUMN [status] NVARCHAR(50) NULL;
ALTER TABLE [dbo].[Projects] ALTER COLUMN [billingType] NVARCHAR(50) NULL;
ALTER TABLE [dbo].[Projects] ALTER COLUMN [managerId] UNIQUEIDENTIFIER NULL;
-- ALTER TABLE [dbo].[Projects] ADD [billingRateTimePeriod] NVARCHAR(50);

-- AddForeignKey
ALTER TABLE [dbo].[Projects] ADD CONSTRAINT [FK__Projects__client__123EB7A3] FOREIGN KEY ([clientId]) REFERENCES [dbo].[Clients]([id]) ON DELETE SET NULL ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[Projects] ADD CONSTRAINT [FK__Projects__manage__1332DBDC] FOREIGN KEY ([managerId]) REFERENCES [dbo].[Users]([id]) ON DELETE SET NULL ON UPDATE NO ACTION;

COMMIT TRAN;

END TRY
BEGIN CATCH

IF @@TRANCOUNT > 0
BEGIN
    ROLLBACK TRAN;
END;
THROW

END CATCH
