CREATE PROCEDURE [dbo].[GetSentMailInfo]
  @mailGroup int = 1,
  @isTest bit = 1
AS
SELECT b.Id as templateId ,Mail, Name, Company, Subject, Body
From [dbo].[MailAddress] a WITH (NOLOCK)
  LEFT JOIN [dbo].[MailTemplate] b  WITH (NOLOCK)
  ON a.[MailGroup] = b.[MailGroup]
WHERE  a.[IsTest] = @isTest and  b.[MailGroup] = @mailgroup and b.IsForSent = 1
RETURN 0
