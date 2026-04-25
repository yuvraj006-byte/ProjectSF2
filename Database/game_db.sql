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
-- Table structure for table `character_mounts`
--

DROP TABLE IF EXISTS `character_mounts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `character_mounts` (
  `character_id` int(11) NOT NULL,
  `mount_id` int(11) NOT NULL,
  PRIMARY KEY (`character_id`,`mount_id`),
  KEY `fk_character_mounts_mount` (`mount_id`),
  CONSTRAINT `fk_character_mounts_character` FOREIGN KEY (`character_id`) REFERENCES `characters` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_character_mounts_mount` FOREIGN KEY (`mount_id`) REFERENCES `mounts` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `character_mounts`
--

LOCK TABLES `character_mounts` WRITE;
/*!40000 ALTER TABLE `character_mounts` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `character_mounts` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `character_quests`
--

DROP TABLE IF EXISTS `character_quests`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `character_quests` (
  `character_id` int(11) NOT NULL,
  `quest_id` int(11) NOT NULL,
  `status` enum('not_started','in_progress','completed') DEFAULT 'not_started',
  PRIMARY KEY (`character_id`,`quest_id`),
  KEY `fk_character_quests_quest` (`quest_id`),
  CONSTRAINT `fk_character_quests_character` FOREIGN KEY (`character_id`) REFERENCES `characters` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_character_quests_quest` FOREIGN KEY (`quest_id`) REFERENCES `quests` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `character_quests`
--

LOCK TABLES `character_quests` WRITE;
/*!40000 ALTER TABLE `character_quests` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `character_quests` ENABLE KEYS */;
UNLOCK TABLES;
commit;

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
  `xp` int(11) DEFAULT 0,
  `gold` int(11) DEFAULT 0,
  `hp` int(11) DEFAULT 100,
  `max_hp` int(11) DEFAULT 100,
  `attack` int(11) DEFAULT 10,
  `defense` int(11) DEFAULT 5,
  `current_location_id` int(11) DEFAULT NULL,
  `x_pos` float DEFAULT 0,
  `y_pos` float DEFAULT 0,
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
-- Table structure for table `defeated_enemies`
--

DROP TABLE IF EXISTS `defeated_enemies`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `defeated_enemies` (
  `enemy_id` int(11) NOT NULL,
  `defeated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`enemy_id`),
  CONSTRAINT `defeated_enemies_ibfk_1` FOREIGN KEY (`enemy_id`) REFERENCES `enemies` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `defeated_enemies`
--

LOCK TABLES `defeated_enemies` WRITE;
/*!40000 ALTER TABLE `defeated_enemies` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `defeated_enemies` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `empire_routes`
--

DROP TABLE IF EXISTS `empire_routes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `empire_routes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `from_empire_id` int(11) DEFAULT NULL,
  `to_empire_id` int(11) DEFAULT NULL,
  `price` int(11) DEFAULT 0,
  `travel_time` int(11) DEFAULT NULL,
  `is_allowed` tinyint(1) DEFAULT 1,
  PRIMARY KEY (`id`),
  KEY `idx_empire_routes_from` (`from_empire_id`),
  KEY `idx_empire_routes_to` (`to_empire_id`),
  CONSTRAINT `empire_routes_ibfk_1` FOREIGN KEY (`from_empire_id`) REFERENCES `empires` (`id`),
  CONSTRAINT `empire_routes_ibfk_2` FOREIGN KEY (`to_empire_id`) REFERENCES `empires` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `empire_routes`
--

LOCK TABLES `empire_routes` WRITE;
/*!40000 ALTER TABLE `empire_routes` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `empire_routes` VALUES
(1,1,2,0,0,0),
(2,1,3,0,0,1),
(3,1,4,0,0,0),
(4,2,1,0,0,0),
(5,2,3,60,3,1),
(6,2,4,40,2,1),
(7,4,1,0,0,0),
(8,4,2,40,2,1),
(9,4,3,50,3,1),
(10,3,1,40,2,1),
(11,3,2,60,3,1),
(12,3,4,50,3,1);
/*!40000 ALTER TABLE `empire_routes` ENABLE KEYS */;
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
-- Table structure for table `enemies`
--

DROP TABLE IF EXISTS `enemies`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `enemies` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(80) NOT NULL,
  `level` int(11) DEFAULT 1,
  `location_id` int(11) NOT NULL,
  `hp` int(11) NOT NULL,
  `attack` int(11) NOT NULL,
  `defense` int(11) NOT NULL,
  `xp_reward` int(11) DEFAULT 0,
  `gold_reward` int(11) DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `fk_enemies_location` (`location_id`),
  CONSTRAINT `fk_enemies_location` FOREIGN KEY (`location_id`) REFERENCES `nations` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `enemies`
--

LOCK TABLES `enemies` WRITE;
/*!40000 ALTER TABLE `enemies` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `enemies` VALUES
(1,'Imp',2,1,180,18,6,40,10),
(2,'Hell Hound',3,2,260,24,8,60,15),
(3,'Blood Thrall',4,4,360,32,12,85,20),
(4,'Hallowed One',5,5,480,40,16,110,25),
(5,'Bone Giant',6,3,620,48,20,140,35),
(6,'Soul Drinker',8,6,900,65,30,220,60),
(7,'Unnulaaz',9,7,1050,75,34,260,70),
(8,'Zyreth',10,8,1200,85,38,300,80),
(9,'Valtherax',11,9,1380,95,42,340,90),
(10,'Morvath',12,10,1560,105,46,380,100),
(11,'Elmazith',12,11,1650,110,48,420,110),
(12,'Mezanod',13,12,1800,120,52,460,120),
(13,'Theggoroth',14,13,2100,135,58,520,140),
(14,'Ornonas',15,14,2350,150,64,580,150),
(15,'Gostrath',15,15,2450,155,66,620,160),
(16,'Vunnin',16,16,2700,170,72,680,180),
(17,'Vastramuun',17,17,3000,185,78,750,200),
(18,'Ograrath',18,19,3400,200,85,900,250),
(19,'Belphegor',19,21,3800,215,90,1050,280),
(20,'Asmodeus',20,22,4200,230,95,1200,300),
(21,'Mammon',21,23,4600,245,100,1400,330),
(22,'Beelzebub',22,21,5000,260,105,1600,360),
(23,'Leviathan',23,21,5400,275,110,1800,400),
(24,'Lucifer',25,20,6200,300,120,2200,500),
(25,'Satan',27,19,7000,320,130,2600,600),
(26,'Lilith',30,22,8200,360,145,3200,800);
/*!40000 ALTER TABLE `enemies` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `enemy_drops`
--

DROP TABLE IF EXISTS `enemy_drops`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `enemy_drops` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `item_id` int(11) NOT NULL,
  `enemy_id` int(11) NOT NULL,
  `drop_rate` float NOT NULL,
  `quantity_min` int(11) DEFAULT 1,
  `quantity_max` int(11) DEFAULT 1,
  PRIMARY KEY (`id`),
  KEY `fk_enemy_drops_item` (`item_id`),
  KEY `fk_enemy_drops_enemy` (`enemy_id`),
  CONSTRAINT `fk_enemy_drops_enemy` FOREIGN KEY (`enemy_id`) REFERENCES `enemies` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_enemy_drops_item` FOREIGN KEY (`item_id`) REFERENCES `items` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=132 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `enemy_drops`
--

LOCK TABLES `enemy_drops` WRITE;
/*!40000 ALTER TABLE `enemy_drops` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `enemy_drops` VALUES
(1,14,1,0.5,1,2),
(2,24,1,0.45,1,2),
(3,21,1,0.2,1,2),
(4,14,2,0.4,1,2),
(5,24,2,0.4,1,2),
(6,21,2,0.25,1,2),
(7,1,2,0.15,1,1),
(8,1,3,0.3,1,2),
(9,4,3,0.25,1,2),
(10,21,3,0.25,1,2),
(11,7,3,0.15,1,2),
(12,1,4,0.35,1,2),
(13,4,4,0.3,1,2),
(14,7,4,0.2,1,2),
(15,10,4,0.15,1,2),
(16,1,5,0.25,1,2),
(17,4,5,0.25,1,2),
(18,7,5,0.2,1,2),
(19,10,5,0.2,1,2),
(20,12,5,0.15,1,2),
(21,16,5,0.12,1,2),
(22,3,6,0.12,1,1),
(23,6,6,0.1,1,1),
(24,8,6,0.12,1,1),
(25,23,6,0.1,1,1),
(26,1,6,0.2,1,2),
(27,7,6,0.2,1,2),
(28,10,6,0.2,1,2),
(29,3,7,0.15,1,1),
(30,6,7,0.12,1,1),
(31,8,7,0.15,1,1),
(32,23,7,0.12,1,1),
(33,12,7,0.15,1,2),
(34,16,7,0.12,1,2),
(35,3,8,0.18,1,1),
(36,6,8,0.15,1,1),
(37,8,8,0.18,1,1),
(38,23,8,0.15,1,1),
(39,19,8,0.12,1,2),
(40,20,8,0.12,1,2),
(41,3,9,0.2,1,1),
(42,6,9,0.18,1,1),
(43,8,9,0.2,1,1),
(44,23,9,0.18,1,1),
(45,17,9,0.1,1,2),
(46,21,9,0.1,1,2),
(47,3,10,0.22,1,1),
(48,6,10,0.2,1,1),
(49,8,10,0.22,1,1),
(50,23,10,0.2,1,1),
(51,19,10,0.1,1,2),
(52,20,10,0.1,1,2),
(53,3,11,0.25,1,1),
(54,6,11,0.22,1,1),
(55,8,11,0.25,1,1),
(56,23,11,0.22,1,1),
(57,17,11,0.1,1,2),
(58,3,12,0.28,1,1),
(59,6,12,0.25,1,1),
(60,8,12,0.28,1,1),
(61,23,12,0.25,1,1),
(62,21,12,0.1,1,2),
(63,3,13,0.3,1,1),
(64,6,13,0.28,1,1),
(65,8,13,0.3,1,1),
(66,23,13,0.28,1,1),
(67,19,13,0.08,1,2),
(68,3,14,0.32,1,1),
(69,6,14,0.3,1,1),
(70,8,14,0.32,1,1),
(71,23,14,0.3,1,1),
(72,20,14,0.08,1,2),
(73,3,15,0.35,1,1),
(74,6,15,0.32,1,1),
(75,8,15,0.35,1,1),
(76,23,15,0.32,1,1),
(77,21,15,0.08,1,2),
(78,3,16,0.38,1,1),
(79,6,16,0.35,1,1),
(80,8,16,0.38,1,1),
(81,23,16,0.35,1,1),
(82,3,17,0.4,1,1),
(83,6,17,0.38,1,1),
(84,8,17,0.4,1,1),
(85,23,17,0.38,1,1),
(86,3,18,0.42,1,1),
(87,6,18,0.4,1,1),
(88,8,18,0.42,1,1),
(89,23,18,0.4,1,1),
(90,3,19,0.45,1,1),
(91,6,19,0.42,1,1),
(92,8,19,0.45,1,1),
(93,23,19,0.42,1,1),
(94,11,19,0.02,1,1),
(95,26,19,0.02,1,1),
(96,11,20,0.05,1,1),
(97,26,20,0.05,1,1),
(98,3,20,0.3,1,2),
(99,6,20,0.28,1,2),
(100,8,20,0.3,1,2),
(101,23,20,0.28,1,2),
(102,11,21,0.06,1,1),
(103,26,21,0.06,1,1),
(104,3,21,0.32,1,2),
(105,6,21,0.3,1,2),
(106,8,21,0.32,1,2),
(107,23,21,0.3,1,2),
(108,11,22,0.07,1,1),
(109,26,22,0.07,1,1),
(110,3,22,0.34,1,2),
(111,6,22,0.32,1,2),
(112,8,22,0.34,1,2),
(113,23,22,0.32,1,2),
(114,11,23,0.08,1,1),
(115,26,23,0.08,1,1),
(116,3,23,0.36,1,2),
(117,6,23,0.34,1,2),
(118,8,23,0.36,1,2),
(119,23,23,0.34,1,2),
(120,11,24,0.1,1,1),
(121,26,24,0.1,1,1),
(122,3,24,0.4,1,2),
(123,6,24,0.38,1,2),
(124,8,24,0.4,1,2),
(125,23,24,0.38,1,2),
(126,11,25,0.12,1,1),
(127,26,25,0.12,1,1),
(128,3,25,0.42,1,2),
(129,6,25,0.4,1,2),
(130,8,25,0.42,1,2),
(131,23,25,0.4,1,2);
/*!40000 ALTER TABLE `enemy_drops` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `equipment`
--

DROP TABLE IF EXISTS `equipment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `equipment` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `character_id` int(11) NOT NULL,
  `item_id` int(11) NOT NULL,
  `slot` enum('head','body','legs','boots','weapon','shield','accessory') NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `character_id` (`character_id`,`slot`),
  KEY `fk_equipment_item` (`item_id`),
  CONSTRAINT `fk_equipment_character` FOREIGN KEY (`character_id`) REFERENCES `characters` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_equipment_item` FOREIGN KEY (`item_id`) REFERENCES `items` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `equipment`
--

LOCK TABLES `equipment` WRITE;
/*!40000 ALTER TABLE `equipment` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `equipment` ENABLE KEYS */;
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
-- Table structure for table `inventory`
--

DROP TABLE IF EXISTS `inventory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `inventory` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `character_id` int(11) NOT NULL,
  `item_id` int(11) NOT NULL,
  `quantity` int(11) DEFAULT 1,
  PRIMARY KEY (`id`),
  UNIQUE KEY `character_id` (`character_id`,`item_id`),
  KEY `fk_inventory_item` (`item_id`),
  CONSTRAINT `fk_inventory_character` FOREIGN KEY (`character_id`) REFERENCES `characters` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_inventory_item` FOREIGN KEY (`item_id`) REFERENCES `items` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `inventory`
--

LOCK TABLES `inventory` WRITE;
/*!40000 ALTER TABLE `inventory` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `inventory` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `items`
--

DROP TABLE IF EXISTS `items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `items` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(80) NOT NULL,
  `description` text DEFAULT NULL,
  `item_type` enum('weapon','armor','consumable','material','quest') NOT NULL,
  `attack_bonus` int(11) DEFAULT 0,
  `defense_bonus` int(11) DEFAULT 0,
  `hp_restore` int(11) DEFAULT 0,
  `price` int(11) DEFAULT 0,
  `from_quests` tinyint(1) NOT NULL,
  `tier` enum('S','A','B','C') DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `items`
--

LOCK TABLES `items` WRITE;
/*!40000 ALTER TABLE `items` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `items` VALUES
(1,'Sharpened War Spear','A balanced spear used by frontline soldiers.','weapon',25,5,0,55,0,'B'),
(2,'Spear of the Vanguard','A legendary spear carried by elite warriors.','weapon',60,10,0,600,1,NULL),
(3,'Polished Steel Sword','A refined steel blade with excellent balance.','weapon',38,8,0,115,0,'A'),
(4,'Reinforced Wooden Guard','A sturdy wooden shield reinforced with metal.','armor',10,20,0,120,0,'B'),
(5,'Aegis of the Ancients','A mystical shield infused with ancient protection magic.','armor',5,15,0,120,1,NULL),
(6,'Robe of the Archmage','A robe imbued with powerful arcane energy.','armor',5,35,0,480,0,'A'),
(7,'Obsidian Bulwark','A heavy shield forged from volcanic stone.','armor',12,25,0,220,0,'B'),
(8,'Reinforced Iron Dagger','A compact dagger built for precise strikes.','weapon',40,7,0,120,0,'A'),
(9,'Iron-Bound Chestplate','A durable chestplate reinforced with iron bands.','armor',5,30,0,90,1,NULL),
(10,'Mageweave Robe','A lightweight robe woven with enchanted threads.','armor',5,28,0,85,0,'B'),
(11,'Spear of the Vanguard','A battle-tested spear used by elite soldiers.','weapon',45,10,0,210,0,'S'),
(12,'Sturdy Iron Buckler','A small but reliable iron shield.','armor',8,18,0,85,0,'B'),
(13,'Forged Iron Helm','A simple but durable iron helmet.','armor',2,22,0,55,1,NULL),
(14,'Frayed Cloth Robe','A worn robe used by novice mages.','armor',1,15,0,45,0,'C'),
(15,'Titanwood Warclub','A massive club carved from ancient titanwood.','weapon',65,12,0,620,1,NULL),
(16,'Tempered Bronze Shield','A bronze shield tempered for battle.','armor',7,18,0,95,0,'B'),
(17,'Reinforced Iron Dagger','A simple reinforced dagger.','weapon',28,5,0,60,0,'B'),
(18,'Obsidian Bulwark','A legendary obsidian shield of immense strength.','armor',15,28,0,440,1,NULL),
(19,'Dragonsteel Tower Shield','A massive shield forged from dragonsteel.','armor',10,20,0,160,0,'B'),
(20,'Bronze Kite Shield','A lightweight bronze shield.','armor',8,18,0,85,0,'B'),
(21,'Healing Berry','A sweet forest berry that restores minor health.','consumable',0,0,25,20,0,'B'),
(22,'Greater Healing Potion','A powerful alchemical healing potion.','consumable',0,0,60,120,1,NULL),
(23,'Elixir of Vitality','A rare elixir that strengthens life force.','consumable',0,0,40,90,0,'A'),
(24,'Mana Nectar','A glowing nectar that restores magical energy.','consumable',0,0,0,75,0,'C'),
(25,'Antidote Herb Bundle','Herbs that neutralize most poisons.','consumable',0,0,10,30,1,NULL),
(26,'Phoenix Fruit','A legendary fruit with restorative and rebirth properties.','consumable',0,0,100,300,0,'S'),
(27,'Seal of the Forgotten King','A mystical relic required to unlock ancient ruins.','quest',0,0,0,500,1,NULL);
/*!40000 ALTER TABLE `items` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `location_enemies`
--

DROP TABLE IF EXISTS `location_enemies`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `location_enemies` (
  `location_id` int(11) NOT NULL,
  `enemy_id` int(11) NOT NULL,
  `spawn_rate` float NOT NULL,
  `is_unique` tinyint(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`location_id`,`enemy_id`),
  KEY `enemy_id` (`enemy_id`),
  CONSTRAINT `location_enemies_ibfk_1` FOREIGN KEY (`location_id`) REFERENCES `nations` (`id`),
  CONSTRAINT `location_enemies_ibfk_2` FOREIGN KEY (`enemy_id`) REFERENCES `enemies` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `location_enemies`
--

LOCK TABLES `location_enemies` WRITE;
/*!40000 ALTER TABLE `location_enemies` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `location_enemies` VALUES
(1,1,0.6,0),
(1,2,0.3,0),
(1,3,0.1,0),
(2,1,0.3,0),
(2,2,0.5,0),
(2,3,0.2,0),
(3,3,0.3,0),
(3,4,0.2,0),
(3,5,0.5,0),
(4,1,0.2,0),
(4,3,0.5,0),
(4,4,0.3,0),
(5,3,0.3,0),
(5,4,0.5,0),
(5,5,0.2,0),
(6,6,0.4,0),
(6,7,0.35,0),
(6,8,0.25,0),
(7,6,0.3,0),
(7,7,0.4,0),
(7,9,0.3,0),
(8,7,0.3,0),
(8,8,0.4,0),
(8,10,0.3,0),
(9,8,0.3,0),
(9,9,0.4,0),
(9,11,0.3,0),
(10,9,0.3,0),
(10,10,0.4,0),
(10,12,0.3,0),
(11,10,0.3,0),
(11,11,0.5,0),
(11,12,0.2,0),
(12,9,0.2,0),
(12,11,0.3,0),
(12,12,0.5,0),
(13,13,0.5,0),
(13,14,0.3,0),
(13,15,0.2,0),
(14,13,0.3,0),
(14,14,0.4,0),
(14,16,0.3,0),
(15,14,0.3,0),
(15,15,0.4,0),
(15,16,0.3,0),
(16,15,0.3,0),
(16,16,0.4,0),
(16,17,0.3,0),
(17,13,0.2,0),
(17,16,0.3,0),
(17,17,0.5,0),
(19,18,0.6,0),
(19,24,0.1,0),
(19,25,0.25,0),
(19,26,0.05,1),
(20,24,0.05,1),
(21,19,0.05,1),
(22,26,0.05,1),
(23,20,0.2,0),
(23,21,0.35,0),
(23,22,0.25,0),
(23,23,0.2,0);
/*!40000 ALTER TABLE `location_enemies` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `mounts`
--

DROP TABLE IF EXISTS `mounts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `mounts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) DEFAULT NULL,
  `speed` int(11) DEFAULT NULL,
  `description` text DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mounts`
--

LOCK TABLES `mounts` WRITE;
/*!40000 ALTER TABLE `mounts` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `mounts` VALUES
(1,'Giant Eagle',110,'A noble and sturdy bird of prey, often used as an early aerial mount for scouts and messengers.'),
(2,'Wyvern',120,'A fierce draconic beast with leathery wings and a venomous sting, faster than most natural flyers.'),
(3,'Griffin',130,'A majestic hybrid of lion and eagle, known for its balance of speed, strength, and loyalty.'),
(4,'Pegasus',140,'A magical winged horse, graceful and swift, often bonded with skilled riders or knights.'),
(5,'Storm Drake',170,'A lightning-infused draconic creature that rides thunderclouds and cuts through the skies with ease.'),
(6,'Sky Serpent',190,'A long, serpentine airborne creature that glides effortlessly on wind currents at extreme speeds.'),
(7,'Celestial Phoenix',210,'A radiant immortal bird of flame and light, reborn from ashes and blazing across the skies.'),
(8,'Ancient Void Dragon',230,'A colossal primordial dragon that bends air itself, considered the fastest and most feared sky mount.');
/*!40000 ALTER TABLE `mounts` ENABLE KEYS */;
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
  `description` text DEFAULT NULL,
  `xp_reward` int(11) DEFAULT 0,
  `gold_reward` int(11) DEFAULT 0,
  `location_id` int(11) NOT NULL,
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
(1,'The Crucible of Calculated Will','An unseen astral intellect presses against your mind, forcing you to solve a burning multiplication challenge to prove your mental discipline.',50,15,1),
(2,'Murmur of the Veilbound Shade','A drifting veilbound shade whispers a riddle from the edge of the light. Answer correctly or lose its fading knowledge.',75,20,2),
(3,'The Veiled Sigil of Salvation','An ancient altar conceals its power within hidden structure. Discover the word revealed by the first letters of its carved script.',90,25,4),
(4,'The Astral Wager of Unnulaaz','Accept the unseen wager of Unnulaaz, an astral Demon Lord who bends fate itself. Call the coin correctly or his summoned servants will answer instead.',70,30,5),
(5,'Severing the Lesser Flame','A flame-wreathed lesser demon stalks the ruins. Identify its true weakness before it strikes or be forced into battle unprepared.',105,35,3),
(6,'Veil of the Infernal Pact','A whisper coils around your thoughts, offering forbidden power. Accept it wisely, or a lingering curse will weaken you in future encounters.',120,50,13),
(7,'The Frostbound Seal','A colossal stone door pulsates with arcane energy. Interpret the runes correctly to suppress the raging magic, or suffer a scorching burst.',150,60,10),
(8,'Gate of the Night Sovereign','An iron gate looms with four symbols. Only the one that rules the night can unlock the path. Fail and the mechanism strikes you!',130,45,11),
(9,'Trial by Infernal Might','A horned lesser demon challenges your strength. Outroll it to survive, but failure causes wounds and weakens you for the next encounter.',160,70,7),
(10,'Temptation of the Gilded Snare','A radiant chest hums unnaturally. Resist opening it to avoid a curse that will hinder your next challenge, or suffer its effects.',110,40,9),
(11,'The Crimson-Eyed Survivor','A wounded figure crawls from the ruins. Help them and risk corruption, or avoid danger but miss the chance to save a soul.',125,50,15),
(12,'The Fork of Ashen Fate','Two paths stretch into red mist. Choose unwisely and lose stamina and dexterity in the next challenge.',115,45,14),
(13,'Sanctuary of Chaotic Power','A fractured Sanctuary core pulses with unstable, chaotic energy. Channel it wisely or risk being shredded by raw power.',180,75,20),
(14,'Shadow\'s Bargain','A towering shadow stretches across the ruins. Accept its offered strength, but beware the hidden corruption.',200,80,19),
(15,'Riddle of the Unseen','An abstract riddle of unseen forces tests your insight. Name the invisible threat or suffer phantom strikes.',160,70,21),
(16,'Fusion of Spirit Fragments','Four spirit fragments grant power, but miscalculating their fusion shatters them violently, leaving you weakened.',150,65,23),
(17,'Word of True Might','Speak a word of power meeting strict conditions. Weak words are consumed by darkness and sap your strength.',170,70,22),
(18,'Endurance of the Shadows','Three shadow strikes aim to break your resolve. Collapse and recovery will be slow.',190,80,19),
(19,'The Hidden Number','A concealed number holds the key to passage. Fail to guess it and a mysterious backlash weakens you.',140,60,21),
(20,'Duel with the Void Guardian','Face a powerful guardian. Outroll its strength by at least 3 points or be struck and wounded.',200,90,20),
(21,'Silence of the Void','A riddle of absence and silence. Solve it or have the void drain your willpower.',150,65,23),
(22,'Trial of the Statues of Mezanod','Four statues present a logic puzzle. Deduce their correct order or the puzzle resets, draining your focus.',180,75,22);
/*!40000 ALTER TABLE `quests` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `shop_items`
--

DROP TABLE IF EXISTS `shop_items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `shop_items` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `shop_id` int(11) NOT NULL,
  `item_id` int(11) NOT NULL,
  `price_override` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_shop_items_shop` (`shop_id`),
  KEY `fk_shop_items_item` (`item_id`),
  CONSTRAINT `fk_shop_items_item` FOREIGN KEY (`item_id`) REFERENCES `items` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_shop_items_shop` FOREIGN KEY (`shop_id`) REFERENCES `shops` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=45 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `shop_items`
--

LOCK TABLES `shop_items` WRITE;
/*!40000 ALTER TABLE `shop_items` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `shop_items` VALUES
(1,1,11,305),
(2,1,8,174),
(3,1,3,167),
(4,1,1,80),
(5,1,6,696),
(6,1,7,319),
(7,1,19,232),
(8,1,4,174),
(9,1,26,435),
(10,1,23,131),
(11,1,24,109),
(12,2,3,115),
(13,2,1,55),
(14,2,17,60),
(15,2,8,120),
(16,2,10,85),
(17,2,12,85),
(18,2,16,95),
(19,2,20,85),
(20,2,21,20),
(21,2,23,90),
(22,2,24,75),
(23,3,11,273),
(24,3,3,150),
(25,3,8,156),
(26,3,17,78),
(27,3,7,286),
(28,3,6,624),
(29,3,19,208),
(30,3,14,59),
(31,3,26,390),
(32,3,21,26),
(33,3,24,98),
(34,4,1,47),
(35,4,17,51),
(36,4,3,98),
(37,4,14,38),
(38,4,10,72),
(39,4,12,72),
(40,4,20,72),
(41,4,4,102),
(42,4,21,17),
(43,4,23,77),
(44,4,24,64);
/*!40000 ALTER TABLE `shop_items` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `shops`
--

DROP TABLE IF EXISTS `shops`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `shops` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `region_id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_shops_location` (`region_id`),
  CONSTRAINT `fk_shops_location` FOREIGN KEY (`region_id`) REFERENCES `nations` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `shops`
--

LOCK TABLES `shops` WRITE;
/*!40000 ALTER TABLE `shops` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `shops` VALUES
(1,6,'Embervault Exchange'),
(2,1,'Tideglass Emporium'),
(3,10,'Dunebound Reliquary'),
(4,4,'Lumenroot Curios');
/*!40000 ALTER TABLE `shops` ENABLE KEYS */;
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

-- Dump completed on 2026-04-25 14:33:56
