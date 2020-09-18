-- Creates the user "shcooper" for SQL Server using the security credential "RestrictedFaculty"   
-- The user login starts with the password "Baz1nga," but that password must be changed after the first login.  

CREATE LOGIN designer   
   WITH PASSWORD = 'Pa55w0rd!1'
GO  