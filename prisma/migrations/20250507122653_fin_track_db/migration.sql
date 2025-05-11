BEGIN TRY

BEGIN TRAN;

-- CreateTable
CREATE TABLE [dbo].[Activities] (
    [id] UNIQUEIDENTIFIER NOT NULL CONSTRAINT [DF__Activities__id__25518C17] DEFAULT newid(),
    [projectId] UNIQUEIDENTIFIER NOT NULL,
    [userId] UNIQUEIDENTIFIER NOT NULL,
    [date] DATETIME NOT NULL,
    [hours] FLOAT(53) NOT NULL,
    [progress] INT,
    [notes] NVARCHAR(1000),
    CONSTRAINT [PK__Activiti__3213E83F01D46A32] PRIMARY KEY CLUSTERED ([id])
);

-- CreateTable
CREATE TABLE [dbo].[BudgetAllocations] (
    [id] UNIQUEIDENTIFIER NOT NULL CONSTRAINT [DF__BudgetAlloca__id__1BC821DD] DEFAULT newid(),
    [budgetId] UNIQUEIDENTIFIER NOT NULL,
    [userId] UNIQUEIDENTIFIER NOT NULL,
    [hours] FLOAT(53) NOT NULL,
    [rate] DECIMAL(10,2) NOT NULL,
    CONSTRAINT [PK__BudgetAl__3213E83FA1FE8038] PRIMARY KEY CLUSTERED ([id])
);

-- CreateTable
CREATE TABLE [dbo].[Budgets] (
    [id] UNIQUEIDENTIFIER NOT NULL CONSTRAINT [DF__Budgets__id__160F4887] DEFAULT newid(),
    [projectId] UNIQUEIDENTIFIER NOT NULL,
    [itemType] NVARCHAR(100) NOT NULL,
    [description] NVARCHAR(1000),
    [status] NVARCHAR(50) CONSTRAINT [DF__Budgets__status__17036CC0] DEFAULT 'OPEN',
    [createdById] UNIQUEIDENTIFIER NOT NULL,
    CONSTRAINT [PK__Budgets__3213E83FAE21337F] PRIMARY KEY CLUSTERED ([id])
);

-- CreateTable
CREATE TABLE [dbo].[Clients] (
    [id] UNIQUEIDENTIFIER NOT NULL CONSTRAINT [DF__Clients__id__07C12930] DEFAULT newid(),
    [name] NVARCHAR(255) NOT NULL,
    CONSTRAINT [PK__Clients__3213E83F7E4EF78B] PRIMARY KEY CLUSTERED ([id])
);

-- CreateTable
CREATE TABLE [dbo].[CostSplits] (
    [id] UNIQUEIDENTIFIER NOT NULL CONSTRAINT [DF__CostSplits__id__2FCF1A8A] DEFAULT newid(),
    [projectId] UNIQUEIDENTIFIER NOT NULL,
    [cost] DECIMAL(18,2) NOT NULL,
    [splitWith] NVARCHAR(max) NOT NULL,
    [approvedBy] UNIQUEIDENTIFIER,
    CONSTRAINT [PK__CostSpli__3213E83F5F228E23] PRIMARY KEY CLUSTERED ([id])
);

-- CreateTable
CREATE TABLE [dbo].[ExchangeRates] (
    [id] UNIQUEIDENTIFIER NOT NULL CONSTRAINT [DF__ExchangeRate__id__3493CFA7] DEFAULT newid(),
    [currency] NVARCHAR(10) NOT NULL,
    [rate] DECIMAL(10,4) NOT NULL,
    [createdAt] DATETIME CONSTRAINT [DF__ExchangeR__creat__3587F3E0] DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT [PK__Exchange__3213E83FD3DAAEA4] PRIMARY KEY CLUSTERED ([id])
);

-- CreateTable
CREATE TABLE [dbo].[Expenses] (
    [id] UNIQUEIDENTIFIER NOT NULL CONSTRAINT [DF__Expenses__id__208CD6FA] DEFAULT newid(),
    [projectId] UNIQUEIDENTIFIER NOT NULL,
    [submittedBy] UNIQUEIDENTIFIER NOT NULL,
    [expenseType] NVARCHAR(50) NOT NULL,
    [isBillable] BIT NOT NULL,
    [amount] DECIMAL(18,2) NOT NULL,
    [description] NVARCHAR(1000),
    [expenseDate] DATETIME NOT NULL,
    CONSTRAINT [PK__Expenses__3213E83F95C50797] PRIMARY KEY CLUSTERED ([id])
);

-- CreateTable
CREATE TABLE [dbo].[Projects] (
    [id] UNIQUEIDENTIFIER NOT NULL CONSTRAINT [DF__Projects__id__0F624AF8] DEFAULT newid(),
    [name] NVARCHAR(255) NOT NULL,
    [code] NVARCHAR(50) NOT NULL,
    [clientId] UNIQUEIDENTIFIER NOT NULL,
    [startDate] DATETIME NOT NULL,
    [endDate] DATETIME NOT NULL,
    [status] NVARCHAR(50) NOT NULL,
    [billingType] NVARCHAR(50) NOT NULL,
    [managerId] UNIQUEIDENTIFIER NOT NULL,
    [totalContract] DECIMAL(18,2),
    [approvedBudget] DECIMAL(18,2),
    [allocatedBudget] DECIMAL(18,2),
    [createdAt] DATETIME CONSTRAINT [DF__Projects__create__10566F31] DEFAULT CURRENT_TIMESTAMP,
    [updatedAt] DATETIME CONSTRAINT [DF__Projects__update__114A936A] DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT [PK__Projects__3213E83FDFB1A0FD] PRIMARY KEY CLUSTERED ([id]),
    CONSTRAINT [UQ__Projects__357D4CF98DAC9E13] UNIQUE NONCLUSTERED ([code])
);

-- CreateTable
CREATE TABLE [dbo].[RoleRates] (
    [id] UNIQUEIDENTIFIER NOT NULL CONSTRAINT [DF__RoleRates__id__3864608B] DEFAULT newid(),
    [role] NVARCHAR(50) NOT NULL,
    [rate] DECIMAL(10,2) NOT NULL,
    [validFrom] DATETIME NOT NULL,
    CONSTRAINT [PK__RoleRate__3213E83F35863CD4] PRIMARY KEY CLUSTERED ([id])
);

-- CreateTable
CREATE TABLE [dbo].[sysdiagrams] (
    [name] NVARCHAR(128) NOT NULL,
    [principal_id] INT NOT NULL,
    [diagram_id] INT NOT NULL IDENTITY(1,1),
    [version] INT,
    [definition] VARBINARY(max),
    CONSTRAINT [PK__sysdiagr__C2B05B618B44F901] PRIMARY KEY CLUSTERED ([diagram_id]),
    CONSTRAINT [UK_principal_name] UNIQUE NONCLUSTERED ([principal_id],[name])
);

-- CreateTable
CREATE TABLE [dbo].[TravelRequests] (
    [id] UNIQUEIDENTIFIER NOT NULL CONSTRAINT [DF__TravelReques__id__2A164134] DEFAULT newid(),
    [projectId] UNIQUEIDENTIFIER NOT NULL,
    [requesterId] UNIQUEIDENTIFIER NOT NULL,
    [destination] NVARCHAR(255) NOT NULL,
    [purpose] NVARCHAR(1000) NOT NULL,
    [cost] DECIMAL(18,2) NOT NULL,
    [status] NVARCHAR(50) CONSTRAINT [DF__TravelReq__statu__2B0A656D] DEFAULT 'PENDING',
    CONSTRAINT [PK__TravelRe__3213E83F5FB1491E] PRIMARY KEY CLUSTERED ([id])
);

-- CreateTable
CREATE TABLE [dbo].[Notifications] (
    [id] UNIQUEIDENTIFIER NOT NULL CONSTRAINT [Notifications_id_df] DEFAULT newid(),
    [userId] UNIQUEIDENTIFIER NOT NULL,
    [type] NVARCHAR(50) NOT NULL,
    [message] NVARCHAR(1000) NOT NULL,
    [isRead] BIT NOT NULL CONSTRAINT [Notifications_isRead_df] DEFAULT 0,
    [createdAt] DATETIME NOT NULL CONSTRAINT [Notifications_createdAt_df] DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT [PK__Notifica__3213E83F] PRIMARY KEY CLUSTERED ([id])
);

-- CreateTable
CREATE TABLE [dbo].[Approvals] (
    [id] UNIQUEIDENTIFIER NOT NULL CONSTRAINT [Approvals_id_df] DEFAULT newid(),
    [entityId] UNIQUEIDENTIFIER NOT NULL,
    [entityType] NVARCHAR(100) NOT NULL,
    [approverId] UNIQUEIDENTIFIER NOT NULL,
    [status] NVARCHAR(50) NOT NULL,
    [comment] NVARCHAR(1000),
    [updatedAt] DATETIME NOT NULL CONSTRAINT [Approvals_updatedAt_df] DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT [PK__Approval__3213E83F] PRIMARY KEY CLUSTERED ([id])
);

-- CreateTable
CREATE TABLE [dbo].[AuditLogs] (
    [id] UNIQUEIDENTIFIER NOT NULL CONSTRAINT [AuditLogs_id_df] DEFAULT newid(),
    [userId] UNIQUEIDENTIFIER,
    [actionType] NVARCHAR(100) NOT NULL,
    [entityType] NVARCHAR(100) NOT NULL,
    [entityId] NVARCHAR(100) NOT NULL,
    [description] NVARCHAR(1000) NOT NULL,
    [timestamp] DATETIME NOT NULL CONSTRAINT [AuditLogs_timestamp_df] DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT [PK__AuditLog__3213E83F] PRIMARY KEY CLUSTERED ([id])
);

-- CreateTable
CREATE TABLE [dbo].[Lookups] (
    [id] UNIQUEIDENTIFIER NOT NULL CONSTRAINT [Lookups_id_df] DEFAULT newid(),
    [category] NVARCHAR(100) NOT NULL,
    [code] NVARCHAR(100) NOT NULL,
    [label] NVARCHAR(255) NOT NULL,
    [isActive] BIT NOT NULL CONSTRAINT [Lookups_isActive_df] DEFAULT 1,
    [sortOrder] INT,
    CONSTRAINT [PK__Lookups__3213E83F] PRIMARY KEY CLUSTERED ([id])
);

-- CreateTable
CREATE TABLE [dbo].[Users] (
    [id] UNIQUEIDENTIFIER NOT NULL CONSTRAINT [DF__Users__id__0B91BA14] DEFAULT newid(),
    [fullName] NVARCHAR(255) NOT NULL,
    [email] NVARCHAR(255) NOT NULL,
    [role] NVARCHAR(50) NOT NULL,
    CONSTRAINT [PK__Users__3213E83F861CB477] PRIMARY KEY CLUSTERED ([id]),
    CONSTRAINT [UQ__Users__AB6E6164120FB4DB] UNIQUE NONCLUSTERED ([email])
);

-- AddForeignKey
ALTER TABLE [dbo].[Activities] ADD CONSTRAINT [FK__Activitie__proje__2645B050] FOREIGN KEY ([projectId]) REFERENCES [dbo].[Projects]([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[Activities] ADD CONSTRAINT [FK__Activitie__userI__2739D489] FOREIGN KEY ([userId]) REFERENCES [dbo].[Users]([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[BudgetAllocations] ADD CONSTRAINT [FK__BudgetAll__budge__1CBC4616] FOREIGN KEY ([budgetId]) REFERENCES [dbo].[Budgets]([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[BudgetAllocations] ADD CONSTRAINT [FK__BudgetAll__userI__1DB06A4F] FOREIGN KEY ([userId]) REFERENCES [dbo].[Users]([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[Budgets] ADD CONSTRAINT [FK__Budgets__created__18EBB532] FOREIGN KEY ([createdById]) REFERENCES [dbo].[Users]([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[Budgets] ADD CONSTRAINT [FK__Budgets__project__17F790F9] FOREIGN KEY ([projectId]) REFERENCES [dbo].[Projects]([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[CostSplits] ADD CONSTRAINT [FK__CostSplit__appro__31B762FC] FOREIGN KEY ([approvedBy]) REFERENCES [dbo].[Users]([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[CostSplits] ADD CONSTRAINT [FK__CostSplit__proje__30C33EC3] FOREIGN KEY ([projectId]) REFERENCES [dbo].[Projects]([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[Expenses] ADD CONSTRAINT [FK__Expenses__projec__2180FB33] FOREIGN KEY ([projectId]) REFERENCES [dbo].[Projects]([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[Expenses] ADD CONSTRAINT [FK__Expenses__submit__22751F6C] FOREIGN KEY ([submittedBy]) REFERENCES [dbo].[Users]([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[Projects] ADD CONSTRAINT [FK__Projects__client__123EB7A3] FOREIGN KEY ([clientId]) REFERENCES [dbo].[Clients]([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[Projects] ADD CONSTRAINT [FK__Projects__manage__1332DBDC] FOREIGN KEY ([managerId]) REFERENCES [dbo].[Users]([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[TravelRequests] ADD CONSTRAINT [FK__TravelReq__proje__2BFE89A6] FOREIGN KEY ([projectId]) REFERENCES [dbo].[Projects]([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[TravelRequests] ADD CONSTRAINT [FK__TravelReq__reque__2CF2ADDF] FOREIGN KEY ([requesterId]) REFERENCES [dbo].[Users]([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[Notifications] ADD CONSTRAINT [Notifications_userId_fkey] FOREIGN KEY ([userId]) REFERENCES [dbo].[Users]([id]) ON DELETE NO ACTION ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE [dbo].[Approvals] ADD CONSTRAINT [Approvals_approverId_fkey] FOREIGN KEY ([approverId]) REFERENCES [dbo].[Users]([id]) ON DELETE NO ACTION ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE [dbo].[AuditLogs] ADD CONSTRAINT [AuditLogs_userId_fkey] FOREIGN KEY ([userId]) REFERENCES [dbo].[Users]([id]) ON DELETE SET NULL ON UPDATE CASCADE;


ALTER TABLE [dbo].[Projects] ADD [billingRateTimePeriod] NVARCHAR(50) NULL;

COMMIT TRAN;

END TRY
BEGIN CATCH

IF @@TRANCOUNT > 0
BEGIN
    ROLLBACK TRAN;
END;
THROW

END CATCH
