CREATE TEMP TABLE _csv_import ( LEB TEXT, BHSA_Latin TEXT,BHSA_English TEXT,SBLGNT_abbr TEXT,SBLGNT_English TEXT );

.separator "\t"
.import book-names.txt _csv_import

DROP TABLE IF EXISTS book_names;
CREATE TABLE book_names ( _id INTEGER PRIMARY KEY AUTOINCREMENT, LEB TEXT, BHSA_Latin TEXT,BHSA_English TEXT,SBLGNT_abbr TEXT,SBLGNT_English TEXT, English TEXT );

INSERT INTO book_names (LEB, BHSA_Latin,BHSA_English,SBLGNT_abbr,SBLGNT_English) 
					SELECT LEB, BHSA_Latin,BHSA_English,SBLGNT_abbr,SBLGNT_English
					FROM _csv_import WHERE 1;
-- get rid of the temporary table
DROP TABLE _csv_import;

UPDATE book_names SET English=replace(BHSA_English,'_',' ') WHERE LENGTH(BHSA_English) > 0;
UPDATE book_names SET English=SBLGNT_English WHERE LENGTH(SBLGNT_English) > 0;

-- wrap the whole business in a single transaction so sqlite doesn't do commits all the time
BEGIN TRANSACTION;

-- create the final table
DROP TABLE IF EXISTS lexham;
CREATE TABLE lexham (	
	_id INTEGER PRIMARY KEY AUTOINCREMENT,
	reference TEXT,
	verseText TEXT,
	lexhamAbbreviation TEXT,
	chapter INT,
	verse INT
);

CREATE TEMP TABLE _csv_import ( 
	reference TEXT,
	verseText TEXT
);

.separator "\t"
.import LEB.tabs.txt _csv_import

INSERT INTO lexham (reference, verseText) 
					SELECT reference, verseText
					FROM _csv_import WHERE 1;
-- get rid of the temporary table
DROP TABLE _csv_import;

UPDATE lexham SET	lexhamAbbreviation=substr(reference,0,instr(reference,' ')),
					chapter=substr(reference,instr(reference,' '),instr(reference,':')-instr(reference,' ')),
					verse=substr(reference,instr(reference,':')+1);

COMMIT TRANSACTION;
