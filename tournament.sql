-- Clear out any previous tournament databases.

DROP DATABASE IF EXISTS tournament;

-- Create database.

CREATE DATABASE tournament;

-- Connect to the DB before creating tables.

\c tournament;

-- Create table for players.

CREATE TABLE players (id serial primary key, name text);

-- Create table for games.

CREATE TABLE matches(
game_id serial primary key, 
winner integer references players(id), 
loser integer references players(id), 
PRIMARY KEY (winner, loser)
);

-- Create view to count total matches per player.

CREATE VIEW standings AS

SELECT players.id, players.name, 

COUNT(matches.*) AS games
FROM players LEFT JOIN games
ON players.id = games.winner OR 
players.id = games.loser

GROUP BY players.id;
