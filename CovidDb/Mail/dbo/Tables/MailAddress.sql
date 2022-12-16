CREATE TABLE [dbo].[MailAddress]
(
  [Id] INT NOT NULL PRIMARY KEY IDENTITY(1,1),
  [Mail] NVARCHAR(100),
  [Name] NVARCHAR(100),
  [Company] NVARCHAR(100),
  [IsTest] BIT,
  [MailGroup] INT,
)
