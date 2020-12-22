    SELECT  'ALTER DATABASE ' + QUOTENAME(name) + ' SET AUTO_SHRINK OFF WITH NO_WAIT;' AS [To Execute]
    FROM    sys.databases
    WHERE   is_auto_shrink_on = 1;


	SELECT  'ALTER DATABASE ' + QUOTENAME(name) + ' SET AUTO_CLOSE OFF WITH NO_WAIT;' AS [To Execute]
    FROM    sys.databases
    WHERE   is_auto_close_on = 1;


	ALTER DATABASE [INVOICES-INVOICESTEST] SET AUTO_CLOSE OFF WITH NO_WAIT;