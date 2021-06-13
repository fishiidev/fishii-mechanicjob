INSERT INTO `jobs` (name, label) VALUES
	('mechanic', 'Mecanico')
;

INSERT INTO `job_grades` (job_name, grade, name, label, salary, skin_male, skin_female) VALUES
	('mechanic',0,'recruit','Recluta',20,'{}','{}'),
    ('mechanic',1,'mechanic','Mecanico',20,'{}','{}'),
	('mechanic',2,'experimented','Mecanico Experimentado',20,'{}','{}'),
	('mechanic',3,'chief','Subjefe',20,'{}','{}'),
	('mechanic',4,'boss','Jefe',40,'{}','{}')
;

INSERT INTO `addon_account` (name, label, shared) VALUES
	('society_mechanic', 'Mecanico', 1)
;


INSERT INTO `addon_inventory` (name, label, shared) VALUES
	('society_mechanic', 'Mecanico', 1)
;
