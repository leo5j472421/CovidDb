CREATE PROCEDURE [dbo].[GetEmailTemplate]
  @mailGroup int
AS
  SELECT id as TemplateId ,Subject, Body FROM
  [dbo].[MailTemplate] b  WITH (NOLOCK)
  WHERE  b.[MailGroup] = @mailgroup and b.IsForSent = 1
RETURN 0
