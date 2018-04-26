SELECT P.Name, COUNT(G.Game_id)
    FROM Player AS P
    JOIN Players_of_game AS PG ON P.FIFA_ID = PG.FIFA_ID
    JOIN Game AS G on PG.Game = G.Game_ID
    WHERE P.Team_id = G.Winner AND P.Name = ?