DROP TRIGGER IF EXISTS NEW_POKEMON;


CREATE TRIGGER NEW_POKEMON BEFORE INSERT ON POKEMON
FOR EACH ROW
BEGIN
	IF NEW.pok_height < 0 THEN
		SET NEW.pok_height = 0;
	END IF;
	IF NEW.pok_weight < 0 THEN
		SET NEW.pok_weight = 0;
	END IF;
	IF NEW.pok_base_experience < 0 THEN
		SET NEW.pok_base_experience = 0;
	END IF;
END;

INSERT INTO pokemon VALUES(722,'popplio',-1,-1,-1);


DROP TRIGGER IF EXISTS NEW_HABITAT;


CREATE TRIGGER NEW_HABITAT BEFORE INSERT ON pokemon_habitats
FOR EACH ROW
BEGIN
	IF NEW.hab_name = '' THEN
		SET NEW.hab_name = 'Unknown';
	END IF;
	IF NEW.hab_descript = '' THEN
		SET NEW.hab_descript = 'Unknown';
	END IF;
END;

INSERT INTO pokemon_habitats VALUES(10,'','');


DROP TRIGGER IF EXISTS NEW_ABILITY;


CREATE TRIGGER NEW_ABILITY BEFORE INSERT ON pokemon_abilities
FOR EACH ROW
BEGIN
	IF NEW.is_hidden >= 0 and NEW.is_hidden < 2 THEN
		SET NEW.is_hidden = 0;
	END IF;
	IF NEW.slot > 0 and NEW.is_hidden < 4 THEN
		SET NEW.is_hidden = 1;
	END IF;
END;

INSERT INTO pokemon_abilities VALUES(407,22,2,4);