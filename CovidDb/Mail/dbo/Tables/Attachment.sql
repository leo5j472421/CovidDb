CREATE TABLE [dbo].[Attachment]
(
  [Id] INT NOT NULL PRIMARY KEY IDENTITY (1,1),
  [MailTemplateId] INT NOT NULL,
  [Path] NVARCHAR(1000),
  [IsLinkImage] BIT,
  [ContentId] NVARCHAR(100)
)
