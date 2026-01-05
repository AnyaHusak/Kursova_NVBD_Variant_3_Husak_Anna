CREATE DATABASE ConferenceDB;
GO

USE ConferenceDB;
GO

CREATE TABLE AcademicDegrees (
    DegreeID INT IDENTITY(1,1) PRIMARY KEY,
    DegreeName NVARCHAR(50) NOT NULL UNIQUE 
);

CREATE TABLE Equipment (
    EquipmentID INT IDENTITY(1,1) PRIMARY KEY,
    EquipmentName NVARCHAR(100) NOT NULL,
    Description NVARCHAR(255) NULL
);

CREATE TABLE Rooms (
    RoomID INT IDENTITY(1,1) PRIMARY KEY,
    RoomName NVARCHAR(50) NOT NULL, 
    Capacity INT NOT NULL CHECK (Capacity > 0), 
    Building NVARCHAR(100) NULL 
);


CREATE TABLE Speakers (
    SpeakerID INT IDENTITY(1,1) PRIMARY KEY,
    FirstName NVARCHAR(50) NOT NULL,
    LastName NVARCHAR(50) NOT NULL,
    Email NVARCHAR(100) NULL,
    Workplace NVARCHAR(100) NULL, 
    Country NVARCHAR(50) NULL,
    DegreeID INT NOT NULL, 
    CONSTRAINT FK_Speakers_Degrees FOREIGN KEY (DegreeID) REFERENCES AcademicDegrees(DegreeID)
);


CREATE TABLE Conferences (
    ConferenceID INT IDENTITY(1,1) PRIMARY KEY,
    Title NVARCHAR(200) NOT NULL,
    StartDate DATE NOT NULL,
    EndDate DATE NOT NULL,
    LocationCity NVARCHAR(100) NOT NULL, 
    Description NVARCHAR(MAX) NULL,
    CONSTRAINT CK_Conference_Dates CHECK (EndDate >= StartDate) 
);


CREATE TABLE Sections (
    SectionID INT IDENTITY(1,1) PRIMARY KEY,
    ConferenceID INT NOT NULL,
    Name NVARCHAR(150) NOT NULL,
    RoomID INT NOT NULL, 
    CONSTRAINT FK_Sections_Conferences FOREIGN KEY (ConferenceID) REFERENCES Conferences(ConferenceID),
    CONSTRAINT FK_Sections_Rooms FOREIGN KEY (RoomID) REFERENCES Rooms(RoomID)
);


CREATE TABLE Speeches (
    SpeechID INT IDENTITY(1,1) PRIMARY KEY,
    SectionID INT NOT NULL,
    SpeakerID INT NOT NULL,
    Title NVARCHAR(200) NOT NULL, 
    StartTime DATETIME NOT NULL,  
    DurationMinutes INT NOT NULL DEFAULT 45, 
    Abstract NVARCHAR(MAX) NULL,  
    CONSTRAINT FK_Speeches_Sections FOREIGN KEY (SectionID) REFERENCES Sections(SectionID),
    CONSTRAINT FK_Speeches_Speakers FOREIGN KEY (SpeakerID) REFERENCES Speakers(SpeakerID)
);


CREATE TABLE SpeechEquipment (
    SpeechID INT NOT NULL,
    EquipmentID INT NOT NULL,
    Quantity INT NOT NULL DEFAULT 1 CHECK (Quantity > 0),
    PRIMARY KEY (SpeechID, EquipmentID), 
    CONSTRAINT FK_SpeechEquip_Speeches FOREIGN KEY (SpeechID) REFERENCES Speeches(SpeechID),
    CONSTRAINT FK_SpeechEquip_Equipment FOREIGN KEY (EquipmentID) REFERENCES Equipment(EquipmentID)
);
GO