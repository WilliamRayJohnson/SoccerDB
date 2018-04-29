SELECT t.name, i.injury, COUNT(i.FIFA_id)
    FROM player p
    JOIN team t ON p.team_id = t.team_id
    JOIN injury i ON p.FIFA_id = i.FIFA_id
    GROUP BY t.name, i.Injury