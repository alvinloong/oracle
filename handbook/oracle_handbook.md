# [Administration](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/administration.html)

## [Database Administrator's Guide](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/admin/index.html)

### [Part I Basic Database Administration](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/admin/basic-database-administration.html#GUID-1DF51F9B-86E9-4E40-A30E-00714E7C0003)

#### [Getting Started with Database Administration](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/admin/getting-started-with-database-administration.html#GUID-EA8CC987-EF18-4434-B962-01312CD3A8AC)

##### [Data Utilities](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/admin/getting-started-with-database-administration.html#GUID-32B0A12C-97F7-4BF8-BEAB-6880346C0BAB)

- See Also:
  - [*Oracle Database Utilities*](https://docs.oracle.com/pls/topic/lookup?ctx=en/database/oracle/oracle-database/12.2/admin&id=SUTIL003) for detailed information about SQL*Loader
  - [*Oracle Database Utilities*](https://docs.oracle.com/pls/topic/lookup?ctx=en/database/oracle/oracle-database/12.2/admin&id=SUTIL100) for detailed information about Data Pump

#### [Creating and Configuring an Oracle Database](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/admin/creating-and-configuring-an-oracle-database.html#GUID-807DE711-C82C-4BB2-8C31-5EE89CA71349)

##### [Creating a Database with DBCA](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/admin/creating-and-configuring-an-oracle-database.html#GUID-99A93810-62B1-4707-9995-89B3D0B5FB56)

##### [Specifying Initialization Parameters](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/admin/creating-and-configuring-an-oracle-database.html#GUID-052F49CA-731A-4608-A2B9-2C801621D80F)

###### [Specifying the DDL Lock Timeout](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/admin/creating-and-configuring-an-oracle-database.html#GUID-93D95DD8-B7A0-4C37-B2B2-69A9E5C8F3AD)

```
ALTER SESSION SET DDL_LOCK_TIMEOUT = 10;
ALTER SYSTEM SET DDL_LOCK_TIMEOUT = 10;
ALTER TABLE sales ADD (tax_code VARCHAR2(10));
```

#### [Starting Up and Shutting Down](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/admin/starting-up-and-shutting-down.html#GUID-045DE684-6680-4099-A49E-2F5B5FA59670)

##### [Starting Up a Database](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/admin/starting-up-and-shutting-down.html#GUID-203404B5-5157-4F29-A241-B8ABC4753819)

###### [Starting Up an Instance](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/admin/starting-up-and-shutting-down.html#GUID-D9267CB2-D5E5-4A22-93AA-CF69D618FE6B)

[About Starting Up an Instance](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/admin/starting-up-and-shutting-down.html#GUID-85232C86-0135-4F4C-8941-09963AD78BBB)

With SQL*Plus and Oracle Restart, you can start an instance in various modes:

- `NOMOUNT`—Start the instance without mounting a database. This does not allow access to the database and usually would be done only for database creation or the re-creation of control files.
- `MOUNT`—Start the instance and mount the database, but leave it closed. This state allows for certain DBA activities, but does not allow general access to the database.
- `OPEN`—Start the instance, and mount and open the database. This can be done in unrestricted mode, allowing access to all users, or in restricted mode, allowing access for database administrators only.
- `FORCE`—Force the instance to start after a startup or shutdown problem.
- `OPEN` `RECOVER`—Start the instance and have complete media recovery begin immediately.

See Also:

- [*SQL\*Plus User's Guide and Reference*](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/sqpug/STARTUP.html#GUID-275013B7-CAE2-4619-9A0F-40DB71B61FE8) for details on the `STARTUP` command syntax

STARTUP **Syntax**

```
STARTUP db_options  | cdb_options | upgrade_options
```

where *db options* has the following syntax:

```
[FORCE] [RESTRICT] [PFILE=filename] [QUIET]  [ MOUNT [dbname] |  [ OPEN [open_db_options] [dbname] ] | NOMOUNT ]
```

To bring the database to the next stage, you use the `ALTER DATABASE` statement. For example, this statement brings the database from the `NOMOUNT` to the `MOUNT` stage:

```
ALTER DATABASE MOUNT;
ALTER DATABASE OPEN;
```

[Starting an Instance, and Mounting and Opening a Database](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/admin/starting-up-and-shutting-down.html#GUID-88014B87-63F0-43CD-A01F-8EC595AC1636)

```
STARTUP
STARTUP OPEN
```

[Starting an Instance Without Mounting a Database](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/admin/starting-up-and-shutting-down.html#GUID-F3543C05-09A3-48AA-A06D-72F6E7E1B571)

```
STARTUP NOMOUNT
```

database creation

```
STARTUP NOMOUNT
CREATE DATABASE sample
   CONTROLFILE REUSE 
   LOGFILE
      GROUP 1 ('diskx:log1.log', 'disky:log1.log') SIZE 50K, 
      GROUP 2 ('diskx:log2.log', 'disky:log2.log') SIZE 50K 
   MAXLOGFILES 5 
   MAXLOGHISTORY 100 
   MAXDATAFILES 10 
   MAXINSTANCES 2 
   ARCHIVELOG 
   CHARACTER SET AL32UTF8
   NATIONAL CHARACTER SET AL16UTF16
   DATAFILE  
      'disk1:df1.dbf' AUTOEXTEND ON,
      'disk2:df2.dbf' AUTOEXTEND ON NEXT 10M MAXSIZE UNLIMITED
   DEFAULT TEMPORARY TABLESPACE temp_ts
   UNDO TABLESPACE undo_ts 
   SET TIME_ZONE = '+02:00';
```

re-creation of control files

```
STARTUP NOMOUNT
CREATE CONTROLFILE REUSE DATABASE "CDB1" RESETLOGS FORCE LOGGING ARCHIVELOG
    MAXLOGFILES 16
    MAXLOGMEMBERS 3
    MAXDATAFILES 1024
    MAXINSTANCES 8
    MAXLOGHISTORY 292
LOGFILE
  GROUP 1 '/u01/oradata/CDB1_STBY/onlinelog/o1_mf_1_hkc7zl6g_.log'  SIZE 50M BLOCKSIZE 512,
  GROUP 2 '/u01/oradata/CDB1_STBY/onlinelog/o1_mf_2_hkc7zlpn_.log'  SIZE 50M BLOCKSIZE 512,
  GROUP 3 '/u01/oradata/CDB1_STBY/onlinelog/o1_mf_3_hkc7zm63_.log'  SIZE 50M BLOCKSIZE 512
BLOCKSIZE 512
DATAFILE
  '/u01/oradata/CDB1_STBY/datafile/o1_mf_system_hkc7w1yp_.dbf',
  '/u01/oradata/CDB1_STBY/datafile/o1_mf_sysaux_hkc7x5hs_.dbf',
  '/u01/oradata/CDB1_STBY/datafile/o1_mf_undotbs1_hkc7xo5g_.dbf',
  '/u01/oradata/CDB1_STBY/datafile/o1_mf_users_hkc7yfr6_.dbf',
CHARACTER SET AL32UTF8
;
```

Create standby database

```
echo "******************************************************************************"
echo "Create auxillary instance." `date`
echo "******************************************************************************"
sqlplus / as sysdba <<EOF
--SHUTDOWN IMMEDIATE;
STARTUP NOMOUNT PFILE='/tmp/init${ORACLE_SID}_stby.ora';
exit;
EOF

echo "******************************************************************************"
echo "Create standby database using RMAN duplicate." `date`
echo "******************************************************************************"
rman TARGET sys/${SYS_PASSWORD}@${NODE1_DB_UNIQUE_NAME} AUXILIARY sys/${SYS_PASSWORD}@${NODE2_DB_UNIQUE_NAME} <<EOF

DUPLICATE TARGET DATABASE
  FOR STANDBY
  FROM ACTIVE DATABASE
  DORECOVER
  SPFILE
    SET db_unique_name='${NODE2_DB_UNIQUE_NAME}' COMMENT 'Is standby'
  NOFILENAMECHECK;
  
exit;
EOF
```

[Starting an Instance and Mounting a Database](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/admin/starting-up-and-shutting-down.html#GUID-01B47551-8B2E-4A4C-9A8A-4999C09161FC)

```
STARTUP MOUNT
```

For example, the database must be mounted but not open during the following tasks:

- Starting with Oracle Database 12*c* Release 1 (12.1.0.2), putting a database instance in force full database caching mode. For more information, see "[Using Force Full Database Caching Mode](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/admin/managing-memory.html#GUID-CEBDCC3D-4B69-43C1-A7BE-F635F9F69D5F)".
- Enabling and disabling redo log archiving options. For more information, see [Managing Archived Redo Log Files](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/admin/managing-archived-redo-log-files.html#GUID-5EE4AC49-E1B2-41A2-BEE7-AA951EAAB2F3).
- Performing full database recovery. For more information, see [*Oracle Database Backup and Recovery User's Guide*](https://docs.oracle.com/pls/topic/lookup?ctx=en/database/oracle/oracle-database/12.2/admin&id=BRADV8005).

Enable archivelog mode

```
SHUTDOWN IMMEDIATE;
STARTUP MOUNT;
ALTER DATABASE ARCHIVELOG;
ALTER DATABASE OPEN;
```

[Restricting Access to an Instance at Startup](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/admin/starting-up-and-shutting-down.html#GUID-7A570C5F-BCBB-49A4-9586-270ED9DE2079)

```
STARTUP RESTRICT
ALTER SYSTEM ENABLE RESTRICTED SESSION;
ALTER SYSTEM DISABLE RESTRICTED SESSION;
```

[Forcing an Instance to Start](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/admin/starting-up-and-shutting-down.html#GUID-751E8E2A-C114-456E-AC6E-B66B1A91AF1B)

You should not force a database to start unless you are faced with the following:

- You cannot shut down the current instance with the `SHUTDOWN NORMAL`, `SHUTDOWN IMMEDIATE`, or `SHUTDOWN TRANSACTIONAL` commands.
- You experience problems when starting an instance.

```
STARTUP FORCE
```

[Starting an Instance, Mounting a Database, and Starting Complete Media Recovery](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/admin/starting-up-and-shutting-down.html#GUID-CCA52747-05CA-4ED3-BE6D-E2E684C4D87D)

```
STARTUP OPEN RECOVER
```

[Automatic Database Startup at Operating System Start](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/admin/starting-up-and-shutting-down.html#GUID-61535B5E-457C-4676-9A6E-070C647CEAFA)

[Starting Remote Instances](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/admin/starting-up-and-shutting-down.html#GUID-CE1C1E98-FF9C-44EA-B749-4129EEF3EC6F)

##### [Altering Database Availability](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/admin/starting-up-and-shutting-down.html#GUID-2042AAE4-DAE5-4CD4-89E9-B9DE3A8A2AA1)

###### [Mounting a Database to an Instance](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/admin/starting-up-and-shutting-down.html#GUID-BFB79EA2-2BB0-4BB4-9900-E16FA78011CF)

```
ALTER DATABASE MOUNT;
```

###### [Opening a Closed Database](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/admin/starting-up-and-shutting-down.html#GUID-2F9AB5DD-2744-4509-BD02-2C7893C78E4E)

```
ALTER DATABASE OPEN;
```

###### [Opening a Database in Read-Only Mode](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/admin/starting-up-and-shutting-down.html#GUID-E346A6EB-6CAA-4A0F-AF0E-841B8C3D5B05)

```
ALTER DATABASE OPEN READ ONLY;
ALTER DATABASE OPEN READ WRITE;
```

###### [Restricting Access to an Open Database](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/admin/starting-up-and-shutting-down.html#GUID-989D380B-A4BE-43D2-B687-C68EDA7F69A5)

```
ALTER SYSTEM ENABLE RESTRICTED SESSION;
ALTER SYSTEM DISABLE RESTRICTED SESSIO;
```

##### [Shutting Down a Database](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/admin/starting-up-and-shutting-down.html#GUID-3661B282-5C34-4E32-BC6A-906A72712866)

###### [Shutting Down with the Normal Mode](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/admin/starting-up-and-shutting-down.html#GUID-276E548C-DEBC-45EC-903D-4D13F1AEC683)

```
SHUTDOWN;
SHUTDOWN NORMAL;
```

###### [Shutting Down with the Immediate Mode](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/admin/starting-up-and-shutting-down.html#GUID-3C64BD77-4C53-41C6-B691-6CC5F59F2CEA)

```
SHUTDOWN IMMEDIATE;
```

###### [Shutting Down with the Transactional Mode](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/admin/starting-up-and-shutting-down.html#GUID-37C35468-6C3C-471B-A5E2-16592EBA863A)

```
SHUTDOWN TRANSACTIONAL;
```

###### [Shutting Down with the Abort Mode](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/admin/starting-up-and-shutting-down.html#GUID-CA71AC52-13E6-4958-A963-5F007F106DEC)

```
SHUTDOWN ABORT;
```

### [Part II Oracle Database Structure and Storage](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/admin/oracle-database-structure-and-storage.html#GUID-F11D30A7-BF12-4D8F-A1C2-D7437D38F8C7)

#### [Managing Control Files](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/admin/managing-control-files.html#GUID-5F6F9382-6921-4992-9789-E63B18E99C5F)

##### [Creating Control Files](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/admin/managing-control-files.html#GUID-9CBB8320-E2F6-4BDB-9B1C-A7B801F97F73)

```
CONTROL_FILES = (/u01/oracle/prod/control01.ctl,
                 /u02/oracle/prod/control02.ctl, 
                 /u03/oracle/prod/control03.ctl)
```

###### [Creating New Control Files](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/admin/managing-control-files.html#GUID-9B2E206A-C7E0-4409-9EE2-7501F2BDB696)

[When to Create New Control Files](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/admin/managing-control-files.html#GUID-553F209C-EE30-4637-8344-BB26FE3AA088)

You must create new control files in certain situations.

It is necessary for you to create new control files in the following situations:

- All control files for the database have been permanently damaged and you do not have a control file backup.
- You want to change the database name.

[The CREATE CONTROLFILE Statement](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/admin/managing-control-files.html#GUID-E4677C95-CDBE-4FB5-9A9E-A227B3547FAE)

```
CREATE CONTROLFILE
   SET DATABASE prod
   LOGFILE GROUP 1 ('/u01/oracle/prod/redo01_01.log', 
                    '/u01/oracle/prod/redo01_02.log'),
           GROUP 2 ('/u01/oracle/prod/redo02_01.log', 
                    '/u01/oracle/prod/redo02_02.log'),
           GROUP 3 ('/u01/oracle/prod/redo03_01.log', 
                    '/u01/oracle/prod/redo03_02.log') 
   RESETLOGS
   DATAFILE '/u01/oracle/prod/system01.dbf' SIZE 3M,
            '/u01/oracle/prod/rbs01.dbs' SIZE 5M,
            '/u01/oracle/prod/users01.dbs' SIZE 5M,
            '/u01/oracle/prod/temp01.dbs' SIZE 5M
   MAXLOGFILES 50
   MAXLOGMEMBERS 3
   MAXLOGHISTORY 400
   MAXDATAFILES 200
   MAXINSTANCES 6
   ARCHIVELOG;
```

[Creating New Control Files](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/admin/managing-control-files.html#GUID-3F2B3E3B-F53C-41C9-A902-3CABFCF4EB40)

```
SELECT member FROM v$logfile;
SELECT name FROM v$datafile;
SELECT value FROM v$parameter WHERE name = 'control_files';
SHOW PARAMETER control_files;
```

##### [Backing Up Control Files](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/admin/managing-control-files.html#GUID-204AF8CF-6C51-4D0F-ADE2-BA804352EA93)

Back up the control file to a binary file (duplicate of existing control file) using the following statement:

```
ALTER DATABASE BACKUP CONTROLFILE TO '/oracle/backup/control.bkp';
```

Produce SQL statements that can later be used to re-create your control file:

```
ALTER DATABASE BACKUP CONTROLFILE TO TRACE;
SELECT * FROM v$diag_info WHERE name = 'Diag Trace';
```

```
less /u01/app/oracle/diag/rdbms/cdb1_stby/cdb1/trace/alert_cdb1.log
Backup controlfile written to trace file /u01/app/oracle/diag/rdbms/cdb1_stby/cdb1/trace/cdb1_ora_2338.trc
less /u01/app/oracle/diag/rdbms/cdb1_stby/cdb1/trace/cdb1_ora_2338.trc
```

```
-- The following are current System-scope REDO Log Archival related
-- parameters and can be included in the database initialization file.
--
-- LOG_ARCHIVE_DEST=''
-- LOG_ARCHIVE_DUPLEX_DEST=''
--
-- LOG_ARCHIVE_FORMAT=%t_%s_%r.dbf
--
-- DB_UNIQUE_NAME="cdb1_stby"
--
-- LOG_ARCHIVE_CONFIG='SEND, RECEIVE'
-- LOG_ARCHIVE_CONFIG='DG_CONFIG=("cdb1")'
-- LOG_ARCHIVE_MAX_PROCESSES=4
-- STANDBY_FILE_MANAGEMENT=AUTO
-- STANDBY_ARCHIVE_DEST=?#/dbs/arch
-- FAL_CLIENT=''
-- FAL_SERVER=cdb1.world
--
-- LOG_ARCHIVE_DEST_1='LOCATION=USE_DB_RECOVERY_FILE_DEST'
-- LOG_ARCHIVE_DEST_1='OPTIONAL REOPEN=300 NODELAY'
-- LOG_ARCHIVE_DEST_1='ARCH NOAFFIRM NOVERIFY SYNC'
-- LOG_ARCHIVE_DEST_1='REGISTER NOALTERNATE NODEPENDENCY'
-- LOG_ARCHIVE_DEST_1='NOMAX_FAILURE NOQUOTA_SIZE NOQUOTA_USED NODB_UNIQUE_NAME'
-- LOG_ARCHIVE_DEST_1='VALID_FOR=(PRIMARY_ROLE,ONLINE_LOGFILES)'
-- LOG_ARCHIVE_DEST_STATE_1=ENABLE
--
-- Below are two sets of SQL statements, each of which creates a new
-- control file and uses it to open the database. The first set opens
-- the database with the NORESETLOGS option and should be used only if
-- the current versions of all online logs are available. The second
-- set opens the database with the RESETLOGS option and should be used
-- if online logs are unavailable.
-- The appropriate set of statements can be copied from the trace into
-- a script file, edited as necessary, and executed when there is a
-- need to re-create the control file.
--
```

```
--     Set #1. NORESETLOGS case
--
-- The following commands will create a new control file and use it
-- to open the database.
-- Data used by Recovery Manager will be lost.
-- Additional logs may be required for media recovery of offline
-- Use this only if the current versions of all online logs are
-- available.
-- WARNING! The current control file needs to be checked against
-- the datafiles to insure it contains the correct files. The
-- commands printed here may be missing log and/or data files.
-- Another report should be made after the database has been
-- successfully opened.
-- After mounting the created controlfile, the following SQL
-- statement will place the database in the appropriate
-- protection mode:
--  ALTER DATABASE SET STANDBY DATABASE TO MAXIMIZE PERFORMANCE
STARTUP NOMOUNT
CREATE CONTROLFILE REUSE DATABASE "CDB1" NORESETLOGS FORCE LOGGING ARCHIVELOG
    MAXLOGFILES 16
    MAXLOGMEMBERS 3
    MAXDATAFILES 1024
    MAXINSTANCES 8
    MAXLOGHISTORY 292
LOGFILE
  GROUP 1 '/u01/oradata/CDB1_STBY/onlinelog/o1_mf_1_hkc7zl6g_.log'  SIZE 50M BLOCKSIZE 512,
  GROUP 2 '/u01/oradata/CDB1_STBY/onlinelog/o1_mf_2_hkc7zlpn_.log'  SIZE 50M BLOCKSIZE 512,
  GROUP 3 '/u01/oradata/CDB1_STBY/onlinelog/o1_mf_3_hkc7zm63_.log'  SIZE 50M BLOCKSIZE 512
-- STANDBY LOGFILE
--   GROUP 10 '/u01/oradata/CDB1_STBY/onlinelog/o1_mf_10_hkc7zmnx_.log'  SIZE 50M BLOCKSIZE 512,
--   GROUP 11 '/u01/oradata/CDB1_STBY/onlinelog/o1_mf_11_hkc7zn42_.log'  SIZE 50M BLOCKSIZE 512,
--   GROUP 12 '/u01/oradata/CDB1_STBY/onlinelog/o1_mf_12_hkc7znl3_.log'  SIZE 50M BLOCKSIZE 512,
--   GROUP 13 '/u01/oradata/CDB1_STBY/onlinelog/o1_mf_13_hkc7znyy_.log'  SIZE 50M BLOCKSIZE 512
DATAFILE
  '/u01/oradata/CDB1_STBY/datafile/o1_mf_system_hkc7w1yp_.dbf',
  '/u01/oradata/CDB1_STBY/datafile/o1_mf_sysaux_hkc7x5hs_.dbf',
  '/u01/oradata/CDB1_STBY/datafile/o1_mf_undotbs1_hkc7xo5g_.dbf',
  '/u01/oradata/CDB1_STBY/datafile/o1_mf_users_hkc7yfr6_.dbf',
  '/u01/oradata/CDB1_STBY/AADE880BD721351EE05365C7A8C0D10E/datafile/o1_mf_system_hkc7ylvy_.dbf',
  '/u01/oradata/CDB1_STBY/AADE880BD721351EE05365C7A8C0D10E/datafile/o1_mf_sysaux_hkc7yt7v_.dbf',
  '/u01/oradata/CDB1_STBY/AADE880BD721351EE05365C7A8C0D10E/datafile/o1_mf_undotbs1_hkc7z9sd_.dbf',
  '/u01/oradata/CDB1_STBY/AADE880BD721351EE05365C7A8C0D10E/datafile/o1_mf_users_hkc7zc69_.dbf'
CHARACTER SET AL32UTF8
;
-- Commands to re-create incarnation table
-- Below log names MUST be changed to existing filenames on
-- disk. Any one log file from each branch can be used to
-- re-create incarnation records.
-- ALTER DATABASE REGISTER LOGFILE '/u01/app/oracle/CDB1_STBY/archivelog/2020_08_08/o1_mf_1_1_%u_.arc';
-- ALTER DATABASE REGISTER LOGFILE '/u01/app/oracle/CDB1_STBY/archivelog/2020_08_08/o1_mf_1_1_%u_.arc';
-- Recovery is required if any of the datafiles are restored backups,
-- or if the last shutdown was not normal or immediate.
RECOVER DATABASE
-- All logs need archiving and a log switch is needed.
ALTER SYSTEM ARCHIVE LOG ALL;
-- Database can now be opened normally.
ALTER DATABASE OPEN;
-- Open all the PDBs.
ALTER PLUGGABLE DATABASE ALL OPEN;
-- Files in read-only tablespaces are now named.
ALTER DATABASE RENAME FILE 'MISSING00005'
  TO '/u01/oradata/CDB1_STBY/AADE6CBD2E162DF5E05365C7A8C024EB/datafile/o1_mf_system_hkc7xpqo_.dbf';
ALTER DATABASE RENAME FILE 'MISSING00006'
  TO '/u01/oradata/CDB1_STBY/AADE6CBD2E162DF5E05365C7A8C024EB/datafile/o1_mf_sysaux_hkc7xy99_.dbf';
ALTER DATABASE RENAME FILE 'MISSING00008'
  TO '/u01/oradata/CDB1_STBY/AADE6CBD2E162DF5E05365C7A8C024EB/datafile/o1_mf_undotbs1_hkc7yh89_.dbf';
-- Online the files in read-only tablespaces.
ALTER SESSION SET CONTAINER = PDB$SEED;
ALTER TABLESPACE "SYSTEM" ONLINE;
ALTER TABLESPACE "SYSAUX" ONLINE;
ALTER TABLESPACE "UNDOTBS1" ONLINE;
ALTER SESSION SET CONTAINER = CDB$ROOT;
-- Commands to add tempfiles to temporary tablespaces.
-- Online tempfiles have complete space information.
-- Other tempfiles may require adjustment.
ALTER TABLESPACE TEMP ADD TEMPFILE '/u01/oradata/CDB1_STBY/datafile/o1_mf_temp_hkc8ry4r_.tmp' REUSE;
ALTER SESSION SET CONTAINER = PDB$SEED;
ALTER TABLESPACE TEMP ADD TEMPFILE '/u01/oradata/CDB1_STBY/AADE6CBD2E162DF5E05365C7A8C024EB/datafile/o1_mf_temp_hkc8rzsm_.tmp' REUSE;
ALTER SESSION SET CONTAINER = PDB1;
ALTER TABLESPACE TEMP ADD TEMPFILE '/u01/oradata/CDB1_STBY/AADE880BD721351EE05365C7A8C0D10E/datafile/o1_mf_temp_%u_.tmp' REUSE;
ALTER SESSION SET CONTAINER = CDB$ROOT;
-- End of tempfile additions.
--
--
----------------------------------------------------------
-- The following script can be used on the standby database
-- to re-populate entries for a standby controlfile created
-- on the primary and copied to the standby site.
----------------------------------------------------------
ALTER DATABASE ADD STANDBY LOGFILE THREAD 1 '/u01/oradata/CDB1_STBY/onlinelog/o1_mf_10_hkc7zmnx_.log'
 SIZE 50M BLOCKSIZE 512 REUSE;
ALTER DATABASE ADD STANDBY LOGFILE THREAD 1 '/u01/oradata/CDB1_STBY/onlinelog/o1_mf_11_hkc7zn42_.log'
 SIZE 50M BLOCKSIZE 512 REUSE;
ALTER DATABASE ADD STANDBY LOGFILE THREAD 1 '/u01/oradata/CDB1_STBY/onlinelog/o1_mf_12_hkc7znl3_.log'
 SIZE 50M BLOCKSIZE 512 REUSE;
ALTER DATABASE ADD STANDBY LOGFILE THREAD 1 '/u01/oradata/CDB1_STBY/onlinelog/o1_mf_13_hkc7znyy_.log'
 SIZE 50M BLOCKSIZE 512 REUSE;
-- Registering these archivelog entries will help rebuild
-- information displayed by the V$ARCHIVED_LOG fixed view
```

```
--     Set #2. RESETLOGS case
--
-- The following commands will create a new control file and use it
-- to open the database.
-- Data used by Recovery Manager will be lost.
-- The contents of online logs will be lost and all backups will
-- be invalidated. Use this only if online logs are damaged.
-- WARNING! The current control file needs to be checked against
-- the datafiles to insure it contains the correct files. The
-- commands printed here may be missing log and/or data files.
-- Another report should be made after the database has been
-- successfully opened.
-- After mounting the created controlfile, the following SQL
-- statement will place the database in the appropriate
-- protection mode:
--  ALTER DATABASE SET STANDBY DATABASE TO MAXIMIZE PERFORMANCE
STARTUP NOMOUNT
CREATE CONTROLFILE REUSE DATABASE "CDB1" RESETLOGS FORCE LOGGING ARCHIVELOG
    MAXLOGFILES 16
    MAXLOGMEMBERS 3
    MAXDATAFILES 1024
    MAXINSTANCES 8
    MAXLOGHISTORY 292
LOGFILE
  GROUP 1 '/u01/oradata/CDB1_STBY/onlinelog/o1_mf_1_hkc7zl6g_.log'  SIZE 50M BLOCKSIZE 512,
  GROUP 2 '/u01/oradata/CDB1_STBY/onlinelog/o1_mf_2_hkc7zlpn_.log'  SIZE 50M BLOCKSIZE 512,
  GROUP 3 '/u01/oradata/CDB1_STBY/onlinelog/o1_mf_3_hkc7zm63_.log'  SIZE 50M BLOCKSIZE 512
-- STANDBY LOGFILE
--   GROUP 10 '/u01/oradata/CDB1_STBY/onlinelog/o1_mf_10_hkc7zmnx_.log'  SIZE 50M BLOCKSIZE 512,
--   GROUP 11 '/u01/oradata/CDB1_STBY/onlinelog/o1_mf_11_hkc7zn42_.log'  SIZE 50M BLOCKSIZE 512,
--   GROUP 12 '/u01/oradata/CDB1_STBY/onlinelog/o1_mf_12_hkc7znl3_.log'  SIZE 50M BLOCKSIZE 512,
--   GROUP 13 '/u01/oradata/CDB1_STBY/onlinelog/o1_mf_13_hkc7znyy_.log'  SIZE 50M BLOCKSIZE 512
DATAFILE
  '/u01/oradata/CDB1_STBY/datafile/o1_mf_system_hkc7w1yp_.dbf',
  '/u01/oradata/CDB1_STBY/datafile/o1_mf_sysaux_hkc7x5hs_.dbf',
  '/u01/oradata/CDB1_STBY/datafile/o1_mf_undotbs1_hkc7xo5g_.dbf',
  '/u01/oradata/CDB1_STBY/datafile/o1_mf_users_hkc7yfr6_.dbf',
  '/u01/oradata/CDB1_STBY/AADE880BD721351EE05365C7A8C0D10E/datafile/o1_mf_system_hkc7ylvy_.dbf',
  '/u01/oradata/CDB1_STBY/AADE880BD721351EE05365C7A8C0D10E/datafile/o1_mf_sysaux_hkc7yt7v_.dbf',
  '/u01/oradata/CDB1_STBY/AADE880BD721351EE05365C7A8C0D10E/datafile/o1_mf_undotbs1_hkc7z9sd_.dbf',
  '/u01/oradata/CDB1_STBY/AADE880BD721351EE05365C7A8C0D10E/datafile/o1_mf_users_hkc7zc69_.dbf'
CHARACTER SET AL32UTF8
;
-- Commands to re-create incarnation table
-- Below log names MUST be changed to existing filenames on
-- disk. Any one log file from each branch can be used to
-- re-create incarnation records.
-- ALTER DATABASE REGISTER LOGFILE '/u01/app/oracle/CDB1_STBY/archivelog/2020_08_08/o1_mf_1_1_%u_.arc';
-- ALTER DATABASE REGISTER LOGFILE '/u01/app/oracle/CDB1_STBY/archivelog/2020_08_08/o1_mf_1_1_%u_.arc';
-- Recovery is required if any of the datafiles are restored backups,
-- or if the last shutdown was not normal or immediate.
RECOVER DATABASE USING BACKUP CONTROLFILE
-- Database can now be opened zeroing the online logs.
ALTER DATABASE OPEN RESETLOGS;
-- Open all the PDBs.
ALTER PLUGGABLE DATABASE ALL OPEN;
-- Files in read-only tablespaces are now named.
ALTER DATABASE RENAME FILE 'MISSING00005'
  TO '/u01/oradata/CDB1_STBY/AADE6CBD2E162DF5E05365C7A8C024EB/datafile/o1_mf_system_hkc7xpqo_.dbf';
ALTER DATABASE RENAME FILE 'MISSING00006'
  TO '/u01/oradata/CDB1_STBY/AADE6CBD2E162DF5E05365C7A8C024EB/datafile/o1_mf_sysaux_hkc7xy99_.dbf';
ALTER DATABASE RENAME FILE 'MISSING00008'
  TO '/u01/oradata/CDB1_STBY/AADE6CBD2E162DF5E05365C7A8C024EB/datafile/o1_mf_undotbs1_hkc7yh89_.dbf';
-- Online the files in read-only tablespaces.
ALTER SESSION SET CONTAINER = PDB$SEED;
ALTER TABLESPACE "SYSTEM" ONLINE;
ALTER TABLESPACE "SYSAUX" ONLINE;
ALTER TABLESPACE "UNDOTBS1" ONLINE;
ALTER SESSION SET CONTAINER = CDB$ROOT;
-- Commands to add tempfiles to temporary tablespaces.
-- Online tempfiles have complete space information.
-- Other tempfiles may require adjustment.
ALTER TABLESPACE TEMP ADD TEMPFILE '/u01/oradata/CDB1_STBY/datafile/o1_mf_temp_hkc8ry4r_.tmp' REUSE;
ALTER SESSION SET CONTAINER = PDB$SEED;
ALTER TABLESPACE TEMP ADD TEMPFILE '/u01/oradata/CDB1_STBY/AADE6CBD2E162DF5E05365C7A8C024EB/datafile/o1_mf_temp_hkc8rzsm_.tmp' REUSE;
ALTER SESSION SET CONTAINER = PDB1;
ALTER TABLESPACE TEMP ADD TEMPFILE '/u01/oradata/CDB1_STBY/AADE880BD721351EE05365C7A8C0D10E/datafile/o1_mf_temp_%u_.tmp' REUSE;
ALTER SESSION SET CONTAINER = CDB$ROOT;
-- End of tempfile additions.
--
--
--
----------------------------------------------------------
-- The following script can be used on the standby database
-- to re-populate entries for a standby controlfile created
-- on the primary and copied to the standby site.
----------------------------------------------------------
ALTER DATABASE ADD STANDBY LOGFILE THREAD 1 '/u01/oradata/CDB1_STBY/onlinelog/o1_mf_10_hkc7zmnx_.log'
 SIZE 50M BLOCKSIZE 512 REUSE;
ALTER DATABASE ADD STANDBY LOGFILE THREAD 1 '/u01/oradata/CDB1_STBY/onlinelog/o1_mf_11_hkc7zn42_.log'
 SIZE 50M BLOCKSIZE 512 REUSE;
ALTER DATABASE ADD STANDBY LOGFILE THREAD 1 '/u01/oradata/CDB1_STBY/onlinelog/o1_mf_12_hkc7znl3_.log'
 SIZE 50M BLOCKSIZE 512 REUSE;
ALTER DATABASE ADD STANDBY LOGFILE THREAD 1 '/u01/oradata/CDB1_STBY/onlinelog/o1_mf_13_hkc7znyy_.log'
 SIZE 50M BLOCKSIZE 512 REUSE;
-- Registering these archivelog entries will help rebuild
-- information displayed by the V$ARCHIVED_LOG fixed view
```

##### [Recovering a Control File Using a Current Copy](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/admin/managing-control-files.html#GUID-D6662264-5149-4394-BE10-28C3047A8343)

###### [Recovering from Control File Corruption Using a Control File Copy](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/admin/managing-control-files.html#GUID-EF0BDE73-74D7-48E7-89E1-9CA09000C58E)

```
% cp /u03/oracle/prod/control03.ctl  /u02/oracle/prod/control02.ctl
```

###### [Recovering from Permanent Media Failure Using a Control File Copy](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/admin/managing-control-files.html#GUID-1D5E1025-2FD5-4A72-B250-1F99CE36AAA8)

```
% cp /u01/oracle/prod/control01.ctl  /u04/oracle/prod/control03.ctl
CONTROL_FILES = (/u01/oracle/prod/control01.ctl,
                 /u02/oracle/prod/control02.ctl, 
                 /u04/oracle/prod/control03.ctl)
```

##### [Dropping Control Files](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/admin/managing-control-files.html#GUID-AB003834-2392-4B99-ADBD-497636A2E096)

You can drop control files, but the database should have **at least two control files** at all times.

Note:

This operation does not physically delete the unwanted control file from the disk. Use operating system commands to delete the unnecessary file after you have dropped the control file from the database.

##### [Control Files Data Dictionary Views](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/admin/managing-control-files.html#GUID-B0AB9343-301E-45C8-AACC-5BC9C85CB2CD)

```
SELECT name FROM v$controlfile;
SELECT value FROM v$parameter WHERE name = 'control_files';
SELECT rpad(substr(name,1,50),51,' ') "control file name" FROM gv$controlfile;

SELECT
    status,
    name,
    is_recovery_dest_file,
    block_size,
    file_size_blks,
    con_id
FROM
    v$controlfile;
SELECT
    controlfile_type,
    controlfile_created,
    controlfile_sequence#,
    controlfile_change#,
    controlfile_time
FROM
    v$database;
SELECT
    type,
    record_size,
    records_total,
    records_used,
    first_index,
    last_index,
    last_recid,
    con_id
FROM
    v$controlfile_record_section;
```

#### [Managing Archived Redo Log Files](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/admin/managing-archived-redo-log-files.html#GUID-5EE4AC49-E1B2-41A2-BEE7-AA951EAAB2F3)

##### [What Is the Archived Redo Log?](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/admin/managing-archived-redo-log-files.html#GUID-9BD00F2E-DC98-4871-8D26-FDB40623909C)

You can use archived redo log files to:

- Recover a database
- Update a standby database
- Get information about the history of a database using the LogMiner utility

##### [Choosing Between NOARCHIVELOG and ARCHIVELOG Mode](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/admin/managing-archived-redo-log-files.html#GUID-2FF3967A-44E6-4EA1-8759-5DB2D67CBDE1)

###### [Running a Database in NOARCHIVELOG Mode](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/admin/managing-archived-redo-log-files.html#GUID-21A9A3AC-1D90-4848-B3BB-3A9E797547F8)

###### [Running a Database in ARCHIVELOG Mode](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/admin/managing-archived-redo-log-files.html#GUID-36F3335E-A28B-47BA-82C2-E17B4C8A453A)

The archiving of filled groups has these advantages:

- A database backup, together with online and archived redo log files, guarantees that you can recover all committed transactions in the event of an operating system or disk failure.
- If you keep archived logs available, you can use a backup taken while the database is open and in normal system use.
- You can keep a standby database current with its original database by continuously applying the original archived redo log files to the standby.

##### [Controlling Archiving](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/admin/managing-archived-redo-log-files.html#GUID-BE84B19D-7BE2-40D5-B962-5EF54E53095C)

###### [Setting the Initial Database Archiving Mode](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/admin/managing-archived-redo-log-files.html#GUID-0FC1DF01-4AB0-4888-B61F-19D234DAB6CB)

###### [Changing the Database Archiving Mode](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/admin/managing-archived-redo-log-files.html#GUID-C12EA833-4717-430A-8919-5AEA747087B9)

**Back up the database before and after.**

Enable archivelog mode

```
SHUTDOWN IMMEDIATE;
STARTUP MOUNT;
ALTER DATABASE ARCHIVELOG;
ALTER DATABASE OPEN;
```

###### [Performing Manual Archiving](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/admin/managing-archived-redo-log-files.html#GUID-6796C2F0-C35B-42E0-85C2-C19A94855E96)

```
SHUTDOWN IMMEDIATE;
STARTUP MOUNT;
ALTER DATABASE ARCHIVELOG MANUAL;
ALTER DATABASE OPEN;
ALTER SYSTEM ARCHIVE LOG ALL;
```

###### [Adjusting the Number of Archiver Processes](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/admin/managing-archived-redo-log-files.html#GUID-8E0F3F8E-0727-46F4-8E8E-FFEC2EE0D375)

```
ALTER SYSTEM SET LOG_ARCHIVE_MAX_PROCESSES=6;
```

### [Part III Schema Objects](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/admin/schema-objects.html#GUID-2DA8C61C-58B0-4892-8E5D-E7A9120BC120)

#### [Managing Tables](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/admin/managing-tables.html#GUID-707B02F5-E589-4C20-8E2E-5ED4F7888702)

##### [Altering Tables](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/admin/managing-tables.html#GUID-D4AE1CF2-08F7-4AB2-9317-0DE20AC70D44)

###### [Adding Table Columns](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/admin/managing-tables.html#GUID-3BBC0224-E218-422F-803A-B2FE56906E44)

```
ALTER TABLE admin_emp ADD (bonus NUMBER (7,2));
```

If you specify the `DEFAULT` clause for a nullable column for some table types, then the default value is stored as metadata, but the column itself is not populated with data.

```
ALTER TABLE employee ADD empoyee_status VARCHAR2(20) DEFAULT ‘Working’ NOT NULL;
```

#### [Managing Indexes](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/admin/managing-indexes.html#GUID-E4149397-FF37-4367-A12F-675433715904)

##### [Guidelines for Managing Indexes](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/admin/managing-indexes.html#GUID-1C31FFD6-B826-4F13-9452-7C3B8B28F677)

###### [Understand When to Use Unusable or Invisible Indexes](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/admin/managing-indexes.html#GUID-3A66938F-73C6-4173-844E-3938A0DBBB54)

##### [Creating Indexes](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/admin/managing-indexes.html#GUID-BF813E96-C4BD-433C-B26A-70289D938D02)

###### [Creating an Invisible Index](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/admin/managing-indexes.html#GUID-1FEFC754-C26F-4EC7-A1B3-318850A089AA)

```
CREATE INDEX emp_ename ON emp(ename)
      TABLESPACE users
      STORAGE (INITIAL 20K
      NEXT 20k)
      INVISIBLE;
ALTER SESSION SET OPTIMIZER_USE_INVISIBLE_INDEXES=TRUE;
```

##### [Altering Indexes](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/admin/managing-indexes.html#GUID-E637BC13-A2CA-454D-B680-07B95F7C4CE4)

###### [Making an Index Invisible or Visible](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/admin/managing-indexes.html#GUID-FD6F0D3D-022E-433D-9E11-B3A5D65A84C2)

```
ALTER INDEX index INVISIBLE;
ALTER INDEX index VISIBLE;
SELECT INDEX_NAME, VISIBILITY FROM USER_INDEXES
   WHERE INDEX_NAME = 'IND1';
```

## [Database Concepts](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/cncpt/index.html)

### [Part III Oracle Transaction Management](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/cncpt/oracle-transaction-management.html#GUID-3144CE4E-8120-49D9-9BDF-BE9C011E5662)

#### [Data Concurrency and Consistency](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/cncpt/data-concurrency-and-consistency.html#GUID-E8CBA9C5-58E3-460F-A82A-850E0152E95C)

##### [Introduction to Data Concurrency and Consistency](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/cncpt/data-concurrency-and-consistency.html#GUID-7AD41DFA-04E5-4738-B744-C4407170411C)

###### [Multiversion Read Consistency](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/cncpt/data-concurrency-and-consistency.html#GUID-4BD4DFD6-DAEA-41B2-BB56-7135568F0548)

[Read Consistency and Undo Segments](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/cncpt/data-concurrency-and-consistency.html#GUID-8DC0D1D1-C2B1-4237-9B77-27889B6467C1)

### [Part IV Oracle Database Storage Structures](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/cncpt/oracle-database-storage-structures.html#GUID-B679FE3E-8FC1-404C-A368-5A4AC0553664)

#### [Logical Storage Structures](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/cncpt/logical-storage-structures.html#GUID-13CE5EDA-8C66-4CA0-87B5-4069215A368D)

##### [Overview of Segments](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/cncpt/logical-storage-structures.html#GUID-7DA83E64-9FF1-45A7-A9AC-D4997DDE0866)

###### [Undo Segments](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/cncpt/logical-storage-structures.html#GUID-6E206D3A-E0E7-4B23-9C41-516FB35BC3FE)

### [Part V Oracle Instance Architecture](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/cncpt/oracle-instance-architecture.html#GUID-23B1D0B9-F8FC-42EB-AE48-6D00558DB675)

#### [Memory Architecture](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/cncpt/memory-architecture.html#GUID-913335DF-050A-479A-A653-68A064DCCA41)

##### [Overview of the Program Global Area (PGA)](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/cncpt/memory-architecture.html#GUID-859795E2-87CD-442B-B36F-584A77755F59)

##### [Overview of the System Global Area (SGA)](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/cncpt/memory-architecture.html#GUID-24EDB8CD-8279-4CED-82AF-642FC01A4A73)

###### [Database Buffer Cache](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/cncpt/memory-architecture.html#GUID-4FF66585-E469-4631-9225-29D75594CD14)

###### [Redo Log Buffer](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/cncpt/memory-architecture.html#GUID-C2AD1BF6-A5AE-42E9-9677-0AA08126864B)

###### [Shared Pool](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/cncpt/memory-architecture.html#GUID-1CB2BA23-4386-46DA-9146-5FE0E4599AC6)

###### [Large Pool](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/cncpt/memory-architecture.html#GUID-1ECB5213-AC4E-4BB4-9113-91C761676B34)

###### [Java Pool](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/cncpt/memory-architecture.html#GUID-51234BB8-1976-4670-8BC5-BB0E3D3BA12D)

###### [Fixed SGA](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/cncpt/memory-architecture.html#GUID-F18E4E7F-2ED9-4734-A6E4-4E77D0561C19)

#### [Process Architecture](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/cncpt/process-architecture.html#GUID-85D9852E-5BF1-4AC0-9E5A-49F0570DBD7A)

##### [Introduction to Processes](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/cncpt/process-architecture.html#GUID-FB843ADE-8DDD-4F83-8EB9-D4B5E4B6B022)

###### [Types of Processes](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/cncpt/process-architecture.html#GUID-B9B8BB8D-FB3D-46BC-AFBD-346A69BAB3EC)

###### [Multiprocess and Multithreaded Oracle Database Systems](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/cncpt/process-architecture.html#GUID-4B460E97-18A0-4F5A-A62F-9608FFD43664)

```
COL SPID FORMAT a8
COL STID FORMAT a8
SELECT SPID, STID, PROGRAM FROM V$PROCESS ORDER BY SPID;
```

##### [Overview of Background Processes](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/cncpt/process-architecture.html#GUID-D8AE1B78-69D5-4F0F-8BE3-C91AA2514F2D)

###### [Mandatory Background Processes](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/cncpt/process-architecture.html#GUID-2E691FEA-9027-47E4-A3D0-1B235BBA295A)

[Process Monitor Process (PMON) Group](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/cncpt/process-architecture.html#GUID-B5CA9579-53DB-442C-A85F-F21FD334833A)

[System Monitor Process (SMON)](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/cncpt/process-architecture.html#GUID-21393D94-CA2D-4551-BD20-28BEFDC98631)

[Database Writer Process (DBW)](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/cncpt/process-architecture.html#GUID-DC9CBDED-3978-450A-9D7A-0A94CE8FF233)

[Log Writer Process (LGWR)](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/cncpt/process-architecture.html#GUID-B6BE2C31-1543-4504-9763-6FFBBF99DC85)

[Checkpoint Process (CKPT)](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/cncpt/process-architecture.html#GUID-D3174B3E-BCCA-473F-961E-84A36FD5C372)

[Recoverer Process (RECO)](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/cncpt/process-architecture.html#GUID-9FF900D1-7DB8-4D41-8D34-8E99AF650CEC)

[Figure 15-4](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/cncpt/process-architecture.html#GUID-D3174B3E-BCCA-473F-961E-84A36FD5C372__BABEACIA)

## [Database Reference](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/refrn/index.html)

### [Part I Initialization Parameters](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/refrn/initialization-parameters.html#GUID-6F1C3203-0AA0-4AF1-921C-A027DD7CB6A9)

#### [Initialization Parameters](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/refrn/initialization-parameters-2.html#GUID-FD266F6F-D047-4EBB-8D96-B51B1DCA2D61)

##### [LOG_ARCHIVE_CONFIG](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/refrn/LOG_ARCHIVE_CONFIG.html#GUID-4DABDBE9-04B6-44D2-B93D-DAB15EA71427)

##### [LOG_ARCHIVE_DEST](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/refrn/LOG_ARCHIVE_DEST.html#GUID-AACE967D-EF85-43F4-B895-5E510ABADCC3)

##### [LOG_ARCHIVE_DEST_n](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/refrn/LOG_ARCHIVE_DEST_n.html#GUID-10BD97BF-6295-4E85-A1A3-854E15E05A44)

##### [LOG_ARCHIVE_DEST_STATE_n](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/refrn/LOG_ARCHIVE_DEST_STATE_n.html#GUID-983A9C52-3046-4286-AEA7-800741EE0561)

### [Part II Static Data Dictionary Views](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/refrn/static-data-dictionary-views.html#GUID-8865F65B-EF6D-44A5-B0A1-3179EFF0C36A)

#### [Static Data Dictionary Views: DBA_2PC_NEIGHBORS to DBA_HIST_JAVA_POOL_ADVICE](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/refrn/static-data-dictionary-views-3.html#GUID-085A6CC5-3EF3-40BF-89D4-9C49B0097B2D)

##### [DBA_DATA_FILES](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/refrn/DBA_DATA_FILES.html#GUID-0FA17297-73ED-4B5D-B511-103993C003D3)

```
COL tablespace_name FOR a30;
COL tablespace_size FOR a10;
SET pagesize 1000
SET linesize 1000
SELECT tablespace_name,round(sum(bytes)/1024/1024/1024,1) AS tablespace_size_GB FROM dba_data_files GROUP BY tablespace_name ORDER BY 2 DESC;
SELECT file_name, file_id, tablespace_name,round(bytes/1024/1024/1024,1) AS file_size_GB, status FROM dba_data_files ORDER BY file_id;
```

### [Part III  Dynamic Performance Views](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/refrn/dynamic-performance-views.html#GUID-8C5690B0-DE10-4460-86DF-80111869CF4C)

#### [Dynamic Performance (V$) Views: V$ACCESS to V$HVMASTER_INFO](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/refrn/dynamic-performance-v-views-1.html#GUID-A634ED26-2334-40F5-A016-22973F54BEDA)

##### [About Dynamic Performance Views](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/refrn/about-dynamic-performance-views.html#GUID-F66BEE0B-8091-48A3-975B-376D23B8B4E8)

###### [V$ Views](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/refrn/about-dynamic-performance-views.html#GUID-2B9DD73A-4C3A-467A-A934-01B705AB77A8)

###### [GV$ Views](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/refrn/about-dynamic-performance-views.html#GUID-884B21B1-7C87-41E1-8F97-C4668704AF30)

In Oracle Real Application Clusters, querying a `GV$` view retrieves the `V$` view information from all qualified instances. In addition to the `V$` information, each `GV$` view contains an extra column named `INST_ID` of data type `NUMBER`.

```
SELECT * FROM GV$LOCK WHERE INST_ID = 2 OR INST_ID = 5;
```

##### [V$ACTIVE_INSTANCES](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/refrn/V-ACTIVE_INSTANCES.html#GUID-3F06BAD1-C0F2-4FA7-9B5D-61C318F878E6)

```
SELECT * FROM v$active_instances;
SELECT decode(count(*), 0, 'No', 'Yes') RAC FROM ( SELECT 1 FROM v$active_instances WHERE rownum = 1 );
```

##### [V$CONTROLFILE](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/refrn/V-CONTROLFILE.html#GUID-C285E8C5-6A2D-44B1-BDF8-F880B5F088C4)

`INVALID` if the name cannot be determined (which should not occur); **NULL** if the name can be determined

```
SET pagesize 1000
SET linesize 1000
COL name FOR a50;
COL is_recovery_dest_file FOR a30;

SELECT name FROM v$controlfile;
SELECT name,status FROM v$controlfile;
SELECT rpad(substr(name,1,50),51,' ') "control file name" FROM gv$controlfile;
SELECT
    status,
    name,
    is_recovery_dest_file,
    block_size,
    file_size_blks,
    con_id
FROM
    v$controlfile;
```

##### [V$DATABASE](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/refrn/V-DATABASE.html#GUID-C62A7B96-2DD4-4E70-A0D9-26EE4BFBE256)

```
SET pagesize 300
SET linesize 300
COL name FOR a20;
COL db_unique_name FOR a30;
COL log_mode FOR a15;
COL protection_mode FOR a20;
COL dataguard_broker FOR a15;
COL flashback_on FOR a15;
COL fs_failover_status FOR a25;
COL database_role FOR a20;
COL open_mode FOR a30;
COL switchover_status FOR a30;

SELECT name, created,log_mode,protection_mode,dataguard_broker,flashback_on,db_unique_name,fs_failover_status,database_role,open_mode,switchover_status FROM v$database;
SELECT database_role,open_mode FROM v$database;

SET pagesize 300
SET linesize 300
COL database_role FOR a20;
COL open_mode FOR a30;
COL switchover_status FOR a30;
SELECT database_role,open_mode,switchover_status FROM v$database;
SELECT name,db_unique_name,created FROM v$database;
SELECT name, created,log_mode,dataguard_broker,flashback_on,db_unique_name FROM v$database;
SELECT
    controlfile_type,
    controlfile_created,
    controlfile_sequence#,
    controlfile_change#,
    controlfile_time
FROM
    v$database;
```

#### [Dynamic Performance (V$) Views: V$IM_COLUMN_LEVEL to V$RULE_SET_AGGREGATE_STATS](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/refrn/dynamic-performance-v-views-2.html#GUID-B200B2D6-08D4-49B0-9FD9-8AF6AED37202)

##### [V$INSTANCE](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/refrn/V-INSTANCE.html#GUID-6A0C9B51-1714-4223-B166-9D54C4E65D67)

```
SELECT * FROM v$instance;
SELECT count(*) FROM gv$instance;
```

##### [V$PARAMETER](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/refrn/V-PARAMETER.html#GUID-C86F3AB0-1191-447F-8EDF-4727D8693754)

```
COL name FOR a30;
COL value FOR a30;
SELECT name, value FROM v$parameter WHERE name='cluster_database';
```

## [Database Backup and Recovery User's Guide](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/bradv/index.html)

## [SQL Language Reference](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/sqlrf/index.html)

### [Expressions](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/sqlrf/Expressions.html#GUID-E7A5363C-AEE9-4809-99C1-1A9C6E3AE017)

#### [Column Expressions](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/sqlrf/Column-Expressions.html#GUID-B16B2D82-5D4B-485B-AE20-160EC0C7137A)

A column expression can be a simple expression, compound expression, function expression, or expression list, but it can contain only the following forms of expression:

- Columns of the subject table — the table being created, altered, or indexed

- Constants (strings or numbers)

- Deterministic functions — either SQL built-in functions or user-defined functions

  See Also:

  [Simple Expressions](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/sqlrf/Simple-Expressions.html#GUID-0E033897-60FB-40D7-A5F3-498B0FCC31B0), [Compound Expressions](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/sqlrf/Compound-Expressions.html#GUID-533C7BA0-C8B4-4323-81EA-1379657AF64A), [Function Expressions](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/sqlrf/Function-Expressions.html#GUID-C47F0B7D-9058-481F-815E-A31FB21F3BD5), and [Expression Lists](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/sqlrf/Expression-Lists.html#GUID-5CC8FC75-813B-44AA-8737-D940FA887D1E) for information on these forms of *`expr`*

### [SQL Statements: ALTER SYNONYM to COMMENT](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/sqlrf/SQL-Statements-ALTER-SYNONYM-to-COMMENT.html#GUID-7B9A6386-C065-4D0D-957E-9859DD917A6C)

**alter_interval_partitioning**

```
CREATE TABLE pos_data_range (
   start_date        DATE,
   store_id          NUMBER,
   inventory_id      NUMBER(6),
   qty_sold          NUMBER(3)
)
   PARTITION BY RANGE (start_date)
( 
   PARTITION pos_data_p0 VALUES LESS THAN (TO_DATE('1-7-2007', 'DD-MM-YYYY')),
   PARTITION pos_data_p1 VALUES LESS THAN (TO_DATE('1-8-2007', 'DD-MM-YYYY'))
); 
ALTER TABLE pos_data_range SET INTERVAL(NUMTOYMINTERVAL(1, 'MONTH'));
ALTER TABLE pos_data_range SET INTERVAL();
ALTER TABLE pos_data SET INTERVAL(NUMTOYMINTERVAL(3, 'MONTH'));
```

### [SQL Statements: COMMIT to CREATE JAVA](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/sqlrf/SQL-Statements-COMMIT-to-CREATE-JAVA.html#GUID-A087EE75-DE65-4AA6-A479-280413DB74C8)

#### [CREATE DATABASE](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/sqlrf/CREATE-DATABASE.html#GUID-ECE717DF-F116-4151-927C-2E51BB9DD39C)

**Creating a Database: Example**

```
CREATE DATABASE sample
   CONTROLFILE REUSE 
   LOGFILE
      GROUP 1 ('diskx:log1.log', 'disky:log1.log') SIZE 50K, 
      GROUP 2 ('diskx:log2.log', 'disky:log2.log') SIZE 50K 
   MAXLOGFILES 5 
   MAXLOGHISTORY 100 
   MAXDATAFILES 10 
   MAXINSTANCES 2 
   ARCHIVELOG 
   CHARACTER SET AL32UTF8
   NATIONAL CHARACTER SET AL16UTF16
   DATAFILE  
      'disk1:df1.dbf' AUTOEXTEND ON,
      'disk2:df2.dbf' AUTOEXTEND ON NEXT 10M MAXSIZE UNLIMITED
   DEFAULT TEMPORARY TABLESPACE temp_ts
   UNDO TABLESPACE undo_ts 
   SET TIME_ZONE = '+02:00';
```

### [SQL Statements: CREATE SEQUENCE to DROP CLUSTER](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/sqlrf/SQL-Statements-CREATE-SEQUENCE-to-DROP-CLUSTER.html#GUID-01CD18EA-DF10-4B99-B64A-69BB959EEE59)

#### [CREATE TABLE](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/sqlrf/CREATE-TABLE.html#GUID-F9CE0CC3-13AE-4744-A43C-EAC7A71AAAB6)

**Interval Partitioning Example**

```
CREATE TABLE customers_demo (
  customer_id number(6),
  cust_first_name varchar2(20),
  cust_last_name varchar2(20),
  credit_limit number(9,2))
PARTITION BY RANGE (credit_limit)
INTERVAL (1000)
(PARTITION p1 VALUES LESS THAN (5001));
SELECT partition_name, high_value FROM user_tab_partitions WHERE table_name = 'CUSTOMERS_DEMO';
CREATE TABLE pos_data (
   start_date        DATE,
   store_id          NUMBER,
   inventory_id      NUMBER(6),
   qty_sold          NUMBER(3)
)
PARTITION BY RANGE (start_date)
INTERVAL(NUMTOYMINTERVAL(1, 'MONTH'))
(
   PARTITION pos_data_p2 VALUES LESS THAN (TO_DATE('1-7-2007', 'DD-MM-YYYY')),
   PARTITION pos_data_p3 VALUES LESS THAN (TO_DATE('1-8-2007', 'DD-MM-YYYY'))
);
```

### [SQL Statements: MERGE to UPDATE](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/sqlrf/SQL-Statements-MERGE-to-UPDATE.html#GUID-07BBB875-6272-441A-893F-35E2F9CA58ED)

#### [MERGE](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/sqlrf/MERGE.html#GUID-5692CCB7-24D9-4C0E-81A7-A22436DC968F)

```
MERGE INTO bonuses D
   USING (SELECT employee_id, salary, department_id FROM employees
   WHERE department_id = 80) S
   ON (D.employee_id = S.employee_id)
   WHEN MATCHED THEN UPDATE SET D.bonus = D.bonus + S.salary*.01
     DELETE WHERE (S.salary > 8000)
   WHEN NOT MATCHED THEN INSERT (D.employee_id, D.bonus)
     VALUES (S.employee_id, S.salary*.01)
     WHERE (S.salary <= 8000);
```

## [SQL*Plus User's Guide and Reference](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/sqpug/index.html)

### [Part I SQL*Plus Getting Started](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/sqpug/getting-started.html#GUID-0A5854C2-ECDD-4068-9A9F-4BDE8AABEB51)

#### [Starting SQL*Plus](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/sqpug/starting-SQL-Plus.html#GUID-9FEB89E9-6392-4C43-95D3-51B72C9EB982)

##### [SQL*Plus Program Syntax](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/sqpug/starting-SQL-Plus.html#GUID-41344314-43A7-4391-AABF-6A98EA98BEDF)

###### [Options](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/sqpug/starting-SQL-Plus.html#GUID-073C1D33-E424-4791-8C79-8FA7B3CDEC43)

[SILENT Option](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/sqpug/starting-SQL-Plus.html#GUID-D4929F5A-29F5-41FB-AF88-AC52ED7C75D9)

```
sqlplus -silent
sqlplus -silent /nolog
```

###### [Logon](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/sqpug/starting-SQL-Plus.html#GUID-0B78B28B-A989-4A75-BBD9-FA688C990DB1)

```
sqlplus /nolog
sqlplus -silent /nolog
```

### [Part III SQL*Plus Reference](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/sqpug/SQL-Plus-reference.html#GUID-C3D4A718-56AD-4872-ADFF-A216FF70EDF2)

#### [SQL*Plus Command Reference](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/sqpug/SQL-Plus-command-reference.html#GUID-177F24B7-D154-4F8B-A05B-7568079800C6)

##### [STARTUP](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/sqpug/STARTUP.html#GUID-275013B7-CAE2-4619-9A0F-40DB71B61FE8)

**Syntax**

```
STARTUP db_options  | cdb_options | upgrade_options
```

where *db options* has the following syntax:

```
[FORCE] [RESTRICT] [PFILE=filename] [QUIET]  [ MOUNT [dbname] |  [ OPEN [open_db_options] [dbname] ] | NOMOUNT ]
```

where *open_db_options* has the following syntax:

```
READ {ONLY | WRITE [RECOVER]} | RECOVER
```

where *cdb_options* has the following syntax:

```
root_connection_options | pdb_connection_options
```

# [Database Utilities](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/sutil/)

## [Part I Oracle Data Pump](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/sutil/oracle-data-pump.html#GUID-501A9908-BCC5-434C-8853-9A6096766B5A)

### [Data Pump Export](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/sutil/oracle-data-pump-export-utility.html#GUID-5F7380CE-A619-4042-8D13-1F7DDE429991)

#### [Parameters Available in Export's Command-Line Mode](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/sutil/oracle-data-pump-export-utility.html#GUID-33880357-06B1-4CA2-8665-9D41347C6705)

##### [CONTENT](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/sutil/oracle-data-pump-export-utility.html#GUID-F7994C75-CC86-4A5D-AA9A-361A94FD9C03)

```
expdp hr DIRECTORY=dpump_dir1 DUMPFILE=hr.dmp CONTENT=METADATA_ONLY
expdp username/password DIRECTORY=directory_object_name \
                        DUMPFILE=dumpfile_name \
                        TABLES=table_names|TABLESPACES=tablespace_names|FULL=y \
                        CONTENT=metadata_only
```

##### [DIRECTORY](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/sutil/oracle-data-pump-export-utility.html#GUID-D7F1C0E8-E3CF-495E-9596-E08AEE36BB6B)

```
DUMPDIR_NAME=xxx
DUMPDIR=xxx
mkdir -p $DUMPDIR
create or replace directory ${DUMPDIR_NAME} as '$DUMPDIR';
grant read, write on directory ${DUMPDIR_NAME} to scott;
expdp scott/xxx DUMPFILE=x%U.dmp LOGFILE=x.log DIRECTORY=${DUMPDIR_NAME} SCHEMAS=x PARALLEL=4 exclude=STATISTICS
```

##### [DUMPFILE](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/sutil/oracle-data-pump-export-utility.html#GUID-A6300021-419F-4C1D-AFF1-38FE1123326B)

```
expdp scott/xxx DUMPFILE=x%U.dmp LOGFILE=x.log DIRECTORY=${DUMPDIR_NAME} SCHEMAS=x PARALLEL=4 EXCLUDE=STATISTICS
```

##### [EXCLUDE](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/sutil/oracle-data-pump-export-utility.html#GUID-64249296-2AFF-40EA-AA44-BC0A1B5A1E7C)

Enables you to filter the metadata that is exported by specifying objects and object types to be excluded from the export operation.

```
expdp scott/xxx DUMPFILE=x%U.dmp LOGFILE=x.log DIRECTORY=${DUMPDIR_NAME} SCHEMAS=x PARALLEL=4 exclude=STATISTICS
expdp hr DIRECTORY=dpump_dir1 DUMPFILE=hr_exclude.dmp EXCLUDE=VIEW,
PACKAGE, FUNCTION

```

**Excluding Constraints**

- `EXCLUDE=CONSTRAINT` excludes all constraints, except for any constraints needed for successful table creation and loading.
- `EXCLUDE=REF_CONSTRAINT` excludes referential integrity (foreign key) constraints.

**Excluding Grants and Users**

Specifying `EXCLUDE`=`GRANT` excludes object grants on all object types and system privilege grants.

Specifying `EXCLUDE`=`USER` excludes only the definitions of users, not the objects contained within users' schemas.

##### [PARALLEL](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/sutil/oracle-data-pump-export-utility.html#GUID-55E6AC71-5CDE-410E-AB02-798AEC54F411)

Specifies the maximum number of processes of active execution operating on behalf of the export job. This execution set consists of a combination of worker processes and parallel I/O server processes. 

```
expdp scott/xxx DUMPFILE=x%U.dmp LOGFILE=x.log DIRECTORY=${DUMPDIR_NAME} SCHEMAS=x PARALLEL=4 exclude=STATISTICS
```

##### [SCHEMAS](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/sutil/oracle-data-pump-export-utility.html#GUID-8B512637-E259-4F20-B7C9-DCD0BB501D09)

```
expdp scott/xxx DUMPFILE=x%U.dmp LOGFILE=x.log DIRECTORY=${DUMPDIR_NAME} SCHEMAS=x PARALLEL=4 exclude=STATISTICS
expdp hr DIRECTORY=dpump_dir1 DUMPFILE=expdat.dmp SCHEMAS=hr,sh,oe
```

##### [TABLES](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/sutil/oracle-data-pump-export-utility.html#GUID-9D052182-6BD8-4167-B528-2E352C9CDBDB)

Specifies that you want to perform a table-mode export.

```
expdp hr DIRECTORY=dpump_dir1 DUMPFILE=tables.dmp
TABLES=employees,jobs,departments
expdp hr DIRECTORY=dpump_dir1 DUMPFILE=tables_part.dmp
TABLES=sh.sales:sales_Q1_2012,sh.sales:sales_Q2_2012
```

### [Data Pump Import](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/sutil/datapump-import-utility.html#GUID-D11E340E-14C6-43B8-AB09-6335F0C1F71B)

#### [Parameters Available in Import's Command-Line Mode](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/sutil/datapump-import-utility.html#GUID-BA74D4F6-2840-4002-A673-0A7D9CBB3D78)

##### [CONTENT](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/sutil/datapump-import-utility.html#GUID-1609551D-212C-4DB1-B9D7-508FB75DD20C)

```
impdp hr DIRECTORY=dpump_dir1 DUMPFILE=expfull.dmp CONTENT=METADATA_ONLY
```

##### [DIRECTORY](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/sutil/datapump-import-utility.html#GUID-DA339AA4-C040-4D3B-A85F-DD3E470D452A)

```
impdp hr DIRECTORY=dpump_dir1 DUMPFILE=expfull.dmp 
LOGFILE=dpump_dir2:expfull.log
```

##### [SQLFILE](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/sutil/datapump-import-utility.html#GUID-8453D1F2-FDA9-4658-B42E-9D5B75AFEED9)

```
impdp hr DIRECTORY=dpump_dir1 DUMPFILE=expfull.dmp
SQLFILE=dpump_dir2:expfull.sql
```

A SQL file named `expfull.sql` is written to `dpump_dir2`.

```
SET linesize 200
SET pagesize 200
COL owner FOR a15;
COL directory_name FOR a30;
COL directory_path FOR a70;
SELECT * FROM dba_directories;
CREATE OR REPLACE DIRECTORY dir_test AS '/tmp/backup/';
GRANT READ, WRITE ON DIRECTORY dir_test TO user1;
GRANT DATAPUMP_EXP_FULL_DATABASE to user1;
GRANT DATAPUMP_IMP_FULL_DATABASE to user1;
ALTER USER user1 DEFAULT ROLE ALL;
expdp user1 DIRECTORY=dir_test DUMPFILE=test_schema.dmp FULL=y CONTENT=metadata_only
impdp user1 DIRECTORY=dir_test DUMPFILE=test_schema.dmp SQLFILE=dir_test:test_schema.sql
```

## [Part IV Other Utilities](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/sutil/other-oracle-utilities.html#GUID-FCEA49BD-D3AF-4337-88F1-3A23545F35A6)

### [Original Export](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/sutil/oracle-original-export-utility.html#GUID-901CBBE0-65FB-439E-942D-F2038C18BCD2)

#### [Export Parameters](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/sutil/oracle-original-export-utility.html#GUID-125385E7-A32B-4B52-B1E3-3E3878E0C7B3)

##### [BUFFER](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/sutil/oracle-original-export-utility.html#GUID-0ADF8770-F909-410D-910F-507A0A1F1D4A)

Specifies the size, in bytes, of the buffer used to fetch rows.

```
exp scott/xxx file=x.dmp log=x.log buffer=10240000 owner=x
```

##### [CONTENT](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/sutil/oracle-data-pump-export-utility.html#GUID-F7994C75-CC86-4A5D-AA9A-361A94FD9C03)

```
CONTENT=[ALL | DATA_ONLY | METADATA_ONLY]
```

- `ALL` unloads both data and metadata. This is the default.
- `DATA_ONLY` unloads only table row data; no database object definitions are unloaded.
- `METADATA_ONLY` unloads only database object definitions; no table row data is unloaded. Be aware that if you specify `CONTENT=METADATA_ONLY`, then when the dump file is subsequently imported, any index or table statistics imported from the dump file will be locked after the import.

```
expdp hr DIRECTORY=dpump_dir1 DUMPFILE=hr.dmp CONTENT=METADATA_ONLY
```

##### [DIRECT](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/sutil/oracle-original-export-utility.html#GUID-568F98CF-21C2-4E12-A27B-88E771E4988A)

Specifying `DIRECT=y` causes Export to extract data by reading the data directly, bypassing the SQL command-processing layer (evaluating buffer).

```
exp scott/xxx file=x.dmp log=x.log direct=y recordlength=65535 owner=x
```

##### [FILE](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/sutil/oracle-original-export-utility.html#GUID-0FACAACB-5B1D-4249-BE03-35EFD59FC5E1)

```
exp scott/xxx file=x.dmp log=x.log buffer=10240000 owner=x
exp scott FILE = dat1.dmp, dat2.dmp, dat3.dmp FILESIZE=2048
```

##### [FILESIZE](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/sutil/oracle-original-export-utility.html#GUID-D12380E1-F2BF-4471-9AEF-911BED8871F5)

```
exp scott FILE = dat1.dmp, dat2.dmp, dat3.dmp FILESIZE=2048
```

##### [LOG](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/sutil/oracle-original-export-utility.html#GUID-0FDE4A82-6EC5-4874-8CA1-A2153A5BDD28)

```
exp scott/xxx file=x.dmp log=x.log buffer=10240000 owner=x
```

##### [OWNER](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/sutil/oracle-original-export-utility.html#GUID-5820B9FE-BD28-49D6-AF9B-BBC0458B490D)

Indicates that the export is a user-mode export and lists the users whose objects will be exported. If the user initiating the export is the database administrator (DBA), then multiple users can be listed.

```
exp scott/xxx file=x.dmp log=x.log buffer=10240000 owner=x
```

##### [RECORDLENGTH](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/sutil/oracle-original-export-utility.html#GUID-CC0271E1-20B2-445C-98E9-6088BEA5D761)

```
exp scott/xxx file=x.dmp log=x.log direct=y recordlength=65535 owner=x
```

[ROWS](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/sutil/oracle-original-export-utility.html#GUID-6DA6357B-B674-440B-AE5F-7E07643B590A)

```
exp scott/xxx GRANTS=y CONSTRAINTS=y ROWS=n
```

# [Development](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/development.html)

## [Database Development Guide](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/adfns/index.html)

### [Part II SQL for Application Developers](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/adfns/sql-for-application-developers.html#GUID-54D6B268-E1AC-4198-AAF7-5AA5595F17EE)

#### [Using Regular Expressions in Database Applications](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/adfns/regexp.html#GUID-1935FD80-A3CD-413F-BD2E-BBEFE64000B2)

```
SELECT REGEXP_COUNT('Albert Einstein', 'e', 7, 'c') FROM dual;
SELECT 'Rohit Shinde' Programmer,REGEXP_COUNT(Programmer, 's', 1, 'i') 'Expression_Output' FROM dual;
```

### [Part IV Advanced Topics for Application Developers](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/adfns/advanced-part.html#GUID-9E3D5BB0-9896-488A-8AAB-9F24C23B4938)

#### [Using Edition-Based Redefinition](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/adfns/editions.html#GUID-58DE05A0-5DEF-4791-8FA8-F04D11964906)

##### [Editions](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/adfns/editions.html#GUID-3C543B31-9BA6-421D-9791-D85866185052)

###### [Editioned and Noneditioned Objects](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/adfns/editions.html#GUID-F0D940E0-618D-4656-982E-1C5E49FCCD42)

**Noneditioned Objects That Can Depend on Editioned O**bjects

**Virtual column**

The expression can invoke PL/SQL functions.

```
column [ datatype ] [ GENERATED ALWAYS ] AS ( column_expression )
[ VIRTUAL ] [ evaluation_edition_clause ]
[ unusable_before_clause ] [ unusable_beginning_clause ]
[ inline_constraint ]...
```

```
CREATE TABLE sales
(
   sales_id      NUMBER,
   cust_id       NUMBER,
   sales_amt     NUMBER,
   sale_category VARCHAR2(6)
   GENERATED ALWAYS AS
   (
      CASE
         WHEN sales_amt <= 10000 THEN 'LOW'
         WHEN sales_amt > 10000 AND sales_amt <= 100000 THEN 'MEDIUM'
         WHEN sales_amt > 100000 AND sales_amt <= 1000000 THEN 'HIGH'
         ELSE 'ULTRA'
      END
    ) VIRTUAL
);
CREATE TABLE Employee(
Employee_num NUMBER,
Salary NUMBER,
Dearness_allowance NUMBER,
Total_salary NUMBER AS (Salary+Dearness_allowance)
);
```

## [Data Cartridge Developer's Guide](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/addci/index.html)

### [Building Domain Indexes](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/addci/building-domain-indexes.html#GUID-E370B5E4-BAC0-49C6-B17D-830B3A507FB4)

#### [Using System Partitioning](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/addci/building-domain-indexes.html#GUID-032AAB4D-3AEA-4CB3-92F4-C30A3AD59656)

##### [Implementing System Partitioning](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/addci/building-domain-indexes.html#GUID-DEB47AB5-FB01-4A7A-A93B-671D9EDE7D9C)

###### [Creating a System-Partitioned Table](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/addci/building-domain-indexes.html#GUID-2D94CE13-B343-450E-9678-704D35435FB0)

```
CREATE TABLE SystemPartitionedTable (c1 INTEGER, c2 INTEGER)
PARTITION BY SYSTEM
(
  PARTITION p1 TABLESPACE tbs_1,
  PARTITION p2 TABLESPACE tbs_2,
  PARTITION p3 TABLESPACE tbs_3,
  PARTITION p4 TABLESPACE tbs_4
);
CREATE TABLE sales3 
(
    sales_id   NUMBER,
    product_code NUMBER,
    state_code   NUMBER
)
PARTITION BY SYSTEM
(
   PARTITION p1 TABLESPACE users,
   PARTITION p2 TABLESPACE users
);
SELECT partition_name FROM user_segments WHERE segment_name = 'SALES3';
CREATE INDEX in_sales3_state ON sales3 (state_code) LOCAL;
SELECT partition_name
FROM user_segments
WHERE segment_name = 'IN_SALES3_STATE';
SELECT partitioning_type
FROM user_part_tables
WHERE table_name = 'SALES3';
SELECT partition_name, high_value
FROM user_tab_partitions
WHERE table_name = 'SALES3';
```

###### [Inserting Data into a System-Partitioned Table](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/addci/building-domain-indexes.html#GUID-5A178C16-6B3F-4DC0-8C4D-E2C22A0A5A34)

```
INSERT INTO SystemPartitionedTable PARTITION (p1) VALUES (4,5);
INSERT INTO sales3 PARTITION (p1) VALUES (1,101,1);
```

###### [Deleting and Updating Data in a System-Partitioned Table](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/addci/building-domain-indexes.html#GUID-479314EF-CC8B-4FB2-9DB5-168B9171D3D9)

While delete and update operations do not require the partition extended syntax, Oracle recommends that you use it if at all possible. 

```
DELETE sales3 WHERE state_code = 1;
DELETE sales3 PARTITION (p1) WHERE state_code = 1;
```

## [Database PL/SQL Language Reference](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/lnpls/index.html)

### [PL/SQL Static SQL](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/lnpls/static-sql.html#GUID-A2E4086F-94DC-4CC7-9E4B-30285BEC3313)

#### [Cursor Variables](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/lnpls/static-sql.html#GUID-4A6E054A-4002-418D-A1CA-DE849CD7E6D5)

##### [Creating Cursor Variables](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/lnpls/static-sql.html#GUID-470A7A99-888A-46C2-BDAF-D4710E650F27)

**Cursor Variable Declarations**

```
DECLARE
  TYPE empcurtyp IS REF CURSOR RETURN employees%ROWTYPE;  -- strong type
  TYPE genericcurtyp IS REF CURSOR;                       -- weak type

  cursor1  empcurtyp;       -- strong cursor variable
  cursor2  genericcurtyp;   -- weak cursor variable
  my_cursor SYS_REFCURSOR;  -- weak cursor variable

  TYPE deptcurtyp IS REF CURSOR RETURN departments%ROWTYPE;  -- strong type
  dept_cv deptcurtyp;  -- strong cursor variable
BEGIN
  NULL;
END;
/
```

**Cursor Variable with User-Defined Return Type**

```
DECLARE
  TYPE EmpRecTyp IS RECORD (
    employee_id NUMBER,
    last_name VARCHAR2(25),
    salary   NUMBER(8,2));

  TYPE EmpCurTyp IS REF CURSOR RETURN EmpRecTyp;
  emp_cv EmpCurTyp;
BEGIN
  NULL;
END;
/
```

##### [Variables in Cursor Variable Queries](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/lnpls/static-sql.html#GUID-E03A2A12-D298-4D1C-8CCE-3B5D17DDFC7C)

**Variable in Cursor Variable Query—No Result Set Change**

```
DECLARE
  sal           employees.salary%TYPE;
  sal_multiple  employees.salary%TYPE;
  factor        INTEGER := 2;
 
  cv SYS_REFCURSOR;
 
BEGIN
  OPEN cv FOR
    SELECT salary, salary*factor
    FROM employees
    WHERE job_id LIKE 'AD_%';   -- PL/SQL evaluates factor
 
  LOOP
    FETCH cv INTO sal, sal_multiple;
    EXIT WHEN cv%NOTFOUND;
    DBMS_OUTPUT.PUT_LINE('factor = ' || factor);
    DBMS_OUTPUT.PUT_LINE('sal          = ' || sal);
    DBMS_OUTPUT.PUT_LINE('sal_multiple = ' || sal_multiple);
    factor := factor + 1;  -- Does not affect sal_multiple
  END LOOP;
 
  CLOSE cv;
END;
/
```

**Variable in Cursor Variable Query—Result Set Change**

```
DECLARE
  sal           employees.salary%TYPE;
  sal_multiple  employees.salary%TYPE;
  factor        INTEGER := 2;
 
  cv SYS_REFCURSOR;
 
BEGIN
  DBMS_OUTPUT.PUT_LINE('factor = ' || factor);
 
  OPEN cv FOR
    SELECT salary, salary*factor
    FROM employees
    WHERE job_id LIKE 'AD_%';   -- PL/SQL evaluates factor
 
  LOOP
    FETCH cv INTO sal, sal_multiple;
    EXIT WHEN cv%NOTFOUND;
    DBMS_OUTPUT.PUT_LINE('sal          = ' || sal);
    DBMS_OUTPUT.PUT_LINE('sal_multiple = ' || sal_multiple);
  END LOOP;
 
  factor := factor + 1;
 
  DBMS_OUTPUT.PUT_LINE('factor = ' || factor);
 
  OPEN cv FOR
    SELECT salary, salary*factor
    FROM employees
    WHERE job_id LIKE 'AD_%';   -- PL/SQL evaluates factor
 
  LOOP
    FETCH cv INTO sal, sal_multiple;
    EXIT WHEN cv%NOTFOUND;
    DBMS_OUTPUT.PUT_LINE('sal          = ' || sal);
    DBMS_OUTPUT.PUT_LINE('sal_multiple = ' || sal_multiple);
  END LOOP;
 
  CLOSE cv;
END;
/
```

##### [Querying a Collection](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/lnpls/static-sql.html#GUID-65ADB424-2C2D-49ED-9E98-99A3A68BA248)

```
CREATE OR REPLACE PACKAGE pkg AUTHID DEFINER AS
  TYPE rec IS RECORD(f1 NUMBER, f2 VARCHAR2(30));
  TYPE mytab IS TABLE OF rec INDEX BY pls_integer;
END;

DECLARE
  v1 pkg.mytab;  -- collection of records
  v2 pkg.rec;
  c1 SYS_REFCURSOR;
BEGIN
  v1(1).f1 := 1;
  v1(1).f2 := 'one';
  OPEN c1 FOR SELECT * FROM TABLE(v1);
  FETCH c1 INTO v2;
  CLOSE c1;
  DBMS_OUTPUT.PUT_LINE('Values in record are ' || v2.f1 || ' and ' || v2.f2);
END;
/
```

##### [Cursor Variables as Subprogram Parameters](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/lnpls/static-sql.html#GUID-9713DFC2-3C2E-49B2-922F-02D43F9D0619)

**Procedure to Open Cursor Variable for One Query**

```
CREATE OR REPLACE PACKAGE emp_data AUTHID DEFINER AS
  TYPE empcurtyp IS REF CURSOR RETURN employees%ROWTYPE;
  PROCEDURE open_emp_cv (emp_cv IN OUT empcurtyp);
END emp_data;
/
CREATE OR REPLACE PACKAGE BODY emp_data AS
  PROCEDURE open_emp_cv (emp_cv IN OUT EmpCurTyp) IS
  BEGIN
    OPEN emp_cv FOR SELECT * FROM employees;
  END open_emp_cv;
END emp_data;
/
```

**Opening Cursor Variable for Chosen Query (Same Return Type)**

```
CREATE OR REPLACE PACKAGE emp_data AUTHID DEFINER AS
  TYPE empcurtyp IS REF CURSOR RETURN employees%ROWTYPE;
  PROCEDURE open_emp_cv (emp_cv IN OUT empcurtyp, choice INT);
END emp_data;
/
CREATE OR REPLACE PACKAGE BODY emp_data AS
  PROCEDURE open_emp_cv (emp_cv IN OUT empcurtyp, choice INT) IS
  BEGIN
    IF choice = 1 THEN
      OPEN emp_cv FOR SELECT *
      FROM employees
      WHERE commission_pct IS NOT NULL;
    ELSIF choice = 2 THEN
      OPEN emp_cv FOR SELECT *
      FROM employees
      WHERE salary > 2500;
    ELSIF choice = 3 THEN
      OPEN emp_cv FOR SELECT *
      FROM employees
      WHERE department_id = 100;
    END IF;
  END;
END emp_data;
/
```

**Opening Cursor Variable for Chosen Query (Different Return Types)**

```
CREATE OR REPLACE PACKAGE admin_data AUTHID DEFINER AS
  TYPE gencurtyp IS REF CURSOR;
  PROCEDURE open_cv (generic_cv IN OUT gencurtyp, choice INT);
END admin_data;
/
CREATE OR REPLACE PACKAGE BODY admin_data AS
  PROCEDURE open_cv (generic_cv IN OUT gencurtyp, choice INT) IS
  BEGIN
    IF choice = 1 THEN
      OPEN generic_cv FOR SELECT * FROM employees;
    ELSIF choice = 2 THEN
      OPEN generic_cv FOR SELECT * FROM departments;
    ELSIF choice = 3 THEN
      OPEN generic_cv FOR SELECT * FROM jobs;
    END IF;
  END;
END admin_data;
/
```

### [PL/SQL Error Handling](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/lnpls/plsql-error-handling.html#GUID-0502DC1A-F0A5-4180-A912-6A5CDC855F56)

#### [Retrieving Error Code and Error Message](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/lnpls/plsql-error-handling.html#GUID-7E0CDD98-D31C-4745-B819-B5C5E1DF90A8)

In an exception handler, for the exception being handled:

- You can retrieve the error code with the PL/SQL function `SQLCODE`, described in "[SQLCODE Function](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/lnpls/SQLCODE-function.html#GUID-1FFD7902-D22D-4505-815A-C97DDBEFB4B5)".

- You can retrieve the error message with either:

  - The PL/SQL function `SQLERRM`, described in "[SQLERRM Function](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/lnpls/SQLERRM-function.html#GUID-D4468C8F-62D9-42A5-AF72-C1098C866DC5)"

    This function returns a maximum of 512 bytes, which is the maximum length of an Oracle Database error message (including the error code, nested messages, and message inserts such as table and column names).

  - The package function `DBMS_UTILITY`.`FORMAT_ERROR_STACK`, described in [*Oracle Database PL/SQL Packages and Types Reference*](https://www.oracle.com/pls/topic/lookup?ctx=en/database/oracle/oracle-database/12.2/lnpls&id=ARPLS73242)

    This function returns the full error stack, up to 2000 bytes.

  Oracle recommends using `DBMS_UTILITY`.`FORMAT_ERROR_STACK`, except when using the `FORALL` statement with its `SAVE` `EXCEPTIONS` clause, as in [Example 12-13](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/lnpls/plsql-optimization-and-tuning.html#GUID-DAF46F06-EF3F-4B1A-A518-5238B80C69FA__BABGBABA).

A SQL statement cannot invoke `SQLCODE` or `SQLERRM`. To use their values in a SQL statement, assign them to local variables first, as in [Example 11-23](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/lnpls/plsql-error-handling.html#GUID-7E0CDD98-D31C-4745-B819-B5C5E1DF90A8__CJAJBAJG).

See Also:

- [*Oracle Database PL/SQL Packages and Types Reference*](https://www.oracle.com/pls/topic/lookup?ctx=en/database/oracle/oracle-database/12.2/lnpls&id=ARPLS73241) for information about the `DBMS_UTILITY`.`FORMAT_ERROR_BACKTRACE` function, which displays the call stack at the point where an exception was raised, even if the subprogram is called from an exception handler in an outer scope
- [*Oracle Database PL/SQL Packages and Types Reference*](https://www.oracle.com/pls/topic/lookup?ctx=en/database/oracle/oracle-database/12.2/lnpls&id=ARPLS74078) for information about the `UTL_CALL_STACK` package, whose subprograms provide information about currently executing subprograms, including subprogram names

```
DROP TABLE errors;
CREATE TABLE errors (
  code      NUMBER,
  message   VARCHAR2(64)
);

CREATE OR REPLACE PROCEDURE p AUTHID DEFINER AS
  name    EMPLOYEES.LAST_NAME%TYPE;
  v_code  NUMBER;
  v_errm  VARCHAR2(64);
BEGIN
  SELECT last_name INTO name
  FROM EMPLOYEES
  WHERE EMPLOYEE_ID = -1;
EXCEPTION
  WHEN OTHERS THEN
    v_code := SQLCODE;
    v_errm := SUBSTR(SQLERRM, 1, 64);
    DBMS_OUTPUT.PUT_LINE
      ('Error code ' || v_code || ': ' || v_errm);
 
    /* Invoke another procedure,
       declared with PRAGMA AUTONOMOUS_TRANSACTION,
       to insert information about errors. */
 
    INSERT INTO errors (code, message)
    VALUES (v_code, v_errm);

    RAISE;
END;
/
```

#### [Continuing Execution After Handling Exceptions](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/lnpls/plsql-error-handling.html#GUID-E63131E7-4AE6-4C47-8D21-5EC1F6D3AA68)

**Exception Handler Runs and Execution Ends**

```
DROP TABLE employees_temp;
CREATE TABLE employees_temp AS
  SELECT employee_id, salary, commission_pct
  FROM employees;
 
DECLARE
  sal_calc NUMBER(8,2);
BEGIN
  INSERT INTO employees_temp (employee_id, salary, commission_pct)
  VALUES (301, 2500, 0);
 
  SELECT (salary / commission_pct) INTO sal_calc
  FROM employees_temp
  WHERE employee_id = 301;
 
  INSERT INTO employees_temp VALUES (302, sal_calc/100, .1);
  DBMS_OUTPUT.PUT_LINE('Row inserted.');
EXCEPTION
  WHEN ZERO_DIVIDE THEN
    DBMS_OUTPUT.PUT_LINE('Division by zero.');
END;
/
```

Result:

```
Division by zero.
```

**Exception Handler Runs and Execution Continues**

```
DECLARE
  sal_calc NUMBER(8,2);
BEGIN
  INSERT INTO employees_temp (employee_id, salary, commission_pct)
  VALUES (301, 2500, 0);
 
  BEGIN
    SELECT (salary / commission_pct) INTO sal_calc
    FROM employees_temp
    WHERE employee_id = 301;
  EXCEPTION
    WHEN ZERO_DIVIDE THEN
      DBMS_OUTPUT.PUT_LINE('Substituting 2500 for undefined number.');
      sal_calc := 2500;
  END;
 
  INSERT INTO employees_temp VALUES (302, sal_calc/100, .1);
  DBMS_OUTPUT.PUT_LINE('Enclosing block: Row inserted.');
EXCEPTION
  WHEN ZERO_DIVIDE THEN
    DBMS_OUTPUT.PUT_LINE('Enclosing block: Division by zero.');
END;
/
```

Result:

```
Substituting 2500 for undefined number.
Enclosing block: Row inserted.
```

## [Database PL/SQL Packages and Types Reference](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/arpls/index.html)

# [Performance](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/performance.html)

## [SQL Tuning Guide](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/tgsql/index.html)

### [Part V Optimizer Statistics](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/tgsql/optimizer-statistics.html#GUID-0A2F3D52-A135-43E1-9CAB-55BFE068A297)

#### [Analyzing Statistics Using Optimizer Statistics Advisor](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/tgsql/optimizer-statistics-advisor.html#GUID-054F4B76-DD57-46EE-98EA-0FF04F49D1B3)

### [Part VII Monitoring and Tracing SQL](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/tgsql/monitoring-and-tracing-sql.html#GUID-CA494EFF-53D7-4345-9576-8FED65F35AAE)

#### [Performing Application Tracing](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/tgsql/performing-application-tracing.html#GUID-440D3AD4-B302-408E-8627-FE8032DD09F9)

##### [Overview of End-to-End Application Tracing](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/tgsql/performing-application-tracing.html#GUID-246A5A52-E666-4DBC-BDF6-98B83260A7AD)

###### [End-to-End Application Tracing in a Multitenant Environment](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/tgsql/performing-application-tracing.html#GUID-5A0DF363-2BF3-4AD7-A4BC-9CBF45855DE7)

- PDB administrators must view traces from a specific PDB.

  You can use SQL Trace to collect diagnostic data for the SQL statements executing in a PDB application. The trace data includes SQL tracing (event 10046) and optimizer tracing (event 10053). Using `V$` views, developers can access only SQL or optimizer trace records without accessing the entire trace file.

###### [Tools for End-to-End Application Tracing](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/tgsql/performing-application-tracing.html#GUID-31EF2BD5-28DB-488F-A855-8DA324F6970B)

[Overview of TKPROF](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/tgsql/performing-application-tracing.html#GUID-A1F41137-03E2-43AD-98E4-AD49760C4C35)

To format the contents of the trace file and place the output into a readable output file, run the TKPROF program.

TKPROF can also do the following:

- Create a SQL script that stores the statistics in the database
- Determine the execution plans of SQL statements

# [High Availability](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/high-availability.html)

## Backup and Recovery

### [Database Backup and Recovery Reference](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/rcmrf/index.html)

#### [RMAN Commands: RECOVER to VALIDATE](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/rcmrf/rman-commands-recover-to-validate.html#GUID-C3809416-7521-4C18-AA50-B2B52A56DCFF)

##### [RUN](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/rcmrf/RUN.html#GUID-88250EEF-DC49-42A9-822C-4011B1345C7B)

```
rman target / LOG=rman.log <<EOF

run {
...
}
EOF
```



```
RMAN> SHOW DEVICE TYPE;

RMAN configuration parameters for database with db_unique_name PROD1 are:
CONFIGURE DEVICE TYPE DISK PARALLELISM 1 BACKUP TYPE TO BACKUPSET; # default
CONFIGURE DEVICE TYPE SBT_TAPE PARALLELISM 1 BACKUP TYPE TO BACKUPSET; # default
RUN
{
  ALLOCATE CHANNEL c1 DEVICE TYPE DISK FORMAT "/disk2/%U";
  BACKUP DATABASE PLUS ARCHIVELOG;
}
RUN { EXECUTE SCRIPT backup_db; }
```

##### [SQL](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/rcmrf/SQL.html#GUID-D55D7184-60DA-4B11-B483-8F14726AFE43)

```
ALTER TABLESPACE users ADD DATAFILE '/disk1/oradata/users02.dbf' SIZE 1M AUTOEXTEND ON NEXT 10K MAXSIZE 2M;
```

##### [SQL (Quoted)](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/rcmrf/SQL-Quoted.html#GUID-D8D11F06-005D-40EE-B041-BC46C52E71AE)

This example backs up a tablespace and then archives all unarchived online redo logs.

```
BACKUP TABLESPACE users;
sql 'ALTER SYSTEM ARCHIVE LOG CURRENT';
```

```
sql 'ALTER TABLESPACE users ADD DATAFILE ''/disk1/oradata/users02.dbf'' 
  SIZE 100K AUTOEXTEND ON NEXT 10K MAXSIZE 100K';
```

#### [**B** Deprecated RMAN Syntax](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/rcmrf/deprecated-rman-syntax.html#GUID-E2B27FFB-FAF1-4622-94E5-E4D51D61E86B)

**Table B-1** ***Deprecated RMAN Syntax***

| Deprecated in Release | Deprecated Syntax                                            | Preferred Current Syntax                                     |
| :-------------------- | :----------------------------------------------------------- | :----------------------------------------------------------- |
| 12.1                  | `ALTER DATABASE`                                             | n/a                                                          |
| 11.2.0                | [CONFIGURE](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/rcmrf/CONFIGURE.html#GUID-B5094E73-C26C-4FED-AE39-8C2E9540050A) or [SET](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/rcmrf/SET.html#GUID-BC501B5C-4CD0-485D-AA18-27E2894024C3) `COMPRESSION ALGORITHM 'ZLIB'` | [CONFIGURE](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/rcmrf/CONFIGURE.html#GUID-B5094E73-C26C-4FED-AE39-8C2E9540050A) or [SET](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/rcmrf/SET.html#GUID-BC501B5C-4CD0-485D-AA18-27E2894024C3) `COMPRESSION ALGORITHM 'MEDIUM'` |
| 11.2.0                | [CONFIGURE](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/rcmrf/CONFIGURE.html#GUID-B5094E73-C26C-4FED-AE39-8C2E9540050A) or [SET](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/rcmrf/SET.html#GUID-BC501B5C-4CD0-485D-AA18-27E2894024C3) `COMPRESSION ALGORITHM 'BZIP2'` | [CONFIGURE](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/rcmrf/CONFIGURE.html#GUID-B5094E73-C26C-4FED-AE39-8C2E9540050A) or [SET](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/rcmrf/SET.html#GUID-BC501B5C-4CD0-485D-AA18-27E2894024C3) `COMPRESSION ALGORITHM 'BASIC'` |
| 11.2.0                | `V$FLASH_RECOVERY_AREA_USAGE`                                | `V$RECOVERY_AREA_USAGE`                                      |
| 11.1.0                | `CONVERT` `ON TARGET PLATFORM`                               | `CONVERT` `ON DESTINATION PLATFORM`                          |
| 11.1.0                | `UNTIL RESTORE POINT`                                        | `TO RESTORE POINT`                                           |
| 11.1.0                | `BACKUP` `... AS STANDBY`                                    | n/a                                                          |
| 11.1.0                | `... KEEP [LOGS | NOLOGS]`                                   | `... KEEP`                                                   |
| 11.1.0                | `BLOCKRECOVER`                                               | `RECOVER`                                                    |
| 10.0.1                | `BACKUP` `... INCREMENTAL LEVEL` `[2,3,4]`                   | Levels *other than* `0` and `1` are deprecated.              |
| 10.0.1                | `BACKUP` `... PARMS`                                         | `CONFIGURE`` CHANNEL ... PARMS`                              |
| 10.0.1                | `COPY`                                                       | `BACKUP` `AS COPY`                                           |
| 10.0.1                | `CREATE CATALOG` `TABLESPACE`                                | `CREATE CATALOG`                                             |
| 10.0.1                | `LIST` `... BY BACKUP [SUMMARY]`                             | n/a                                                          |
| 10.0.1                | `LIST` `... VERBOSE`                                         | n/a                                                          |
| 10.0.1                | `RESTORE`` ... PARMS`                                        | `CONFIGURE` `CHANNEL ... PARMS`                              |
| 10.0.1                | `SEND` `... PARMS`                                           | `CONFIGURE` `CHANNEL ... PARMS`                              |
| 9.2                   | `REPLICATE`                                                  | `RESTORE` `CONTROLFILE FROM ...`                             |
| 9.2                   | `SET` `AUTOLOCATE`                                           | Enabled by default                                           |
| 9.0.1                 | `ALLOCATE CHANNEL FOR DELETE`                                | n/a                                                          |
| 9.0.1                 | `ALLOCATE CHANNEL`` ... TYPE`                                | `CONFIGURE` `CHANNEL ... DEVICE TYPE`                        |
| 9.0.1                 | `ALLOCATE CHANNEL` `... KBYTES`                              | `CONFIGURE` `CHANNEL ... MAXPIECESIZE`                       |
| 9.0.1                 | `ALLOCATE CHANNEL` `... READRATE`                            | `CONFIGURE` `CHANNEL ... RATE`                               |
| 9.0.1                 | `... ARCHIVELOG ... LOGSEQ`                                  | `... ARCHIVELOG ... SEQUENCE`                                |
| 9.0.1                 | `BACKUP` `... SETSIZE`                                       | `BACKUP` `...` `MAXSETSIZE`                                  |
| 9.0.1                 | `CHANGE` `... CROSSCHECK`                                    | `CROSSCHECK`                                                 |
| 9.0.1                 | `CHANGE` `... DELETE`                                        | `DELETE`                                                     |
| 9.0.1                 | `REPORT` `... AT LOGSEQ`                                     | `REPORT ... AT SEQUENCE`                                     |
| 9.0.1                 | `SET` `AUXNAME`                                              | `CONFIGURE` `AUXNAME`                                        |
| 9.0.1                 | `SET` `DUPLEX`                                               | `SET` `BACKUP COPIES``CONFIGURE` `BACKUP COPIES`             |
| 9.0.1                 | `SET` `LIMIT CHANNEL ...`                                    | `ALLOCATE CHANNEL` `...``CONFIGURE` `CHANNEL ...`            |
| 9.0.1                 | `SET` `SNAPSHOT`                                             | `CONFIGURE` `SNAPSHOT`                                       |
| 9.0.1                 | `UNTIL LOGSEQ` (see *`untilClause`*)                         | `UNTIL SEQUENCE` (see *`untilClause`*)                       |
| 8.1.7                 | `CONFIGURE` `COMPATIBLE`                                     | n/a                                                          |
| 8.1.5                 | `ALLOCATE CHANNEL` `CLONE`                                   | `CONFIGURE` `AUXILIARY CHANNEL`                              |
| 8.1.5                 | `CHANGE` `... VALIDATE`                                      | `CROSSCHECK`                                                 |
| 8.1.5                 | `CLONE` (see `RMAN`)                                         | `AUXILIARY` (see `RMAN`)                                     |
| 8.1.5                 | `CONFIGURE` `CLONE`                                          | `CONFIGURE` `AUXILIARY`                                      |
| 8.1.5                 | `MSGLOG` (see `RMAN`)                                        | `LOG` (see `RMAN`)                                           |
| 8.1.5                 | `RCVCAT` (see `RMAN`)                                        | `CATALOG` (see `RMAN`)                                       |

### [Database Backup and Recovery User's Guide](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/bradv/index.html)

#### [Part I Overview of Backup and Recovery](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/bradv/part-overview-backup-recovery.html#GUID-CD5F857C-198E-4097-A5C8-F0D7E9C00D30)

##### [Getting Started with RMAN](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/bradv/getting-started-rman.html#GUID-871FF5B2-C82B-462E-8182-FA28CF7B3E3B)

###### [Starting RMAN and Connecting to a Database: Quick Start](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/bradv/getting-started-rman.html#GUID-3DAE7BA3-C367-4BFF-A5B2-28B3EC67BB2D)

```
rman
CONNECT TARGET "sys@CDB1 AS SYSDBA"
CONNECT TARGET /
rman TARGET / LOG /tmp/msglog.log APPEND
```

###### [Showing the Default RMAN Configuration](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/bradv/getting-started-rman.html#GUID-72A34428-3C57-4F3D-A5BA-334B16FA707E)

```
SHOW ALL;
```

###### [Backing Up a Database: Quick Start](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/bradv/getting-started-rman.html#GUID-096D8191-5DB3-4F49-83EF-14DC13DEA022)

```
BACKUP DATABASE;
BACKUP 
  FORMAT 'AL_%d/%t/%s/%p' 
  ARCHIVELOG LIKE '%arc_dest%';
BACKUP
  TAG 'weekly_full_db_bkup' 
  DATABASE MAXSETSIZE 10M;
BACKUP TAG &1 COPIES &2 DATABASE FORMAT '/disk2/db_%U';
BACKUP DATABASE PLUS ARCHIVELOG;

SHUTDOWN IMMEDIATE;
STARTUP FORCE DBA;
SHUTDOWN IMMEDIATE;
STARTUP MOUNT;
BACKUP DATABASE;
BACKUP AS COPY DATABASE;
ALTER DATABASE OPEN;

BACKUP INCREMENTAL LEVEL 0 DATABASE;
BACKUP INCREMENTAL LEVEL 1 CUMULATIVE DATABASE;
BACKUP INCREMENTAL LEVEL 1 DATABASE;

BACKUP 
  INCREMENTAL LEVEL 1
  FOR RECOVER OF COPY 
  WITH TAG 'incr_update'
  DATABASE;
BACKUP 
  INCREMENTAL LEVEL 1
  FOR RECOVER OF COPY
  DATAFILECOPY FORMAT
  '/disk2/df1.cpy'
  DATABASE;

RECOVER COPY OF DATABASE 
  WITH TAG 'incr_update';

BACKUP VALIDATE CHECK LOGICAL
  DATABASE ARCHIVELOG ALL;

VALIDATE DATAFILE 4 BLOCK 10 TO 13;

VALIDATE BACKUPSET 35;

LIST BACKUP;

DELETE ARCHIVELOG ALL;
DELETE NOPROMPT ARCHIVELOG ALL;

```

Scripting RMAN Operations

```
# my_command_file.txt
CONNECT TARGET /
BACKUP DATABASE PLUS ARCHIVELOG;
LIST BACKUP;
EXIT;

@/my_dir/my_command_file.txt  # runs specified command file
rman @/my_dir/my_command_file.txt
```

###### [Reporting on RMAN Operations: Quick Start](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/bradv/getting-started-rman.html#GUID-AEE6F3BF-4EFD-467A-8E29-9963BC7DEDD8)

```
LIST BACKUP OF DATABASE;
LIST BACKUP OF DATABASE BY BACKUP;
LIST BACKUP BY FILE;
LIST BACKUP SUMMARY;

LIST COPY OF DATAFILE 1;
LIST COPY OF DATAFILE 1,3;
LIST BACKUP OF ARCHIVELOG FROM SEQUENCE 10;
LIST BACKUPSET OF DATAFILE 1,3;

LIST EXPIRED COPY;
LIST BACKUP RECOVERABLE;

REPORT NEED BACKUP DATABASE;
REPORT OBSOLETE;
REPORT SCHEMA;
REPORT UNRECOVERABLE;

```

###### [Maintaining RMAN Backups](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/bradv/getting-started-rman.html#GUID-F4FBE633-ADBC-475F-813F-1F64F66D7415)

```
CROSSCHECK BACKUP;
CROSSCHECK COPY;
DELETE OBSOLETE;
```

###### [Diagnosing and Repairing Failures with Data Recovery Advisor: Quick Start](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/bradv/getting-started-rman.html#GUID-F24568FC-0546-4CB0-B843-87F0A95D1649)

```
LIST FAILURE;
ADVISE FAILURE;
REPAIR FAILURE;
```

###### [Rewinding a Database with Flashback Database: Quick Start](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/bradv/getting-started-rman.html#GUID-852BB34C-0F26-49C8-A282-EEF1FBF92FC1)

```
SHUTDOWN IMMEDIATE;
STARTUP MOUNT;

FLASHBACK DATABASE TO SCN 861150;

FLASHBACK DATABASE 
  TO RESTORE POINT BEFORE_CHANGES;

FLASHBACK DATABASE    
  TO TIMESTAMP TO_DATE(04-DEC-2009  03:30:00','DD-MON-YYYY HH24:MI:SS');
ALTER DATABASE OPEN READ ONLY;
SHUTDOWN IMMEDIATE;
STARTUP MOUNT;
ALTER DATABASE OPEN RESETLOGS;
```

###### [Restoring and Recovering Database Files: Quick Start](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/bradv/getting-started-rman.html#GUID-DF1E7501-30F1-45FB-B7FA-52DC53F03205)

```
REPORT SCHEMA;
RESTORE DATABASE PREVIEW SUMMARY;
```

Recovering the Whole Database: Quick Start

```
STARTUP FORCE MOUNT;
RESTORE DATABASE;
RECOVER DATABASE;
ALTER DATABASE OPEN;
```

Recovering Tablespaces: Quick Start

```
ALTER TABLESPACE users OFFLINE;
RUN
{
  SET NEWNAME FOR DATAFILE '/disk1/oradata/prod/users01.dbf' 
    TO '/disk2/users01.dbf';
  RESTORE TABLESPACE users;
  SWITCH DATAFILE ALL;   # update control file with new file names
  RECOVER TABLESPACE users;
}
ALTER TABLESPACE users ONLINE;
```

Recovering Individual Data Blocks: Quick Start

```
SELECT NAME, VALUE FROM V$DIAG_INFO;
RECOVER CORRUPTION LIST;
RECOVER DATAFILE 1 BLOCK 233, 235 DATAFILE 2 BLOCK 100 TO 200;
```

#### [Part II Starting and Configuring RMAN and Flashback Database](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/bradv/part-starting-configuring-rman.html#GUID-F25F36B4-B31E-438D-AAF9-C555BE8082B1)

##### [Configuring the RMAN Environment](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/bradv/configuring-rman-client-basic.html#GUID-5155F8E6-6E35-4261-9CC1-F12DAA9FAC5B)

###### [About Configuring the Environment for RMAN Backups](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/bradv/configuring-rman-client-basic.html#GUID-AD92E09D-0788-4AB5-8792-5F969C8D237A)

[Showing and Clearing Persistent RMAN Configurations](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/bradv/configuring-rman-client-basic.html#GUID-44DD1FEB-3A95-436C-ABF9-03921B778155)

```
SHOW ALL;

RMAN configuration parameters for database with db_unique_name PROD1 are:
CONFIGURE RETENTION POLICY TO RECOVERY WINDOW OF 3 DAYS;
CONFIGURE BACKUP OPTIMIZATION ON;
CONFIGURE DEFAULT DEVICE TYPE TO DISK; # default
CONFIGURE CONTROLFILE AUTOBACKUP ON; # default
CONFIGURE CONTROLFILE AUTOBACKUP FORMAT FOR DEVICE TYPE SBT_TAPE TO '%F'; # default
CONFIGURE CONTROLFILE AUTOBACKUP FORMAT FOR DEVICE TYPE DISK TO '%F'; # default
CONFIGURE DEVICE TYPE 'SBT_TAPE' PARALLELISM 2 BACKUP TYPE TO COMPRESSED BACKUPSET;
CONFIGURE DEVICE TYPE DISK PARALLELISM 1 BACKUP TYPE TO BACKUPSET; # default
CONFIGURE DATAFILE BACKUP COPIES FOR DEVICE TYPE SBT_TAPE TO 1; # default
CONFIGURE DATAFILE BACKUP COPIES FOR DEVICE TYPE DISK TO 1; # default
CONFIGURE ARCHIVELOG BACKUP COPIES FOR DEVICE TYPE SBT_TAPE TO 1; # default
CONFIGURE ARCHIVELOG BACKUP COPIES FOR DEVICE TYPE DISK TO 1; # default
CONFIGURE CHANNEL DEVICE TYPE 'SBT_TAPE' PARMS 'ENV=(OB_DEVICE=tape1)';
CONFIGURE MAXSETSIZE TO UNLIMITED; # default
CONFIGURE ENCRYPTION FOR DATABASE OFF; # default
CONFIGURE ENCRYPTION ALGORITHM 'AES128'; # default
CONFIGURE COMPRESSION ALGORITHM 'BASIC' AS OF RELEASE 'DEFAULT' OPTIMIZE FOR LOAD TRUE ; # default
CONFIGURE RMAN OUTPUT TO KEEP FOR 7 DAYS; # default
CONFIGURE ARCHIVELOG DELETION POLICY TO NONE; # default
CONFIGURE SNAPSHOT CONTROLFILE NAME TO '/disk1/oracle/dbs/snapcf_ev.f'; # default
```

```
SHOW RETENTION POLICY;
SHOW DEFAULT DEVICE TYPE;
```

```
CONFIGURE BACKUP OPTIMIZATION CLEAR;
CONFIGURE RETENTION POLICY CLEAR;
CONFIGURE CONTROLFILE AUTOBACKUP FORMAT FOR DEVICE TYPE DISK CLEAR;
```

[Configuring the Default Device for Backups: Disk or SBT](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/bradv/configuring-rman-client-basic.html#GUID-3845B630-DD47-4147-BA6E-8D677CAF1CC2)

```
BACKUP DEVICE TYPE sbt DATABASE;
BACKUP DEVICE TYPE DISK DATABASE;
```

[Configuring the Default Type for Backups: Backup Sets or Copies](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/bradv/configuring-rman-client-basic.html#GUID-BC37B3E4-3338-4452-A363-DB882F2E9415)

```
CONFIGURE DEVICE TYPE DISK BACKUP TYPE TO COPY; # image copies
CONFIGURE DEVICE TYPE DISK BACKUP TYPE TO BACKUPSET; # uncompressed
CONFIGURE DEVICE TYPE DISK BACKUP TYPE TO COMPRESSED BACKUPSET;
CONFIGURE DEVICE TYPE sbt BACKUP TYPE TO COMPRESSED BACKUPSET;
```

[Configuring Channels](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/bradv/configuring-rman-client-basic.html#GUID-911248BA-A742-426C-9B90-51214CFAF36B)

[About Channel Configuration](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/bradv/configuring-rman-client-basic.html#GUID-06001DF9-43B5-4A93-BFBC-B03D718A8692)

```
CONFIGURE CHANNEL DEVICE TYPE DISK MAXPIECESIZE 2G;
CONFIGURE CHANNEL DEVICE TYPE DISK FORMAT /tmp/%U;
```

[Configuring Channels for Disk](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/bradv/configuring-rman-client-basic.html#GUID-FAFF9171-43CF-493A-BA5A-AD9B59B2CFEB)

```
CONFIGURE CHANNEL DEVICE TYPE DISK FORMAT '/disk1/ora_df%t_s%s_s%p';
```

```
CONFIGURE CHANNEL DEVICE TYPE DISK FORMAT '+dgroup1';
```

[Configuring Parallel Channels for Disk and SBT Devices](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/bradv/configuring-rman-client-basic.html#GUID-C6D6E615-892F-4586-B14D-1BA42CB0C457)

As a rule, the number of channels used in executing a command should match the number of devices accessed.

```
RMAN> CONFIGURE DEVICE TYPE sbt PARALLELISM 2;

old RMAN configuration parameters:
CONFIGURE DEVICE TYPE 'SBT_TAPE' BACKUP TYPE TO COMPRESSED BACKUPSET PARALLELISM 1;
new RMAN configuration parameters:
CONFIGURE DEVICE TYPE 'SBT_TAPE' PARALLELISM 2 BACKUP TYPE TO COMPRESSED BACKUPSET;
new RMAN configuration parameters are successfully stored
```

[Manually Overriding Configured Channels](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/bradv/configuring-rman-client-basic.html#GUID-1090ADE7-5B97-43FE-B9BA-B720C50CE6B7)

```
RUN 
{
  ALLOCATE CHANNEL c1 DEVICE TYPE DISK;
  BACKUP TABLESPACE users;
}
```

In this case, RMAN uses only the disk channel that you manually allocated within the [`RUN`](https://www.oracle.com/pls/topic/lookup?ctx=en/database/oracle/oracle-database/12.2/bradv&id=RCMRF151) command, overriding any defaults set by using `CONFIGURE` `DEVICE` `TYPE`, `CONFIGURE` `DEFAULT` `DEVICE`, or `CONFIGURE` `CHANNEL` settings.

[Configuring Control File and Server Parameter File Autobackups](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/bradv/configuring-rman-client-basic.html#GUID-98BA7492-7108-4DF9-B5A2-21957072E308)

```
CONFIGURE CONTROLFILE AUTOBACKUP ON;
CONFIGURE CONTROLFILE AUTOBACKUP OFF;
```

[Configuring the Control File Autobackup Format](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/bradv/configuring-rman-client-basic.html#GUID-C64AE090-0749-43EA-92C4-69DC6201A15F)

The `%F` variable format translates into *`c-IIIIIIIIII-YYYYMMDD-QQ`*, with the placeholders defined as follows:

- *`IIIIIIIIII`* stands for the DBID.
- *`YYYYMMDD`* is a time stamp of the day the backup is generated.
- *`QQ`* is the hexadecimal sequence that starts with `00` and has a maximum of `FF`.

```
CONFIGURE CONTROLFILE AUTOBACKUP FORMAT 
  FOR DEVICE TYPE DISK TO '?/oradata/cf_%F';
```

The following example configures the autobackup to write to an Automatic Storage Management disk group:

```
CONFIGURE CONTROLFILE AUTOBACKUP FORMAT 
  FOR DEVICE TYPE DISK TO '+dgroup1/%F';
```

Note:

The valid formats for control file autobackups are: `%D`, `%I`, `%M`, `%Y`, `%F`, `%T`, `%d`, and `%n`. If you use formats other than these, you may not be able to restore the control file autobackup.

To clear control file autobackup formats for a device:

- Use the following commands:

  ```
  CONFIGURE CONTROLFILE AUTOBACKUP FORMAT FOR DEVICE TYPE DISK CLEAR;
  CONFIGURE CONTROLFILE AUTOBACKUP FORMAT FOR DEVICE TYPE sbt CLEAR;
  ```

If you have set up a [**fast recovery area**](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/bradv/glossary.html#GUID-6E3CDD76-A573-4E5C-B12D-59C232C96C19) for the database, then you can direct control file autobackups to the fast recovery area by clearing the control file autobackup format for disk.

Note:

All files in the fast recovery area are maintained by Oracle Database and associated file names are maintained in the Oracle Managed Files (OMF) format.

[Overriding the Configured Control File Autobackup Format](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/bradv/configuring-rman-client-basic.html#GUID-B04B5550-6DF9-4FDE-A03A-CFDF57518264)

```
SET CONTROLFILE AUTOBACKUP FORMAT FOR DEVICE TYPE DISK TO 'controlfile_%F';
BACKUP AS COPY DATABASE;
RUN
{
  SET CONTROLFILE AUTOBACKUP FORMAT FOR DEVICE TYPE DISK TO '/tmp/%F.bck'; 
  BACKUP AS BACKUPSET 
    DEVICE TYPE DISK 
    DATABASE;
}
```

###### [Configuring the Backup Retention Policy](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/bradv/configuring-rman-client-basic.html#GUID-03DE4CF6-9D9F-4806-B5CA-CAA4CF5F2133)

[Configuring a Redundancy-Based Retention Policy](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/bradv/configuring-rman-client-basic.html#GUID-E9AEAC34-6C40-40A1-BAF5-3EAE20417715)

```
CONFIGURE RETENTION POLICY TO REDUNDANCY 3;
```

[Configuring a Recovery Window-Based Retention Policy](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/bradv/configuring-rman-client-basic.html#GUID-95ABBB30-713E-4781-B5C3-6ADBEB658DE3)

```
CONFIGURE RETENTION POLICY TO RECOVERY WINDOW OF 7 DAYS;
```

[Disabling the Retention Policy](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/bradv/configuring-rman-client-basic.html#GUID-B668D2BC-8807-4308-AAB4-F3B85EA2B6C4)

```
CONFIGURE RETENTION POLICY TO NONE;
```

###### [Backup Optimization and the CONFIGURE command](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/bradv/configuring-rman-client-basic.html#GUID-914A65A7-872E-465B-95E5-0FD5ADAF6A9C)

[Overview of Backup Optimization](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/bradv/configuring-rman-client-basic.html#GUID-ABA3E439-57C2-4AE7-BCEF-39A6663E7AA2)

When you enable backup optimization, the `BACKUP` command skips backing up files when the identical file has been backed up to the specified device type.

[Configuring Backup Optimization](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/bradv/configuring-rman-client-basic.html#GUID-D78276FA-E505-4542-9D78-2335B5F94922)

```
SHOW BACKUP OPTIMIZATION;
CONFIGURE BACKUP OPTIMIZATION OFF;
CONFIGURE BACKUP OPTIMIZATION ON;
```

###### [Configuring an Archived Redo Log Deletion Policy](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/bradv/configuring-rman-client-basic.html#GUID-FA142760-8ACB-43DA-939C-8407618D2D0F)

[Enabling an Archived Redo Log Deletion Policy](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/bradv/configuring-rman-client-basic.html#GUID-97829620-DD75-4993-BE83-E67F5CA5BB18)

```
CONFIGURE ARCHIVELOG DELETION POLICY TO APPLIED ON ALL STANDBY;
```





#### [Part III Backing Up and Archiving Data](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/bradv/part-backing-up-archiving.html#GUID-008E0F84-E623-4467-8706-A99B34002DD6)

##### [RMAN Backup Concepts](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/bradv/rman-backup-concepts.html#GUID-B3380142-ABCD-437F-9E06-B219D74E6738)

###### [Backing Up the Database](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/bradv/backing-up-database.html#GUID-93BAB347-063F-439E-BDF3-109AB8D1F8E7)

[Backing Up Database Files with RMAN](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/bradv/backing-up-database.html#GUID-344F4D14-AC81-4093-B921-6403EE75112C)

[Backing Up Control Files with RMAN](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/bradv/backing-up-database.html#GUID-D25F0A92-12AE-490E-AB8F-C9E54E081CDD)

```
CONFIGURE CONTROLFILE AUTOBACKUP ON; 
CONFIGURE CONTROLFILE AUTOBACKUP FORMAT FOR DEVICE TYPE DISK TO '/disk2/%F';
CONFIGURE CONTROLFILE AUTOBACKUP FORMAT FOR DEVICE TYPE sbt TO 'cf_auto_%F';
SHOW CONTROLFILE AUTOBACKUP;
SHOW ALL;

BACKUP DEVICE TYPE sbt 
  TABLESPACE users 
  INCLUDE CURRENT CONTROLFILE;
BACKUP CURRENT CONTROLFILE;
BACKUP AS COPY
  CURRENT CONTROLFILE 
  FORMAT '/tmp/control01.ctl';
```

[Backing Up Server Parameter Files with RMAN](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/bradv/backing-up-database.html#GUID-D3E617F5-121C-41DC-A191-B3BA6D121B30)

```
BACKUP DEVICE TYPE sbt SPFILE;
```

#### [Part IV Managing RMAN Backups](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/bradv/part-managing-rman-backups.html#GUID-9B9779FA-2C8B-4D11-AC3B-F6FFA95AE2D1)

##### [Maintaining RMAN Backups and Repository Records](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/bradv/maintaining-rman-backups.html#GUID-F5C3D045-279B-4AB3-8A91-3231A716402C)

###### [Overview of RMAN Backup and Repository Maintenance](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/bradv/maintaining-rman-backups.html#GUID-9B20BEFF-DE04-481C-8A50-46902B3B8B5F)

[Basic Concepts of Backup and Repository Maintenance](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/bradv/maintaining-rman-backups.html#GUID-E5BBAAFE-1191-4A96-A63A-91EDF87F7C3E)

[About Maintenance Commands in a Data Guard Environment](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/bradv/maintaining-rman-backups.html#GUID-F0C0A8F9-CBDF-4EDE-BAAF-F93CC37638B1)

[About Crosschecks in a Data Guard Environment](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/bradv/maintaining-rman-backups.html#GUID-2792BBD5-2FD4-435B-85A3-0916D8EF6EC6)

For a crosscheck, RMAN can only update the status of a file from `AVAILABLE` to `EXPIRED` when connected to the database associated with the file.

###### [Updating the RMAN Repository](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/bradv/maintaining-rman-backups.html#GUID-93AE3A35-4B8C-424A-A5D4-CE14E160738C)

Crosschecks are useful because they can do the following:

- Update outdated information about backups that disappeared from disk or tape or became corrupted
- Update the repository if you delete archived redo logs or other files with operating system commands

[Crosschecking the RMAN Repository](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/bradv/maintaining-rman-backups.html#GUID-EFF8F8D1-D67C-4202-9C8E-DE74ADFF1FFB)

[Crosschecking All Backups and Copies](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/bradv/maintaining-rman-backups.html#GUID-E1D38362-4C8E-4F16-AEBF-6A6429D7BB3A)

```
CROSSCHECK BACKUP;
CROSSCHECK COPY;
```

[Crosschecking Specific Backup Sets and Copies](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/bradv/maintaining-rman-backups.html#GUID-C306C814-ACB3-49E7-AEBD-C0A7FC78D163)

```
LIST BACKUP;  # lists all backup sets, proxy copies, and image copies
```



```
CROSSCHECK BACKUP;  # checks backup sets, proxy copies, and image copies
CROSSCHECK COPY OF DATABASE;
CROSSCHECK BACKUPSET 1338, 1339, 1340;
CROSSCHECK BACKUPPIECE TAG 'nightly_backup';
CROSSCHECK BACKUP OF ARCHIVELOG ALL SPFILE;
CROSSCHECK BACKUP OF DATAFILE "?/oradata/trgt/system01.dbf"
  COMPLETED AFTER 'SYSDATE-14';
CROSSCHECK CONTROLFILECOPY '/tmp/control01.ctl';
CROSSCHECK DATAFILECOPY 113, 114, 115;
CROSSCHECK PROXY 789;
```



###### [Deleting RMAN Backups and Archived Redo Logs](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/bradv/maintaining-rman-backups.html#GUID-8C4B395D-7C24-485F-BEA0-A355821FB93D)

[Overview of Deleting RMAN Backups](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/bradv/maintaining-rman-backups.html#GUID-8EFDE192-A385-457E-B00A-7A9ED7598223)

[About Deletion of Archived Redo Logs](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/bradv/maintaining-rman-backups.html#GUID-8E5E9B7B-6627-4B14-8BFC-1C53EFB82FEF)

```
DELETE NOPROMPT ARCHIVELOG ALL;
DELETE EXPIRED ARCHIVELOG ALL;
```

[Deleting All Backups and Copies](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/bradv/maintaining-rman-backups.html#GUID-0F82F489-C5FB-41C2-9687-AE9A5CD89406)

```
CROSSCHECK BACKUP;
CROSSCHECK COPY;
DELETE BACKUP;
DELETE COPY;
```

[Deleting Specified Backups and Copies](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/bradv/maintaining-rman-backups.html#GUID-D39FCF70-C71B-46C7-8ED5-94CF33A5611D)

[Deleting Expired RMAN Backups and Copies](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/bradv/maintaining-rman-backups.html#GUID-ABB66655-6FAC-4375-AFA0-2E40634085A5)

```
CROSSCHECK BACKUP;
DELETE EXPIRED BACKUP;
DELETE NOPROMPT EXPIRED BACKUP;
```

[Deleting Obsolete RMAN Backups Based on Retention Policies](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/bradv/maintaining-rman-backups.html#GUID-DB5F52FF-58DE-4486-B0B3-D0EAEA26A776)

```
DELETE OBSOLETE;
DELETE NOPROMPT OBSOLETE;

```

#### [Part V Diagnosing and Responding to Failures](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/bradv/part-diagnosing-responding-failures.html#GUID-ED89DC53-A816-450B-BFF4-A712D2694EEC)

##### [Performing Flashback and Database Point-in-Time Recovery](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/bradv/rman-performing-flashback-dbpitr.html#GUID-5463669A-DC89-4FF4-ACCE-136A72DF687B)

###### [Rewinding a Table with Flashback Table](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/bradv/rman-performing-flashback-dbpitr.html#GUID-FF315DFC-ABBC-410D-ABDB-75FA89D43255)

```
SELECT CURRENT_SCN FROM V$DATABASE;
SELECT NAME, SCN, TIME FROM V$RESTORE_POINT;
SELECT NAME, VALUE/60 MINUTES_RETAINED
FROM   V$PARAMETER
WHERE  NAME = 'undo_retention';
ALTER TABLE table ENABLE ROW MOVEMENT;
SELECT other.owner, other.table_name
FROM   sys.all_constraints this, sys.all_constraints other
WHERE  this.owner = schema_name
AND    this.table_name = table_name
AND    this.r_owner = other.owner
AND    this.r_constraint_name = other.constraint_name
AND    this.constraint_type='R';
FLASHBACK TABLE hr.temp_employees
  TO RESTORE POINT temp_employees_update;
FLASHBACK TABLE hr.temp_employees
  TO SCN 123456;
FLASHBACK TABLE hr.temp_employees
  TO TIMESTAMP TO_TIMESTAMP('2013-10-17 09:30:00', 'YYYY-MM-DD HH:MI:SS');
```

##### [Performing RMAN Recovery: Advanced Scenarios](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/bradv/rman-recovery-advanced.html#GUID-EA9DB3ED-2481-47DD-908B-A314D5C3F730)

###### [Recovering a NOARCHIVELOG Database with Incremental Backups](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/bradv/rman-recovery-advanced.html#GUID-18DC642E-DA14-47A9-9547-02F385CA47EA)

```
STARTUP FORCE MOUNT
RESTORE DATABASE 
  FROM TAG "consistent_whole_backup";
RECOVER DATABASE NOREDO;
ALTER DATABASE OPEN RESETLOGS;
```

###### [Restoring the Server Parameter File](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/bradv/rman-recovery-advanced.html#GUID-2B93E1AF-5ED1-4FAE-91BB-63362CADF7AD)

To restore the server parameter file from autobackup:
```
STARTUP FORCE NOMOUNT;
RUN 
{
  ALLOCATE CHANNEL c1 DEVICE TYPE sbt PARMS ...;
  SET UNTIL TIME 'SYSDATE-7';
  SET CONTROLFILE AUTOBACKUP FORMAT 
    FOR DEVICE TYPE sbt TO '/disk1/control_files/autobackup_%F';
  SET DBID 123456789;
  RESTORE SPFILE
    TO '/tmp/spfileTEMP.ora'
    FROM AUTOBACKUP MAXDAYS 10;
}
STARTUP FORCE PFILE=/tmp/init.ora;
```


[Restoring the Server Parameter File from a Control File Autobackup](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/bradv/rman-recovery-advanced.html#GUID-8077F97F-76A7-49DC-8C1E-5FE8ADD0914F)

```
SET DBID 320066378;
RUN 
{
  SET CONTROLFILE AUTOBACKUP FORMAT 
    FOR DEVICE TYPE DISK TO 'autobackup_format';
  RESTORE SPFILE FROM AUTOBACKUP;
}
```

[Creating an Initialization Parameter File with RMAN](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/bradv/rman-recovery-advanced.html#GUID-AE7CD28F-3187-44DD-BEC2-E43839EC63E6)

```
RESTORE SPFILE TO PFILE '/tmp/initTEMP.ora';
STARTUP FORCE PFILE='/tmp/initTEMP.ora';
```

###### [Performing Recovery with a Backup Control File](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/bradv/rman-recovery-advanced.html#GUID-77C2B092-4BEB-4BAC-91F9-7368EA16A2B6)

[About Recovery with a Backup Control File](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/bradv/rman-recovery-advanced.html#GUID-7B78C0E8-423A-4BE0-88D5-AB903DB49608)

[About Control File Locations During RMAN Restore](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/bradv/rman-recovery-advanced.html#GUID-64F583E8-2E1A-4F13-847B-5FCEFA9E008A)

```
RESTORE CONTROLFILE TO '/tmp/my_controlfile';
```

[About RMAN Recovery With and Without a Recovery Catalog](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/bradv/rman-recovery-advanced.html#GUID-FE57B2EA-428A-4408-BBB5-D9392D6B0F8B)

```
SET DBID 320066378;
RUN
{
  SET CONTROLFILE AUTOBACKUP FORMAT 
    FOR DEVICE TYPE DISK TO 'autobackup_format';
  RESTORE CONTROLFILE FROM AUTOBACKUP;
}
```

[About RMAN Recovery When Using a Fast Recovery Area](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/bradv/rman-recovery-advanced.html#GUID-918B5EE1-DBE9-464E-B8F9-454E1F94136A)

```
CROSSCHECK BACKUP DEVICE TYPE sbt;
```

[Performing Recovery with a Backup Control File and No Recovery Catalog](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/bradv/rman-recovery-advanced.html#GUID-927C5614-DC12-4B58-B261-EBD5F08A4202)

```
STARTUP NOMOUNT;
SET DBID 676549873;
RUN 
{
  # Optionally, set upper limit for eligible time stamps of control file 
  # backups
  # SET UNTIL TIME '09/10/2013 13:45:00';
  # Specify a nondefault autobackup format only if required
  # SET CONTROLFILE AUTOBACKUP FORMAT FOR DEVICE TYPE DISK 
  #   TO '?/oradata/%F.bck';
  ALLOCATE CHANNEL c1 DEVICE TYPE sbt PARMS '...'; # allocate manually
  RESTORE CONTROLFILE FROM AUTOBACKUP
    MAXSEQ 100           # start at sequence 100 and count down
    MAXDAYS 180;         # start at UNTIL TIME and search back 6 months
  ALTER DATABASE MOUNT;
}
# Now use automatic channels configured in restored control file
RESTORE DATABASE UNTIL SEQUENCE 13244;
RECOVER DATABASE UNTIL SEQUENCE 13244;
ALTER DATABASE OPEN RESETLOGS;
```

###### [Restoring a Database on a New Host](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/bradv/rman-recovery-advanced.html#GUID-6B71E7DF-A2B6-44F5-A8D5-B184BB41A768)



#### [Part VIII Performing User-Managed Backup and Recovery](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/bradv/part-user-managed-backup-recovery.html#GUID-F74964D7-F1D1-4401-827A-32D3E51BB41D)

##### [Performing User-Managed Database Flashback and Recovery](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/bradv/user-managed-flashback-dbpitr.html#GUID-704F6AB0-04C4-4345-913B-B316DD06D05E)

##### [Performing User-Managed Recovery: Advanced Scenarios](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/bradv/user-managed-recovery-advanced.html#GUID-24903185-E2CE-452E-8370-E4A47AD2632B)

###### [Responding to the Loss of a Subset of the Current Control Files](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/bradv/user-managed-recovery-advanced.html#GUID-22AD5382-06ED-4FDF-BDD4-C8CD682F83E0)

[Copying a Multiplexed Control File to a Default Location](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/bradv/user-managed-recovery-advanced.html#GUID-A4F29C29-95A7-4F05-8638-9C921AF9E0DC)

```
SQL> SHUTDOWN ABORT
% cp /oracle/good_cf.f /oracle/dbs/bad_cf.f
SQL> STARTUP
```

[Copying a Multiplexed Control File to a Nondefault Location](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/bradv/user-managed-recovery-advanced.html#GUID-49F97453-C0B3-4F18-B94C-63FB5C780BC3)

```
SQL> SHUTDOWN ABORT
% cp /disk1/oradata/trgt/control01.dbf /new_disk/control01.dbf
CONTROL_FILES='/disk1/oradata/trgt/control01.dbf','/new_disk/control02.dbf'
SQL> STARTUP
```

###### [Recovering After the Loss of All Current Control Files](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/bradv/user-managed-recovery-advanced.html#GUID-3913B513-ECF0-469A-A50A-A5A573C85DC0)

[Recovering with a Backup Control File in the Default Location](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/bradv/user-managed-recovery-advanced.html#GUID-B798CEB4-E8BE-467A-B17D-DBB993E912BE)

```
SQL> SHUTDOWN ABORT
SQL> STARTUP MOUNT 
SQL> RECOVER DATABASE USING BACKUP CONTROLFILE UNTIL CANCEL
SQL> ALTER DATABASE OPEN RESETLOGS;
```

[Recovering with a Backup Control File in a Nondefault Location](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/bradv/user-managed-recovery-advanced.html#GUID-48CAA587-BD0E-4F94-BD6B-BF21520E53EF)

## Data Guard

### [Data Guard Broker](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/dgbkr/index.html)

#### [Managing Broker Configurations](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/dgbkr/managing-oracle-data-guard-broker-configurations.html#GUID-FCCDC53A-C6F4-4AFB-A220-9D6622474027)

##### [Setting Up the Broker Configuration Files](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/dgbkr/managing-oracle-data-guard-broker-configurations.html#GUID-E4EE9680-63B7-4483-843B-47E33FC41B20)

###### [Renaming the Broker Configuration Files](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/dgbkr/managing-oracle-data-guard-broker-configurations.html#GUID-73036514-7061-4B0D-83E5-C257EE59D791)

```
ALTER SYSTEM SET DG_BROKER_START=FALSE;
ALTER SYSTEM SET DG_BROKER_CONFIG_FILE1=filespec1;
ALTER SYSTEM SET DG_BROKER_CONFIG_FILE2=filespec2;
ALTER SYSTEM SET DG_BROKER_START=TRUE;
SHOW PARAMETER DG_BROKER_START;
```

###### [Starting the Data Guard Broker](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/dgbkr/managing-oracle-data-guard-broker-configurations.html#GUID-BAAE6C51-C29F-4950-A885-EB1289A230B2)

```
ALTER SYSTEM SET DG_BROKER_START=TRUE;
SHOW PARAMETER DG_BROKER_START;
```

##### [Configuration Status](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/dgbkr/managing-oracle-data-guard-broker-configurations.html#GUID-92632C7B-BFF3-4678-9F4F-CC0B72ED6A35)

```
SHOW CONFIGURATION;
SHOW DATABASE cdb1;
SHOW DATABASE cdb1_stby;
SHOW DATABASE VERBOSE cdb1;
SHOW DATABASE VERBOSE cdb1_stby;
```

#### [Managing the Members of a Broker Configuration](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/dgbkr/managing-oracle-data-guard-broker-configuration-members.html#GUID-0CD70A29-4F51-4CC1-88EB-2D8AA29F75D7)

##### [Managing States of Broker Configuration Members](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/dgbkr/managing-oracle-data-guard-broker-configuration-members.html#GUID-7430128F-D79C-4F6A-8932-8830478B83AB)

Primary - TRANSPORT-ON

Physical standby - APPLY-ON

```
EDIT DATABASE 'cdb1' SET STATE='TRANSPORT-OFF';
EDIT DATABASE 'cdb1' SET STATE='TRANSPORT-ON';
EDIT DATABASE 'cdb1_stby' SET STATE='APPLY-OFF';
EDIT DATABASE 'cdb1_stby' SET STATE='APPLY-ON';
```

##### [Managing Database Properties](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/dgbkr/managing-oracle-data-guard-broker-configuration-members.html#GUID-5CA7C5EC-DE39-482D-8E54-2C3126651271)

###### [Monitorable (Read-Only) Properties](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/dgbkr/managing-oracle-data-guard-broker-configuration-members.html#GUID-3A5DC529-0C67-4EBF-8771-C7C3281F1553)

```
SHOW DATABASE VERBOSE cdb1;
SHOW DATABASE 'cdb1' 'InconsistentLogXptProps';
SHOW DATABASE 'cdb1' 'LogXptMode';
SHOW DATABASE 'cdb1' 'RedoRoutes';
```

###### [Configurable (Changeable) Properties](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/dgbkr/managing-oracle-data-guard-broker-configuration-members.html#GUID-58646FFF-47E4-40DC-A7DA-C4AB33CDB16B)

```
SHOW DATABASE 'cdb1' 'ArchiveLagTarget';
EDIT DATABASE 'cdb1' SET PROPERTY 'ArchiveLagTarget'=1200;
```

##### [Managing Redo Transport Services](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/dgbkr/managing-oracle-data-guard-broker-configuration-members.html#GUID-6DC53E53-63F3-42D7-865E-C7689AEBD44A)

###### [Managing Redo Transport Services for Data Protection Modes](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/dgbkr/managing-oracle-data-guard-broker-configuration-members.html#GUID-5BFCC986-BB38-47CF-86CE-9F54E2539CBF)

```
SHOW DATABASE 'cdb1' 'LogXptMode';
SHOW DATABASE 'cdb1_stby' 'LogXptMode';
SHOW DATABASE 'cdb1' 'RedoRoutes';
```

###### [Advanced Redo Transport Settings](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/dgbkr/managing-oracle-data-guard-broker-configuration-members.html#GUID-81DE5E90-C544-410C-942E-6172E7BB4205)

```
EDIT DATABASE 'cdb1' SET PROPERTY 'RedoRoutes' = '(LOCAL : Local_Sales SYNC)';
EDIT DATABASE 'Local_Sales' SET PROPERTY 'RedoRoutes' = '(cdb1 : Remote_Sales ASYNC)';
EDIT DATABASE 'Local_Sales' SET PROPERTY 'RedoRoutes' = '(cdb1 : Remote_Sales)';
SHOW CONFIGURATION VERBOSE;
```

###### [Turning Redo Transport Services On and Off](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/dgbkr/managing-oracle-data-guard-broker-configuration-members.html#GUID-407D7187-93B3-4DAB-A31E-4D5302265A48)

```
EDIT DATABASE 'cdb1' SET STATE='TRANSPORT-OFF';
EDIT DATABASE 'cdb1_stby' SET PROPERTY 'LogShipping'='OFF';
```

###### [Transport Lag](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/dgbkr/managing-oracle-data-guard-broker-configuration-members.html#GUID-376B5C8C-C922-4AED-A8BB-1E5D362551A6)

```
EDIT DATABASE 'cdb1_stby' SET PROPERTY 'TransportLagThreshold'=15;
```

##### [Managing Redo Transport Services for Recovery Appliance](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/dgbkr/managing-oracle-data-guard-broker-configuration-members.html#GUID-845BE719-CC15-4D6C-BD91-FF935CAE605A)

```
ADD RECOVERY_APPLIANCE EnterpriseRecoveryAppliance AS CONNECT IDENTIFIER IS
EnterpriseRecoveryAppliance.example.com;
SHOW RECOVERY_APPLIANCE 'EnterpriseRecoveryAppliance';
ENABLE RECOVERY_APPLIANCE 'EnterpriseRecoveryAppliance';
EDIT RECOVERY_APPLIANCE 'EnterpriseRecoveryAppliance'
SET PROPERTY 'TransportLagThreshold'=15;
EDIT DATABASE 'cdb1' SET PROPERTY 'RedoRoutes' = '(LOCAL : cdb1_stby SYNC)';
EDIT DATABASE 'cdb1_stby' SET PROPERTY 'RedoRoutes' = '(cdb1 : EnterpriseRecoveryAppliance ASYNC)';
```

##### [Managing Log Apply Services](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/dgbkr/managing-oracle-data-guard-broker-configuration-members.html#GUID-6753936C-E2E3-471E-BCC5-0C4697AD4255)

The database properties related to log apply are as follows:

Properties common to Redo Apply and SQL Apply

```
SHOW DATABASE 'cdb1_stby' 'ApplyInstanceTimeout';
SHOW DATABASE 'cdb1_stby' 'DelayMins';
SHOW DATABASE 'cdb1_stby' 'PreferredApplyInstance';
```

Properties specific to Redo Apply

```
SHOW DATABASE 'cdb1_stby' 'ApplyParallel';
SHOW DATABASE 'cdb1_stby' 'ApplyInstances';
```

Properties specific to SQL Apply

```
SHOW DATABASE 'cdb1_stby' 'LsbyMaxSga';
SHOW DATABASE 'cdb1_stby' 'LsbyMaxServers';
SHOW DATABASE 'cdb1_stby' 'LsbyRecordSkipErrors';
SHOW DATABASE 'cdb1_stby' 'LsbyRecordSkipDdl';
SHOW DATABASE 'cdb1_stby' 'LsbyRecordAppliedDdl';
SHOW DATABASE 'cdb1_stby' 'LsbyMaxEventsRecorded';
SHOW DATABASE 'cdb1_stby' 'LsbyPreserveCommitOrder';
```

###### [Apply Services in an Oracle RAC Database Environment](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/dgbkr/managing-oracle-data-guard-broker-configuration-members.html#GUID-AD180341-C7FD-4965-8826-E32372F10F27)

```
EDIT DATABASE 'cdb1_stby' SET STATE='APPLY-ON' WITH APPLY INSTANCE='cdb1_stby2';
SHOW DATABASE 'cdb1_stby' 'PreferredApplyInstance';
```

###### [Apply Lag](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/dgbkr/managing-oracle-data-guard-broker-configuration-members.html#GUID-EBA4925E-4580-4D06-9355-20DF777E5DCA)

```
EDIT DATABASE 'cdb1_stby' SET PROPERTY 'ApplyLagThreshold'=15;
SHOW DATABASE 'cdb1_stby' 'ApplyLagThreshold';
```

##### [Managing Data Protection Modes](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/dgbkr/managing-oracle-data-guard-broker-configuration-members.html#GUID-994BE350-859F-41DC-A1D3-B6E8D5EEF2C8)

###### [Setting the Protection Mode for Your Configuration](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/dgbkr/managing-oracle-data-guard-broker-configuration-members.html#GUID-A938EA13-B128-4D54-8A99-6871D93F01CE)

| Protection Mode   | Redo Transport     | Standby Redo Log Files Needed? | Usable with Fast-Start Failover? |
| :---------------- | :----------------- | :----------------------------- | :------------------------------- |
| `MAXPROTECTION`   | `SYNC`             | Yes                            | Yes                              |
| `MAXAVAILABILITY` | `SYNC`, `FASTSYNC` | Yes                            | Yes                              |
| `MAXPERFORMANCE`  | `ASYNC`            | Yes                            | Yes                              |

```
EDIT DATABASE 'cdb1_stby' SET PROPERTY LogXptMode='SYNC';
EDIT DATABASE 'cdb1' SET PROPERTY RedoRoutes = '(LOCAL : cdb1_stby SYNC)';
EDIT CONFIGURATION SET PROTECTION MODE AS MAXPERFORMANCE;
EDIT CONFIGURATION SET PROTECTION MODE AS MAXAVAILABILITY;
EDIT CONFIGURATION SET PROTECTION MODE AS MAXPROTECTION;
```

##### [Managing Far Sync Instances](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/dgbkr/managing-oracle-data-guard-broker-configuration-members.html#GUID-247E7C1E-EEC0-42CA-AC9F-E73948F5EDC1)

```
ADD FAR_SYNC FS1 AS CONNECT IDENTIFIER IS FS1.example.com;
ENABLE FAR_SYNC FS1;
EDIT DATABASE 'cdb1' SET PROPERTY 'RedoRoutes' = '(LOCAL : FS1 SYNC)';
EDIT FAR_SYNC 'FS1' SET PROPERTY 'RedoRoutes' = '(cdb1 : cdb1_stby ASYNC)';
EDIT CONFIGURATION SET PROTECTION MODE AS MaxAvailability;
SHOW CONFIGURATION;

EDIT FAR_SYNC 'FS2' SET PROPERTY 'RedoRoutes' = '(cdb1_stby : cdb1 ASYNC)';
ENABLE FAR_SYNC FS2;
EDIT DATABASE 'cdb1_stby' SET PROPERTY 'RedoRoutes' = '(LOCAL : FS2 SYNC)';
SHOW CONFIGURATION;

srvctl modify database -d <db_unique_name> -startoption MOUNT
```

##### [Managing Fast-Start Failover](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/dgbkr/managing-oracle-data-guard-broker-configuration-members.html#GUID-E2C40F7E-8ACC-4A75-AAAA-52E54F39F488)

```
SHOW FAST_START FAILOVER;
ENABLE FAST_START FAILOVER;
DISABLE FAST_START FAILOVER;
START OBSERVER;
SHOW CONFIGURATION FastStartFailoverThreshold;
SHOW CONFIGURATION FastStartFailoverPmyShutdown;
SHOW CONFIGURATION FastStartFailoverLagLimit;
SHOW CONFIGURATION FastStartFailoverAutoReinstate;
SHOW CONFIGURATION FastStartFailoverTarget;
SHOW CONFIGURATION ObserverOverride;
SHOW CONFIGURATION ObserverReconnect;
SHOW CONFIGURATION verbose;
```

##### [Managing Database Conversions](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/dgbkr/managing-oracle-data-guard-broker-configuration-members.html#GUID-0F7CA42F-1FE4-437E-9A2E-3FD3D2738BC1)

```
CONVERT DATABASE 'cdb1_stby' TO SNAPSHOT STANDBY;
CONVERT DATABASE 'cdb1_stby' TO PHYSICAL STANDBY;
```

##### [Database Status](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/dgbkr/managing-oracle-data-guard-broker-configuration-members.html#GUID-85D20060-248B-42A1-B78D-15C23AAA2F59)

```
SHOW CONFIGURATION;
SHOW DATABASE 'cdb1';
SHOW DATABASE 'cdb1_stby' LogXptMode;
SHOW DATABASE 'cdb1_stby' LogXptStatus;
SHOW DATABASE 'cdb1_stby' InconsistentProperties;
SHOW DATABASE 'cdb1_stby' InconsistentLogXptProps;
VALIDATE DATABASE cdb1;
VALIDATE DATABASE cdb1_stby;
```

#### [Switchover and Failover Operations](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/dgbkr/using-data-guard-broker-to-manage-switchovers-failovers.html#GUID-44E7A982-7CD4-4A51-B00E-62C0698C5CD6)

##### [Manual Failover](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/dgbkr/using-data-guard-broker-to-manage-switchovers-failovers.html#GUID-9A988501-7E18-4A62-8CD6-4BDDFA355C98)

###### [Performing a Manual Failover Operation](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/dgbkr/using-data-guard-broker-to-manage-switchovers-failovers.html#GUID-89BF9FC5-1E3F-4C0B-90CB-AF4B39B5245E)

```
FAILOVER TO database-name;
FAILOVER TO database-name IMMEDIATE;
```

###### [Reenabling Disabled Databases After a Role Change](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/dgbkr/using-data-guard-broker-to-manage-switchovers-failovers.html#GUID-D1C0709A-FBF0-4635-95A4-385506A5EC2D)

```
REINSTATE DATABASE db_unique_name;
```

##### [Fast-Start Failover](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/dgbkr/using-data-guard-broker-to-manage-switchovers-failovers.html#GUID-995CED84-BEA1-4675-9C68-B37CB996924F)

| Protection Mode      | Physical Standbys Supported? | Logical Standbys Supported? | Far Sync Instances Supported to Send Redo? |
| :------------------- | :--------------------------- | :-------------------------- | :----------------------------------------- |
| Maximum Protection   | Yes                          | No                          | No                                         |
| Maximum Availability | Yes                          | Yes                         | Yes                                        |
| Maximum Performance  | Yes                          | Yes                         | No                                         |

```
START OBSERVER;
SHOW FAST_START FAILOVER;
```

###### [Enabling Fast-Start Failover](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/dgbkr/using-data-guard-broker-to-manage-switchovers-failovers.html#GUID-D26D79F2-0093-4C0E-98CD-224A5C8CBFA4)

[When Fast-Start Failover Is Enabled and the Observer Is Running](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/dgbkr/using-data-guard-broker-to-manage-switchovers-failovers.html#GUID-824C3FEF-9D1D-4AA7-9C7A-DBDBADC77F47)

This section lists the steps the master observer takes to determine if a fast-start failover is needed and then to perform one, if necessary.

1. Monitor the environment to ensure the primary database is available.

   The master observer waits the number of seconds specified by the `FastStartFailoverThreshold` configuration property before attempting a fast-start failover when the primary database has crashed or has lost connectivity with the observer, as in the following situations:

   - The primary database loses its connections with both the observer and target standby database

   - Instance failures

     If a single-instance primary database (either Oracle RAC or non-Oracle RAC), or if all instances of an Oracle RAC primary database fail, the observer attempts a fast-start failover.

   - Shutdown abort

     If a single-instance primary database (either Oracle RAC or non-Oracle RAC), or if all instances of an Oracle RAC primary database are shut down with the `ABORT` option, the observer attempts a fast-start failover. Fast-start failover will not be attempted for the other types of database shutdown (`NORMAL`, `IMMEDIATE`, `TRANSACTIONAL`).

2. Reconnect within the time specified by the `FastStartFailoverThreshold` property.

3. Verify the target standby database is ready for failover.

4. Initiate a fast-start failover.





#### [Scenarios Using the DGMGRL Command-Line Interface](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/dgbkr/examples-using-data-guard-broker-DGMGRL-utility.html#GUID-D9018A5C-8C7A-4F6C-A7D3-B14E5AF7D4BC)

##### [Prerequisites for Getting Started](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/dgbkr/examples-using-data-guard-broker-DGMGRL-utility.html#GUID-C9349251-C406-4C10-AFA7-34CA4FB1299B)

```
CREATE SPFILE='spfilename' FROM PFILE='pfilename';
```

##### [Scenario 1: Creating a Configuration](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/dgbkr/examples-using-data-guard-broker-DGMGRL-utility.html#GUID-EBCA7643-F1D9-4EA0-BC5F-45AEEDEBC5BC)

```
dgmgrl
CONNECT sysdg@cdb1.example.com;
ALTER SYSTEM SET LOG_ARCHIVE_DEST_n=" ";
SHOW PARAMETER DB_UNIQUE_NAME;
CREATE CONFIGURATION 'DRSolution' AS
PRIMARY DATABASE IS 'cdb1'
CONNECT IDENTIFIER IS cdb1.example.com;
SHOW CONFIGURATION;
ADD DATABASE 'cdb1_stby' AS
CONNECT IDENTIFIER IS cdb1_stby.world;
ADD DATABASE 'cdb1_stby' AS
CONNECT IDENTIFIER IS cdb1_stby.world MAINTAINED AS PHYSICAL;
SHOW CONFIGURATION;
```

##### [Scenario 2: Setting Database Properties](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/dgbkr/examples-using-data-guard-broker-DGMGRL-utility.html#GUID-94628DB0-9C89-4D05-AB6D-A41555B9C7C4)

```
EDIT DATABASE 'cdb1_stby' SET PROPERTY 'LogArchiveFormat'='log_%t_%s_%r_%d.dbf';
EDIT DATABASE 'cdb1_stby' SET PROPERTY 'StandbyArchiveLocation'='/archfs/arch/';
SHOW DATABASE VERBOSE 'cdb1_stby';
SHOW DATABASE 'cdb1' 'InconsistentProperties';
SHOW DATABASE 'cdb1_stby' 'InconsistentProperties';
```

##### [Scenario 3: Enabling the Configuration and Databases](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/dgbkr/examples-using-data-guard-broker-DGMGRL-utility.html#GUID-99E9459D-5F21-4153-8D82-14BDD20A00BB)

```
ENABLE CONFIGURATION;
SHOW CONFIGURATION;
ENABLE DATABASE 'cdb1_stby';
SHOW DATABASE 'cdb1_stby';
```

##### [Scenario 4: Setting the Configuration Protection Mode](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/dgbkr/examples-using-data-guard-broker-DGMGRL-utility.html#GUID-82319941-58E8-4672-8609-7CC496D3DC29)

Note:

You cannot change the protection mode from maximum performance mode to maximum protection mode. You must first change the protection mode to maximum availability and then to maximum protection mode.

A restart of the primary database is not necessary when changing the protection mode.

```
EDIT DATABASE 'cdb1' SET PROPERTY 'LogXptMode'='SYNC';
EDIT DATABASE 'cdb1' SET PROPERTY 'LogXptMode'='ASYNC';
EDIT DATABASE 'cdb1_stby' SET PROPERTY 'LogXptMode'='SYNC';
EDIT DATABASE 'cdb1_stby' SET PROPERTY 'LogXptMode'='ASYNC';
EDIT CONFIGURATION SET PROTECTION MODE AS MAXPERFORMANCE;
EDIT CONFIGURATION SET PROTECTION MODE AS MAXAVAILABILITY;
EDIT CONFIGURATION SET PROTECTION MODE AS MAXPROTECTION;
SHOW CONFIGURATION;
```

##### [Scenario 5: Setting up Maximum Availability Mode with a Far Sync Instance](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/dgbkr/examples-using-data-guard-broker-DGMGRL-utility.html#GUID-FD18A0B8-350F-44E5-867E-0AD17E65D226)

```
ADD FAR_SYNC 'FS' AS CONNECT IDENTIFIER IS FS.EXAMPLE.COM;
ENABLE FAR_SYNC 'FS';
SHOW CONFIGURATION;
EDIT DATABASE 'cdb1' SET PROPERTY RedoRoutes='(LOCAL : FS SYNC)';
EDIT FAR_SYNC 'FS' SET PROPERTY RedoRoutes='(cdb1 : cdb1_stby');
SHOW CONFIGURATION;
EDIT CONFIGURATION SET PROTECTION MODE AS MaxAvailability;
SHOW CONFIGURATION;
SHOW CONFIGURATION WHEN PRIMARY IS 'cdb1_stby';
EDIT DATABASE 'cdb1_stby' SET PROPERTY RedoRoutes='(LOCAL : FS SYNC)';
EDIT FAR_SYNC 'FS' SET PROPERTY RedoRoutes=('cdb1 : cdb1_stby)(cdb1_stby : cdb1)';
SHOW CONFIGURATION WHEN PRIMARY IS 'cdb1_stby';
```

##### [Scenario 6: Enabling Fast-Start Failover and Starting the Observer](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/dgbkr/examples-using-data-guard-broker-DGMGRL-utility.html#GUID-AAE5EA1A-53A2-4D8D-BF59-A2856B38C99D)

```
EDIT DATABASE 'cdb1' SET PROPERTY 'LogXptMode'='SYNC';
EDIT DATABASE 'cdb1_stby' SET PROPERTY 'LogXptMode'='SYNC';
EDIT DATABASE 'cdb1' SET PROPERTY FastStartFailoverTarget='cdb1_stby';
EDIT CONFIGURATION SET PROTECTION MODE AS MAXAVAILABILITY;
```

If it is not already enabled on the primary and standby databases, enable Flashback Database by issuing the following statements on each database:

```
ALTER SYSTEM SET UNDO_RETENTION=3600 SCOPE=SPFILE;
ALTER SYSTEM SET UNDO_MANAGEMENT='AUTO' SCOPE=SPFILE;
SHUTDOWN IMMEDIATE;
STARTUP MOUNT;
SHOW PARAMETER UNDO;
ALTER SYSTEM SET DB_FLASHBACK_RETENTION_TARGET=4320 SCOPE=BOTH;
ALTER DATABASE ARCHIVELOG;
ALTER SYSTEM SET db_recovery_file_dest_size=<size>;
ALTER SYSTEM SET db_recovery_file_dest=<directory-specification>;
ALTER DATABASE FLASHBACK ON;
ALTER DATABASE OPEN;
```

Start up to three observers by logging into the observer computers and running DGMGRL.

```
CONNECT sysdg@cdb1.example.com;
START OBSERVER observer1 IN BACKGROUND
FILE IS /net/sales/dat/oracle/broker/fsfo.dat
LOGFILE IS /net/sales/dat/oracle/broker/observer.log
CONNECT IDENTIFIER IS cdb1;
```



```
ENABLE FAST_START FAILOVER;
SHOW FAST_START FAILOVER;
SHOW DATABASE 'cdb1' 'FastStartFailoverTarget';
SHOW DATABASE 'cdb1_stby' 'FastStartFailoverTarget';
```

##### [Scenario 7: Enabling Fast-Start Failover When a Far Sync Instance Is In Use](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/dgbkr/examples-using-data-guard-broker-DGMGRL-utility.html#GUID-09A3230B-A2A2-449D-89E0-EDDBD76A157C)

```
EDIT DATABASE 'cdb1' SET PROPERTY FastStartFailoverTarget='cdb1_stby';
EDIT DATABASE 'cdb1_stby' SET PROPERTY FastStartFailoverTarget='cdb1';
ENABLE FAST_START FAILOVER;
```

##### [Scenario 8: Performing Routine Management Tasks](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/dgbkr/examples-using-data-guard-broker-DGMGRL-utility.html#GUID-EF93CD0C-B038-4442-9D7F-F0B2B48F8927)

```
EDIT DATABASE 'cdb1' SET PROPERTY 'LogXptMode'=ASYNC;
EDIT DATABASE 'cdb1' RESET PROPERTY LogXptMode;
EDIT CONFIGURATION RESET PROPERTY TraceLevel;
EDIT DATABASE 'cdb1_stby' SET STATE='APPLY-OFF';
EDIT DATABASE 'cdb1_stby' SET STATE='APPLY-ON';
EDIT DATABASE cdb1 SET STATE=TRANSPORT-OFF;
EDIT DATABASE cdb1 SET STATE=TRANSPORT-ON;
DISABLE CONFIGURATION;
DISABLE DATABASE 'cdb1_stby';
DISABLE FAR_SYNC 'FS';
REMOVE DATABASE 'cdb1_stby';
REMOVE FAR_SYNC 'FS';
REMOVE CONFIGURATION;
```

##### [Scenario 9: Performing a Switchover Operation](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/dgbkr/examples-using-data-guard-broker-DGMGRL-utility.html#GUID-1403D1C3-8944-42D0-8BDA-21D695C7958A)

```
SHOW DATABASE VERBOSE 'cdb1';
SHOW DATABASE 'cdb1_stby';
SHOW CONFIGURATION;
VALIDATE DATABASE 'cdb1';
VALIDATE DATABASE 'cdb1_stby';
SWITCHOVER TO 'cdb1_stby';
SHOW CONFIGURATION;
```

##### [Scenario 10: Performing a Manual Failover Operation](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/dgbkr/examples-using-data-guard-broker-DGMGRL-utility.html#GUID-630F5987-328C-410C-AE3B-A9D66EB233D4)

```
VALIDATE DATABASE 'cdb1';
VALIDATE DATABASE 'cdb1_stby';
CONNECT sysdg@cdb1_stby.example.com;
FAILOVER TO 'cdb1';
FAILOVER TO 'cdb1_stby';
SHOW CONFIGURATION;
SHOW DATABASE cdb1_stby;
SHOW DATABASE 'cdb1';
```

##### [Scenario 11: Reinstating a Failed Primary Database](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/dgbkr/examples-using-data-guard-broker-DGMGRL-utility.html#GUID-D46A9644-136B-4149-8C74-BF4E845B3DE3)

```
dgmgrl connect sysdg
SHUTDOWN IMMEDIATE;
STARTUP MOUNT;
REINSTATE DATABASE 'cdb1';
REINSTATE DATABASE 'cdb1_stby';
ALTER DATABASE OPEN;
SHOW CONFIGURATION;
SHOW DATABASE 'cdb1_stby';
SHOW DATABASE 'cdb1';
```

Following might be done on new primary

```
REINSTATE DATABASE 'cdb1';
```

enable Flashback Database by issuing the following statements on each database:

```
SELECT flashback_on FROM v$database;
SHUTDOWN IMMEDIATE;
STARTUP MOUNT;
ALTER DATABASE FLASHBACK ON;
ALTER DATABASE OPEN;
```

Recreate

```
echo "******************************************************************************"
echo "Create auxillary instance." `date`
echo "******************************************************************************"
sqlplus / as sysdba <<EOF
--SHUTDOWN IMMEDIATE;
STARTUP NOMOUNT PFILE='/tmp/init${ORACLE_SID}_stby.ora';
exit;
EOF


echo "******************************************************************************"
echo "Create standby database using RMAN duplicate." `date`
echo "******************************************************************************"
rman TARGET sys/${SYS_PASSWORD}@${NODE1_DB_UNIQUE_NAME} AUXILIARY sys/${SYS_PASSWORD}@${NODE2_DB_UNIQUE_NAME} <<EOF

DUPLICATE TARGET DATABASE
  FOR STANDBY
  FROM ACTIVE DATABASE
  DORECOVER
  SPFILE
    SET db_unique_name='${NODE2_DB_UNIQUE_NAME}' COMMENT 'Is standby'
  NOFILENAMECHECK;
  
exit;
EOF
```



```
echo "******************************************************************************"
echo "Configure broker (on primary) and display configuration." `date`
echo "******************************************************************************"
dgmgrl sys/${SYS_PASSWORD}@${NODE1_DB_UNIQUE_NAME} <<EOF
REMOVE CONFIGURATION;
CREATE CONFIGURATION my_dg_config AS PRIMARY DATABASE IS ${NODE1_DB_UNIQUE_NAME} CONNECT IDENTIFIER IS ${NODE1_DB_UNIQUE_NAME}${DB_DOMAIN_STR};
ADD DATABASE ${NODE2_DB_UNIQUE_NAME} AS CONNECT IDENTIFIER IS ${NODE2_DB_UNIQUE_NAME}${DB_DOMAIN_STR} MAINTAINED AS PHYSICAL;
ENABLE CONFIGURATION;
SHOW CONFIGURATION;
SHOW DATABASE ${NODE1_DB_UNIQUE_NAME};
SHOW DATABASE ${NODE2_DB_UNIQUE_NAME};
EXIT;
EOF
```

##### [Scenario 12: Converting a Physical Standby to a Snapshot Standby](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/dgbkr/examples-using-data-guard-broker-DGMGRL-utility.html#GUID-05313396-B80D-4F53-BB44-AC7B0FF5E8B4)

```
CONVERT DATABASE 'cdb1_stby' to snapshot standby;
SHOW CONFIGURATION;
CONVERT DATABASE 'cdb1_stby' to PHYSICAL STANDBY;
```

Might need to do following on standby first for converting it back to physical standby.

```
SHUTDOWN IMMEDIATE;
STARTUP MOUNT;
```

##### [Scenario 13: Monitoring a Data Guard Configuration](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/dgbkr/examples-using-data-guard-broker-DGMGRL-utility.html#GUID-13FDC86F-A736-44F0-A2DD-33B7FF3067A7)

```
SHOW CONFIGURATION;
SHOW DATABASE 'cdb1';
SHOW DATABASE 'cdb1_stby';
SHOW DATABASE 'cdb1' 'LogXptStatus';
SHOW DATABASE 'cdb1' 'InconsistentProperties';
EDIT DATABASE 'cdb1' SET PROPERTY 'LogArchiveTrace'=511;
SHOW DATABASE 'cdb1' 'InconsistentLogXptProps';
EDIT DATABASE 'cdb1_stby' SET PROPERTY 'ReopenSecs'=300;
```

##### [Scenario 14: Adding a Recovery Appliance to a Broker Configuration](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/dgbkr/examples-using-data-guard-broker-DGMGRL-utility.html#GUID-424D1C65-66EA-4286-B59C-A48D80B4587E)

```
ADD RECOVERY_APPLIANCE EnterpriseRecoveryAppliance AS CONNECT IDENTIFIER IS
EnterpriseRecoveryAppliance.example.com;
SHOW RECOVERY_APPLIANCE 'EnterpriseRecoveryAppliance';
ENABLE RECOVERY_APPLIANCE 'EnterpriseRecoveryAppliance';
SHOW RECOVERY_APPLIANCE 'EnterpriseRecoveryAppliance';
```

#### [Troubleshooting Oracle Data Guard](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/dgbkr/troubleshooting-oracle-data-guard-broker.html#GUID-CF46FC94-2F5B-40AA-89A6-8B8F2B124807)

##### [General Problems and Solutions](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/dgbkr/troubleshooting-oracle-data-guard-broker.html#GUID-0AED2023-2A96-4B7B-96A2-CE0942AC0144)

###### [ORA-16596: database not part of the Oracle Data Guard broker configuration](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/dgbkr/troubleshooting-oracle-data-guard-broker.html#GUID-17E8BAEE-3D30-4A49-9869-C3D13180C709)

###### [Redo Accumulating on the Primary Is Not Sent to Some Standby Databases](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/dgbkr/troubleshooting-oracle-data-guard-broker.html#GUID-203CF4DA-A3D3-4BB3-A840-64D61CE2862B)

```
SHOW CONFIGURATION;
SHOW DATABASE cdb1;
SHOW DATABASE cdb1_stby;
SHOW DATABASE cdb1_stby 'LogShipping';
SHOW DATABASE cdb1 'LogXptStatus';
```

###### [Many Log Files Are Received on a Standby Database But Not Applied](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/dgbkr/troubleshooting-oracle-data-guard-broker.html#GUID-87B880E0-EA12-4C6A-8640-0EF39EF0C378)

```
SHOW DATABASE cdb1;
SHOW DATABASE cdb1_stby;
SHOW DATABASE cdb1 'DelayMins';
SHOW DATABASE cdb1_stby 'DelayMins';
```

###### [The Request Timed Out or Cloud Control Performance Is Sluggish](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/dgbkr/troubleshooting-oracle-data-guard-broker.html#GUID-3C04CB40-B5E3-4952-BD2D-C953CE1FCC57)

###### [The Primary Database is Flashed Back](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/dgbkr/troubleshooting-oracle-data-guard-broker.html#GUID-AE89C1C3-F896-4526-A0EA-372301DAF5C4)

###### [Standby Fails to Automatically Start Up Due to Unknown Service (ORA-12514)](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/dgbkr/troubleshooting-oracle-data-guard-broker.html#GUID-AC5641FD-20E9-411C-A9D2-5F2EA384325E)

```
SHOW INSTANCE VERBOSE 'cdb1' ON DATABASE cdb1;
lsnrctl status
```

##### [Troubleshooting Problems During a Switchover Operation](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/dgbkr/troubleshooting-oracle-data-guard-broker.html#GUID-E417A951-84C5-4693-9136-8480FB8B1876)

##### [Troubleshooting Problems During a Failover Operation](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/dgbkr/troubleshooting-oracle-data-guard-broker.html#GUID-0BA77759-4B36-42FA-BEE1-BE132ED88ACE)

### [Data Guard Concepts and Administration](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/sbydb/index.html)

#### [Part I Concepts and Administration](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/sbydb/oracle-data-guard-concepts.html#GUID-F78703FB-BD74-4F20-9971-8B37ACC40A65)

##### [Creating a Physical Standby Database](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/sbydb/creating-oracle-data-guard-physical-standby.html#GUID-B511FB6E-E3E7-436D-94B5-071C37550170)

##### [Managing Physical and Snapshot Standby Databases](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/sbydb/managing-oracle-data-guard-physical-standby-databases.html#GUID-B140C38B-DE01-4252-8422-7154018DDFEC)

###### [Starting Up and Shutting Down a Physical Standby Database](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/sbydb/managing-oracle-data-guard-physical-standby-databases.html#GUID-D7026A24-78EF-4C0D-84E5-41D767516565)

###### [Opening a Physical Standby Database](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/sbydb/managing-oracle-data-guard-physical-standby-databases.html#GUID-D5FB88EC-799D-40E7-80E1-19474E3167E4)

[Real-time Query](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/sbydb/managing-oracle-data-guard-physical-standby-databases.html#GUID-07CB190C-C248-4FF5-AB64-EAA9C6D42677)

Use the following SQL statements to stop Redo Apply, open a standby instance read-only, and restart Redo Apply:

```
SQL> ALTER DATABASE RECOVER MANAGED STANDBY DATABASE CANCEL;
SQL> ALTER DATABASE OPEN;
SQL> ALTER DATABASE RECOVER MANAGED STANDBY DATABASE DISCONNECT;
```

**Example: Querying V$DATABASE to Check the Standby's Open Mode**

```
SQL> SELECT open_mode FROM V$DATABASE;
 
OPEN_MODE
--------------------
READ ONLY
```



```
SQL> ALTER DATABASE RECOVER MANAGED STANDBY DATABASE DISCONNECT;
 
Database altered.
```



```
SQL> SELECT open_mode FROM V$DATABASE;
 
OPEN_MODE
--------------------
READ ONLY WITH APPLY
```

[Monitoring Apply Lag in a Real-time Query Environment](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/sbydb/managing-oracle-data-guard-physical-standby-databases.html#GUID-C225DCBC-E9FB-4E86-9D19-A5D20C3A8AA5)

```
SQL> SELECT name, value, datum_time, time_computed FROM V$DATAGUARD_STATS
WHERE name like 'apply lag';
     
    NAME         VALUE            DATUM_TIME              TIME_COMPUTED
    ---------    -------------    -------------------     -------------------
    apply lag    +00 00:00:00     05/27/2009 08:54:16     05/27/2009 08:54:17
```

#### [Part II Reference](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/sbydb/oracle-data-guard-parameters-views.html#GUID-626518B4-BF38-4D93-A543-457D55CA5B75)

##### [LOG_ARCHIVE_DEST_n Parameter Attributes](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/sbydb/LOG_ARCHIVE_DEST_n-parameter-attributes.html#GUID-B04FC22C-F0B0-440F-BAF4-182EE547FCC1)

###### [AFFIRM and NOAFFIRM](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/sbydb/LOG_ARCHIVE_DEST_n-parameter-attributes.html#GUID-559248E6-B153-4B7B-A8A9-9CEE102088F0)

###### [COMPRESSION](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/sbydb/LOG_ARCHIVE_DEST_n-parameter-attributes.html#GUID-DD58C7C2-EE9D-4632-94C9-F6C652718006)

###### [DELAY](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/sbydb/LOG_ARCHIVE_DEST_n-parameter-attributes.html#GUID-C014D9BB-79D3-4E49-9477-A5CBF0E88167)

###### [LOCATION and SERVICE](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/sbydb/LOG_ARCHIVE_DEST_n-parameter-attributes.html#GUID-9ACDEC6C-C2E0-4EDA-B66D-B1F819D3368D)

###### [MANDATORY](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/sbydb/LOG_ARCHIVE_DEST_n-parameter-attributes.html#GUID-C4AD4812-D4A6-41C9-8F03-4C87B64F1D4D)

###### [MAX_CONNECTIONS](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/sbydb/LOG_ARCHIVE_DEST_n-parameter-attributes.html#GUID-12412B5D-E454-4A2D-942C-7FD8DD71B0DB)

###### [MAX_FAILURE](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/sbydb/LOG_ARCHIVE_DEST_n-parameter-attributes.html#GUID-3655C0B5-E669-4475-95B9-01A67AE6A144)

###### [NET_TIMEOUT](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/sbydb/LOG_ARCHIVE_DEST_n-parameter-attributes.html#GUID-5067F60F-780E-429E-A0FB-CB121B8DF321)

###### [SYNC and ASYNC](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/sbydb/LOG_ARCHIVE_DEST_n-parameter-attributes.html#GUID-E3626025-2E4C-4C61-B5DF-2BB106F0A349)

###### [VALID_FOR](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/sbydb/LOG_ARCHIVE_DEST_n-parameter-attributes.html#GUID-2E1845CC-B3CA-4409-BACB-6AB40D6D42E5)

# [Data Warehousing](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/data-warehousing.html)

## [VLDB and Partitioning Guide](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/vldbg/index.html)

### [Partitioning Concepts](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/vldbg/partition-concepts.html#GUID-EA7EF5CB-DD49-43AF-889A-F83AAC0D7D51)

#### [Partitioning Extensions](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/vldbg/partition-concepts.html#GUID-90E4C4FC-A021-4AF9-AEAA-02CA4435C9B4)

##### [Manageability Extensions](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/vldbg/partition-concepts.html#GUID-35E4BFBA-B4FE-4A7A-8BFA-AAFDB1C14F60)

###### [Interval Partitioning](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/vldbg/partition-concepts.html#GUID-C121EA1B-2725-4464-B2C9-EEDE0C3C95AB)

Interval partitioning is an extension of range partitioning .

You must specify at least one range partition.

External reading:

[**Oracle Interval Partitioning Tips**](http://www.dba-oracle.com/t_interval_partitioning.htm)

```
SELECT * FROM pos_data PARTITION (SYS_P81);
SELECT * FROM pos_data PARTITION FOR (to_date('15-AUG-2007','dd-mon-yyyy'));
```

# [Distributed Data ](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/distributed-data.html)

## Heterogeneous Connectivity

### [Database Gateway for  APPC Installation and Configuration Guide for AIX 5L Based Systems  (64-Bit), HP-UX Itanium, Solaris Operating System (SPARC 64-Bit), Linux  x86, and Linux x86-64](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/appci/index.html)

In [computing](https://en.wikipedia.org/wiki/Computing), **Advanced Program to Program Communication** or **APPC** is a [protocol](https://en.wikipedia.org/wiki/Protocol_(computing)) which [computer programs](https://en.wikipedia.org/wiki/Computer_program) can use to communicate over a [network](https://en.wikipedia.org/wiki/Computer_network). Refer to [wikipedia](https://en.wikipedia.org/wiki/IBM_Advanced_Program-to-Program_Communication).

