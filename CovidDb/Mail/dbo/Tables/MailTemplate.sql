CREATE TABLE [dbo].[MailTemplate]
(
  [Id] INT NOT NULL PRIMARY KEY IDENTITY (1,1),
  [Subject] NVARCHAR(1000),
  [Body] NVARCHAR(Max),
  [MailGroup] INT,
  [IsForSent] BIT,
)
