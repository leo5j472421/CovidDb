CREATE PROCEDURE [dbo].[GetAttachments]
  @mailTemplateId int = 0
AS
  SELECT [Path],
  [IsLinkImage] ,
  [ContentId] FROM [dbo].[Attachment]
  Where MailTemplateId = @mailTemplateId 
RETURN 0
