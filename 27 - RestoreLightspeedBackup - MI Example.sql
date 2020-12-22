exec master.dbo.xp_restore_database
@database = 'MI',
@filename = 'c:\DWPPRHWSQL01_MI_FULL_20141209_195701.bak',
@with = 'move "MI_Data" to "D:\MSSQL\DATA\MI\MI_Data.mdf"',
@with = 'move "MI_Log" to "D:\MSSQL\DATA\MI\MI_Log.ldf"'