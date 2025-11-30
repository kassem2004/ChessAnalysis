import pandas as pd
from sqlalchemy import create_engine
from config import DB_USERNAME, DB_PASSWORD, DB_NAME

df = pd.read_csv("data_raw/games_raw.csv")

df = df.rename(columns={
    "id": "lichess_id",
    "white_id": "white_name",
    "black_id": "black_name",
    "white_rating": "white_elo",
    "black_rating": "black_elo",
    "winner": "result",
    "opening_name": "opening",
    "opening_eco": "eco_code",
    "opening_ply": "opening_moves",
    "increment_code": "time_control",
    "moves": "moves",
    "victory_status": "ending_type",
    "created_at": "game_start",
    "last_move_at": "game_end"
})

# Keep Ranked games only
df = df[df['rated'] == True]

df["game_start"] = pd.to_datetime(df["game_start"], unit="ms", errors="coerce")
df["game_end"]   = pd.to_datetime(df["game_end"], unit="ms", errors="coerce")

df = df.drop_duplicates(subset=["lichess_id"])

if "index" in df.columns:
    df = df.drop(columns=["index"])

engine = create_engine(f'postgresql+psycopg2://{DB_USERNAME}:{DB_PASSWORD}@localhost:5432/{DB_NAME}')

df.to_sql("games", engine, if_exists="append", index=False)