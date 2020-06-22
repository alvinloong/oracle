# [Administration](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/administration.html)

# [High Availability](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/high-availability.html)

## Backup and Recovery

### [Database Backup and Recovery Reference](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/rcmrf/index.html)

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



#### [Part III Backing Up and Archiving Data](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/bradv/part-backing-up-archiving.html#GUID-008E0F84-E623-4467-8706-A99B34002DD6)

##### [RMAN Backup Concepts](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/bradv/rman-backup-concepts.html#GUID-B3380142-ABCD-437F-9E06-B219D74E6738)



#### [Part IV Managing RMAN Backups](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/bradv/part-managing-rman-backups.html#GUID-9B9779FA-2C8B-4D11-AC3B-F6FFA95AE2D1)

##### [Deleting RMAN Backups and Archived Redo Logs](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/bradv/maintaining-rman-backups.html#GUID-8C4B395D-7C24-485F-BEA0-A355821FB93D)

###### [Deleting All Backups and Copies](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/bradv/maintaining-rman-backups.html#GUID-0F82F489-C5FB-41C2-9687-AE9A5CD89406)

```
CROSSCHECK BACKUP;
CROSSCHECK COPY;
DELETE BACKUP;
DELETE COPY;
```

###### [Deleting Specified Backups and Copies](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/bradv/maintaining-rman-backups.html#GUID-D39FCF70-C71B-46C7-8ED5-94CF33A5611D)

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
select flashback_on from v$database;
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

