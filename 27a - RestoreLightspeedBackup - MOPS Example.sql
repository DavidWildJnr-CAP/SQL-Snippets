exec master.dbo.xp_restore_database
@database = 'MOPS',
@filename = 'c:\mops_FULL_20161005_230334.bak', --> POINT TO YOUR BACKUP FILE
@with = 'move "metrofiledevData" to "D:\MSSQL\DATA\Mops_Recovery\metrofiledevData.mdf"',
@with = 'move "metrofiledevData2" to "D:\MSSQL\DATA\Mops_Recovery\metrofiledevData2.ndf"',
@with = 'move "metrofileindx" to "D:\MSSQL\DATA\Mops_Recovery\metrofileindx.ndf"',
@with = 'move "metrofileindx2" to "D:\MSSQL\DATA\Mops_Recovery\metrofileindx2.ndf"',
@with = 'move "metrofilelog" to "D:\MSSQL\DATA\Mops_Recovery\metrofilelog.ldf"',
@with = 'stats = 1',
@with = 'replace'
