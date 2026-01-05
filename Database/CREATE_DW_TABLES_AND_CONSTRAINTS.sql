CREATE DATABASE ConferenceDW;

GO



USE ConferenceDW;

GO

CREATE TABLE DimDate (
    DateKey INT PRIMARY KEY,        -- Формат YYYYMMDD (напр. 20240101)
    FullDate DATE NOT NULL,
    Year INT,
    Month INT,
    MonthName NVARCHAR(20),
    Day INT,
    DayOfWeek INT,
    DayName NVARCHAR(20),
    Quarter INT,
    IsWeekend BIT                   -- 1 якщо вихідний
);



CREATE TABLE DimSpeakers (
    SpeakerKey INT IDENTITY(1,1) PRIMARY KEY,
    SpeakerOriginalID INT,          -- ID з оригінальної бази
    FullName NVARCHAR(150),
    AcademicDegree NVARCHAR(50),    -- Сюди підтягнемо назву ступеня
    Country NVARCHAR(50),
    Email NVARCHAR(100),
    RowEffectiveDate DATETIME DEFAULT GETDATE(), -- Для SCD (історія змін)
    RowExpirationDate DATETIME NULL,
    IsCurrent BIT DEFAULT 1
);


CREATE TABLE DimConferences (
    ConferenceKey INT IDENTITY(1,1) PRIMARY KEY,
    ConferenceOriginalID INT,
    Title NVARCHAR(200),
    LocationCity NVARCHAR(100),
    Description NVARCHAR(MAX)
);
-- Вимір Обладнання
CREATE TABLE DimEquipment (
    EquipmentKey INT IDENTITY(1,1) PRIMARY KEY,
    EquipmentOriginalID INT,
    EquipmentName NVARCHAR(100),
    Type NVARCHAR(50) DEFAULT 'General' -- Додаткове поле для звіту
);
-- Вимір Приміщень
CREATE TABLE DimRooms (
    RoomKey INT IDENTITY(1,1) PRIMARY KEY,
    RoomOriginalID INT,
    RoomName NVARCHAR(50),
    Building NVARCHAR(100),
    CapacityBucket NVARCHAR(20) -- Напр: "Мала", "Середня", "Велика"
);
/* 3. Створюємо Таблиці Фактів (Facts) */
-- Факт 1: Виступи (Аналіз тривалості та кількості)
CREATE TABLE FactSpeeches (
    FactSpeechID INT IDENTITY(1,1) PRIMARY KEY,
    DateKey INT NOT NULL,           -- Зв'язок з часом
    SpeakerKey INT NOT NULL,        -- Хто виступав
    ConferenceKey INT NOT NULL,     -- Де виступав
    RoomKey INT NOT NULL,           -- В якій кімнаті
    DurationMinutes INT,            -- Міра: тривалість
    SpeechCount INT DEFAULT 1,      -- Міра: кількість (завжди 1)
  

    -- Зовнішні ключі
    CONSTRAINT FK_FactSpeeches_Date FOREIGN KEY (DateKey) REFERENCES DimDate(DateKey),
    CONSTRAINT FK_FactSpeeches_Speaker FOREIGN KEY (SpeakerKey) REFERENCES DimSpeakers(SpeakerKey),
    CONSTRAINT FK_FactSpeeches_Conference FOREIGN KEY (ConferenceKey) REFERENCES DimConferences(ConferenceKey),
    CONSTRAINT FK_FactSpeeches_Room FOREIGN KEY (RoomKey) REFERENCES DimRooms(RoomKey)
);
-- Факт 2: Використання обладнання (Аналіз ресурсів)
CREATE TABLE FactEquipmentUsage (
    FactUsageID INT IDENTITY(1,1) PRIMARY KEY,
    DateKey INT NOT NULL,
    EquipmentKey INT NOT NULL,
    ConferenceKey INT NOT NULL,
    QuantityUsed INT,               -- Міра: скільки штук взяли
    

    CONSTRAINT FK_FactEquip_Date FOREIGN KEY (DateKey) REFERENCES DimDate(DateKey),
    CONSTRAINT FK_FactEquip_Equip FOREIGN KEY (EquipmentKey) REFERENCES DimEquipment(EquipmentKey),
    CONSTRAINT FK_FactEquip_Conf FOREIGN KEY (ConferenceKey) REFERENCES DimConferences(ConferenceKey)
);

GO