SELECT T.Name, MAX(Wins.Wins)
    FROM (SELECT T.Name, COUNT(G.Winner) AS WINS
            FROM (Team T JOIN Game G ON T.Team_ID = G.Winner)
            GROUP BY T.Team_id, G.Stadium_ID) AS wins