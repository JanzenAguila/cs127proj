drop database alumrecords;
create database alumrecords;
use alumrecords;
create table client (
	user_id INT PRIMARY KEY AUTO_INCREMENT,
	firstname VARCHAR(50),
	lastname VARCHAR(50),
	middlename VARCHAR(50),
	extension VARCHAR(5),
	email VARCHAR(100),
	password VARCHAR(100)
);
create table admin (
	admin_id INT PRIMARY KEY AUTO_INCREMENT,
	admin_user_id INT,
	CONSTRAINT `fk_admin_client`
		FOREIGN KEY (admin_user_id) REFERENCES client (user_id)
);
create table alumni (
	student_number INT PRIMARY KEY NOT NULL,
	birthday DATE,
	age INT, -- select *, YEAR(CURDATE()) - YEAR(birthday) AS age FROM alumni_id
	sex VARCHAR(1),
	batch INT,
	grad_year INT,
	alumni_user_id INT,
	CONSTRAINT `fk_alumni_client`
		FOREIGN KEY (alumni_user_id) REFERENCES client (user_id)
);
create table contact_num (
	alumni_student_number INT,
	phone_number VARCHAR(10),
	CONSTRAINT `fk_num_alumni`
		FOREIGN KEY (alumni_student_number) REFERENCES alumni (student_number)
);
create table job (
	alumni_student_number INT,
	company VARCHAR(100),
	company_loc_city VARCHAR(50),
	company_loc_country VARCHAR(50),
	company_position VARCHAR(100),
	CONSTRAINT `fk_job_alumni`
		FOREIGN KEY (alumni_student_number) REFERENCES alumni (student_number)
);
create table activity (
	activity_number INT PRIMARY KEY AUTO_INCREMENT,
	partnerships VARCHAR(100),
	event_name VARCHAR(100),
	event_date DATE
);
create table activity_log (
	log_id INT PRIMARY KEY AUTO_INCREMENT,
	log VARCHAR(100),
	curtime TIMESTAMP
);
delimiter |
create trigger addAdmin after insert on admin
	for each row
		begin
			insert into activity_log(log, curtime) values ("Added an admin.", now());
		end;
|
create trigger updAdmin after update on admin
	for each row
		begin
			insert into activity_log(log, curtime) values ("Updated an admin's info.", now());
		end;
|
create trigger delAdmin after delete on admin
	for each row
		begin
			insert into activity_log(log, curtime) values ("Deleted an admin.", now());
		end;
|
create trigger addAlum after insert on alumni
	for each row
		begin
			insert into activity_log(log, curtime) values ("Added an alumni.", now());
		end;
|
create trigger updAlum after update on alumni
	for each row
		begin
			insert into activity_log(log, curtime) values ("Updated an alumni's info.", now());
		end;
|
create trigger delAlum after delete on alumni
	for each row
		begin
			insert into activity_log(log, curtime) values ("Deleted an alumni.", now());
		end;
|
create trigger addAct after insert on activity
	for each row
		begin
			insert into activity_log(log, curtime) values ("Added an activity.", now());
		end;
|
create trigger updAct after update on activity
	for each row
		begin
			insert into activity_log(log, curtime) values ("Updated an activity.", now());
		end;
|
create trigger delAct after delete on activity
	for each row
		begin
			insert into activity_log(log, curtime) values ("Deleted an activity.", now());
		end;
|
delimiter ;
alter table admin AUTO_INCREMENT = 10000001; -- 1XXXXXXX is the format for an admin id
alter table alumni AUTO_INCREMENT = 20000001; -- 2XXXXXXX is the format for an alumni id
insert into client (firstname, lastname, middlename, extension, email, password) values ('John', 'Doe', 'Smith', NULL, 'johndoe@gmail.com', 'johndoe');
insert into admin (admin_user_id) values (1);
insert into client (firstname, lastname, middlename, extension, email, password) values ('Mike', 'Wallace', 'Roberts', NULL, 'mikewallace@gmail.com', 'mikewallace');
insert into admin (admin_user_id) values (2);
insert into client (firstname, lastname, middlename, extension, email, password) values ('Sara', 'Boyle', 'Little', NULL, 'saraboyle@gmail.com', 'saraboyle');
insert into admin (admin_user_id) values (3);
insert into client (firstname, lastname, middlename, extension, email, password) values ('Abbey', 'Goodwin', 'Jenkins', 'NULL', 'abbeygoodwin@gmail.com', 'abbeygoodwin');
insert into admin (admin_user_id) values (4);	
insert into client (firstname, lastname, middlename, extension, email, password) values ('Jonathan', 'Robertson', 'Fisher', NULL, 'jonathanrobertson@gmail.com', 'jonathanrobertson');
insert into admin (admin_user_id) values (5);
insert into client (firstname, lastname, middlename, extension, email, password) values ('Maggie', 'Anderson', 'Conner', NULL, 'maggieconner@gmail.com', 'maggieconner');
insert into admin (admin_user_id) values (6);
insert into client (firstname, lastname, middlename, extension, email, password) values ('Anna', 'Perkins', 'Mitchell', NULL, 'annaperkins@gmail.com', 'annaperkins');
insert into admin (admin_user_id) values (7);
insert into client (firstname, lastname, middlename, extension, email, password) values ('Kevin', 'Meyer', 'Walker', NULL, 'kevinmeyer@gmail.com', 'kevinmeyer');
insert into admin (admin_user_id) values (8);
insert into client (firstname, lastname, middlename, extension, email, password) values ('Josh', 'Moore', 'Thompson', 'Jr.', 'joshmoore@gmail.com', 'joshmoore');
insert into admin (admin_user_id) values (9);
insert into client (firstname, lastname, middlename, extension, email, password) values ('Michael', 'Cole', 'Robinson', NULL, 'michaelcole@gmail.com', 'michaelcole');
insert into admin (admin_user_id) values (10);
insert into client (firstname, lastname, middlename, extension, email, password) values ('Angie', 'Meeks', 'Johnson', NULL, 'angiemeeks@gmail.com', 'angiemeeks');
insert into admin (admin_user_id) values (11);
insert into client (firstname, lastname, middlename, extension, email, password) values ('Belle', 'Stark', 'Howell', NULL, 'bellestark@gmail.com', 'bellestark');
insert into admin (admin_user_id) values (12);
insert into client (firstname, lastname, middlename, extension, email, password) values ('Jane', 'Jacobs', 'Brown', NULL, 'janejacobs@gmail.com', 'janejacobs');
insert into admin (admin_user_id) values (13);
insert into client (firstname, lastname, middlename, extension, email, password) values ('Austin', 'Swift', 'McLaughlin', NULL, 'austinswift@gmail.com', 'austinswift');
insert into admin (admin_user_id) values (14);
insert into client (firstname, lastname, middlename, extension, email, password) values ('Nate', 'Walter', 'Larson', 'Jr.', 'natewalter@gmail.com', 'natewalter');
insert into admin (admin_user_id) values (15);
insert into client (firstname, lastname, middlename, extension, email, password) values ('Green', 'Gooding', 'Boyle', NULL, 'greengooding@gmail.com', 'greengooding');
insert into admin (admin_user_id) values (16);
insert into client (firstname, lastname, middlename, extension, email, password) values ('Jacob', 'Bennet', 'Mitchell', NULL, 'jacobbennet@gmail.com', 'jacobbennet');
insert into admin (admin_user_id) values (17);
insert into client (firstname, lastname, middlename, extension, email, password) values ('Sotto', 'Manuel', 'Pacquiao', NULL, 'manuelsotto@gmail.com', 'manuelsotto');
insert into admin (admin_user_id) values (18);
insert into client (firstname, lastname, middlename, extension, email, password) values ('Idol', 'Desiderio', 'Si', NULL, 'idoldesiderio@gmail.com', 'idoldesiderio');
insert into admin (admin_user_id) values (19);
insert into client (firstname, lastname, middlename, extension, email, password) values ('LeBron', 'Jordan', 'Bryant', 'Jr.', 'lebronjordan@gmail.com', '14rings');
insert into admin (admin_user_id) values (20);
insert into client (firstname, lastname, middlename, extension, email, password) values ('Kevin', 'Curry', 'Thompson', NULL, 'kevincurry@gmail.com', '31jokesnomore');
insert into admin (admin_user_id) values (21);
insert into client (firstname, lastname, middlename, extension, email, password) values ('KSG', 'Gungirl', 'Best', NULL, 'ksggungirl@gmail.com', 'ksggungirl');
insert into admin (admin_user_id) values (22);
insert into client (firstname, lastname, middlename, extension, email, password) values ('Kel-Tec', 'RFB', 'AM', NULL, 'keltecRFB@gmail.com', 'greatestgamer');
insert into admin (admin_user_id) values (23);
insert into client (firstname, lastname, middlename, extension, email, password) values ('Naruto', 'Uzumaki', 'Hokage', NULL, 'narutouzumaki@gmail.com', 'narutouzumaki');
insert into admin (admin_user_id) values (24);
insert into client (firstname, lastname, middlename, extension, email, password) values ('Monika', 'Doki', 'Best', NULL, 'lilmonix3@gmail.com', 'justmonika');
insert into admin (admin_user_id) values (25);
insert into client (firstname, lastname, middlename, extension, email, password) values ('PIP3', 'Python', 'On', NULL, 'pip3python@gmail.com', 'totallymessy');
insert into admin (admin_user_id) values (26);
insert into client (firstname, lastname, middlename, extension, email, password) values ('FN', 'FAL', 'Herstal', NULL, 'fnfal@gmail.com', 'bestgun');
insert into admin (admin_user_id) values (27);
insert into client (firstname, lastname, middlename, extension, email, password) values ('Nate', 'Robinson', 'Brown', NULL, 'naterobinson@gmail.com', 'heartoverheight');
insert into admin (admin_user_id) values (28);
insert into client (firstname, lastname, middlename, extension, email, password) values ('Sublime', 'Text', 'SublimeText', 'III', 'sublimetext@gmail.com', 'sublimetext');
insert into admin (admin_user_id) values (29);
insert into client (firstname, lastname, middlename, extension, email, password) values ('Gru', 'Minions', 'Loves', NULL, 'gruminions@gmail.com', 'gruminions');
insert into admin (admin_user_id) values (30);
insert into client (firstname, lastname, middlename, extension, email, password) values ('Tom', 'Jerry', 'And', NULL, 'tomjerry@gmail.com', 'childhood');
insert into admin (admin_user_id) values (31);
insert into client (firstname, lastname, middlename, extension, email, password) values ('Alan', 'Turing', 'Thankyou', NULL, 'alanturing@gmail.com', 'alanturing');
insert into admin (admin_user_id) values (32);
insert into client (firstname, lastname, middlename, extension, email, password) values ('Thomas', 'Edison', 'Alva', NULL, 'thomasedison@gmail.com', 'thomasedison');
insert into admin (admin_user_id) values (33);
insert into client (firstname, lastname, middlename, extension, email, password) values ('Juan', 'Tamad', 'Hindi', NULL, 'juantamad@gmail.com', 'juantamad');
insert into admin (admin_user_id) values (34);
insert into client (firstname, lastname, middlename, extension, email, password) values ('Jeff', 'Name', 'What', NULL, 'jeffname@gmail.com', 'mynamesjeff');
insert into admin (admin_user_id) values (35);
insert into client (firstname, lastname, middlename, extension, email, password) values ('Stephen', 'Hillenberg', 'Spongebob', NULL, 'stephenhillenburg@gmail.com', 'stephenhillenburg');
insert into admin (admin_user_id) values (36);
insert into client (firstname, lastname, middlename, extension, email, password) values ('Aria', 'Kanzaki', 'Holmes', NULL, 'ariakanzaki@gmail.com', 'ariakanzaki');
insert into admin (admin_user_id) values (37);
insert into client (firstname, lastname, middlename, extension, email, password) values ('Crisostomo', 'Ibarra', 'Simoun', 'Jr.', 'crisostomoibarra@gmail.com', 'postyourlightuppics');
insert into admin (admin_user_id) values (38);
insert into client (firstname, lastname, middlename, extension, email, password) values ('Jimmy', 'Neutron', 'Nerdtron', NULL, 'jimmyneutron@gmail.com', 'jimbo');
insert into admin (admin_user_id) values (39);
insert into client (firstname, lastname, middlename, extension, email, password) values ('Artoria', 'Pendragon', 'Saber', NULL, 'artoriapendragon@gmail.com', 'artoriapendragon');
insert into admin (admin_user_id) values (40);
insert into client (firstname, lastname, middlename, extension, email, password) values ('Cu', 'Chulainn', 'Gae', NULL, 'cuchulainnn@gmail.com', 'gaebolg');
insert into admin (admin_user_id) values (41);
insert into client (firstname, lastname, middlename, extension, email, password) values ('Marie', 'Antonette', 'French', NULL, 'marieantonette@gmail.com', 'vivalafrance');
insert into admin (admin_user_id) values (42);
insert into client (firstname, lastname, middlename, extension, email, password) values ('Lelouch', 'Britannia', 'Vi', NULL, 'lelouchbritannia@gmail.com', 'lelouchbritannia');
insert into admin (admin_user_id) values (43);
insert into client (firstname, lastname, middlename, extension, email, password) values ('Arctic', 'Magnum', 'Warfare', NULL, 'awm@gmail.com', 'bestguninpubg');
insert into admin (admin_user_id) values (44);
insert into client (firstname, lastname, middlename, extension, email, password) values ('Rick', 'Astley', 'NGGYU', NULL, 'rickastley@gmail.com', 'nevergonnagiveyouup');
insert into admin (admin_user_id) values (45);
insert into client (firstname, lastname, middlename, extension, email, password) values ('Asuka', 'Langley', 'Soryuu', NULL, 'asukalangley@gmail.com', 'asukalangley');
insert into admin (admin_user_id) values (46);
insert into client (firstname, lastname, middlename, extension, email, password) values ('Platelet', 'Chan', 'Kesshouban', 'IV', 'plateletchan@gmail.com', 'plateletchan');
insert into admin (admin_user_id) values (47);
insert into client (firstname, lastname, middlename, extension, email, password) values ('Kafuu', 'Chino', 'Kawaii', NULL, 'kafuuchino@gmail.com', 'kafuuchino');
insert into admin (admin_user_id) values (48);
insert into client (firstname, lastname, middlename, extension, email, password) values ('Shrek', 'Movie', 'The', 'IV', 'shrekmovie@gmail.com', 'shrekmovie');
insert into admin (admin_user_id) values (49);
insert into client (firstname, lastname, middlename, extension, email, password) values ('Bee', 'Movie', 'The', 'IX', 'beemovie@gmail.com', 'beemovie');
insert into admin (admin_user_id) values (50);
insert into client (firstname, lastname, middlename, extension, email, password) values ('Rin', 'Tohsaka', 'Thicc', NULL, 'rintohsaka@gmail.com', 'rintohsaka');
insert into admin (admin_user_id) values (51);
insert into client (firstname, lastname, middlename, extension, email, password) values ('Sakura', 'Matou', 'Thicc', NULL, 'sakuramatou@gmail.com', 'sakuramatou');
insert into admin (admin_user_id) values (52);
insert into client (firstname, lastname, middlename, extension, email, password) values ('Sheen', 'Estevez', 'Guevarra', NULL, 'sheenestevez@gmail.com', 'ultralord');
insert into admin (admin_user_id) values (53);
insert into client (firstname, lastname, middlename, extension, email, password) values ('All', 'Might', 'Izuku', 'Jr.', 'izukumidoriya@gmail.com', 'izukumidoriya');
insert into admin (admin_user_id) values (54);
insert into client (firstname, lastname, middlename, extension, email, password) values ('Kyrie', 'Irving', 'Uncle', NULL, 'kyrieirving@gmail.com', 'uncledrew');
insert into admin (admin_user_id) values (55);
insert into client (firstname, lastname, middlename, extension, email, password) values ('Grizzly', 'Mk', 'Gun', 'V', 'grizzlymkv@gmail.com', 'grizzlymkv');
insert into admin (admin_user_id) values (56);
insert into client (firstname, lastname, middlename, extension, email, password) values ('FN', 'FiveSeven', 'Herstal', NULL, 'fn57@gmail.com', 'fn57');
insert into admin (admin_user_id) values (57);
insert into client (firstname, lastname, middlename, extension, email, password) values ('Wolfgang', 'Mozart', 'Amadeus', NULL, 'amadeusmozart@gmail.com', 'amadeusmozart');
insert into admin (admin_user_id) values (58);
insert into client (firstname, lastname, middlename, extension, email, password) values ('Colt', 'AR-15', 'ST', NULL, 'ar15@gmail.com', 'schoolshootF');
insert into admin (admin_user_id) values (59);
insert into client (firstname, lastname, middlename, extension, email, password) values ('Bongo', 'Cat', 'Meme', 'Jr.', 'bongocat@gmail.com', 'taptaptap');
insert into admin (admin_user_id) values (60);
insert into client (firstname, lastname, middlename, extension, email, password) values ('Crazy', 'Dave', 'Really', NULL, 'crazydave@gmail.com', 'crazydave');
insert into admin (admin_user_id) values (61);
insert into client (firstname, lastname, middlename, extension, email, password) values ('Michael', 'Jackson', 'Jeffrey', NULL, 'mj23@gmail.com', 'jordanmoonwalk');
insert into admin (admin_user_id) values (62);
insert into client (firstname, lastname, middlename, extension, email, password) values ('Suomi', 'Konepistooli', 'Kawaii', NULL, 'suomikonepistooli@gmail.com', 'suomikonepistooli');
insert into admin (admin_user_id) values (63);
insert into client (firstname, lastname, middlename, extension, email, password) values ('Fubuki', 'Destroyer', 'Class', NULL, 'fubukidestroyer@gmail.com', 'fubukidestroyer');
insert into admin (admin_user_id) values (64);
insert into client (firstname, lastname, middlename, extension, email, password) values ('Yuri', 'Doki', 'SecondBest', NULL, 'yuridoki@gmail.com', 'yurioniceF');
insert into admin (admin_user_id) values (65);
insert into client (firstname, lastname, middlename, extension, email, password) values ('UP', 'Dank Ages', 'UDA', NULL, 'uda@gmail.com', 'bestmemepageuwu');
insert into admin (admin_user_id) values (66);
insert into client (firstname, lastname, middlename, extension, email, password) values ('UPLB', 'Memesoc', 'uplbms', NULL, 'uplbms@gmail.com', 'bestmemepageowo');
insert into admin (admin_user_id) values (67);
insert into client (firstname, lastname, middlename, extension, email, password) values ('Albert', 'Hugh', 'Andrews', NULL, 'alberthugh@gmail.com', 'alberthugh');
insert into admin (admin_user_id) values (68);
insert into client (firstname, lastname, middlename, extension, email, password) values ('Joanne', 'Hardaway', 'Freeman', NULL, 'joannehardaway@gmail.com', 'joannehardaway');
insert into admin (admin_user_id) values (69);
insert into client (firstname, lastname, middlename, extension, email, password) values ('Richard', 'Newton', 'Webber', NULL, 'richardnewton@gmail.com', 'richardnewton');
insert into admin (admin_user_id) values (70);
insert into client (firstname, lastname, middlename, extension, email, password) values ('Michelle', 'Armstrong', 'Smith', NULL, 'michellearmstrong@gmail.com', 'michellearmstrong');
insert into admin (admin_user_id) values (71);
insert into client (firstname, lastname, middlename, extension, email, password) values ('James', 'Hart', 'Little', NULL, 'jameshart@gmail.com', 'jameshart');
insert into admin (admin_user_id) values (72);
insert into client (firstname, lastname, middlename, extension, email, password) values ('Annie', 'Mills', 'Miller', 'III', 'anniemills@gmail.com', 'anniemills');
insert into admin (admin_user_id) values (73);
insert into client (firstname, lastname, middlename, extension, email, password) values ('Alice', 'Zuberg', 'SynthesisThirty', NULL, 'alicezuberg@gmail.com', 'bestgril');
insert into admin (admin_user_id) values (74);
insert into client (firstname, lastname, middlename, extension, email, password) values ('Eugeo', 'Thirtytwo', 'Synthesis', NULL, 'eugeo@gmail.com', 'ultimategae');
insert into admin (admin_user_id) values (75);
insert into client (firstname, lastname, middlename, extension, email, password) values ('Jeanne', 'Arc', 'Of', NULL, 'jeannearc@gmail.com', 'mamajeanne');
insert into admin (admin_user_id) values (76);
insert into client (firstname, lastname, middlename, extension, email, password) values ('Donald', 'Trump', 'Duck', NULL, 'donaldtrump@gmail.com', 'donaldtrump');
insert into admin (admin_user_id) values (77);
insert into client (firstname, lastname, middlename, extension, email, password) values ('Benjamin', 'Tennyson', 'Ten', 'X', 'ben10@gmail.com', 'ben10');
insert into admin (admin_user_id) values (78);
insert into client (firstname, lastname, middlename, extension, email, password) values ('Kevin', 'Levin', 'Eleven', 'XI', 'kevin11@gmail.com', 'kevin11');
insert into admin (admin_user_id) values (79);
insert into client (firstname, lastname, middlename, extension, email, password) values ('Gwendolyn', 'Tennyson', 'Ten', NULL, 'gwen10@gmail.com', 'gwen10');
insert into admin (admin_user_id) values (80);
insert into client (firstname, lastname, middlename, extension, email, password) values ('Spongebob', 'Squarepants', 'Imready', NULL, 'spongebobsquarepants@gmail.com', 'spongebobsquarepants');
insert into admin (admin_user_id) values (81);
insert into client (firstname, lastname, middlename, extension, email, password) values ('Patrick', 'Star', 'Rock', NULL, 'patrickstar@gmail.com', 'patrickstar');
insert into admin (admin_user_id) values (82);
insert into client (firstname, lastname, middlename, extension, email, password) values ('Squidward', 'Tentacles', 'Clarinet', NULL, 'squidwardtentacles@gmail.com', 'squidwardtentacles');
insert into admin (admin_user_id) values (83);
insert into client (firstname, lastname, middlename, extension, email, password) values ('Rajon', 'Rondo', 'Meme', NULL, 'rajonrondo@gmail.com', 'rajonrondo');
insert into admin (admin_user_id) values (84);
insert into client (firstname, lastname, middlename, extension, email, password) values ('Lance', 'Stephenson', 'Meme', NULL, 'lancestephenson@gmail.com', 'lancestephenson');
insert into admin (admin_user_id) values (85);
insert into client (firstname, lastname, middlename, extension, email, password) values ('JaVale', 'McGee', 'Meme', NULL, 'javalemcgee@gmail.com', 'javalemcgee');
insert into admin (admin_user_id) values (86);
insert into client (firstname, lastname, middlename, extension, email, password) values ('Google', 'Chan', 'Plus', NULL, 'googlechan@gmail.com', 'issheagirl');
insert into admin (admin_user_id) values (87);
insert into client (firstname, lastname, middlename, extension, email, password) values ('Rowan', 'Atkinson', 'Bean', NULL, 'rowanatkinson@gmail.com', 'mrbean');
insert into admin (admin_user_id) values (88);
insert into client (firstname, lastname, middlename, extension, email, password) values ('Edward', 'Elric', 'Alphonse', NULL, 'edwardelric@gmail.com', 'edwardelric');
insert into admin (admin_user_id) values (89);
insert into client (firstname, lastname, middlename, extension, email, password) values ('Alphonse', 'Elric', 'Edward', NULL, 'alphonseelric@gmail.com', 'alphonseelric');
insert into admin (admin_user_id) values (90);
insert into client (firstname, lastname, middlename, extension, email, password) values ('Ash', 'Ketchum', 'Pikachu', NULL, 'ashketchum@gmail.com', 'ashketchum');
insert into admin (admin_user_id) values (91);
insert into client (firstname, lastname, middlename, extension, email, password) values ('Detective', 'Pikachu', 'Deadpool', 'III', 'detectivepikachu@gmail.com', 'detectivepikachu');
insert into admin (admin_user_id) values (92);
insert into client (firstname, lastname, middlename, extension, email, password) values ('Emilia', 'Daisuki', 'ReZero', NULL, 'emilia@gmail.com', 'bestelfgril');
insert into admin (admin_user_id) values (93);
insert into client (firstname, lastname, middlename, extension, email, password) values ('Peter', 'Piper', 'Pickle', NULL, 'peterpiper@gmail.com', 'peterpiper');
insert into admin (admin_user_id) values (94);
insert into client (firstname, lastname, middlename, extension, email, password) values ('Subscribe', 'Pewdiepie', 'To', NULL, 'pewdiepie@gmail.com', 'tseries');
insert into admin (admin_user_id) values (95);
insert into client (firstname, lastname, middlename, extension, email, password) values ('Subscribe', 'T-series', 'To', NULL, 'tseries@gmail.com', 'pewdiepie');
insert into admin (admin_user_id) values (96);
insert into client (firstname, lastname, middlename, extension, email, password) values ('Youtube', 'Rewind', 'Trash', 'XIII', 'youtuberewind@gmail.com', 'youtuberewind');
insert into admin (admin_user_id) values (97);
insert into client (firstname, lastname, middlename, extension, email, password) values ('Comsci', 'Two', 'One', 'VII', 'cmsc127@gmail.com', 'cmsc127');
insert into admin (admin_user_id) values (98);
insert into client (firstname, lastname, middlename, extension, email, password) values ('UP', 'Mahal', 'Naming', NULL, 'junksais@gmail.com', 'junksais');
insert into admin (admin_user_id) values (99);
insert into client (firstname, lastname, middlename, extension, email, password) values ('Mark', 'Zuckerberg', 'Van', NULL, 'markzuckerberg@gmail.com', 'mark');
insert into admin (admin_user_id) values (100);
--
insert into client (firstname, lastname, middlename, extension, email, password) values ('Charlie', 'Barton', 'Andrews', NULL, 'charliebarton@gmail.com', 'charliebarton');
insert into alumni (student_number, birthday, sex, batch, grad_year, alumni_user_id) values (199312345, '1978-12-28', 'M', 1993, 1999, 101);
insert into job (alumni_student_number, company, company_loc_city, company_loc_country, company_position) values (199312345, 'Dreamer inc', 'Los Angeles', 'USA', 'Secretary');
insert into contact_num (alumni_student_number, phone_number) values (199312345, '987654321');
--
insert into client (firstname, lastname, middlename, extension, email, password) values ('Bruce', 'Gibson', 'Turner', 'Sr.', 'brucegibson@gmail.com', 'brucegibson');
insert into alumni (student_number, birthday, sex, batch, grad_year, alumni_user_id) values (197905782, '1961-08-14', 'M', 1979, 1984, 102);
insert into job (alumni_student_number, company, company_loc_city, company_loc_country, company_position) values (197905782, 'Cheap inc', 'Boston', 'USA', 'Developer');
insert into contact_num (alumni_student_number, phone_number) values (197905782, '9402986317');
--
insert into client (firstname, lastname, middlename, extension, email, password) values ('Natalie', 'Green', 'Webber', NULL, 'nataliegreen@gmail.com', 'nataliegreen');
insert into alumni (student_number, birthday, sex, batch, grad_year, alumni_user_id) values (199851840, '1981-10-08', 'F', 1998, 2002, 103);
insert into job (alumni_student_number, company, company_loc_city, company_loc_country, company_position) values (199851840, 'Hyper inc', 'Philadelphia', 'USA', 'Clerk');
insert into contact_num (alumni_student_number, phone_number) values (199851840, '9060123068');
--
insert into client (firstname, lastname, middlename, extension, email, password) values ('Jake', 'Miller', 'Houston', NULL, 'jakemiller@gmail.com', 'jakemiller');
insert into alumni (student_number, birthday, sex, batch, grad_year, alumni_user_id) values (199729129, '1982-02-01', 'M', 1997, 2003, 104);
insert into job (alumni_student_number, company, company_loc_city, company_loc_country, company_position) values (199729129, 'Rocker inc', 'New York', 'USA', 'Bartender');
insert into contact_num (alumni_student_number, phone_number) values (199729129, '9103246711');
--
insert into client (firstname, lastname, middlename, extension, email, password) values ('May', 'Parker', 'West', NULL, 'mayparker@gmail.com', 'mayparker');
insert into alumni (student_number, birthday, sex, batch, grad_year, alumni_user_id) values (200301932, '1987-09-04', 'F', 2003, 2007, 105);
insert into job (alumni_student_number, company, company_loc_city, company_loc_country, company_position) values (199729129, 'Genius inc', 'Washington', 'USA', 'Vice President');
insert into contact_num (alumni_student_number, phone_number) values (199729129, '9361297410');
--
insert into client (firstname, lastname, middlename, extension, email, password) values ('Mark', 'Zuckerberg', 'Van', NULL, 'markzuckerberg@gmail.com', 'markzuckerberg');
insert into alumni (student_number, birthday, sex, batch, grad_year, alumni_user_id) values (200355237, '1982-03-26', 'M', 2003, 2008, 106);
insert into job (alumni_student_number, company, company_loc_city, company_loc_country, company_position) values (199729129, 'Social inc', 'Seattle', 'USA', 'CEO');
insert into contact_num (alumni_student_number, phone_number) values (199729129, '9246819263');
--
insert into client (firstname, lastname, middlename, extension, email, password) values ('Jean', 'Mills', 'James', 'Jr.', 'jeanmills@gmail.com', 'jeanmills');
insert into alumni (student_number, birthday, sex, batch, grad_year, alumni_user_id) values (200894012, '1986-03-26', 'F', 2008, 2013, 107);
insert into job (alumni_student_number, company, company_loc_city, company_loc_country, company_position) values (200894012, 'Happy inc', 'Michigan', 'USA', 'Manager');
insert into contact_num (alumni_student_number, phone_number) values (200894012, '9172470921');
--
insert into client (firstname, lastname, middlename, extension, email, password) values ('Damian', 'West', 'Michaels', NULL, 'damianwest@gmail.com', 'damianwest');
insert into alumni (student_number, birthday, sex, batch, grad_year, alumni_user_id) values (197410293, '1962-10-13', 'M', 1974, 1978, 108);
insert into job (alumni_student_number, company, company_loc_city, company_loc_country, company_position) values (197410293, 'Well inc', 'Maryland', 'USA', 'Postman');
insert into contact_num (alumni_student_number, phone_number) values (197410293, '9103940185');
--
insert into client (firstname, lastname, middlename, extension, email, password) values ('Hillary', 'Avery', 'Jackson', NULL, 'hillaryavery@gmail.com', 'hillaryavery');
insert into alumni (student_number, birthday, sex, batch, grad_year, alumni_user_id) values (199987659, '1986-03-26', 'F', 1999, 2003, 109);
insert into job (alumni_student_number, company, company_loc_city, company_loc_country, company_position) values (199987659, 'Great inc', 'California', 'USA', 'Professor');
insert into contact_num (alumni_student_number, phone_number) values (199987659, '9059230613');
--
insert into client (firstname, lastname, middlename, extension, email, password) values ('Dio', 'Brando', 'Gatana', NULL, 'diobrando@gmail.com', 'diobrando');
insert into alumni (student_number, birthday, sex, batch, grad_year, alumni_user_id) values (194369696, '1928-12-01', 'M', 1943, 1953, 110);
insert into job (alumni_student_number, company, company_loc_city, company_loc_country, company_position) values (194369696, 'Villain inc', 'Boston', 'USA', 'Fireman');
insert into contact_num (alumni_student_number, phone_number) values (194369696, '9099135823');
--
insert into client (firstname, lastname, middlename, extension, email, password) values ('Myra', 'Davis', 'Jameson', NULL, 'myradavis@gmail.com', 'myradavis');
insert into alumni (student_number, birthday, sex, batch, grad_year, alumni_user_id) values (198309255, '1969-07-19', 'F', 1983, 1988, 111);
insert into job (alumni_student_number, company, company_loc_city, company_loc_country, company_position) values (198309255, 'Creative inc', 'New York', 'USA', 'Agent');
insert into contact_num (alumni_student_number, phone_number) values (198309255, '9253064213');
--
insert into client (firstname, lastname, middlename, extension, email, password) values ('Connor', 'Ball', 'Ligma', NULL, 'connorball@gmail.com', 'connorball');
insert into alumni (student_number, birthday, sex, batch, grad_year, alumni_user_id) values (196701842, '1951-10-04', 'M', 1967, 1973, 112);
insert into job (alumni_student_number, company, company_loc_city, company_loc_country, company_position) values (196701842, 'Savior inc', 'Seattle', 'USA', 'Bartender');
insert into contact_num (alumni_student_number, phone_number) values (196701842, '9018290184');
--
insert into client (firstname, lastname, middlename, extension, email, password) values ('Kendall', 'Adams', 'Tucker', NULL, 'kendalladams@gmail.com', 'kendalladams');
insert into alumni (student_number, birthday, sex, batch, grad_year, alumni_user_id) values (200109324, '1985-07-14', 'F', 2001, 2005, 113);
insert into job (alumni_student_number, company, company_loc_city, company_loc_country, company_position) values (200109324, 'Adamant inc', 'Washington', 'USA', 'Surgeon');
insert into contact_num (alumni_student_number, phone_number) values (200109324, '9104149821');
--
insert into client (firstname, lastname, middlename, extension, email, password) values ('Ramon', 'Batista', 'Gray', 'IV', 'ramonbatista@gmail.com', 'ramonbatista');
insert into alumni (student_number, birthday, sex, batch, grad_year, alumni_user_id) values (200914502, '1993-06-19', 'M', 2009, 2013, 114);
insert into job (alumni_student_number, company, company_loc_city, company_loc_country, company_position) values (200914502, 'Thicc inc', 'Chicago', 'USA', 'Priest');
insert into contact_num (alumni_student_number, phone_number) values (200914502, '9015107274');
--
insert into client (firstname, lastname, middlename, extension, email, password) values ('Gordon', 'Ramsay', 'Fire', NULL, 'gordonramsay@gmail.com', 'gordonramsay');
insert into alumni (student_number, birthday, sex, batch, grad_year, alumni_user_id) values (200724891, '1991-03-30', 'M', 2007, 2011, 115);
insert into job (alumni_student_number, company, company_loc_city, company_loc_country, company_position) values (200724891, 'Spicy inc', 'Louisiana', 'USA', 'Chef');
insert into contact_num (alumni_student_number, phone_number) values (200724891, '9469019248');
--
insert into client (firstname, lastname, middlename, extension, email, password) values ('Alvin', 'Cambridge', 'Willis', NULL, 'alvincambridge@gmail.com', 'alvincambridge');
insert into alumni (student_number, birthday, sex, batch, grad_year, alumni_user_id) values (200624340, '1989-06-05', 'M', 2006, 2011, 116);
insert into job (alumni_student_number, company, company_loc_city, company_loc_country, company_position) values (200624340, 'Cool inc', 'Maryland', 'USA', 'Psychiatrist');
insert into contact_num (alumni_student_number, phone_number) values (200624340, '9130728372');
--
insert into client (firstname, lastname, middlename, extension, email, password) values ('Hannah', 'Fraser', 'McLeod', 'III', 'hannahfraser@gmail.com', 'hannahfraser');
insert into alumni (student_number, birthday, sex, batch, grad_year, alumni_user_id) values (195834909, '1940-10-21', 'F', 1958, 1963, 117);
insert into job (alumni_student_number, company, company_loc_city, company_loc_country, company_position) values (195834909, 'Anonymous inc', 'Boston', 'USA', 'Nurse');
insert into contact_num (alumni_student_number, phone_number) values (195834909, '9035691735');
--
insert into client (firstname, lastname, middlename, extension, email, password) values ('Mary', 'Lee', 'Winston', NULL, 'marylee@gmail.com', 'marylee');
insert into alumni (student_number, birthday, sex, batch, grad_year, alumni_user_id) values (196492057, '1947-12-20', 'F', 1964, 1968, 118);
insert into job (alumni_student_number, company, company_loc_city, company_loc_country, company_position) values (196492057, 'Happy inc', 'Washington', 'USA', 'Saleslady');
insert into contact_num (alumni_student_number, phone_number) values (196492057, '9104920846');
--
insert into client (firstname, lastname, middlename, extension, email, password) values ('Alfred', 'Houston', 'McKnight', NULL, 'alfredhouston@gmail.com', 'alfredhouston');
insert into alumni (student_number, birthday, sex, batch, grad_year, alumni_user_id) values (197513048, '1957-11-13', 'M', 1975, 1979, 119);
insert into job (alumni_student_number, company, company_loc_city, company_loc_country, company_position) values (197513048, 'Cool inc', 'California', 'USA', 'Vice President');
insert into contact_num (alumni_student_number, phone_number) values (197513048, '9140294829');
--
insert into client (firstname, lastname, middlename, extension, email, password) values ('Andre', 'Gordon', 'Ericsson', NULL, 'andregordon@gmail.com', 'andregordon');
insert into alumni (student_number, birthday, sex, batch, grad_year, alumni_user_id) values (200310484, '1990-03-14', 'M', 2003, 2007, 120);
insert into job (alumni_student_number, company, company_loc_city, company_loc_country, company_position) values (200310484, 'Wild inc', 'Los Angeles', 'USA', 'Waiter');
insert into contact_num (alumni_student_number, phone_number) values (200310484, '9028492019');
--
insert into client (firstname, lastname, middlename, extension, email, password) values ('IW', '2000', 'Sodia', NULL, 'iws2000@gmail.com', 'bestGFLgril');
insert into alumni (student_number, birthday, sex, batch, grad_year, alumni_user_id) values (201320020, '1997-02-14', 'F', 2013, 2017, 121);
insert into job (alumni_student_number, company, company_loc_city, company_loc_country, company_position) values (201320020, 'Cute inc', 'Washington', 'USA', 'Soldier');
insert into contact_num (alumni_student_number, phone_number) values (201320020, '9190239510');
--
insert into client (firstname, lastname, middlename, extension, email, password) values ('ID', 'Danya', 'Wtaf', 'III', 'idwdanya@gmail.com', 'idwdanya');
insert into alumni (student_number, birthday, sex, batch, grad_year, alumni_user_id) values (201012404, '1995-10-21', 'F', 2010, 2017, 122);
insert into job (alumni_student_number, company, company_loc_city, company_loc_country, company_position) values (201012404, 'Brains inc', 'California', 'USA', 'Catgirl');
insert into contact_num (alumni_student_number, phone_number) values (201012404, '9103029174');
--
insert into client (firstname, lastname, middlename, extension, email, password) values ('Pete', 'Maravich', 'Pistol', NULL, 'petemaravich@gmail.com', 'petemaravich');
insert into alumni (student_number, birthday, sex, batch, grad_year, alumni_user_id) values (196401304, '1950-05-10', 'M', 1964, 1968, 123);
insert into job (alumni_student_number, company, company_loc_city, company_loc_country, company_position) values (196401304, 'Quicc inc', 'New York', 'USA', 'Player');
insert into contact_num (alumni_student_number, phone_number) values (196401304, '9130206281');
--
insert into client (firstname, lastname, middlename, extension, email, password) values ('Dwight', 'Conley', 'Bradley', NULL, 'dwightconley@gmail.com', 'dwightconley');
insert into alumni (student_number, birthday, sex, batch, grad_year, alumni_user_id) values (197501048, '1960-09-14', 'M', 1975, 1979, 124);
insert into job (alumni_student_number, company, company_loc_city, company_loc_country, company_position) values (197501048, 'Brick inc', 'California', 'USA', 'Construction worker');
insert into contact_num (alumni_student_number, phone_number) values (197501048, '9014239582');
--
insert into client (firstname, lastname, middlename, extension, email, password) values ('Lance', 'Carson', 'Jack', NULL, 'lancecarson@gmail.com', 'lancecarson');
insert into alumni (student_number, birthday, sex, batch, grad_year, alumni_user_id) values (201147130, '1995-12-10', 'M', 2011, 2015, 125);
insert into job (alumni_student_number, company, company_loc_city, company_loc_country, company_position) values (201147130, 'Alpha inc', 'Maryland', 'USA', 'Secretary');
insert into contact_num (alumni_student_number, phone_number) values (201147130, '9150293927');
--
insert into client (firstname, lastname, middlename, extension, email, password) values ('Robert', 'Adams', 'Brewer', NULL, 'robertadams@gmail.com', 'robertadams');
insert into alumni (student_number, birthday, sex, batch, grad_year, alumni_user_id) values (199301485, '1979-06-14', 'M', 1993, 1998, 126);
insert into job (alumni_student_number, company, company_loc_city, company_loc_country, company_position) values (199301485, 'Buzz inc', 'Houston', 'USA', 'Agent');
insert into contact_num (alumni_student_number, phone_number) values (199301485, '9104829014');
--
insert into client (firstname, lastname, middlename, extension, email, password) values ('Kiara', 'McDonald', 'Lincoln', 'III', 'kiaramcdonald@gmail.com', 'kiaramcdonald');
insert into alumni (student_number, birthday, sex, batch, grad_year, alumni_user_id) values (198410752, '1970-03-22', 'F', 1984, 1988, 127);
insert into job (alumni_student_number, company, company_loc_city, company_loc_country, company_position) values (198410752, 'Order inc', 'California', 'USA', 'Waitress');
insert into contact_num (alumni_student_number, phone_number) values (198410752, '9140235837');
--
insert into client (firstname, lastname, middlename, extension, email, password) values ('Sarah', 'Collins', 'Winfrey', NULL, 'sarahcollins@gmail.com', 'sarahcollins');
insert into alumni (student_number, birthday, sex, batch, grad_year, alumni_user_id) values (198302201, '1968-06-15', 'F', 1983, 1988, 128);
insert into job (alumni_student_number, company, company_loc_city, company_loc_country, company_position) values (198302201, 'Buff inc', 'Chicago', 'USA', 'Nurse');
insert into contact_num (alumni_student_number, phone_number) values (198302201, '9140197573');
--
insert into client (firstname, lastname, middlename, extension, email, password) values ('Boris', 'Nick', 'McConner', NULL, 'borisnick@gmail.com', 'borisnick');
insert into alumni (student_number, birthday, sex, batch, grad_year, alumni_user_id) values (197910001, '1965-09-11', 'M', 1979, 1983, 129);
insert into job (alumni_student_number, company, company_loc_city, company_loc_country, company_position) values (197910001, 'Destroy inc', 'Los Angeles', 'USA', 'Trainer');
insert into contact_num (alumni_student_number, phone_number) values (197910001, '9140100238');
--
insert into client (firstname, lastname, middlename, extension, email, password) values ('Coby', 'Louis', 'Carter', NULL, 'cobylouis@gmail.com', 'cobylouis');
insert into alumni (student_number, birthday, sex, batch, grad_year, alumni_user_id) values (197502990, '1960-12-02', 'M', 1975, 1978, 130);
insert into job (alumni_student_number, company, company_loc_city, company_loc_country, company_position) values (197502990, 'Dreamer inc', 'Washington', 'USA', 'Professor');
insert into contact_num (alumni_student_number, phone_number) values (197502990, '9011940001');
--
insert into client (firstname, lastname, middlename, extension, email, password) values ('Karabiner', 'Kurz', 'Nineight', NULL, 'kar98k@gmail.com', 'kar98k');
insert into alumni (student_number, birthday, sex, batch, grad_year, alumni_user_id) values (196301083, '1949-08-22', 'F', 1963, 1968, 131);
insert into job (alumni_student_number, company, company_loc_city, company_loc_country, company_position) values (196301083, 'Destroy inc', 'Los Angeles', 'USA', 'Saleslady');
insert into contact_num (alumni_student_number, phone_number) values (196301083, '913088194');
--
insert into client (firstname, lastname, middlename, extension, email, password) values ('Lee', 'Enfield', 'Briton', 'IV', 'leeenfield@gmail.com', 'leeenfield');
insert into alumni (student_number, birthday, sex, batch, grad_year, alumni_user_id) values (195912006, '1943-12-13', 'F', 1959, 1963, 132);
insert into job (alumni_student_number, company, company_loc_city, company_loc_country, company_position) values (195912006, 'Cute inc', 'Maryland', 'USA', 'Teacher');
insert into contact_num (alumni_student_number, phone_number) values (195912006, '924009135');
--
insert into client (firstname, lastname, middlename, extension, email, password) values ('USS', 'Laffey', 'Benson', NULL, 'usslaffey@gmail.com', 'usslaffey');
insert into alumni (student_number, birthday, sex, batch, grad_year, alumni_user_id) values (195401932, '1940-10-19', 'F', 1954, 1958, 133);
insert into job (alumni_student_number, company, company_loc_city, company_loc_country, company_position) values (195401932, 'Cute inc', 'Washington', 'USA', 'Driver');
insert into contact_num (alumni_student_number, phone_number) values (195401932, '900133294');
--
insert into client (firstname, lastname, middlename, extension, email, password) values ('HMS', 'Belfast', 'Edinburgh', NULL, 'hmsbelfast@gmail.com', 'hmsbelfast');
insert into alumni (student_number, birthday, sex, batch, grad_year, alumni_user_id) values (194912404, '1932-04-07', 'F', 1949, 1953, 134);
insert into job (alumni_student_number, company, company_loc_city, company_loc_country, company_position) values (194912404, 'Brains inc', 'Chicago', 'USA', 'Player');
insert into contact_num (alumni_student_number, phone_number) values (194912404, '914022851');
--
insert into client (firstname, lastname, middlename, extension, email, password) values ('Ritsuka', 'Fujimaru', 'Gudako', NULL, 'ritsukafujimaru@gmail.com', 'ritsukafujimaru');
insert into alumni (student_number, birthday, sex, batch, grad_year, alumni_user_id) values (195094860, '1932-04-07', 'F', 1950, 1954, 135);
insert into job (alumni_student_number, company, company_loc_city, company_loc_country, company_position) values (195094860, 'Rolls inc', 'Los Angeles', 'USA', 'CEO');
insert into contact_num (alumni_student_number, phone_number) values (195094860, '994104928');
--
insert into client (firstname, lastname, middlename, extension, email, password) values ('Illyasviel', 'Einsbern', 'Von', NULL, 'illyasvieleinsbern@gmail.com', 'illyasvieleinsbern');
insert into alumni (student_number, birthday, sex, batch, grad_year, alumni_user_id) values (200900001, '1908-12-31', 'F', 2009, 2013, 136);
insert into job (alumni_student_number, company, company_loc_city, company_loc_country, company_position) values (200900001, 'Cute inc', 'Washington', 'USA', 'Mage');
insert into contact_num (alumni_student_number, phone_number) values (200900001, '9120420397');
--
insert into client (firstname, lastname, middlename, extension, email, password) values ('Gilles', 'Rais', 'De', NULL, 'gillesrais@gmail.com', 'gillesrais');
insert into alumni (student_number, birthday, sex, batch, grad_year, alumni_user_id) values (200792420, '1989-04-17', 'M', 2007, 2012, 137);
insert into job (alumni_student_number, company, company_loc_city, company_loc_country, company_position) values (200792420, 'Creative inc', 'Boston', 'USA', 'Salesman');
insert into contact_num (alumni_student_number, phone_number) values (200792420, '9910492814');
--
insert into client (firstname, lastname, middlename, extension, email, password) values ('Julius', 'Cowell', 'Drake', NULL, 'juliuscowell@gmail.com', 'juliuscowell');
insert into alumni (student_number, birthday, sex, batch, grad_year, alumni_user_id) values (198810492, '1974-02-10', 'M', 1988, 1992, 138);
insert into job (alumni_student_number, company, company_loc_city, company_loc_country, company_position) values (198810492, 'Rocker inc', 'Chicago', 'USA', 'Vice President');
insert into contact_num (alumni_student_number, phone_number) values (198810492, '9104928022');
--
insert into client (firstname, lastname, middlename, extension, email, password) values ('Eugene', 'Smart', 'Clark', 'Jr.', 'eugenesmart@gmail.com', 'eugenesmart');
insert into alumni (student_number, birthday, sex, batch, grad_year, alumni_user_id) values (198191415, '1966-10-09', 'M', 1981, 1985, 139);
insert into job (alumni_student_number, company, company_loc_city, company_loc_country, company_position) values (198191415, 'Savior inc', 'California', 'USA', 'Driver');
insert into contact_num (alumni_student_number, phone_number) values (198191415, '9104827183');
--
insert into client (firstname, lastname, middlename, extension, email, password) values ('Angel', 'Kurt', 'Jackson', NULL, 'angelkurt@gmail.com', 'angelkurt');
insert into alumni (student_number, birthday, sex, batch, grad_year, alumni_user_id) values (197819003, '1964-11-13', 'F', 1978, 1981, 140);
insert into job (alumni_student_number, company, company_loc_city, company_loc_country, company_position) values (197819003, 'Buff inc', 'Houston', 'USA', 'Saleslady');
insert into contact_num (alumni_student_number, phone_number) values (197819003, '9100914826');
--
insert into client (firstname, lastname, middlename, extension, email, password) values ('Joyce', 'Sanders', 'Mitchell', NULL, 'joycesanders@gmail.com', 'joycesanders');
insert into alumni (student_number, birthday, sex, batch, grad_year, alumni_user_id) values (200317999, '1990-04-20', 'F', 2003, 2007, 141);
insert into job (alumni_student_number, company, company_loc_city, company_loc_country, company_position) values (200317999, 'Adamant inc', 'Boston', 'USA', 'Waitress');
insert into contact_num (alumni_student_number, phone_number) values (200317999, '9104929100');
--
insert into client (firstname, lastname, middlename, extension, email, password) values ('Walt', 'Bell', 'Miller', NULL, 'waltbell@gmail.com', 'waltbell');
insert into alumni (student_number, birthday, sex, batch, grad_year, alumni_user_id) values (199719910, '1983-02-11', 'M', 1997, 2001, 142);
insert into job (alumni_student_number, company, company_loc_city, company_loc_country, company_position) values (199719910, 'Original inc', 'Maryland', 'USA', 'Professor');
insert into contact_num (alumni_student_number, phone_number) values (199719910, '9104888192');
--
insert into client (firstname, lastname, middlename, extension, email, password) values ('Sandra', 'Olga', 'Hudson', NULL, 'sandraolga@gmail.com', 'sandraolga');
insert into alumni (student_number, birthday, sex, batch, grad_year, alumni_user_id) values (195900132, '1945-02-11', 'F', 1959, 1964, 143);
insert into job (alumni_student_number, company, company_loc_city, company_loc_country, company_position) values (195900132, 'Cute inc', 'Louisiana', 'USA', 'Nurse');
insert into contact_num (alumni_student_number, phone_number) values (195900132, '9131012409');
--
insert into client (firstname, lastname, middlename, extension, email, password) values ('Oliver', 'Parker', 'Rutherford', NULL, 'oliverparker@gmail.com', 'oliverparker');
insert into alumni (student_number, birthday, sex, batch, grad_year, alumni_user_id) values (196100194, '1948-02-11', 'M', 1961, 1965, 144);
insert into job (alumni_student_number, company, company_loc_city, company_loc_country, company_position) values (196100194, 'Alpha inc', 'Houston', 'USA', 'Teacher');
insert into contact_num (alumni_student_number, phone_number) values (196100194, '9109919420');
--
insert into client (firstname, lastname, middlename, extension, email, password) values ('Raymond', 'Norris', 'Turner', 'IV', 'raymondnorris@gmail.com', 'raymondnorris');
insert into alumni (student_number, birthday, sex, batch, grad_year, alumni_user_id) values (197791711, '1960-08-26', 'M', 1977, 1981, 145);
insert into job (alumni_student_number, company, company_loc_city, company_loc_country, company_position) values (197791711, 'Happy inc', 'Los Angeles', 'USA', 'Surgeon');
insert into contact_num (alumni_student_number, phone_number) values (197791711, '9001948211');
--
insert into activity (partnerships, event_name, event_date) values (NULL, 'Party', '2002-03-09');
insert into activity (partnerships, event_name, event_date) values ('Facebool', 'Forum', '2012-03-25');
insert into activity (partnerships, event_name, event_date) values ('Abble', 'Forum', '2014-03-01');
insert into activity (partnerships, event_name, event_date) values ('Samswng', 'Forum', '2015-06-17');
insert into activity (partnerships, event_name, event_date) values ('Reppler', 'Alumni Homecoming', '2015-01-12');
insert into activity (partnerships, event_name, event_date) values ('Glube', 'Battle of the bands', '2014-11-14');
insert into activity (partnerships, event_name, event_date) values (NULL, 'Party', '2002-08-10');
insert into activity (partnerships, event_name, event_date) values ('Lntel', 'Workshop', '1990-04-09');
insert into activity (partnerships, event_name, event_date) values ('Nokla', 'Forum', '1989-10-30');
insert into activity (partnerships, event_name, event_date) values ('Mozzilo', 'Forum', '2000-04-27');
insert into activity (partnerships, event_name, event_date) values ('Samswng', 'Workshop', '2004-05-10');
insert into activity (partnerships, event_name, event_date) values ('Samswng', 'Job fair', '2004-06-14');
insert into activity (partnerships, event_name, event_date) values ('Samswng', 'Forum', '2005-10-20');
insert into activity (partnerships, event_name, event_date) values ('Microhard', 'Forum', '1997-03-14');
insert into activity (partnerships, event_name, event_date) values ('Microhard', 'Job fair', '1998-03-17');
insert into activity (partnerships, event_name, event_date) values (NULL, 'Battle of the bands', '1988-10-09');
insert into activity (partnerships, event_name, event_date) values ('Nikun', 'Party', '1991-11-27');
insert into activity (partnerships, event_name, event_date) values ('Microhard', 'Workshop', '2010-10-12');
insert into activity (partnerships, event_name, event_date) values ('Facebool', 'Workshop', '2009-06-13');
insert into activity (partnerships, event_name, event_date) values ('Abble', 'Party', '2003-11-24');
insert into activity (partnerships, event_name, event_date) values ('Glube', 'Job fair', '2018-11-23');
insert into activity (partnerships, event_name, event_date) values (NULL, 'Forum', '2017-10-10');
insert into activity (partnerships, event_name, event_date) values ('Microhard', 'Workshop', '2012-02-23');
insert into activity (partnerships, event_name, event_date) values ('Abble', 'Forum', '2004-10-31');
insert into activity (partnerships, event_name, event_date) values ('Nokla', 'Forum', '2013-07-12');
insert into activity (partnerships, event_name, event_date) values ('Nikun', 'Job fair', '1991-11-28');
insert into activity (partnerships, event_name, event_date) values (NULL, 'Job fair', '2011-12-15');
insert into activity (partnerships, event_name, event_date) values ('San Muguel', 'Battle of the bands', '1979-11-30');
insert into activity (partnerships, event_name, event_date) values ('Microhard', 'Workshop', '1989-06-14');
insert into activity (partnerships, event_name, event_date) values ('Abble', 'Party', '2003-12-25');
insert into activity (partnerships, event_name, event_date) values ('Nokla', 'Forum', '2017-11-11');
insert into activity (partnerships, event_name, event_date) values ('Microhard', 'Forum', '2018-01-10');
insert into activity (partnerships, event_name, event_date) values ('Microhard', 'Workshop', '1999-12-14');
insert into activity (partnerships, event_name, event_date) values ('Abble', 'Job fair', '2006-04-16');
insert into activity (partnerships, event_name, event_date) values (NULL, 'Party', '2001-01-17');
insert into activity (partnerships, event_name, event_date) values ('Nikun', 'Workshop', '2011-10-11');
insert into activity (partnerships, event_name, event_date) values ('Abble', 'Workshop', '1999-12-10');
insert into activity (partnerships, event_name, event_date) values ('Samswng', 'Job fair', '2007-11-13');
insert into activity (partnerships, event_name, event_date) values ('Microhard', 'Job fair', '1989-06-14');
insert into activity (partnerships, event_name, event_date) values ('Abble', 'Job fair', '2005-02-20');
insert into activity (partnerships, event_name, event_date) values ('Facebool', 'Forum', '2016-12-01');
insert into activity (partnerships, event_name, event_date) values ('San Muguel', 'Battle of the bands', '1980-12-31');
insert into activity (partnerships, event_name, event_date) values ('Glube', 'Party', '2007-10-04');
insert into activity (partnerships, event_name, event_date) values ('Microhard', 'Forum', '2007-02-12');
insert into activity (partnerships, event_name, event_date) values ('Samswng', 'Job fair', '2003-06-13');
insert into activity (partnerships, event_name, event_date) values (NULL, 'Party', '1997-11-29');
insert into activity (partnerships, event_name, event_date) values ('Lntel', 'Party', '2010-05-26');
insert into activity (partnerships, event_name, event_date) values ('San Muguel', 'Battle of the bands', '1980-12-30');
insert into activity (partnerships, event_name, event_date) values ('Lntel', 'Workshop', '1976-07-12');
insert into activity (partnerships, event_name, event_date) values ('Nokla', 'Forum', '2001-12-04');
insert into activity (partnerships, event_name, event_date) values ('Samswng', 'Job fair', '1998-03-17');
insert into activity (partnerships, event_name, event_date) values (NULL, 'Forum', '2003-12-04');
insert into activity (partnerships, event_name, event_date) values ('Facebool', 'Workshop', '2010-08-19');
insert into activity (partnerships, event_name, event_date) values (NULL, 'Battle of the bands', '1994-04-21');
insert into activity (partnerships, event_name, event_date) values ('Lntel', 'Workshop', '2007-09-16');
insert into activity (partnerships, event_name, event_date) values ('Microhard', 'Job fair', '2013-10-12');
insert into activity (partnerships, event_name, event_date) values (NULL, 'Party', '2014-03-22');
insert into activity (partnerships, event_name, event_date) values (NULL, 'Battle of the bands', '2003-11-21');
insert into activity (partnerships, event_name, event_date) values ('Nokla', 'Forum', '2004-10-11');
insert into activity (partnerships, event_name, event_date) values ('Nokla', 'Forum', '2005-07-14');
insert into activity (partnerships, event_name, event_date) values ('Microhard', 'Workshop', '1975-12-10');
insert into activity (partnerships, event_name, event_date) values ('Facebool', 'Job fair', '2011-07-16');
insert into activity (partnerships, event_name, event_date) values ('Mozzilo', 'Workshop', '2003-11-03');
insert into activity (partnerships, event_name, event_date) values (NULL, 'Workshop', '1973-12-11');
insert into activity (partnerships, event_name, event_date) values ('Nikun', 'Workshop', '2017-10-13');
insert into activity (partnerships, event_name, event_date) values ('Microhard', 'Party', '2014-05-17');
insert into activity (partnerships, event_name, event_date) values ('Samswng', 'Workshop', '2016-12-20');
insert into activity (partnerships, event_name, event_date) values ('Lntel', 'Alumni Homecoming', '2007-12-28');
insert into activity (partnerships, event_name, event_date) values ('Abble', 'Job fair', '1995-02-15');
insert into activity (partnerships, event_name, event_date) values ('Samswng', 'Forum', '2010-10-08');
insert into activity (partnerships, event_name, event_date) values ('Nikun', 'Workshop', '1991-01-24');
insert into activity (partnerships, event_name, event_date) values ('Facebool', 'Forum', '2013-09-14');
insert into activity (partnerships, event_name, event_date) values (NULL, 'Workshop', '2011-02-18');
insert into activity (partnerships, event_name, event_date) values ('San Muguel', 'Battle of the bands', '1998-10-11');
insert into activity (partnerships, event_name, event_date) values ('Lntel', 'Forum', '2014-02-19');
insert into activity (partnerships, event_name, event_date) values ('Microhard', 'Workshop', '2015-11-28');
insert into activity (partnerships, event_name, event_date) values (NULL, 'Job fair', '2012-12-20');
insert into activity (partnerships, event_name, event_date) values ('Microhard', 'Forum', '2007-01-13');
insert into activity (partnerships, event_name, event_date) values ('Samswng', 'Workshop', '1998-03-17');
insert into activity (partnerships, event_name, event_date) values ('Facebool', 'Forum', '2011-11-18');
insert into activity (partnerships, event_name, event_date) values ('San Muguel', 'Battle of the bands', '2013-04-30');
insert into activity (partnerships, event_name, event_date) values ('Mozzilo', 'Forum', '2011-10-19');
insert into activity (partnerships, event_name, event_date) values ('Microhard', 'Job fair', '2012-12-17');
insert into activity (partnerships, event_name, event_date) values ('San Muguel', 'Alumni Homecoming', '2004-11-14');
insert into activity (partnerships, event_name, event_date) values ('Samswng', 'Workshop', '2005-01-12');
insert into activity (partnerships, event_name, event_date) values ('Nokla', 'Job fair', '2010-04-20');
insert into activity (partnerships, event_name, event_date) values (NULL, 'Forum', '2010-11-24');
insert into activity (partnerships, event_name, event_date) values ('Lntel', 'Forum', '2000-10-29');
insert into activity (partnerships, event_name, event_date) values ('Facebool', 'Forum', '2016-05-19');
insert into activity (partnerships, event_name, event_date) values ('Abble', 'Alumni Homecoming', '2015-07-12');
insert into activity (partnerships, event_name, event_date) values ('San Muguel', 'Battle of the bands', '2014-04-19');
insert into activity (partnerships, event_name, event_date) values ('Nikun', 'Workshop', '1984-10-11');
insert into activity (partnerships, event_name, event_date) values ('Abble', 'Job fair', '1980-03-12');
insert into activity (partnerships, event_name, event_date) values ('Mozzilo', 'Workshop', '2006-04-20');
insert into activity (partnerships, event_name, event_date) values ('Facebool', 'Alumni Homecoming', '2017-12-19');
insert into activity (partnerships, event_name, event_date) values ('Glube', 'Job fair', '1994-04-17');
insert into activity (partnerships, event_name, event_date) values ('Lntel', 'Job fair', '2004-10-28');
insert into activity (partnerships, event_name, event_date) values (NULL, 'Forum', '2009-01-13');
insert into activity (partnerships, event_name, event_date) values ('Nokla', 'Forum', '2007-10-18');
insert into activity (partnerships, event_name, event_date) values ('Microhard', 'Party', '2017-02-28');