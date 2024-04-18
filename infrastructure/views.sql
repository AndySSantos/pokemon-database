DROP VIEW IF EXISTS pokemon_total; 
CREATE view pokemon_total as
SELECT pokemon.pok_id, pokemon.pok_name, base_stats.b_atk, base_stats.b_def, base_stats.b_hp, 
base_stats.b_speed, base_stats.b_sp_atk, base_stats.b_sp_def,
sum(base_stats.b_atk + base_stats.b_def + base_stats.b_hp + base_stats.b_speed + base_stats.b_sp_atk + base_stats.b_sp_def) total
FROM pokemon
INNER JOIN base_stats
ON pokemon.pok_id = base_stats.pok_id
GROUP BY pokemon.pok_id;

create view grass_type_view as
SELECT pokemon.pok_id, pokemon.pok_name, types.type_name
FROM pokemon
INNER JOIN pokemon_types
ON pokemon.pok_id = pokemon_types.pok_id
INNER JOIN types
ON pokemon_types.type_id = types.type_id
WHERE types.type_name LIKE '%grass%'

create view att_def_hp as
SELECT pokemon.pok_id, pokemon.pok_name, base_stats.b_atk, base_stats.b_def, base_stats.b_hp, 
base_stats.b_speed, base_stats.b_sp_atk, base_stats.b_sp_def
FROM pokemon
INNER JOIN base_stats
ON pokemon.pok_id = base_stats.pok_id
WHERE b_atk > 100 and b_def > 100 and b_hp > 100
GROUP BY pokemon.pok_id;


create view pok_abilities as
SELECT pokemon.pok_id, pokemon.pok_name, abilities.abil_name, pokemon_abilities.is_hidden, pokemon.pok_base_experience
FROM pokemon
INNER JOIN pokemon_abilities
ON pokemon.pok_id = pokemon_abilities.pok_id
INNER JOIN abilities
ON pokemon_abilities.abil_id = abilities.abil_id
