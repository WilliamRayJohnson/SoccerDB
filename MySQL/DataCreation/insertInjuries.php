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
    $sql = "INSERT INTO `injury` (`FIFA_ID`, `Injury`, `Game_ID`, `Time`)
                SELECT pog.FIFA_ID, \"hurt\", pog.Game_ID, g.Date
                    FROM players_of_game pog
                    JOIN game g ON pog.Game_ID = g.Game_ID
                    ORDER BY RAND()
                    LIMIT 1;";
    $stmt = $db->prepare($sql);
    $stmt->execute();
    printf("Injury %d inserted\n", $i);
}
mysqli_close($db);
?>