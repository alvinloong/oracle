

SET SQLPLUS_DIR=F:\soft\oracle\instantclient_12_1

SET UserName=logger
SET Password=logger
SET NetAlias=SFBI_DB_01

SET LogFile=install_schema.log

%SQLPLUS_DIR%\sqlplus %UserName%/%Password%@%NetAlias%  @".\type\install.sql" %LogFile%
%SQLPLUS_DIR%\sqlplus %UserName%/%Password%@%NetAlias%  @".\sequence\install.sql" %LogFile%
%SQLPLUS_DIR%\sqlplus %UserName%/%Password%@%NetAlias%  @".\table\install.sql" %LogFile%
%SQLPLUS_DIR%\sqlplus %UserName%/%Password%@%NetAlias%  @".\trigger\install.sql" %LogFile%
%SQLPLUS_DIR%\sqlplus %UserName%/%Password%@%NetAlias%  @".\package\install.sql" %LogFile%

notepad %LogFile%
