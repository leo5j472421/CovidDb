CREATE PROCEDURE [dbo].[SentMail]
  @mail NVARCHAR(100),
  @mailGroup int
AS
  update MailAddress
  Set SentTime = GETDATE(),
  MailGroup = @mailGroup
  where Mail = @mail

RETURN 0
