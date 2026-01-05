USE ConferenceDB;
GO

CREATE NONCLUSTERED INDEX IX_Speeches_StartTime 
ON Speeches(StartTime);

CREATE NONCLUSTERED INDEX IX_Sections_ConferenceID 
ON Sections(ConferenceID);

CREATE NONCLUSTERED INDEX IX_Speakers_LastName 
ON Speakers(LastName);
GO

CREATE OR ALTER PROCEDURE sp_AddSpeaker
    @FirstName NVARCHAR(50),
    @LastName NVARCHAR(50),
    @DegreeID INT,
    @Country NVARCHAR(50)
AS
BEGIN
    INSERT INTO Speakers (FirstName, LastName, DegreeID, Country)
    VALUES (@FirstName, @LastName, @DegreeID, @Country);
    
    PRINT 'Спікера успішно додано ID: ' + CAST(SCOPE_IDENTITY() AS NVARCHAR(20));
END;
GO

CREATE OR ALTER TRIGGER trg_PreventConferenceDelete
ON Conferences
FOR DELETE
AS
BEGIN
    IF EXISTS (SELECT * FROM deleted WHERE StartDate < GETDATE())
    BEGIN
        RAISERROR ('Неможливо видалити конференцію, яка вже відбулася або триває! Це порушує історію.', 16, 1);
        ROLLBACK TRANSACTION;
    END
END;
GO