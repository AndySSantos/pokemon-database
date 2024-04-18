CREATE PROCEDURE `output_pokemon_types` (IN var1 varchar(8))
BEGIN
SELECT pokemon.pok_id, pokemon.pok_name, types.type_name
FROM pokemon
INNER JOIN pokemon_types
ON pokemon.pok_id = pokemon_types.pok_id
INNER JOIN types
ON pokemon_types.type_id = types.type_id
WHERE types.type_name LIKE var1;

call output_pokemon_types('charizard');
END;

CREATE PROCEDURE `output_pokemon_habitat` (IN var1 varchar(8))
BEGIN
SELECT pokemon.pok_id, pokemon.pok_name, pokemon_habitats.hab_name
FROM pokemon
INNER JOIN pokemon_evolution_matchup
ON pokemon.pok_id = pokemon_evolution_matchup.pok_id
INNER JOIN pokemon_habitats
ON pokemon_evolution_matchup.hab_id = pokemon_habitats.hab_id
WHERE pokemon_habitats.hab_name LIKE var1;

call output_pokemon_habitat('cave');
END;

CREATE PROCEDURE `output_pokemon_fainted` (IN var1 varchar(79), IN var2 varchar(79))
BEGIN
SELECT pokemon.pok_id, pokemon.pok_name, moves.move_name
FROM pokemon
INNER JOIN base_stats
ON pokemon.pok_id = base_stats.pok_id
INNER JOIN pokemon_moves
ON pokemon.pok_id = pokemon_moves.pok_id
INNER JOIN moves
ON moves.move_name LIKE var1
WHERE pokemon.pok_name LIKE var2 and moves.move_name LIKE var1 and moves.move_power - base_stats.b_hp >= 0
GROUP BY pokemon.pok_id;

call output_pokemon_fainted('mega-punch','Venusaur');
END;

CREATE PROCEDURE `output_pokemon_moves` (IN var1 varchar(79))
BEGIN
SELECT pokemon.pok_id, pokemon.pok_name, moves.move_name
FROM pokemon
INNER JOIN pokemon_moves
ON pokemon.pok_id = pokemon_moves.pok_id
INNER JOIN moves
ON pokemon_moves.move_id = moves.move_id
WHERE pokemon.pok_name LIKE var1;

call output_pokemon_moves('venusaur');
END;


CREATE PROCEDURE `output_pokemon_abilities` (IN var1 varchar(79))
BEGIN
SELECT pokemon.pok_id, pokemon.pok_name, abilities.abil_name
FROM pokemon
INNER JOIN pokemon_abilities
ON pokemon.pok_id = pokemon_abilities.pok_id
INNER JOIN abilities
ON pokemon_abilities.abil_id = abilities.abil_id
WHERE pokemon.pok_name LIKE var1;

call output_pokemon_abilities('venusaur');
END;


CREATE PROCEDURE `output_pokemon_moves_types` (IN var1 varchar(79))
BEGIN
SELECT moves.move_name, types.type_name
FROM moves
INNER JOIN types
ON moves.type_id = types.type_id
WHERE moves.move_name LIKE var1;

call output_pokemon_moves_types('fire-punch');
END;


CREATE PROCEDURE `output_pokemon_type_efficacy` (IN var1 varchar(79))
BEGIN
SELECT types.type_id, types.type_name, type_efficacy.damage_factor, type_efficacy.target_type_id
FROM types
INNER JOIN type_efficacy
ON types.damage_type_id = type_efficacy.damage_type_id
WHERE types.type_name LIKE var1;

call output_pokemon_type_efficacy('steel');
END;



CREATE PROCEDURE `output_pokemon_moves_version` (IN var1 varchar(79))
BEGIN
SELECT moves.move_id, moves.move_name, version_groups.version_name
FROM moves
INNER JOIN pokemon_moves
ON moves.move_id = pokemon_moves.move_id
INNER JOIN version_groups
ON pokemon_moves.version_group_id = version_groups.version_id
WHERE moves.move_name LIKE var1
group by moves.move_id;

call output_pokemon_moves_version('scratch');
END;


CREATE PROCEDURE `output_pokemon_moves_method` (IN var1 varchar(79))
BEGIN
SELECT pokemon.pok_name, pokemon_move_methods.method_name
FROM pokemon
INNER JOIN pokemon_moves
ON pokemon.pok_id = pokemon_moves.pok_id
INNER JOIN pokemon_move_methods
ON pokemon_moves.method_id = pokemon_move_methods.method_id
INNER JOIN moves
ON pokemon_moves.move_id = moves.move_id
WHERE moves.move_name LIKE var1
group by moves.move_id;

call output_pokemon_moves_method('scratch');
END;


drop procedure IF EXISTS output_pokemon_hidden_abil;

CREATE PROCEDURE `output_pokemon_hidden_abil` (IN var1 varchar(79))
BEGIN
SELECT pokemon.pok_name, abilities.abil_name
FROM pokemon
INNER JOIN pokemon_abilities
ON pokemon.pok_id = pokemon_abilities.pok_id
INNER JOIN abilities
ON pokemon_abilities.abil_id = abilities.abil_id
WHERE pokemon.pok_name LIKE var1 and pokemon_abilities.is_hidden = 1
group by abilities.abil_id;

call output_pokemon_hidden_abil('charmander');
END;


CREATE PROCEDURE `output_pokemon_base_stats` (IN var1 varchar(79))
BEGIN
SELECT base_stats.b_atk, base_stats.b_def, base_stats.b_hp, base_stats.b_sp_atk, base_stats.b_sp_def, base_stats.b_speed
FROM pokemon
INNER JOIN base_stats
ON pokemon.pok_id = base_stats.pok_id
WHERE pokemon.pok_name like var1;

call output_pokemon_base_stats('charmeleon');
END;


drop procedure IF EXISTS output_pokemon_evol;

CREATE PROCEDURE `output_pokemon_evol` (IN var1 int)
BEGIN
SELECT pokemon.pok_name, pokemon_evolution.evolved_species_id, pokemon_evolution.evol_minimum_level
FROM pokemon
INNER JOIN pokemon_evolution_matchup
ON pokemon.pok_id = pokemon_evolution_matchup.evolves_from_species_id
INNER JOIN pokemon_evolution
ON pokemon_evolution_matchup.pok_id = pokemon_evolution.evolved_species_id
WHERE pokemon.pok_id LIKE var1;

call output_pokemon_evol('2');
END;
