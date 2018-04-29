CREATE PROCEDURE `insert_injuries` (IN count INT, IN maxGames INT)
BEGIN
    DECLARE injuryi INT DEFAULT 0;
    SET injuryi = 0;

    injury_loop: LOOP
        IF injuryi >= count THEN
            LEAVE injury_loop;
        END IF;
        INSERT INTO `injury` (`FIFA_ID`, `Injury`, `Game_ID`, `Time`)
                SELECT pog.FIFA_ID, "hurt", pog.Game_ID, g.Date
                    FROM (
                        SELECT *
                            FROM game
                            WHERE Game_ID = CAST(FLOOR(RAND() * maxGames) AS CHAR(45))
                            LIMIT 1
                        ) AS g
                    JOIN players_of_game pog ON pog.Game_ID = g.Game_ID
                    ORDER BY RAND()
                    LIMIT 1;
        SET injuryi = injuryi + 1;
    END LOOP injury_loop;
END