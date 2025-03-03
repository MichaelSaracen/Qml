-- DROP TABLE IF EXISTS task;
-- DROP TABLE IF EXISTS subject;
-- CREATE TABLE subject (
-- 	id INTEGER,
-- 	name TEXT,
-- 	PRIMARY KEY (id AUTOINCREMENT)
-- );
-- 
-- INSERT INTO subject (name) VALUES 
-- ('Netzwerk - Grundlagen'), 
-- ('Datenbanken');
-- 
-- CREATE TABLE task (
-- 	id INTEGER,
-- 	question TEXT,
-- 	answer TEXT,
-- 	subjectID INTEGER,
-- 	PRIMARY KEY (id AUTOINCREMENT),
-- 	FOREIGN KEY (subjectID) REFERENCES subject(id) ON DELETE CASCADE
-- );
-- 
-- INSERT INTO task(question, answer, subjectID)
-- VALUES
-- ("Netzwerk-Frage 1", "Netzwerk-Antowrt 1", 1),
-- ("Netzwerk-Frage 2", "Netzwerk-Antowrt 2", 1),
-- ("Netzwerk-Frage 3", "Netzwerk-Antowrt 3", 1),
-- ("Netzwerk-Frage 4", "Netzwerk-Antowrt 1", 1),
-- ("Netzwerk-Frage 5", "Netzwerk-Antowrt 2", 1),
-- ("Netzwerk-Frage 6", "Netzwerk-Antowrt 3", 1),
-- ("Netzwerk-Frage 7", "Netzwerk-Antowrt 1", 1),
-- ("Netzwerk-Frage 8", "Netzwerk-Antowrt 2", 1),
-- ("Netzwerk-Frage 9", "Netzwerk-Antowrt 3", 1),
-- ("Netzwerk-Frage 10", "Netzwerk-Antowrt 1", 1),
-- ("Netzwerk-Frage 11", "Netzwerk-Antowrt 2", 1),
-- ("Netzwerk-Frage 12", "Netzwerk-Antowrt 3", 1),
-- ("Datenbank-Frage 1", "Netzwerk-Antowrt 1", 2),
-- ("Datenbank-Frage 2", "Netzwerk-Antowrt 2", 2),
-- ("Datenbank-Frage 3", "Netzwerk-Antowrt 3", 2);

--- Ablauf der Edit Page
-- Fach hinzufügn
-- INSERT INTO subject (name) VALUES ("BWL");

-- Fach Löschen
-- DELETE FROM subject WHERE id = 3;

-- Frage und Antwort einem Fach hinzuügen
-- INSERT INTO task ( question, answer, subjectID ) VALUES ("Netzwerk-Frage 4", "Netzwerk-Antowrt 4", 1);

-- Alle Fragen eines Fachs anzeigen
-- SELECT id, question, answer FROM task WHERE subjectID = 1;

-- Ändern einer Frage und Antwort
-- UPDATE task SET question = 'Netzwerk-Frage 4 Neu', answer = 'Netzwerk-Antwort 4 Neu' WHERE id = 7;

-- Eine Frage und Antwort Löschen
-- DELETE FROM task WHERE id = 7;

---
SELECT id, question, answer FROM task WHERE subjectID = 1;
