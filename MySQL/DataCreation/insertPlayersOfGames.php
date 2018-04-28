<?php

$db_server = "";
$db_username = "";
$db_password = "";
$db_database = "";

$db = mysqli_connect($db_server, $db_username, $db_password, $db_database);
if (!$db)
    die("Connection failed: " . mysqli_connect_error());

$gameCount = 2000000;

for ($i = 0; $i <= $gameCount; $i++) {
    $sql = "INSERT INTO `players_of_game` (`FIFA_ID`, `Game_ID`, `is_Sub`, `Position`)
                SELECT pg.FIFA_ID, pg.Game_ID, \"no\", \"a position\"
                    FROM (
                        (SELECT hp.FIFA_ID, hg.Game_ID
                            FROM player hp
                            JOIN game hg ON hp.Team_ID=hg.Host_team
                            WHERE hg.Game_ID = ?
                            ORDER BY RAND()
                            LIMIT 11)
                        UNION
                        (SELECT gp.FIFA_ID, gg.Game_ID
                            FROM player gp
                            JOIN game gg ON gp.Team_ID=gg.Guest_team
                            WHERE gg.Game_ID = ?
                            ORDER BY RAND()
                            LIMIT 11)
                    ) AS pg";
    $stmt = $db->prepare($sql);
    $stmt->bind_param("ss", strval($i), strval($i));
    $stmt->execute();
    printf("Players for game %d inserted\n", $i);
}
mysqli_close($db);
?>