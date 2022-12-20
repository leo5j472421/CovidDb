-- Write your own SQL object definition here, and it'll be included in your package.
TRUNCATE TABLE [dbo].[Attachment]
GO
INSERT INTO [dbo].[Attachment] ( Path,IsLinkImage,ContentId,MailTemplateId)
VALUES ('test.jpg',1,'test-01',2)
