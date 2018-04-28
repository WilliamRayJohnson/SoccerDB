CREATE PROCEDURE `insert_host_win` (IN id VARCHAR(45), IN hScore INT, IN gScore INT)
BEGIN
    INSERT INTO `game` (`Game_ID`, `Host_team`, `Guest_team`, `Date`, `H_score`, `G_score`, `Stadium_ID`, `Winner`, `Loser`)
    SELECT id, ht.Team_ID, gt.Team_ID, CURRENT_TIMESTAMP - INTERVAL FLOOR(RAND() * 1460) DAY, hScore, gScore, s.Stadium_ID, ht.Team_ID, gt.Team_ID
        FROM team ht
        CROSS JOIN team gt
        JOIN stadium s ON s.Team_ID = ht.Team_ID
        WHERE ht.Team_ID != gt.Team_ID
        ORDER BY RAND()
        LIMIT 1;
END
