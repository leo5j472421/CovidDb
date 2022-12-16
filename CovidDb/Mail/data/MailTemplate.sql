TRUNCATE TABLE  [dbo].[MailTemplate]
INSERT INTO MailTemplate (Subject,Body,MailGroup)
VALUES ('Hey {Name} This is Testing Mail', 'Dear {Company} This is Testing Mail',1)