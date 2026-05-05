/*M!999999\- enable the sandbox mode */ 
-- MariaDB dump 10.19-11.8.5-MariaDB, for Win64 (AMD64)
--
-- Host: localhost    Database: game_db
-- ------------------------------------------------------
-- Server version	11.8.5-MariaDB

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*M!100616 SET @OLD_NOTE_VERBOSITY=@@NOTE_VERBOSITY, NOTE_VERBOSITY=0 */;

--
-- Table structure for table `characters`
--

DROP TABLE IF EXISTS `characters`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `characters` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `save_id` int(11) NOT NULL,
  `name` varchar(50) NOT NULL,
  `level` int(11) DEFAULT 1,
  `gold` int(11) DEFAULT 0,
  `hp` int(11) DEFAULT 100,
  `max_hp` int(11) DEFAULT 100,
  `attack` int(11) DEFAULT 10,
  `defense` int(11) DEFAULT 5,
  `current_location_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_characters_save` (`save_id`),
  KEY `fk_characters_location` (`current_location_id`),
  CONSTRAINT `fk_characters_location` FOREIGN KEY (`current_location_id`) REFERENCES `nations` (`id`) ON DELETE SET NULL,
  CONSTRAINT `fk_characters_save` FOREIGN KEY (`save_id`) REFERENCES `game_saves` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `characters`
--

LOCK TABLES `characters` WRITE;
/*!40000 ALTER TABLE `characters` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `characters` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `empires`
--

DROP TABLE IF EXISTS `empires`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `empires` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) DEFAULT NULL,
  `description` text DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `empires`
--

LOCK TABLES `empires` WRITE;
/*!40000 ALTER TABLE `empires` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `empires` VALUES
(1,'Mustafar','A volcanic empire of fire and iron, ruled by strength, warfare, and relentless conquest.'),
(2,'Kamino','A maritime empire of towering citadels, known for naval mastery, innovation, and disciplined order.'),
(3,'Genosis','A harsh desert empire built on trade, mining, and survival amid stone and sand.'),
(4,'Nepotis','A fertile forest empire that values harmony, nature, prosperity, and defensive strength.');
/*!40000 ALTER TABLE `empires` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `game_saves`
--

DROP TABLE IF EXISTS `game_saves`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `game_saves` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `save_name` varchar(100) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `fk_game_saves_user` (`user_id`),
  CONSTRAINT `fk_game_saves_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `game_saves`
--

LOCK TABLES `game_saves` WRITE;
/*!40000 ALTER TABLE `game_saves` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `game_saves` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `nations`
--

DROP TABLE IF EXISTS `nations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `nations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) DEFAULT NULL,
  `empire_id` int(11) NOT NULL,
  `region` enum('green','yellow','red','black') DEFAULT NULL,
  `description` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_locations_empire` (`empire_id`),
  CONSTRAINT `fk_locations_empire` FOREIGN KEY (`empire_id`) REFERENCES `empires` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `nations`
--

LOCK TABLES `nations` WRITE;
/*!40000 ALTER TABLE `nations` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `nations` VALUES
(1,'Tipoca City',2,'green','A sleek, storm-battered metropolis rising on stilts above endless seas.'),
(2,'The Tide Docks',2,'green','Bustling platforms where ships arrive between surging tides.'),
(3,'The Dune Gate',3,'green','A colossal entrance marking passage into the shifting sands.'),
(4,'Elarion',4,'green','A serene forest city woven seamlessly into towering ancient trees.'),
(5,'Silverfall Reach',4,'green','A tranquil region of cascading waterfalls and misty cliffs.'),
(6,'Blackfire Citadel',1,'yellow','A fortress of obsidian towering over rivers of flowing lava.'),
(7,'Ashen Bastion',1,'yellow','A heavily fortified outpost blanketed in volcanic ash and smoke.'),
(8,'The Spirefoundry',2,'yellow','A high-tech facility crafting advanced structures amid crashing waves.'),
(9,'Oceanwatch Keep',2,'yellow','A vigilant bastion guarding the deep from unseen threats.'),
(10,'Riftstone Stronghold',3,'yellow','A rugged fortress carved directly into fractured desert rock.'),
(11,'Verdant Spire',4,'yellow','A living tower of vines and wood rising above the canopy.'),
(12,'Greenwatch',4,'yellow','A hidden ranger outpost protecting the wilds from encroaching danger.'),
(13,'Forge of Korran',1,'red','An ancient foundry where legendary weapons are crafted in magma heat.'),
(14,'The Scoria Pits',1,'red','A brutal mining region filled with jagged rock and hidden fire vents.'),
(15,'Citadel of Echoes',2,'red','A mysterious tower where voices carry across wind and water.'),
(16,'Scarab Expanse',3,'red','A vast desert crawling with chitinous creatures and buried ruins.'),
(17,'The Great Foundry',3,'red','A blazing industrial complex powered by relentless desert heat.'),
(18,'The Emerald Heart',4,'red','The sacred core of the forest pulsing with natural energy.'),
(19,'Molten Fissure',1,'black','A massive glowing rift where the planet’s core bleeds to the surface.'),
(20,'Vulkar Keep',1,'black','A warlord’s stronghold perched dangerously above a lavafall.'),
(21,'Pearl Depths',2,'black','A hidden underwater realm shimmering with bioluminescent life.'),
(22,'Bonecrater Hollow',3,'black','A grim basin filled with the remains of ancient beasts.'),
(23,'Mistwood Grove',4,'black','An enchanted woodland perpetually shrouded in soft, glowing fog.');
/*!40000 ALTER TABLE `nations` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `quests`
--

DROP TABLE IF EXISTS `quests`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `quests` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(100) NOT NULL,
  `question` text DEFAULT NULL,
  `location_id` int(11) NOT NULL,
  `answer` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_quests_location` (`location_id`),
  CONSTRAINT `fk_quests_location` FOREIGN KEY (`location_id`) REFERENCES `nations` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `quests`
--

LOCK TABLES `quests` WRITE;
/*!40000 ALTER TABLE `quests` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `quests` VALUES
(1,'The Crucible of Calculated Will','Solve this to prove your will: 12 × 8 = ?',1,'96'),
(2,'Murmur of the Veilbound Shade','I speak without a mouth and hear without ears. I fade when named. What am I?',2,'Echo'),
(3,'The Veiled Sigil of Salvation','First letters reveal the truth: \"Silent Ashes Linger Veiled Among Terrors. Illuminate Order Now.\" What word forms?',4,'SALVATION'),
(4,'The Astral Wager of Unnulaaz','A coin spins in fate’s hand. What are the only two possible outcomes?',5,'Heads or Tails'),
(5,'Severing the Lesser Flame','I burn bright but die with water. What is my weakness?',3,'Water'),
(6,'Veil of the Infernal Pact','Rearrange this cursed word: \"RUCSE\"',13,'CURSE'),
(7,'The Frostbound Seal','Solve the rune equation: 5 + 7 × 2 = ?',10,'19'),
(8,'Gate of the Night Sovereign','Which rules the night: Sun, Moon, Flame, or Storm?',11,'Moon'),
(9,'Trial by Infernal Might','Outmatch the demon: if it rolls 14 and you must exceed it, what is the minimum you must roll?',7,'15'),
(10,'Temptation of the Gilded Snare','I shine with gold but bring you pain. Open me and loss you gain. What am I?',9,'Trapped chest'),
(11,'The Crimson-Eyed Survivor','A moral riddle: help and risk corruption, or ignore and lose virtue. Which choice preserves your humanity?',15,'Help'),
(12,'The Fork of Ashen Fate','Two paths: left loses 2 strength, right loses 3 dexterity. Which costs less overall?',14,'Left path'),
(13,'Sanctuary of Chaotic Power','Balance the chaos: 3² + 4² = ?',20,'25'),
(14,'Shadow\'s Bargain','I offer power but take your soul. What am I?',19,'Dark pact'),
(15,'Riddle of the Unseen','I cannot be seen, but I can strike. I move through air and carry force. What am I?',21,'Wind'),
(16,'Fusion of Spirit Fragments','Combine wisely: 2 + 2 × 2 = ?',23,'6'),
(17,'Word of True Might','Form a strong word from: \"M I G H T\"',22,'MIGHT'),
(18,'Endurance of the Shadows','You take 3 hits of 2 damage each. Total damage = ?',19,'6'),
(19,'The Hidden Number','I am between 10 and 20, divisible by 3. What number am I?',21,'12, 15, or 18'),
(20,'Duel with the Void Guardian','If the guardian has strength 18, what must you reach to exceed it by 3?',20,'21'),
(21,'Silence of the Void','I am heard in silence, and vanish in noise. What am I?',23,'Thought'),
(22,'Trial of the Statues of Mezanod','Order the numbers from smallest to largest: 8, 3, 5, 1',22,'1, 3, 5, 8');
/*!40000 ALTER TABLE `quests` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `stables`
--

DROP TABLE IF EXISTS `stables`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `stables` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `location_id` int(11) NOT NULL,
  `name` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_stables_location` (`location_id`),
  CONSTRAINT `fk_stables_location` FOREIGN KEY (`location_id`) REFERENCES `nations` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `stables`
--

LOCK TABLES `stables` WRITE;
/*!40000 ALTER TABLE `stables` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `stables` VALUES
(1,1,'Harborline Stables'),
(2,2,'Tidebreaker Stables'),
(3,3,'Sirocco Pass Stables'),
(4,4,'Elarion Canopy Stables'),
(5,5,'Silverfall Drift Stables'),
(6,6,'Obsidian Gate Stables'),
(7,7,'Ashveil Bastion Stables'),
(8,8,'Spireforge Stables'),
(9,9,'Deepwatch Stables'),
(10,10,'Riftstone Outpost Stables'),
(11,11,'Verdant Crown Stables'),
(12,12,'Wildguard Stables'),
(13,13,'Korran Ember Stables'),
(14,14,'Scoria Vent Stables'),
(15,15,'Whisper Echo Stables'),
(16,16,'Scarab Sandreach Stables'),
(17,17,'Great Ember Foundry Stables'),
(18,18,'Heartbloom Stables'),
(19,19,'Fissurelight Stables'),
(20,20,'Vulkar Cliff Stables'),
(21,21,'Pearlcurrent Stables'),
(22,22,'Bonecrater Hold Stables'),
(23,23,'Mistveil Grove Stables');
/*!40000 ALTER TABLE `stables` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_name` varchar(100) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
commit;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*M!100616 SET NOTE_VERBOSITY=@OLD_NOTE_VERBOSITY */;

-- Dump completed on 2026-05-05 14:45:36
