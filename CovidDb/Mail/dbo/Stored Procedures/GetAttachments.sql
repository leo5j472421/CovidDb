CREATE PROCEDURE [dbo].[GetAttachments]
  @mailTemplateId int = 0
AS
  SELECT [Path],
  [IsLinkImage] ,
  [ContentId] FROM [dbo].[Attachment]
RETURN 0
