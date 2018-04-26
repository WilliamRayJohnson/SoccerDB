SELECT wins.total_wins, loses.total_loses
    FROM (
        SELECT t.team_id, COUNT(g.Game_id) AS total_wins
            FROM Team t
            JOIN Game g ON t.Team_id = g.Winner
            JOIN Coach_of_game cog ON cog.Game_id = g.Game_id
            JOIN Coach c ON cog.Coach_id = c.Coach_id
            GROUP BY cog.Coach_id
            HAVING t.Name = ? AND c.Name = ?
        ) AS wins
    JOIN (
        SELECT t.Team_id, COUNT(g.Game_id) AS total_loses
            FROM Team t
            JOIN Game g ON t.Team_id = g.Loser
            JOIN Coach_of_game cog ON cog.Game_id = g.Game_id
            JOIN Coach c ON cog.Coach_id = c.Coach_id
            GROUP BY cog.Coach_id
            HAVING t.Name = ? AND c.Name = ?
        ) AS loses ON wins.Team_id = loses.Team_id