--Find log name
sp_helpdb transearch

--AT THIS POINT STOP 2 REPLICATION AGENTS - (LOG READER & DISTRIBUTION AGENT)

--Set new log location 
ALTER DATABASE Transearch
MODIFY FILE (NAME = Transearch_83_LS_Cov_log, 
             FILENAME = 'F:\TransactionLogs\Transearch_Log\Transearch_1.ldf'); -- the new name

--Take database offline
ALTER DATABASE Transearch SET OFFLINE

--MANUALLY MOVE LOG FILE TO NEW LOCATION IN WINDOWS EXPLORER

--Bring database online
ALTER DATABASE Transearch SET ONLINE