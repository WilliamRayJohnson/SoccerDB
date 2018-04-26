CREATE DATABASE soccer_db;

USE soccer_db;

CREATE TABLE `coach` (
  `Coach_ID` varchar(45) NOT NULL,
  `Name` varchar(45) NOT NULL,
  PRIMARY KEY (`Coach_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `referee` (
  `Ref_ID` varchar(45) NOT NULL,
  `Name` varchar(45) NOT NULL,
  `League` varchar(45) NOT NULL,
  PRIMARY KEY (`Ref_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `team` (
  `Name` varchar(45) NOT NULL,
  `Wins` int(11) NOT NULL,
  `Losses` int(11) NOT NULL,
  `City` varchar(45) NOT NULL,
  `Captain` varchar(45) NOT NULL,
  `Coach_ID` varchar(45) NOT NULL,
  `League` varchar(45) NOT NULL,
  `Team_ID` varchar(45) NOT NULL,
  PRIMARY KEY (`Team_ID`),
  KEY `Coach_ID_idx` (`Coach_ID`),
  CONSTRAINT `Coach_ID` FOREIGN KEY (`Coach_ID`) REFERENCES `coach` (`Coach_ID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `stadium` (
  `Stadium_ID` varchar(45) NOT NULL,
  `Location` varchar(45) NOT NULL,
  `Name` varchar(45) NOT NULL,
  `Team_ID` varchar(45) NOT NULL DEFAULT 'Unaffiliated',
  PRIMARY KEY (`Stadium_ID`),
  KEY `Team_ID_idx` (`Team_ID`),
  CONSTRAINT `Team_ID____` FOREIGN KEY (`Team_ID`) REFERENCES `team` (`Team_ID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `game` (
  `Game_ID` varchar(45) NOT NULL,
  `Host_team` varchar(45) NOT NULL,
  `Guest_team` varchar(45) NOT NULL,
  `Date` datetime NOT NULL,
  `H_score` varchar(45) NOT NULL,
  `G_score` varchar(45) NOT NULL,
  `Stadium_ID` varchar(45) NOT NULL,
  `Winner` varchar(45) NOT NULL,
  `Loser` varchar(45) NOT NULL,
  PRIMARY KEY (`Game_ID`),
  KEY `Stadium_ID_idx` (`Stadium_ID`),
  CONSTRAINT `Stadium_ID` FOREIGN KEY (`Stadium_ID`) REFERENCES `stadium` (`Stadium_ID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `team_penalty` (
  `Severity` varchar(45) NOT NULL,
  `Team_ID` varchar(45) NOT NULL,
  `Game_ID` varchar(45) NOT NULL,
  `Time` datetime NOT NULL,
  `Ref_ID` varchar(45) NOT NULL,
  `team penaltycol` varchar(45) NOT NULL,
  PRIMARY KEY (`Team_ID`,`team penaltycol`,`Time`),
  KEY `Game_ID_idx` (`Game_ID`),
  KEY `Ref_ID_idx` (`Ref_ID`),
  CONSTRAINT `Game_ID_` FOREIGN KEY (`Game_ID`) REFERENCES `game` (`Game_ID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `Ref_ID` FOREIGN KEY (`Ref_ID`) REFERENCES `referee` (`Ref_ID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `Team_ID_` FOREIGN KEY (`Team_ID`) REFERENCES `team` (`Team_ID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `player` (
  `FIFA_ID` varchar(45) NOT NULL,
  `Num` int(2) NOT NULL,
  `Name` varchar(45) NOT NULL,
  `Goals_Scored` int(11) NOT NULL,
  `Team_ID` varchar(45) NOT NULL,
  PRIMARY KEY (`FIFA_ID`),
  KEY `Team_ID_idx` (`Team_ID`),
  CONSTRAINT `Team_ID___` FOREIGN KEY (`Team_ID`) REFERENCES `team` (`Team_ID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `players_of_game` (
  `FIFA_ID` varchar(45) NOT NULL,
  `Game_ID` varchar(45) NOT NULL,
  `is_Sub` varchar(45) DEFAULT NULL,
  `Position` varchar(45) NOT NULL,
  PRIMARY KEY (`FIFA_ID`,`Game_ID`),
  KEY `Game_ID_idx` (`Game_ID`),
  CONSTRAINT `FIFA_ID` FOREIGN KEY (`FIFA_ID`) REFERENCES `player` (`FIFA_ID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `Game_ID` FOREIGN KEY (`Game_ID`) REFERENCES `game` (`Game_ID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `league` (
  `Name` varchar(45) NOT NULL,
  PRIMARY KEY (`Name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `injury` (
  `FIFA_ID` varchar(45) NOT NULL,
  `Injury` varchar(45) NOT NULL,
  `Game_ID` varchar(45) NOT NULL,
  `Time` datetime NOT NULL,
  PRIMARY KEY (`FIFA_ID`),
  CONSTRAINT `FIFA_ID_` FOREIGN KEY (`FIFA_ID`) REFERENCES `player` (`FIFA_ID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `card_penalty` (
  `Color` varchar(45) NOT NULL,
  `FIFA_ID` varchar(45) NOT NULL,
  `Game_ID` varchar(45) NOT NULL,
  `Time` datetime NOT NULL,
  `Ref_ID` varchar(45) NOT NULL,
  PRIMARY KEY (`FIFA_ID`,`Ref_ID`,`Time`),
  KEY `Game_ID_idx` (`Game_ID`),
  KEY `Ref_ID___idx` (`Ref_ID`),
  CONSTRAINT `FIFA_ID__` FOREIGN KEY (`FIFA_ID`) REFERENCES `player` (`FIFA_ID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `Game_ID__` FOREIGN KEY (`Game_ID`) REFERENCES `game` (`Game_ID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `Ref_ID__` FOREIGN KEY (`Ref_ID`) REFERENCES `referee` (`Ref_ID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `refs_of_games` (
  `Ref_ID` varchar(45) NOT NULL,
  `Game_ID` varchar(45) NOT NULL,
  `Position` varchar(45) NOT NULL,
  PRIMARY KEY (`Ref_ID`,`Game_ID`),
  KEY `Game_ID_____idx` (`Game_ID`),
  CONSTRAINT `Game_ID____` FOREIGN KEY (`Game_ID`) REFERENCES `game` (`Game_ID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `Ref_ID____` FOREIGN KEY (`Ref_ID`) REFERENCES `referee` (`Ref_ID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `coach_of_game` (
  `Coach_ID` varchar(45) NOT NULL,
  `Game_ID` varchar(45) NOT NULL,
  `Team_ID` varchar(45) NOT NULL,
  PRIMARY KEY (`Coach_ID`),
  KEY `Team_ID_idx` (`Team_ID`),
  KEY `Game_ID_______idx` (`Game_ID`),
  CONSTRAINT `Game_ID______` FOREIGN KEY (`Game_ID`) REFERENCES `game` (`Game_ID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `Team_ID______` FOREIGN KEY (`Team_ID`) REFERENCES `team` (`Team_ID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
