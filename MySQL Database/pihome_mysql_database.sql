-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Server version:               5.6.20 - MySQL Community Server (GPL)
-- Server OS:                    Win32
-- HeidiSQL Version:             9.4.0.5174
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;


-- Dumping database structure for pihome
DROP DATABASE IF EXISTS `pihome`;
CREATE DATABASE IF NOT EXISTS `pihome` /*!40100 DEFAULT CHARACTER SET utf16 COLLATE utf16_bin */;
USE `pihome`;

-- Dumping structure for table pihome.away
DROP TABLE IF EXISTS `away`;
CREATE TABLE IF NOT EXISTS `away` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `status` tinyint(4) DEFAULT NULL,
  `start_datetime` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `end_datetime` timestamp NULL DEFAULT NULL,
  `away_button_id` int(11) DEFAULT '40',
  `away_button_child_id` int(11) DEFAULT '4',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf16 COLLATE=utf16_bin;

-- Dumping data for table pihome.away: ~0 rows (approximately)
/*!40000 ALTER TABLE `away` DISABLE KEYS */;
REPLACE INTO `away` (`id`, `status`, `start_datetime`, `end_datetime`, `away_button_id`, `away_button_child_id`) VALUES
	(1, 0, '2017-10-30 15:27:17', NULL, 40, 4);
/*!40000 ALTER TABLE `away` ENABLE KEYS */;

-- Dumping structure for table pihome.boiler
DROP TABLE IF EXISTS `boiler`;
CREATE TABLE IF NOT EXISTS `boiler` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `status` tinyint(4) DEFAULT '0',
  `fired_status` tinyint(4) DEFAULT '0',
  `name` char(50) COLLATE utf16_bin DEFAULT 'Gas Boiler',
  `node_id` int(11) DEFAULT NULL,
  `node_child_id` int(11) DEFAULT '1',
  `hysteresis_time` tinyint(4) DEFAULT '3',
  `max_operation_time` tinyint(4) DEFAULT '60',
  `datetime` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `FK_boiler_zone` (`node_id`),
  CONSTRAINT `FK_boiler_zone` FOREIGN KEY (`node_id`) REFERENCES `nodes` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf16 COLLATE=utf16_bin;

-- Dumping data for table pihome.boiler: ~0 rows (approximately)
/*!40000 ALTER TABLE `boiler` DISABLE KEYS */;
REPLACE INTO `boiler` (`id`, `status`, `fired_status`, `name`, `node_id`, `node_child_id`, `hysteresis_time`, `max_operation_time`, `datetime`) VALUES
	(1, 1, 1, 'Gas Boiler', 5, 1, 3, 60, '2017-11-03 00:49:02');
/*!40000 ALTER TABLE `boiler` ENABLE KEYS */;

-- Dumping structure for table pihome.boiler_logs
DROP TABLE IF EXISTS `boiler_logs`;
CREATE TABLE IF NOT EXISTS `boiler_logs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `start_datetime` timestamp NULL DEFAULT NULL,
  `start_cause` char(50) COLLATE utf16_bin DEFAULT NULL,
  `stop_datetime` timestamp NULL DEFAULT NULL,
  `stop_cause` char(50) COLLATE utf16_bin DEFAULT NULL,
  `expected_end_date_time` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=731 DEFAULT CHARSET=utf16 COLLATE=utf16_bin;

-- Dumping data for table pihome.boiler_logs: ~0 rows (approximately)
/*!40000 ALTER TABLE `boiler_logs` DISABLE KEYS */;
/*!40000 ALTER TABLE `boiler_logs` ENABLE KEYS */;

-- Dumping structure for table pihome.boost
DROP TABLE IF EXISTS `boost`;
CREATE TABLE IF NOT EXISTS `boost` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `status` tinyint(4) DEFAULT '0',
  `zone_id` int(11) DEFAULT NULL,
  `time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `temperature` tinyint(4) DEFAULT NULL,
  `minute` tinyint(4) DEFAULT '30',
  `boost_button_id` int(11) DEFAULT NULL,
  `boost_button_child_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_boost_zone` (`zone_id`),
  CONSTRAINT `FK_boost_zone` FOREIGN KEY (`zone_id`) REFERENCES `zone` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf16 COLLATE=utf16_bin;

-- Dumping data for table pihome.boost: ~3 rows (approximately)
/*!40000 ALTER TABLE `boost` DISABLE KEYS */;
REPLACE INTO `boost` (`id`, `status`, `zone_id`, `time`, `temperature`, `minute`, `boost_button_id`, `boost_button_child_id`) VALUES
	(8, 0, 33, '2017-10-07 00:17:02', 23, 30, 40, 1),
	(9, 0, 34, '2017-10-16 13:12:27', 23, 30, 40, 2),
	(10, 0, 35, '2017-10-30 13:46:02', 35, 30, 40, 3);
/*!40000 ALTER TABLE `boost` ENABLE KEYS */;

-- Dumping structure for table pihome.frost_protection
DROP TABLE IF EXISTS `frost_protection`;
CREATE TABLE IF NOT EXISTS `frost_protection` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `datetime` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `temperature` tinyint(4) DEFAULT '5',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

-- Dumping data for table pihome.frost_protection: ~0 rows (approximately)
/*!40000 ALTER TABLE `frost_protection` DISABLE KEYS */;
REPLACE INTO `frost_protection` (`id`, `datetime`, `temperature`) VALUES
	(1, '2017-06-16 15:55:48', -1);
/*!40000 ALTER TABLE `frost_protection` ENABLE KEYS */;

-- Dumping structure for table pihome.gateway
DROP TABLE IF EXISTS `gateway`;
CREATE TABLE IF NOT EXISTS `gateway` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` char(50) COLLATE utf16_bin NOT NULL DEFAULT 'serial' COMMENT 'serial or wifi',
  `location` char(50) COLLATE utf16_bin NOT NULL DEFAULT '/dev/ttyAMA0' COMMENT 'ip address or serial port location i.e. /dev/ttyAMA0',
  `port` char(50) COLLATE utf16_bin NOT NULL DEFAULT '115200' COMMENT 'port number 5003 or baud rate115200 for serial gateway',
  `timout` char(50) COLLATE utf16_bin NOT NULL DEFAULT '3',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf16 COLLATE=utf16_bin;

-- Dumping data for table pihome.gateway: ~0 rows (approximately)
/*!40000 ALTER TABLE `gateway` DISABLE KEYS */;
REPLACE INTO `gateway` (`id`, `type`, `location`, `port`, `timout`) VALUES
	(1, 'wifi', '192.168.99.3', '5003', '3');
/*!40000 ALTER TABLE `gateway` ENABLE KEYS */;

-- Dumping structure for table pihome.gateway_logs
DROP TABLE IF EXISTS `gateway_logs`;
CREATE TABLE IF NOT EXISTS `gateway_logs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` char(50) COLLATE utf16_bin DEFAULT 'wifi' COMMENT 'serial or wifi',
  `location` char(50) COLLATE utf16_bin DEFAULT '192.168.99.3' COMMENT 'ip address or serial port location i.e. /dev/ttyAMA0',
  `port` char(50) COLLATE utf16_bin DEFAULT '5003' COMMENT 'port number or baud rate for serial gateway',
  `pid` char(50) COLLATE utf16_bin DEFAULT NULL,
  `pid_start_time` char(50) COLLATE utf16_bin DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf16 COLLATE=utf16_bin;

-- Dumping data for table pihome.gateway_logs: ~0 rows (approximately)
/*!40000 ALTER TABLE `gateway_logs` DISABLE KEYS */;
/*!40000 ALTER TABLE `gateway_logs` ENABLE KEYS */;

-- Dumping structure for table pihome.messages_in
DROP TABLE IF EXISTS `messages_in`;
CREATE TABLE IF NOT EXISTS `messages_in` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `node_id` tinyint(4) DEFAULT NULL,
  `child_id` tinyint(4) DEFAULT NULL,
  `sub_type` int(11) DEFAULT NULL,
  `payload` decimal(10,2) DEFAULT NULL,
  `datetime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf16 COLLATE=utf16_bin;

-- Dumping data for table pihome.messages_in: ~0 rows (approximately)
/*!40000 ALTER TABLE `messages_in` DISABLE KEYS */;
/*!40000 ALTER TABLE `messages_in` ENABLE KEYS */;

-- Dumping structure for table pihome.messages_out
DROP TABLE IF EXISTS `messages_out`;
CREATE TABLE IF NOT EXISTS `messages_out` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `node_id` int(11) NOT NULL COMMENT 'Node ID',
  `child_id` int(11) NOT NULL COMMENT 'Child Sensor',
  `sub_type` int(11) NOT NULL COMMENT 'Command Type',
  `ack` int(11) NOT NULL COMMENT 'Ack Req/Resp',
  `type` int(11) NOT NULL COMMENT 'Type',
  `payload` varchar(100) CHARACTER SET utf8 NOT NULL COMMENT 'Payload',
  `sent` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'Sent Status 0 No - 1 Yes',
  `datetime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Current datetime',
  `zone_id` int(11) NOT NULL COMMENT 'Zone ID related to this entery',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf32 COLLATE=utf32_bin;

-- Dumping data for table pihome.messages_out: ~7 rows (approximately)
/*!40000 ALTER TABLE `messages_out` DISABLE KEYS */;
REPLACE INTO `messages_out` (`id`, `node_id`, `child_id`, `sub_type`, `ack`, `type`, `payload`, `sent`, `datetime`, `zone_id`) VALUES
	(15, 101, 1, 1, 1, 2, '1', 1, '2017-11-03 00:51:02', 33),
	(17, 101, 2, 1, 1, 2, '1', 1, '2017-11-03 00:51:03', 34),
	(19, 101, 3, 1, 1, 2, '1', 1, '2017-11-03 00:51:04', 35),
	(21, 40, 1, 1, 1, 2, '1', 1, '2017-10-06 13:22:14', 33),
	(22, 40, 2, 1, 1, 2, '0', 1, '2017-10-06 13:12:10', 34),
	(23, 40, 3, 1, 1, 2, '1', 1, '2017-10-06 13:20:59', 35),
	(24, 100, 1, 1, 1, 2, '1', 1, '2017-11-03 00:51:05', 0);
/*!40000 ALTER TABLE `messages_out` ENABLE KEYS */;

-- Dumping structure for table pihome.nodes
DROP TABLE IF EXISTS `nodes`;
CREATE TABLE IF NOT EXISTS `nodes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `node_id` int(11) NOT NULL,
  `child_id_1` int(11) DEFAULT NULL,
  `child_id_2` int(11) DEFAULT NULL,
  `child_id_3` int(11) DEFAULT NULL,
  `child_id_4` int(11) DEFAULT NULL,
  `child_id_5` int(11) DEFAULT NULL,
  `child_id_6` int(11) DEFAULT NULL,
  `child_id_7` int(11) DEFAULT NULL,
  `child_id_8` int(11) DEFAULT NULL,
  `name` char(50) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `last_seen` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `status` char(50) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `ms_version` char(50) COLLATE utf16_bin DEFAULT NULL,
  `sketch_version` char(50) COLLATE utf16_bin DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=117 DEFAULT CHARSET=utf16 COLLATE=utf16_bin;

-- Dumping data for table pihome.nodes: ~7 rows (approximately)
/*!40000 ALTER TABLE `nodes` DISABLE KEYS */;
REPLACE INTO `nodes` (`id`, `node_id`, `child_id_1`, `child_id_2`, `child_id_3`, `child_id_4`, `child_id_5`, `child_id_6`, `child_id_7`, `child_id_8`, `name`, `last_seen`, `status`, `ms_version`, `sketch_version`) VALUES
	(1, 21, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Temperature Sensor', '2017-11-02 22:47:34', 'Active', '2.1.1', '1.34'),
	(2, 20, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Temperature Sensor', '2017-11-02 22:43:29', 'Active', '2.1.1', '1.34'),
	(4, 30, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Temperature Sensor', '2017-11-02 22:50:51', 'Active', '2.1.1', '1.34'),
	(5, 100, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Boiler Relay', '2017-09-11 17:01:54', 'Active', NULL, NULL),
	(6, 25, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Temperature Sensor', '2017-11-02 22:49:08', '000', '2.1.1', '1.34'),
	(112, 101, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Zone Controller Relay', '2017-10-30 15:45:06', NULL, '2.1.1', '1.2'),
	(116, 40, 5, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Button Console', '2017-10-06 13:09:31', NULL, '2.1.1', '1.31');
/*!40000 ALTER TABLE `nodes` ENABLE KEYS */;

-- Dumping structure for table pihome.nodes_battery
DROP TABLE IF EXISTS `nodes_battery`;
CREATE TABLE IF NOT EXISTS `nodes_battery` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `node_id` int(11) DEFAULT NULL,
  `bat_voltage` decimal(10,2) DEFAULT NULL,
  `bat_level` decimal(10,2) DEFAULT NULL,
  `update` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf16 COLLATE=utf16_bin;

-- Dumping data for table pihome.nodes_battery: ~0 rows (approximately)
/*!40000 ALTER TABLE `nodes_battery` DISABLE KEYS */;
/*!40000 ALTER TABLE `nodes_battery` ENABLE KEYS */;

-- Dumping structure for table pihome.override
DROP TABLE IF EXISTS `override`;
CREATE TABLE IF NOT EXISTS `override` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `status` tinyint(4) DEFAULT '0',
  `zone_id` int(11) DEFAULT NULL,
  `time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `temperature` tinyint(4) DEFAULT '22',
  PRIMARY KEY (`id`),
  KEY `FK_override_zone` (`zone_id`),
  CONSTRAINT `FK_override_zone` FOREIGN KEY (`zone_id`) REFERENCES `zone` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf16 COLLATE=utf16_bin;

-- Dumping data for table pihome.override: ~3 rows (approximately)
/*!40000 ALTER TABLE `override` DISABLE KEYS */;
REPLACE INTO `override` (`id`, `status`, `zone_id`, `time`, `temperature`) VALUES
	(8, 0, 33, '2017-09-22 12:00:18', 24),
	(9, 0, 34, '2017-09-22 12:00:19', 24),
	(10, 0, 35, '2017-07-14 16:35:55', 35);
/*!40000 ALTER TABLE `override` ENABLE KEYS */;

-- Dumping structure for table pihome.schedule_daily_time
DROP TABLE IF EXISTS `schedule_daily_time`;
CREATE TABLE IF NOT EXISTS `schedule_daily_time` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `status` tinyint(4) DEFAULT NULL,
  `start` time DEFAULT NULL,
  `end` time DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=74 DEFAULT CHARSET=utf16 COLLATE=utf16_bin;

-- Dumping data for table pihome.schedule_daily_time: ~13 rows (approximately)
/*!40000 ALTER TABLE `schedule_daily_time` DISABLE KEYS */;
REPLACE INTO `schedule_daily_time` (`id`, `status`, `start`, `end`) VALUES
	(59, 1, '15:00:00', '15:30:00'),
	(60, 1, '18:00:00', '18:30:00'),
	(61, 1, '19:00:00', '19:45:00'),
	(64, 1, '16:00:00', '16:45:00'),
	(65, 1, '09:00:00', '09:30:00'),
	(66, 1, '11:00:00', '11:20:00'),
	(67, 1, '12:00:00', '12:30:00'),
	(68, 1, '14:00:00', '14:30:00'),
	(69, 1, '17:00:00', '17:45:00'),
	(70, 1, '08:00:00', '08:20:00'),
	(71, 1, '10:00:00', '10:20:00'),
	(72, 1, '13:00:00', '13:30:00'),
	(73, 1, '07:00:00', '07:30:00');
/*!40000 ALTER TABLE `schedule_daily_time` ENABLE KEYS */;

-- Dumping structure for table pihome.schedule_daily_time_zone
DROP TABLE IF EXISTS `schedule_daily_time_zone`;
CREATE TABLE IF NOT EXISTS `schedule_daily_time_zone` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `status` tinyint(4) DEFAULT NULL,
  `schedule_daily_time_id` int(11) DEFAULT NULL,
  `zone_id` int(11) DEFAULT NULL,
  `temperature` tinyint(4) DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `FK_schedule_daily_time_zone_schedule_daily_time` (`schedule_daily_time_id`),
  KEY `FK_schedule_daily_time_zone_zone` (`zone_id`),
  CONSTRAINT `FK_schedule_daily_time_zone_schedule_daily_time` FOREIGN KEY (`schedule_daily_time_id`) REFERENCES `schedule_daily_time` (`id`),
  CONSTRAINT `FK_schedule_daily_time_zone_zone` FOREIGN KEY (`zone_id`) REFERENCES `zone` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=173 DEFAULT CHARSET=utf16 COLLATE=utf16_bin;

-- Dumping data for table pihome.schedule_daily_time_zone: ~39 rows (approximately)
/*!40000 ALTER TABLE `schedule_daily_time_zone` DISABLE KEYS */;
REPLACE INTO `schedule_daily_time_zone` (`id`, `status`, `schedule_daily_time_id`, `zone_id`, `temperature`) VALUES
	(120, 1, 59, 33, 21),
	(121, 0, 59, 34, 0),
	(122, 1, 59, 35, 26),
	(123, 1, 60, 33, 21),
	(124, 0, 60, 34, 23),
	(125, 0, 60, 35, 0),
	(126, 1, 61, 33, 21),
	(127, 0, 61, 34, 0),
	(128, 1, 61, 35, 26),
	(135, 1, 64, 33, 21),
	(136, 0, 64, 34, 0),
	(137, 1, 64, 35, 26),
	(139, 1, 65, 33, 20),
	(140, 0, 65, 34, 0),
	(141, 1, 65, 35, 30),
	(145, 1, 66, 33, 21),
	(146, 0, 66, 34, 0),
	(147, 0, 66, 35, 0),
	(148, 1, 67, 33, 21),
	(149, 0, 67, 34, 0),
	(150, 1, 67, 35, 25),
	(151, 1, 68, 33, 22),
	(152, 0, 68, 34, 0),
	(153, 0, 68, 35, 0),
	(154, 1, 69, 33, 21),
	(155, 0, 69, 34, 0),
	(156, 0, 69, 35, 0),
	(158, 1, 70, 33, 21),
	(159, 0, 70, 34, 0),
	(160, 0, 70, 35, 0),
	(162, 1, 71, 33, 21),
	(163, 0, 71, 34, 0),
	(164, 1, 71, 35, 30),
	(166, 0, 72, 33, 21),
	(167, 0, 72, 34, 0),
	(168, 0, 72, 35, 0),
	(170, 1, 73, 33, 21),
	(171, 1, 73, 34, 21),
	(172, 1, 73, 35, 27);
/*!40000 ALTER TABLE `schedule_daily_time_zone` ENABLE KEYS */;

-- Dumping structure for table pihome.schedule_night_climate_time
DROP TABLE IF EXISTS `schedule_night_climate_time`;
CREATE TABLE IF NOT EXISTS `schedule_night_climate_time` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `status` tinyint(4) DEFAULT NULL,
  `start_time` time DEFAULT '21:00:00',
  `end_time` time DEFAULT '06:00:00',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf16 COLLATE=utf16_bin;

-- Dumping data for table pihome.schedule_night_climate_time: ~0 rows (approximately)
/*!40000 ALTER TABLE `schedule_night_climate_time` DISABLE KEYS */;
REPLACE INTO `schedule_night_climate_time` (`id`, `status`, `start_time`, `end_time`) VALUES
	(1, 1, '21:00:00', '06:00:00');
/*!40000 ALTER TABLE `schedule_night_climate_time` ENABLE KEYS */;

-- Dumping structure for table pihome.schedule_night_climat_zone
DROP TABLE IF EXISTS `schedule_night_climat_zone`;
CREATE TABLE IF NOT EXISTS `schedule_night_climat_zone` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `status` tinyint(4) DEFAULT NULL,
  `zone_id` int(11) DEFAULT NULL,
  `schedule_night_climate_id` int(11) DEFAULT NULL,
  `min_temperature` int(11) DEFAULT '18',
  `max_temperature` int(11) DEFAULT '21',
  PRIMARY KEY (`id`),
  KEY `FK_schedule_zone_night_climat_zone` (`zone_id`),
  KEY `FK_schedule_zone_night_climat_schedule_night_climate` (`schedule_night_climate_id`),
  CONSTRAINT `FK_schedule_zone_night_climat_schedule_night_climate` FOREIGN KEY (`schedule_night_climate_id`) REFERENCES `schedule_night_climate_time` (`id`),
  CONSTRAINT `FK_schedule_zone_night_climat_zone` FOREIGN KEY (`zone_id`) REFERENCES `zone` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf16 COLLATE=utf16_bin;

-- Dumping data for table pihome.schedule_night_climat_zone: ~3 rows (approximately)
/*!40000 ALTER TABLE `schedule_night_climat_zone` DISABLE KEYS */;
REPLACE INTO `schedule_night_climat_zone` (`id`, `status`, `zone_id`, `schedule_night_climate_id`, `min_temperature`, `max_temperature`) VALUES
	(8, 0, 33, 1, 18, 21),
	(9, 1, 34, 1, 18, 21),
	(10, 0, 35, 1, 18, 21);
/*!40000 ALTER TABLE `schedule_night_climat_zone` ENABLE KEYS */;

-- Dumping structure for table pihome.system
DROP TABLE IF EXISTS `system`;
CREATE TABLE IF NOT EXISTS `system` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) COLLATE utf16_bin DEFAULT NULL,
  `version` varchar(50) CHARACTER SET latin1 DEFAULT NULL,
  `build` varchar(50) COLLATE utf16_bin DEFAULT NULL,
  `update_location` char(250) CHARACTER SET latin1 DEFAULT NULL,
  `update_file` char(100) CHARACTER SET latin1 DEFAULT NULL,
  `update_alias` char(100) CHARACTER SET latin1 DEFAULT NULL,
  `country` char(2) CHARACTER SET latin1 DEFAULT NULL,
  `city` char(100) CHARACTER SET latin1 DEFAULT NULL,
  `openweather_api` char(100) CHARACTER SET latin1 DEFAULT NULL,
  `backup_email` char(100) COLLATE utf16_bin DEFAULT NULL,
  `ping_home` bit(1) DEFAULT b'1',
  `pi_serial` varchar(50) COLLATE utf16_bin DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf16 COLLATE=utf16_bin;

-- Dumping data for table pihome.system: ~0 rows (approximately)
/*!40000 ALTER TABLE `system` DISABLE KEYS */;
REPLACE INTO `system` (`id`, `name`, `version`, `build`, `update_location`, `update_file`, `update_alias`, `country`, `city`, `openweather_api`, `backup_email`, `ping_home`, `pi_serial`) VALUES
	(2, 'PiHome - Smart Heating Control', '0.21', '181717', 'http://www.pihome.eu/updates/', 'current-release-versions.php', 'pihome', 'IE', 'Portlaoise', '', 'info@pihome.eu', b'1', '1');
/*!40000 ALTER TABLE `system` ENABLE KEYS */;

-- Dumping structure for table pihome.user
DROP TABLE IF EXISTS `user`;
CREATE TABLE IF NOT EXISTS `user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `account_enable` tinyint(1) DEFAULT NULL,
  `fullname` varchar(100) NOT NULL,
  `username` varchar(25) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(255) NOT NULL,
  `cpdate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `account_date` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `backup` tinyint(4) DEFAULT NULL,
  `users` tinyint(4) DEFAULT NULL,
  `support` tinyint(4) DEFAULT NULL,
  `settings` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

-- Dumping data for table pihome.user: ~0 rows (approximately)
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
REPLACE INTO `user` (`id`, `account_enable`, `fullname`, `username`, `email`, `password`, `cpdate`, `account_date`, `backup`, `users`, `support`, `settings`) VALUES
	(1, 1, 'Administrator', 'admin', 'info@pihome.eu', '0f5f9ba0136d5a8588b3fc70ec752869', '2017-11-03 00:58:12', '2017-06-13 15:10:31', 1, 1, 1, 1);
/*!40000 ALTER TABLE `user` ENABLE KEYS */;

-- Dumping structure for table pihome.weather
DROP TABLE IF EXISTS `weather`;
CREATE TABLE IF NOT EXISTS `weather` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `location` varchar(50) COLLATE utf8_bin DEFAULT NULL,
  `c` tinyint(4) DEFAULT NULL,
  `wind_speed` varchar(50) COLLATE utf8_bin DEFAULT NULL,
  `title` varchar(50) COLLATE utf8_bin DEFAULT NULL,
  `description` varchar(50) COLLATE utf8_bin DEFAULT NULL,
  `sunrise` varchar(50) COLLATE utf8_bin DEFAULT NULL,
  `sunset` varchar(50) COLLATE utf8_bin DEFAULT NULL,
  `img` varchar(50) COLLATE utf8_bin DEFAULT NULL,
  `last_update` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Last weather update',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- Dumping data for table pihome.weather: ~0 rows (approximately)
/*!40000 ALTER TABLE `weather` DISABLE KEYS */;
REPLACE INTO `weather` (`id`, `location`, `c`, `wind_speed`, `title`, `description`, `sunrise`, `sunset`, `img`, `last_update`) VALUES
	(1, 'Portlaoise', 9, '4.18', 'Clouds', 'broken clouds', '1509694256', '1509728026', '04n', '2017-11-03 00:30:02');
/*!40000 ALTER TABLE `weather` ENABLE KEYS */;

-- Dumping structure for table pihome.zone
DROP TABLE IF EXISTS `zone`;
CREATE TABLE IF NOT EXISTS `zone` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `status` tinyint(4) DEFAULT NULL,
  `index_id` tinyint(4) DEFAULT NULL,
  `name` char(50) CHARACTER SET latin1 DEFAULT NULL,
  `type` char(50) CHARACTER SET latin1 DEFAULT NULL,
  `model` char(50) CHARACTER SET latin1 DEFAULT NULL,
  `max_c` tinyint(4) DEFAULT NULL,
  `max_operation_time` tinyint(4) DEFAULT NULL,
  `hysteresis_time` tinyint(4) DEFAULT NULL,
  `sensor_id` int(11) DEFAULT NULL,
  `sensor_child_id` int(11) DEFAULT NULL,
  `controler_id` int(11) DEFAULT NULL,
  `controler_child_id` int(11) DEFAULT NULL,
  `boiler_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_zone_nodes` (`sensor_id`),
  KEY `FK_zone_nodes_2` (`controler_id`),
  KEY `FK_zone_boiler` (`boiler_id`),
  CONSTRAINT `FK_zone_boiler` FOREIGN KEY (`boiler_id`) REFERENCES `boiler` (`id`),
  CONSTRAINT `FK_zone_nodes` FOREIGN KEY (`sensor_id`) REFERENCES `nodes` (`id`),
  CONSTRAINT `FK_zone_nodes_2` FOREIGN KEY (`controler_id`) REFERENCES `nodes` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=36 DEFAULT CHARSET=utf16 COLLATE=utf16_bin;

-- Dumping data for table pihome.zone: ~3 rows (approximately)
/*!40000 ALTER TABLE `zone` DISABLE KEYS */;
REPLACE INTO `zone` (`id`, `status`, `index_id`, `name`, `type`, `model`, `max_c`, `max_operation_time`, `hysteresis_time`, `sensor_id`, `sensor_child_id`, `controler_id`, `controler_child_id`, `boiler_id`) VALUES
	(33, 1, 1, 'Ground Floor', 'Heating', NULL, 23, 60, 3, 1, 0, 112, 1, 1),
	(34, 1, 2, 'First Floor', 'Heating', NULL, 23, 60, 3, 2, 0, 112, 2, 1),
	(35, 1, 5, 'Ch. Hot Water', 'Water', NULL, 40, 60, 3, 4, 0, 112, 3, 1);
/*!40000 ALTER TABLE `zone` ENABLE KEYS */;

-- Dumping structure for table pihome.zone_logs
DROP TABLE IF EXISTS `zone_logs`;
CREATE TABLE IF NOT EXISTS `zone_logs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `zone_id` int(11) DEFAULT NULL,
  `boiler_log_id` int(11) DEFAULT NULL,
  `status` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_zone_logs_zone` (`zone_id`),
  KEY `FK_zone_logs_boiler_logs` (`boiler_log_id`),
  CONSTRAINT `FK_zone_logs_boiler_logs` FOREIGN KEY (`boiler_log_id`) REFERENCES `boiler_logs` (`id`),
  CONSTRAINT `FK_zone_logs_zone` FOREIGN KEY (`zone_id`) REFERENCES `zone` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf16 COLLATE=utf16_bin;

-- Dumping data for table pihome.zone_logs: ~0 rows (approximately)
/*!40000 ALTER TABLE `zone_logs` DISABLE KEYS */;
/*!40000 ALTER TABLE `zone_logs` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
