CREATE PROCEDURE [dbo].[GetSentMailInfo]
  @isTest bit = 1,
  @count int
AS
SELECT Top (@count) Mail, Name, Company
From [dbo].[MailAddress] a WITH (NOLOCK)
WHERE  a.[IsTest] = @isTest AND (@isTest = 1 OR SentTime = null)
RETURN 0
