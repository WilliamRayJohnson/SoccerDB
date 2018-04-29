SELECT teamWins.Name, MAX(teamWins.totalWins)
    FROM (SELECT T.Name, COUNT(G.Winner) AS totalWins
                FROM team T
                JOIN game G ON T.Team_ID = G.Winner
                GROUP BY T.Team_id, G.Stadium_ID) AS teamWins