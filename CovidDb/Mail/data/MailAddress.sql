-- Write your own SQL object definition here, and it'll be included in your package.
TRUNCATE TABLE [dbo].[MailAddress]
GO
INSERT INTO [dbo].[MailAddress] (Mail,Name,Company,IsTest,MailGroup)
VALUES ('leo.chu@568win.com','Leo ininder','568win',1,1),
('leo.chu@568win.com','Leo ininder','568win',1,2)