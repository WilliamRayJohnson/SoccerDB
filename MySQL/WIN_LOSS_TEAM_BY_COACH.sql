SELECT wins.total_wins, loses.total_loses
    FROM (
        SELECT t.team_id, COUNT(g.Game_id) AS total_wins
            FROM team t
            JOIN game g ON t.Team_id = g.Winner
            JOIN coach_of_game cog ON cog.Game_id = g.Game_id
            JOIN coach c ON cog.Coach_id = c.Coach_id
            GROUP BY cog.Coach_id
            HAVING t.Name = ? AND c.Name = ?
        ) AS wins
    JOIN (
        SELECT t.Team_id, COUNT(g.Game_id) AS total_loses
            FROM team t
            JOIN game g ON t.Team_id = g.Loser
            JOIN coach_of_game cog ON cog.Game_id = g.Game_id
            JOIN coach c ON cog.Coach_id = c.Coach_id
            GROUP BY cog.Coach_id
            HAVING t.Name = ? AND c.Name = ?
        ) AS loses ON wins.Team_id = loses.Team_id