CREATE PROCEDURE `insert_games` (IN gamei INT, IN gameCount INT)
BEGIN
    DECLARE hScore INT DEFAULT 0;
    DECLARE gScore INT DEFAULT 0;

    create_game: LOOP
        IF gamei >= gameCount THEN
            LEAVE create_game;
        END IF;
        SET hScore = FLOOR(RAND()*10);
        SET gScore = FLOOR(RAND()*10);
        IF hScore > gScore THEN
            CALL insert_host_win(CAST(gamei AS CHAR(45)), hScore, gScore);
        ELSEIF hScore < gScore THEN
            CALL insert_guest_win(CAST(gamei AS CHAR(45)), hScore, gScore);
        ELSE
            CALL insert_host_win(CAST(gamei AS CHAR(45)), hScore+1, gScore);
        END IF;
        SET gamei = gamei + 1;
    END LOOP create_game;
END
