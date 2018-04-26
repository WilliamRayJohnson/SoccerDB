SELECT MONTH(cti.game_date), YEAR(cti.game_date), AVG(cti.total_injuries)
    FROM (
        SELECT ti.game_date, COUNT(ti.injury) AS total_injuries
            FROM(
                SELECT t.name AS team_name, i.Injury, g.date AS game_date
                    FROM player p
                    JOIN team t ON p.team_id = t.team_id
                    JOIN injury i ON p.FIFA_id = i.FIFA_id
                    JOIN game g ON t.team_id = g.host_team
                UNION
                SELECT t.name AS team_name, i.injury, g.date AS game_date
                    FROM player p
                    JOIN team t ON p.team_id = t.team_id
                    JOIN injury i ON p.FIFA_id = i.FIFA_id
                    JOIN game g ON t.team_id = g.guest_team
                ) AS ti
            GROUP BY ti.game_date
            HAVING ti.team_name = ?
        ) AS cti
    GROUP BY MONTH(cti.game_date), YEAR(cti.game_date)