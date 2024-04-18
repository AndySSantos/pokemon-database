DROP TABLE IF EXISTS `abilities`;
CREATE TABLE `abilities` (
  `abil_id` int(11) NOT NULL AUTO_INCREMENT,
  `abil_name` varchar(79) NOT NULL,
  PRIMARY KEY (`abil_id`)
) ENGINE=InnoDB AUTO_INCREMENT=192 DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `pokemon`;
CREATE TABLE `pokemon` (
  `pok_id` int(11) NOT NULL AUTO_INCREMENT,
  `pok_name` varchar(79) NOT NULL,
  `pok_height` int(11) DEFAULT NULL,
  `pok_weight` int(11) DEFAULT NULL,
  `pok_base_experience` int(11) DEFAULT NULL,
  PRIMARY KEY (`pok_id`)
) ENGINE=InnoDB AUTO_INCREMENT=724 DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `base_stats`;
CREATE TABLE `base_stats` (
  `pok_id` int(11) NOT NULL,
  `b_hp` int(11) DEFAULT NULL,
  `b_atk` int(11) DEFAULT NULL,
  `b_def` int(11) DEFAULT NULL,
  `b_sp_atk` int(11) DEFAULT NULL,
  `b_sp_def` int(11) DEFAULT NULL,
  `b_speed` int(11) DEFAULT NULL,
  PRIMARY KEY (`pok_id`),
  CONSTRAINT `pok_id` FOREIGN KEY (`pok_id`) REFERENCES `pokemon` (`pok_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `pokemon_abilities`;
CREATE TABLE `pokemon_abilities` (
  `pok_id` int(11) NOT NULL,
  `abil_id` int(11) NOT NULL,
  `is_hidden` tinyint(1) NOT NULL,
  `slot` int(11) NOT NULL,
  PRIMARY KEY (`pok_id`,`slot`),
  KEY `abil_id` (`abil_id`),
  KEY `ix_pokemon_abilities_is_hidden` (`is_hidden`),
  CONSTRAINT `pokemon_abilities_ibfk_1` FOREIGN KEY (`pok_id`) REFERENCES `pokemon` (`pok_id`),
  CONSTRAINT `pokemon_abilities_ibfk_2` FOREIGN KEY (`abil_id`) REFERENCES `abilities` (`abil_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `pokemon_habitats`;
CREATE TABLE `pokemon_habitats` (
  `hab_id` int(11) NOT NULL,
  `hab_name` varchar(79) NOT NULL,
  `hab_descript` varchar(400) DEFAULT NULL,
  PRIMARY KEY (`hab_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `pokemon_evolution_matchup`;
CREATE TABLE `pokemon_evolution_matchup` (
  `pok_id` int(11) NOT NULL AUTO_INCREMENT,
  `evolves_from_species_id` int(11) DEFAULT NULL,
  `hab_id` int(11) DEFAULT NULL,
  `gender_rate` int(11) NOT NULL,
  `capture_rate` int(11) NOT NULL,
  `base_happiness` int(11) NOT NULL,
  PRIMARY KEY (`pok_id`),
  KEY `evolves_from_species_id` (`evolves_from_species_id`),
  KEY `habitat_id` (`hab_id`),
  CONSTRAINT `poke_fk` FOREIGN KEY (`pok_id`) REFERENCES `pokemon` (`pok_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `pokemon_evolution_matchup_ibfk_6` FOREIGN KEY (`hab_id`) REFERENCES `pokemon_habitats` (`hab_id`)
) ENGINE=InnoDB AUTO_INCREMENT=722 DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `pokemon_evolution`;
CREATE TABLE `pokemon_evolution` (
  `evol_id` int(11) NOT NULL AUTO_INCREMENT,
  `evolved_species_id` int(11) NOT NULL,
  `evol_minimum_level` int(11) DEFAULT NULL,
  PRIMARY KEY (`evol_id`),
  KEY `evolved_species_id` (`evolved_species_id`),
  CONSTRAINT `pokemon_evolution_ibfk_1` FOREIGN KEY (`evolved_species_id`) REFERENCES `pokemon_evolution_matchup` (`pok_id`)
) ENGINE=InnoDB AUTO_INCREMENT=366 DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `pokemon_move_methods`;
CREATE TABLE `pokemon_move_methods` (
  `method_id` int(11) NOT NULL,
  `method_name` varchar(79) NOT NULL,
  PRIMARY KEY (`method_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `type_efficacy`;
CREATE TABLE `type_efficacy` (
  `damage_type_id` int(11) NOT NULL,
  `target_type_id` int(11) NOT NULL,
  `damage_factor` int(11) NOT NULL,
  PRIMARY KEY (`damage_type_id`,`target_type_id`),
  KEY `target_type_id` (`target_type_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



DROP TABLE IF EXISTS `types`;
CREATE TABLE `types` (
  `type_id` int(11) NOT NULL AUTO_INCREMENT,
  `type_name` varchar(79) NOT NULL,
  `damage_type_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`type_id`),
  KEY `damage_type_idx` (`damage_type_id`),
  CONSTRAINT `damage_type` FOREIGN KEY (`damage_type_id`) REFERENCES `type_efficacy` (`damage_type_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=10003 DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `pokemon_types`;
CREATE TABLE `pokemon_types` (
  `pok_id` int(11) NOT NULL,
  `type_id` int(11) NOT NULL,
  `slot` int(11) NOT NULL,
  PRIMARY KEY (`pok_id`,`slot`),
  KEY `type_id` (`type_id`),
  CONSTRAINT `pokemon_types_ibfk_1` FOREIGN KEY (`pok_id`) REFERENCES `pokemon` (`pok_id`),
  CONSTRAINT `pokemon_types_ibfk_2` FOREIGN KEY (`type_id`) REFERENCES `types` (`type_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `moves`;
CREATE TABLE `moves` (
  `move_id` int(11) NOT NULL AUTO_INCREMENT,
  `move_name` varchar(79) NOT NULL,
  `type_id` int(11) NOT NULL,
  `move_power` smallint(6) DEFAULT NULL,
  `move_pp` smallint(6) DEFAULT NULL,
  `move_accuracy` smallint(6) DEFAULT NULL,
  PRIMARY KEY (`move_id`),
  KEY `type_id` (`type_id`),
  CONSTRAINT `moves_ibfk_2` FOREIGN KEY (`type_id`) REFERENCES `types` (`type_id`)
) ENGINE=InnoDB AUTO_INCREMENT=622 DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `version_groups`;
CREATE TABLE `version_groups` (
  `version_id` int(11) NOT NULL AUTO_INCREMENT,
  `version_name` varchar(79) NOT NULL,
  `order` int(11) DEFAULT NULL,
  PRIMARY KEY (`version_id`),
  UNIQUE KEY `identifier` (`version_name`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `pokemon_moves`;
CREATE TABLE `pokemon_moves` (
  `pok_id` int(11) NOT NULL,
  `version_group_id` int(11) NOT NULL,
  `move_id` int(11) NOT NULL,
  `method_id` int(11) NOT NULL,
  `level` int(11) NOT NULL,
  PRIMARY KEY (`pok_id`,`version_group_id`,`move_id`,`method_id`,`level`),
  KEY `ix_pokemon_moves_level` (`level`),
  KEY `ix_pokemon_moves_version_group_id` (`version_group_id`),
  KEY `ix_pokemon_moves_move_id` (`move_id`),
  KEY `ix_pokemon_moves_pokemon_move_method_id` (`method_id`),
  KEY `ix_pokemon_moves_pokemon_id` (`pok_id`),
  CONSTRAINT `pokemon_moves_ibfk_1` FOREIGN KEY (`pok_id`) REFERENCES `pokemon` (`pok_id`),
  CONSTRAINT `pokemon_moves_ibfk_2` FOREIGN KEY (`move_id`) REFERENCES `moves` (`move_id`),
  CONSTRAINT `pokemon_moves_ibfk_3` FOREIGN KEY (`version_group_id`) REFERENCES `version_groups` (`version_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `pokemon_moves_ibfk_4` FOREIGN KEY (`method_id`) REFERENCES `pokemon_move_methods` (`method_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;