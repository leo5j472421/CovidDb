TRUNCATE TABLE [dbo].[MailGroup]
SET IDENTITY_INSERT [dbo].[MailGroup] ON 
INSERT INTO [dbo].[MailGroup] (Id,Name)
VALUES (1,'Sports Provider')
, (2,'Game Provider')
SET IDENTITY_INSERT [dbo].[MailGroup] OFF
