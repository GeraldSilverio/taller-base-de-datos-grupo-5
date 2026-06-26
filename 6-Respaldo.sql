USE master;
GO

BACKUP DATABASE TiendaOnlineDb
TO DISK = 'C:\SQLBackups\TiendaOnlineDb_BackupCompleto.bak'
WITH 
    FORMAT,
    INIT,
    NAME = 'Respaldo Completo - TiendaOnlineDb',
    DESCRIPTION = 'Backup completo de la base de datos TiendaOnlineDb para proyecto final',
    CHECKSUM,
    STATS = 10;
GO