BEGIN TRY

BEGIN TRAN;

-- CreateTable
CREATE TABLE [dbo].[FT_DetailedLookup] (
    [Id] INT NOT NULL IDENTITY(1,1),
    [Master_ID] INT NOT NULL,
    [Code] NVARCHAR(50) NOT NULL,
    [Value_AR] NVARCHAR(100) NOT NULL,
    [Value_EN] NVARCHAR(100) NOT NULL,
    [isActive] SMALLINT NOT NULL CONSTRAINT [DEFAULT_DetailedLookup_isActive] DEFAULT 1,
    [createdBy] INT NOT NULL,
    [createdDate] DATETIME NOT NULL CONSTRAINT [DEFAULT_DetailedLookup_createdDate] DEFAULT CURRENT_TIMESTAMP,
    [modifiedBy] INT,
    [modifiedDate] DATETIME,
    [comments] NVARCHAR(max),
    CONSTRAINT [PK_FT_DetailedLookup] PRIMARY KEY CLUSTERED ([Id])
);

-- CreateTable
CREATE TABLE [dbo].[FT_MasterLookup] (
    [Id] INT NOT NULL IDENTITY(1,1),
    [value] NVARCHAR(50) NOT NULL,
    [description_AR] NVARCHAR(100) NOT NULL,
    [description_EN] NVARCHAR(100) NOT NULL,
    [isActive] SMALLINT NOT NULL CONSTRAINT [DEFAULT_MasterLookup_isActive] DEFAULT 1,
    [createdBy] INT NOT NULL,
    [createdDate] DATETIME NOT NULL CONSTRAINT [DEFAULT_MasterLookup_createdDate] DEFAULT CURRENT_TIMESTAMP,
    [modifiedBy] INT,
    [modifiedDate] DATETIME,
    CONSTRAINT [PK_MasterLookup] PRIMARY KEY CLUSTERED ([Id])
);

-- CreateTable
CREATE TABLE [dbo].[FT_Projects] (
    [id] UNIQUEIDENTIFIER NOT NULL CONSTRAINT [DF_FTProjectsid] DEFAULT newid(),
    [name] NVARCHAR(100) NOT NULL,
    [code] NVARCHAR(15) NOT NULL,
    [clientId] INT NOT NULL,
    [startDate] DATETIME NOT NULL,
    [endDate] DATETIME NOT NULL,
    [ProjectManager] INT NOT NULL,
    [status] INT NOT NULL,
    [billingType] INT NOT NULL,
    [totalContract] DECIMAL(18,2) NOT NULL,
    [approvedBudget] DECIMAL(18,2) NOT NULL,
    [allocatedBudget] DECIMAL(18,2) NOT NULL,
    [createdAt] DATETIME NOT NULL CONSTRAINT [DF__FTProjects__create] DEFAULT CURRENT_TIMESTAMP,
    [updatedAt] DATETIME NOT NULL CONSTRAINT [DF__FTProjects__update] DEFAULT CURRENT_TIMESTAMP,
    [billingRateTimePeriod] INT NOT NULL,
    [createdBy] INT NOT NULL,
    CONSTRAINT [PK_FTProjects] PRIMARY KEY CLUSTERED ([id])
);

COMMIT TRAN;

END TRY
BEGIN CATCH

IF @@TRANCOUNT > 0
BEGIN
    ROLLBACK TRAN;
END;
THROW

END CATCH
