-- Create Database
CREATE DATABASE WorldPopulationAnalytics;
GO

USE WorldPopulationAnalytics;
GO

--------------------------------------------------
-- Create Population Table
--------------------------------------------------
CREATE TABLE world_population (
    country_name VARCHAR(100),
    continent VARCHAR(50),
    population BIGINT,
    year INT
);

--------------------------------------------------
-- Insert Population Data
--------------------------------------------------
INSERT INTO world_population (country_name, continent, population, year)
VALUES
('China', 'Asia', 1412000000, 2022),
('India', 'Asia', 1408000000, 2022),
('United States', 'North America', 334000000, 2022),
('Indonesia', 'Asia', 276000000, 2022),
('Pakistan', 'Asia', 231000000, 2022),
('Brazil', 'South America', 214000000, 2022),
('Nigeria', 'Africa', 218000000, 2022),
('Bangladesh', 'Asia', 171000000, 2022),
('Russia', 'Europe', 146000000, 2022),
('Mexico', 'North America', 127000000, 2022),

('China', 'Asia', 1393000000, 2015),
('India', 'Asia', 1311000000, 2015),
('United States', 'North America', 321000000, 2015),
('Indonesia', 'Asia', 258000000, 2015),
('Brazil', 'South America', 204000000, 2015),
('Nigeria', 'Africa', 182000000, 2015),
('Pakistan', 'Asia', 199000000, 2015),
('Bangladesh', 'Asia', 161000000, 2015),
('Russia', 'Europe', 144000000, 2015),
('Mexico', 'North America', 121000000, 2015);
