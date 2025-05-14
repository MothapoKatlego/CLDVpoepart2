USE master;
IF EXISTS (SELECT * FROM sys.databases WHERE name = 'VenueManagerDB') 
    DROP DATABASE VenueManagerDB;
GO

CREATE DATABASE VenueManagerDB;
GO

USE VenueManagerDB;
GO

-- Create Venues table
CREATE TABLE Venues ( 
    VenueID INT PRIMARY KEY,
    VenueName VARCHAR(250) NOT NULL,
    VenueAddress VARCHAR(250) NOT NULL,
    Capacity INT NOT NULL,
    ImageURL VARCHAR(500)
);

-- Create Events table
CREATE TABLE Events ( 
    EventID INT PRIMARY KEY,
    EventTitle VARCHAR(250) NOT NULL,
    EventDate DATETIME NOT NULL,
    Description TEXT,
    VenueID INT NULL,
    FOREIGN KEY (VenueID) REFERENCES Venues(VenueID)
); 

-- Create Bookings table
CREATE TABLE Bookings (
    BookingID INT PRIMARY KEY,
    EventID INT NOT NULL,
    VenueID INT NOT NULL,
    BookingTimestamp DATETIME NOT NULL DEFAULT GETDATE(),
    FOREIGN KEY (EventID) REFERENCES Events(EventID),
    FOREIGN KEY (VenueID) REFERENCES Venues(VenueID),
    CONSTRAINT UQ_Booking UNIQUE (EventID, VenueID)
);

-- Insert sample data into Venues
INSERT INTO Venues (VenueID, VenueName, VenueAddress, Capacity, ImageURL)
VALUES 
(1, 'Oceanview Terrace', '21 Wave Blvd, Seaside', 150, 'http://sample.com/oceanview.jpg'),
(2, 'Aurora Hall', '88 Northern Lights Ave, Frostburg', 400, 'http://sample.com/aurora.jpg'),
(3, 'Green Garden Pavilion', '55 Leafy Lane, Greentown', 250, 'http://sample.com/garden.jpg');

-- Insert sample data into Events
INSERT INTO Events (EventID, EventTitle, EventDate, Description, VenueID)
VALUES 
(201, 'Sunset Soirée', '2025-09-05 18:00:00', 'An elegant evening with music and cocktails.', 1),
(202, 'Innovation Expo', '2025-10-12 10:00:00', 'Tech demos and startup presentations.', 2),
(203, 'Autumn Wedding', '2025-11-01 15:00:00', 'The celebration of Emily & David’s union.', 3);

-- Insert sample data into Bookings
INSERT INTO Bookings (BookingID, EventID, VenueID, BookingTimestamp)
VALUES 
(3001, 201, 1, GETDATE()),
(3002, 202, 2, GETDATE()),
(3003, 203, 3, GETDATE());

-- View all inserted records
SELECT * FROM Venues;
SELECT * FROM Events;
SELECT * FROM Bookings;
