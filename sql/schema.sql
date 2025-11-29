-- sql/schema.sql
DROP TABLE IF EXISTS games;

CREATE TABLE games (
    game_id        SERIAL PRIMARY KEY,
    lichess_id     TEXT UNIQUE,          
    rated          BOOLEAN,
    game_start     TIMESTAMPTZ,
    game_end       TIMESTAMPTZ,
    turns          INT,
    ending_type    TEXT,                
    result         VARCHAR(10),          
    time_control   TEXT,
    white_name     TEXT,
    black_name     TEXT,
    white_elo      INT,
    black_elo      INT,
    moves          TEXT,
    eco_code       VARCHAR(10),
    opening        TEXT,
    opening_moves  INT
);