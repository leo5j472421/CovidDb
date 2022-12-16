CREATE ROLE [RoleAragorn]
    AUTHORIZATION [dbo];

GO
EXECUTE sp_addrolemember @rolename = N'RoleAragorn', @membername = N'N_Aragorn';

GO

CREATE ROLE [RoleNagasino]
    AUTHORIZATION [dbo];

GO
EXECUTE sp_addrolemember @rolename = N'RoleNagasino', @membername = N'N_Nagasino';

