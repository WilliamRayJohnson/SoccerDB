<?php

$db_server = "";
$db_username = "";
$db_password = "";
$db_database = "";

$db = mysqli_connect($db_server, $db_username, $db_password, $db_database);
if (!$db)
    die("Connection failed: " . mysqli_connect_error());

$gameCount = 2000000;
$hostTeam = "ht.Team_ID";
$guestTeam = "gt.Team_ID";
$winner;
$loser;

for ($i = 0; $i <= $gameCount; $i++) {
    $sql = "INSERT INTO `game` (`Game_ID`, `Host_team`, `Guest_team`, `Date`, `H_score`, `G_score`, `Stadium_ID`, `Winner`, `Loser`)
                SELECT ?, ht.Team_ID, gt.Team_ID, CURRENT_TIMESTAMP - INTERVAL FLOOR(RAND() * 1460) DAY, ?, ?, s.Stadium_ID, %s, %s
                    FROM team ht
                    CROSS JOIN team gt
                    JOIN stadium s ON s.Team_ID = ht.Team_ID
                    WHERE ht.Team_ID != gt.Team_ID
                    ORDER BY RAND()
                    LIMIT 1";
    $hScore = rand(0, 10);
    $gScore = rand(0, 10);
    if ($hScore > $gScore) {
        $winner = $hostTeam;
        $loser = $guestTeam;
    }
    else if ($hScore < $gScore) {
        $winner = $guestTeam;
        $loser = $hostTeam;
    }
    else {
        $hScore++;
        $winner = $hostTeam;
        $loser = $guestTeam;
    }
    $sql = sprintf($sql, $winner, $loser);
    $stmt = $db->prepare($sql);
    $stmt->bind_param("sii", strval($i), $hScore, $gScore);
    $stmt->execute();
    printf("Game %d inserted\n", $i);
}
mysqli_close($db);
?>