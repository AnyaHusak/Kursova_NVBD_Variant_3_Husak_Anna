USE ConferenceDW;
GO

DECLARE @StartDate DATE = '2014-01-01';
DECLARE @EndDate DATE = '2025-12-31';

WHILE @StartDate <= @EndDate
BEGIN
    INSERT INTO DimDate (
        DateKey, FullDate, Year, Month, MonthName, 
        Day, DayOfWeek, DayName, Quarter, IsWeekend
    )
    SELECT 
        CAST(CONVERT(VARCHAR(8), @StartDate, 112) AS INT),
        @StartDate,
        YEAR(@StartDate),
        MONTH(@StartDate),
        DATENAME(MONTH, @StartDate),
        DAY(@StartDate),
        DATEPART(DW, @StartDate),
        DATENAME(DW, @StartDate),
        DATEPART(QUARTER, @StartDate),
        CASE WHEN DATEPART(DW, @StartDate) IN (1, 7) THEN 1 ELSE 0 END;

    SET @StartDate = DATEADD(dd, 1, @StartDate);
END;
GO