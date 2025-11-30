SELECT opening,
       COUNT(*) AS games_played,
       ROUND(
         SUM(CASE WHEN result = 'white' THEN 1 ELSE 0 END) * 100.0 / COUNT(*),
         2
       ) AS white_win_pct
FROM games
GROUP BY opening
HAVING COUNT(*) >= 50
ORDER BY white_win_pct DESC;

SELECT
	COUNT(*) AS games_played,
    ABS(white_elo - black_elo) AS rating_diff,
    ROUND(AVG(CASE WHEN result = 'white' THEN 1 ELSE 0 END), 2) AS white_win_rate
FROM games
GROUP BY rating_diff
HAVING COUNT(*) >= 50
ORDER BY rating_diff;

SELECT
	opening,
	COUNT (*) AS games_played,
	ROUND(SUM(CASE WHEN result = 'white' THEN 1 ELSE 0 END) * 100.0 / COUNT(*),
	2
	) AS white_win_pct
FROM games
WHERE black_elo > 1500 AND white_elo > 1500
GROUP BY opening
HAVING COUNT(*) >= 50
ORDER BY white_win_pct DESC;