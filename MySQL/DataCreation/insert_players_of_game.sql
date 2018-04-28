CREATE PROCEDURE `insert_players_of_game` (IN firstGame INT, IN lastGame INT)
BEGIN
    DECLARE gamei INT DEFAULT 0;
    SET gamei = firstGame;

    game_loop: LOOP
        IF gamei >= lastGame THEN
            LEAVE game_loop;
        END IF;
        INSERT INTO `players_of_game` (`FIFA_ID`, `Game_ID`, `is_Sub`, `Position`)
            SELECT pg.FIFA_ID, pg.Game_ID, "no", "a position"
                FROM (
                        (SELECT hp.FIFA_ID, hg.Game_ID
                            FROM player hp
                            JOIN game hg ON hp.Team_ID=hg.Host_team
                            WHERE hg.Game_ID = CAST(gamei AS CHAR(45))
                            ORDER BY RAND()
                            LIMIT 11)
                        UNION
                        (SELECT gp.FIFA_ID, gg.Game_ID
                            FROM player gp
                            JOIN game gg ON gp.Team_ID=gg.Guest_team
                            WHERE gg.Game_ID = CAST(gamei AS CHAR(45))
                            ORDER BY RAND()
                            LIMIT 11)
                    ) AS pg;
        SET gamei = gamei + 1;
    END LOOP game_loop;
END
