# crystal-monetdb-libmapi

Crystal binding for the MonetDB MAPI client interface

This is currently experimental and needs a lot of work !

You will need the MonetDB client package installed for this to work and also an instance of MServer5 running

For more details look at monetdb.org

Examples schemas provided under examples/


````
[brian@orville crystal-monetdb-libmapi]$ make
crystal build --release quick.cr -o bin/quick
[brian@orville crystal-monetdb-libmapi]$ bin/quick -H 172.17.0.2 -u monetdb -d threatmonitor -2 false
>> Server Information

 > Merovingian Server: 172.17.0.2
 > Port: 50000
 > Username: monetdb
 > DB: threatmonitor
 > Is Connected?: true
 > Ping?: OK
 > Merovingian URI: mapi:monetdb://172.17.0.2:50000/threatmonitor
 > Monet Version: 
 > Autocommit: false

>> Insert Test
 - INSERT iterations: 3000
Query number: 250 SQL: INSERT INTO "threatmonitor".guid_test VALUES ('#dummy-hsropzicvxbzcvoxgdskdtssvo', 'hsropzicvxbzcvoxgdskdtssvo', 'hsropzicvxbzcvoxgdskdtssvo', 'hsropzicvxbzcvoxgdskdtssvo', 'hsropzicvxbzcvoxgdskdtssvo', 'hsropzicvxbzcvoxgdskdtssvo', 'hsropzicvxbzcvoxgdskdtssvo', 'hsropzicvxbzcvoxgdskdtssvo', 'hsropzicvxbzcvoxgdskdtssvo', 'hsropzicvxbzcvoxgdskdtssvo', 'hsropzicvxbzcvoxgdskdtssvo')
Query number: 500 SQL: INSERT INTO "threatmonitor".guid_test VALUES ('#dummy-fasarzvhfimdqyeanhtbzsqamc', 'fasarzvhfimdqyeanhtbzsqamc', 'fasarzvhfimdqyeanhtbzsqamc', 'fasarzvhfimdqyeanhtbzsqamc', 'fasarzvhfimdqyeanhtbzsqamc', 'fasarzvhfimdqyeanhtbzsqamc', 'fasarzvhfimdqyeanhtbzsqamc', 'fasarzvhfimdqyeanhtbzsqamc', 'fasarzvhfimdqyeanhtbzsqamc', 'fasarzvhfimdqyeanhtbzsqamc', 'fasarzvhfimdqyeanhtbzsqamc')
Query number: 750 SQL: INSERT INTO "threatmonitor".guid_test VALUES ('#dummy-pfwefohlkeylqponpmlqtgrjxe', 'pfwefohlkeylqponpmlqtgrjxe', 'pfwefohlkeylqponpmlqtgrjxe', 'pfwefohlkeylqponpmlqtgrjxe', 'pfwefohlkeylqponpmlqtgrjxe', 'pfwefohlkeylqponpmlqtgrjxe', 'pfwefohlkeylqponpmlqtgrjxe', 'pfwefohlkeylqponpmlqtgrjxe', 'pfwefohlkeylqponpmlqtgrjxe', 'pfwefohlkeylqponpmlqtgrjxe', 'pfwefohlkeylqponpmlqtgrjxe')
Query number: 1000 SQL: INSERT INTO "threatmonitor".guid_test VALUES ('#dummy-hbvdclihtmbzmgocvidixupaky', 'hbvdclihtmbzmgocvidixupaky', 'hbvdclihtmbzmgocvidixupaky', 'hbvdclihtmbzmgocvidixupaky', 'hbvdclihtmbzmgocvidixupaky', 'hbvdclihtmbzmgocvidixupaky', 'hbvdclihtmbzmgocvidixupaky', 'hbvdclihtmbzmgocvidixupaky', 'hbvdclihtmbzmgocvidixupaky', 'hbvdclihtmbzmgocvidixupaky', 'hbvdclihtmbzmgocvidixupaky')
Query number: 1250 SQL: INSERT INTO "threatmonitor".guid_test VALUES ('#dummy-gurtuulylcruvskdmofwwzoqfu', 'gurtuulylcruvskdmofwwzoqfu', 'gurtuulylcruvskdmofwwzoqfu', 'gurtuulylcruvskdmofwwzoqfu', 'gurtuulylcruvskdmofwwzoqfu', 'gurtuulylcruvskdmofwwzoqfu', 'gurtuulylcruvskdmofwwzoqfu', 'gurtuulylcruvskdmofwwzoqfu', 'gurtuulylcruvskdmofwwzoqfu', 'gurtuulylcruvskdmofwwzoqfu', 'gurtuulylcruvskdmofwwzoqfu')
Query number: 1500 SQL: INSERT INTO "threatmonitor".guid_test VALUES ('#dummy-qvruarnrlkjetkjgdcocszykfx', 'qvruarnrlkjetkjgdcocszykfx', 'qvruarnrlkjetkjgdcocszykfx', 'qvruarnrlkjetkjgdcocszykfx', 'qvruarnrlkjetkjgdcocszykfx', 'qvruarnrlkjetkjgdcocszykfx', 'qvruarnrlkjetkjgdcocszykfx', 'qvruarnrlkjetkjgdcocszykfx', 'qvruarnrlkjetkjgdcocszykfx', 'qvruarnrlkjetkjgdcocszykfx', 'qvruarnrlkjetkjgdcocszykfx')
Query number: 1750 SQL: INSERT INTO "threatmonitor".guid_test VALUES ('#dummy-cvbrwgskfphqqoohbmtunjxhbs', 'cvbrwgskfphqqoohbmtunjxhbs', 'cvbrwgskfphqqoohbmtunjxhbs', 'cvbrwgskfphqqoohbmtunjxhbs', 'cvbrwgskfphqqoohbmtunjxhbs', 'cvbrwgskfphqqoohbmtunjxhbs', 'cvbrwgskfphqqoohbmtunjxhbs', 'cvbrwgskfphqqoohbmtunjxhbs', 'cvbrwgskfphqqoohbmtunjxhbs', 'cvbrwgskfphqqoohbmtunjxhbs', 'cvbrwgskfphqqoohbmtunjxhbs')
Query number: 2000 SQL: INSERT INTO "threatmonitor".guid_test VALUES ('#dummy-gckazemknbdhqlslxbzrnkgtra', 'gckazemknbdhqlslxbzrnkgtra', 'gckazemknbdhqlslxbzrnkgtra', 'gckazemknbdhqlslxbzrnkgtra', 'gckazemknbdhqlslxbzrnkgtra', 'gckazemknbdhqlslxbzrnkgtra', 'gckazemknbdhqlslxbzrnkgtra', 'gckazemknbdhqlslxbzrnkgtra', 'gckazemknbdhqlslxbzrnkgtra', 'gckazemknbdhqlslxbzrnkgtra', 'gckazemknbdhqlslxbzrnkgtra')
Query number: 2250 SQL: INSERT INTO "threatmonitor".guid_test VALUES ('#dummy-dzvgoboauzgenyykacqhzoncxy', 'dzvgoboauzgenyykacqhzoncxy', 'dzvgoboauzgenyykacqhzoncxy', 'dzvgoboauzgenyykacqhzoncxy', 'dzvgoboauzgenyykacqhzoncxy', 'dzvgoboauzgenyykacqhzoncxy', 'dzvgoboauzgenyykacqhzoncxy', 'dzvgoboauzgenyykacqhzoncxy', 'dzvgoboauzgenyykacqhzoncxy', 'dzvgoboauzgenyykacqhzoncxy', 'dzvgoboauzgenyykacqhzoncxy')
Query number: 2500 SQL: INSERT INTO "threatmonitor".guid_test VALUES ('#dummy-qglplasgayoobksgcklacshumz', 'qglplasgayoobksgcklacshumz', 'qglplasgayoobksgcklacshumz', 'qglplasgayoobksgcklacshumz', 'qglplasgayoobksgcklacshumz', 'qglplasgayoobksgcklacshumz', 'qglplasgayoobksgcklacshumz', 'qglplasgayoobksgcklacshumz', 'qglplasgayoobksgcklacshumz', 'qglplasgayoobksgcklacshumz', 'qglplasgayoobksgcklacshumz')
Query number: 2750 SQL: INSERT INTO "threatmonitor".guid_test VALUES ('#dummy-dkjnqffttixwhaitqumfqhdtlf', 'dkjnqffttixwhaitqumfqhdtlf', 'dkjnqffttixwhaitqumfqhdtlf', 'dkjnqffttixwhaitqumfqhdtlf', 'dkjnqffttixwhaitqumfqhdtlf', 'dkjnqffttixwhaitqumfqhdtlf', 'dkjnqffttixwhaitqumfqhdtlf', 'dkjnqffttixwhaitqumfqhdtlf', 'dkjnqffttixwhaitqumfqhdtlf', 'dkjnqffttixwhaitqumfqhdtlf', 'dkjnqffttixwhaitqumfqhdtlf')
( Duration ) : Start: 2016-04-30 20:33:39 +0000 Finish: 2016-04-30 20:33:44 +0000 Duration: 00:00:05.4429530

>> Update Test
 - Update Iteration: 0
UPDATE "threatmonitor".guid_test SET guid = 'Dagobert' WHERE f0 LIKE '%asd%';
Rows affected: 0
 - Update Iteration: 1
UPDATE "threatmonitor".guid_test SET guid = 'Dagobert' WHERE f8 LIKE '%asd%';
Rows affected: 4

>> Delete Test
DELETE FROM "threatmonitor".guid_test WHERE guid = 'Dagobert';
Rows affected: 4

>> Create Table Test Empty Table
CREATE TABLE "threatmonitor".table1 ( id int, firstname char(50), lastname char(50), age int);
Query number: 0 SQL: INSERT INTO "threatmonitor".table1 VALUES (0, 'Dave', 'Stevens', 12);
Query number: 250 SQL: INSERT INTO "threatmonitor".table1 VALUES (250, 'Fred', 'Smith', 0);
Query number: 500 SQL: INSERT INTO "threatmonitor".table1 VALUES (500, 'Dave', 'Edwards', 41);
Query number: 750 SQL: INSERT INTO "threatmonitor".table1 VALUES (750, 'Dave', 'Stevens', 53);
Query number: 1000 SQL: INSERT INTO "threatmonitor".table1 VALUES (1000, 'James', 'Edwards', 71);
Query number: 1250 SQL: INSERT INTO "threatmonitor".table1 VALUES (1250, 'Fred', 'Stevens', 69);
Query number: 1500 SQL: INSERT INTO "threatmonitor".table1 VALUES (1500, 'Ernest', 'Jones', 1);
Query number: 1750 SQL: INSERT INTO "threatmonitor".table1 VALUES (1750, 'Dave', 'Stevens', 15);
Query number: 2000 SQL: INSERT INTO "threatmonitor".table1 VALUES (2000, 'James', 'Smith', 11);
Query number: 2250 SQL: INSERT INTO "threatmonitor".table1 VALUES (2250, 'John', 'Jones', 45);
Query number: 2500 SQL: INSERT INTO "threatmonitor".table1 VALUES (2500, 'Dave', 'Stevens', 12);
Query number: 2750 SQL: INSERT INTO "threatmonitor".table1 VALUES (2750, 'John', 'Williams', 67);
Rows affected: 1

>> ALTER TABLE Test ADD COLUMN
ALTER TABLE "threatmonitor".table1 ADD COLUMN sex CHAR(1);
Rows affected: 0

>> ALTER TABLE Test DROP COLUMN
ALTER TABLE "threatmonitor".table1 DROP COLUMN sex;
Rows affected: 0

>> DROP TABLE Test
DROP TABLE "threatmonitor".table1;
Rows affected: 0
SELECT Statement: SELECT * FROM "threatmonitor".guid_test LIMIT 10
Handle: Pointer(Void)@0x22077a0
Table Width: 11
Record Count: 10
MServer Response Key: MOK Code: 0

>> SELECT Test
% threatmonitor.guid_test,	threatmonitor.guid_test,	threatmonitor.guid_test,	threatmonitor.guid_test,	threatmonitor.guid_test,	threatmonitor.guid_test,	threatmonitor.guid_test,	threatmonitor.guid_test,	threatmonitor.guid_test,	threatmonitor.guid_test,	threatmonitor.guid_test # table_name
% guid,	f1,	f2,	f3,	f4,	f5,	f6,	f7,	f8,	f9,	f10 # name
% char,	char,	char,	char,	char,	char,	char,	char,	char,	char,	char # type
% 36,	26,	26,	26,	26,	26,	26,	26,	26,	26,	26 # length
[ "#dummy-vwgydzzpinlwwzyqzfejpcxgod",	"vwgydzzpinlwwzyqzfejpcxgod",	"vwgydzzpinlwwzyqzfejpcxgod",	"vwgydzzpinlwwzyqzfejpcxgod",	"vwgydzzpinlwwzyqzfejpcxgod",	"vwgydzzpinlwwzyqzfejpcxgod",	"vwgydzzpinlwwzyqzfejpcxgod",	"vwgydzzpinlwwzyqzfejpcxgod",	"vwgydzzpinlwwzyqzfejpcxgod",	"vwgydzzpinlwwzyqzfejpcxgod",	"vwgydzzpinlwwzyqzfejpcxgod"	]
[ "#dummy-dynfzsvtzmpzofrgqebrlcznvb",	"dynfzsvtzmpzofrgqebrlcznvb",	"dynfzsvtzmpzofrgqebrlcznvb",	"dynfzsvtzmpzofrgqebrlcznvb",	"dynfzsvtzmpzofrgqebrlcznvb",	"dynfzsvtzmpzofrgqebrlcznvb",	"dynfzsvtzmpzofrgqebrlcznvb",	"dynfzsvtzmpzofrgqebrlcznvb",	"dynfzsvtzmpzofrgqebrlcznvb",	"dynfzsvtzmpzofrgqebrlcznvb",	"dynfzsvtzmpzofrgqebrlcznvb"	]
[ "#dummy-sqmckjiuxgygfkuntnrgxntpzh",	"sqmckjiuxgygfkuntnrgxntpzh",	"sqmckjiuxgygfkuntnrgxntpzh",	"sqmckjiuxgygfkuntnrgxntpzh",	"sqmckjiuxgygfkuntnrgxntpzh",	"sqmckjiuxgygfkuntnrgxntpzh",	"sqmckjiuxgygfkuntnrgxntpzh",	"sqmckjiuxgygfkuntnrgxntpzh",	"sqmckjiuxgygfkuntnrgxntpzh",	"sqmckjiuxgygfkuntnrgxntpzh",	"sqmckjiuxgygfkuntnrgxntpzh"	]
[ "#dummy-ekzpopvrqhstpfvxplhnjnphlf",	"ekzpopvrqhstpfvxplhnjnphlf",	"ekzpopvrqhstpfvxplhnjnphlf",	"ekzpopvrqhstpfvxplhnjnphlf",	"ekzpopvrqhstpfvxplhnjnphlf",	"ekzpopvrqhstpfvxplhnjnphlf",	"ekzpopvrqhstpfvxplhnjnphlf",	"ekzpopvrqhstpfvxplhnjnphlf",	"ekzpopvrqhstpfvxplhnjnphlf",	"ekzpopvrqhstpfvxplhnjnphlf",	"ekzpopvrqhstpfvxplhnjnphlf"	]
[ "#dummy-nuqnikukecgajmahyjogqjozap",	"nuqnikukecgajmahyjogqjozap",	"nuqnikukecgajmahyjogqjozap",	"nuqnikukecgajmahyjogqjozap",	"nuqnikukecgajmahyjogqjozap",	"nuqnikukecgajmahyjogqjozap",	"nuqnikukecgajmahyjogqjozap",	"nuqnikukecgajmahyjogqjozap",	"nuqnikukecgajmahyjogqjozap",	"nuqnikukecgajmahyjogqjozap",	"nuqnikukecgajmahyjogqjozap"	]
[ "#dummy-tyhtvouwoeowqfelwzjbhbrxwl",	"tyhtvouwoeowqfelwzjbhbrxwl",	"tyhtvouwoeowqfelwzjbhbrxwl",	"tyhtvouwoeowqfelwzjbhbrxwl",	"tyhtvouwoeowqfelwzjbhbrxwl",	"tyhtvouwoeowqfelwzjbhbrxwl",	"tyhtvouwoeowqfelwzjbhbrxwl",	"tyhtvouwoeowqfelwzjbhbrxwl",	"tyhtvouwoeowqfelwzjbhbrxwl",	"tyhtvouwoeowqfelwzjbhbrxwl",	"tyhtvouwoeowqfelwzjbhbrxwl"	]
[ "#dummy-mohcynzdzglfgrznimqxusnfbp",	"mohcynzdzglfgrznimqxusnfbp",	"mohcynzdzglfgrznimqxusnfbp",	"mohcynzdzglfgrznimqxusnfbp",	"mohcynzdzglfgrznimqxusnfbp",	"mohcynzdzglfgrznimqxusnfbp",	"mohcynzdzglfgrznimqxusnfbp",	"mohcynzdzglfgrznimqxusnfbp",	"mohcynzdzglfgrznimqxusnfbp",	"mohcynzdzglfgrznimqxusnfbp",	"mohcynzdzglfgrznimqxusnfbp"	]
[ "#dummy-mesgkaopbfyowtamjfzjiklbeo",	"mesgkaopbfyowtamjfzjiklbeo",	"mesgkaopbfyowtamjfzjiklbeo",	"mesgkaopbfyowtamjfzjiklbeo",	"mesgkaopbfyowtamjfzjiklbeo",	"mesgkaopbfyowtamjfzjiklbeo",	"mesgkaopbfyowtamjfzjiklbeo",	"mesgkaopbfyowtamjfzjiklbeo",	"mesgkaopbfyowtamjfzjiklbeo",	"mesgkaopbfyowtamjfzjiklbeo",	"mesgkaopbfyowtamjfzjiklbeo"	]
[ "#dummy-rwyxrjrqnrptgcxugjdzqfaxrf",	"rwyxrjrqnrptgcxugjdzqfaxrf",	"rwyxrjrqnrptgcxugjdzqfaxrf",	"rwyxrjrqnrptgcxugjdzqfaxrf",	"rwyxrjrqnrptgcxugjdzqfaxrf",	"rwyxrjrqnrptgcxugjdzqfaxrf",	"rwyxrjrqnrptgcxugjdzqfaxrf",	"rwyxrjrqnrptgcxugjdzqfaxrf",	"rwyxrjrqnrptgcxugjdzqfaxrf",	"rwyxrjrqnrptgcxugjdzqfaxrf",	"rwyxrjrqnrptgcxugjdzqfaxrf"	]
[ "#dummy-jddmveyjggqhhxchiehurwwigu",	"jddmveyjggqhhxchiehurwwigu",	"jddmveyjggqhhxchiehurwwigu",	"jddmveyjggqhhxchiehurwwigu",	"jddmveyjggqhhxchiehurwwigu",	"jddmveyjggqhhxchiehurwwigu",	"jddmveyjggqhhxchiehurwwigu",	"jddmveyjggqhhxchiehurwwigu",	"jddmveyjggqhhxchiehurwwigu",	"jddmveyjggqhhxchiehurwwigu",	"jddmveyjggqhhxchiehurwwigu"	]
SELECT Statement: SELECT * FROM "threatmonitor".fruits
Handle: Pointer(Void)@0x2213f50
Table Width: 5
Record Count: 8
MServer Response Key: MOK Code: 0

>> SELECT Test
% threatmonitor.fruits,	threatmonitor.fruits,	threatmonitor.fruits,	threatmonitor.fruits,	threatmonitor.fruits # table_name
% name,	price,	weight,	comments,	id # name
% varchar,	varchar,	int,	clob,	int # type
% 9,	4,	2,	11,	1 # length
[ "Apple",	"9.99",	50,	NULL,	1	]
[ "Bananna",	"3.99",	30,	NULL,	2	]
[ "Orange",	"7.99",	60,	NULL,	3	]
[ "Peach",	"5.00",	80,	NULL,	4	]
[ "Kiwi",	"9.00",	20,	NULL,	5	]
[ "Tomato",	"2.00",	20,	"Yes a fruit",	6	]
[ "Pear",	"4.00",	30,	"Juicy",	7	]
[ "Nectarine",	"6.00",	50,	"Juicy",	8	]
Session should now be closed down and disconnected
Checking ....
Connected to MServer ? false

# MClient output showing that Crystal INSERTED the data into the Database

$ mclient -h 172.17.0.2 -u monetdb -d threatmonitor
password:
Welcome to mclient, the MonetDB/SQL interactive terminal (Jul2015-SP2)
Database: MonetDB v11.21.19 (Jul2015-SP4), 'mapi:monetdb://mdb-master-01:50000/threatmonitor'
Type \q to quit, \? for a list of available commands
auto commit mode: on
sql>set schema "threatmonitor";
auto commit mode: on
sql>select * from guid_test limit 10;
+-------------------+-------------------+-------------------+-------------------+-------------------+-------------------+-------------------+-------------------+--------------------+--------------------+--------------------+
| guid              | f1                | f2                | f3                | f4                | f5                | f6                | f7                | f8                 | f9                 | f10                |
+===================+===================+===================+===================+===================+===================+===================+===================+====================+====================+====================+
| #dummy-vwgydzzpin | vwgydzzpinlwwzyqz | vwgydzzpinlwwzyqz | vwgydzzpinlwwzyqz | vwgydzzpinlwwzyqz | vwgydzzpinlwwzyqz | vwgydzzpinlwwzyqz | vwgydzzpinlwwzyqz | vwgydzzpinlwwzyqzf | vwgydzzpinlwwzyqzf | vwgydzzpinlwwzyqzf |
: lwwzyqzfejpcxgod  : fejpcxgod         : fejpcxgod         : fejpcxgod         : fejpcxgod         : fejpcxgod         : fejpcxgod         : fejpcxgod         : ejpcxgod           : ejpcxgod           : ejpcxgod           :
| #dummy-dynfzsvtzm | dynfzsvtzmpzofrgq | dynfzsvtzmpzofrgq | dynfzsvtzmpzofrgq | dynfzsvtzmpzofrgq | dynfzsvtzmpzofrgq | dynfzsvtzmpzofrgq | dynfzsvtzmpzofrgq | dynfzsvtzmpzofrgqe | dynfzsvtzmpzofrgqe | dynfzsvtzmpzofrgqe |
: pzofrgqebrlcznvb  : ebrlcznvb         : ebrlcznvb         : ebrlcznvb         : ebrlcznvb         : ebrlcznvb         : ebrlcznvb         : ebrlcznvb         : brlcznvb           : brlcznvb           : brlcznvb           :
| #dummy-sqmckjiuxg | sqmckjiuxgygfkunt | sqmckjiuxgygfkunt | sqmckjiuxgygfkunt | sqmckjiuxgygfkunt | sqmckjiuxgygfkunt | sqmckjiuxgygfkunt | sqmckjiuxgygfkunt | sqmckjiuxgygfkuntn | sqmckjiuxgygfkuntn | sqmckjiuxgygfkuntn |
: ygfkuntnrgxntpzh  : nrgxntpzh         : nrgxntpzh         : nrgxntpzh         : nrgxntpzh         : nrgxntpzh         : nrgxntpzh         : nrgxntpzh         : rgxntpzh           : rgxntpzh           : rgxntpzh           :
| #dummy-ekzpopvrqh | ekzpopvrqhstpfvxp | ekzpopvrqhstpfvxp | ekzpopvrqhstpfvxp | ekzpopvrqhstpfvxp | ekzpopvrqhstpfvxp | ekzpopvrqhstpfvxp | ekzpopvrqhstpfvxp | ekzpopvrqhstpfvxpl | ekzpopvrqhstpfvxpl | ekzpopvrqhstpfvxpl |
: stpfvxplhnjnphlf  : lhnjnphlf         : lhnjnphlf         : lhnjnphlf         : lhnjnphlf         : lhnjnphlf         : lhnjnphlf         : lhnjnphlf         : hnjnphlf           : hnjnphlf           : hnjnphlf           :
| #dummy-nuqnikukec | nuqnikukecgajmahy | nuqnikukecgajmahy | nuqnikukecgajmahy | nuqnikukecgajmahy | nuqnikukecgajmahy | nuqnikukecgajmahy | nuqnikukecgajmahy | nuqnikukecgajmahyj | nuqnikukecgajmahyj | nuqnikukecgajmahyj |
: gajmahyjogqjozap  : jogqjozap         : jogqjozap         : jogqjozap         : jogqjozap         : jogqjozap         : jogqjozap         : jogqjozap         : ogqjozap           : ogqjozap           : ogqjozap           :
| #dummy-tyhtvouwoe | tyhtvouwoeowqfelw | tyhtvouwoeowqfelw | tyhtvouwoeowqfelw | tyhtvouwoeowqfelw | tyhtvouwoeowqfelw | tyhtvouwoeowqfelw | tyhtvouwoeowqfelw | tyhtvouwoeowqfelwz | tyhtvouwoeowqfelwz | tyhtvouwoeowqfelwz |
: owqfelwzjbhbrxwl  : zjbhbrxwl         : zjbhbrxwl         : zjbhbrxwl         : zjbhbrxwl         : zjbhbrxwl         : zjbhbrxwl         : zjbhbrxwl         : jbhbrxwl           : jbhbrxwl           : jbhbrxwl           :
| #dummy-mohcynzdzg | mohcynzdzglfgrzni | mohcynzdzglfgrzni | mohcynzdzglfgrzni | mohcynzdzglfgrzni | mohcynzdzglfgrzni | mohcynzdzglfgrzni | mohcynzdzglfgrzni | mohcynzdzglfgrznim | mohcynzdzglfgrznim | mohcynzdzglfgrznim |
: lfgrznimqxusnfbp  : mqxusnfbp         : mqxusnfbp         : mqxusnfbp         : mqxusnfbp         : mqxusnfbp         : mqxusnfbp         : mqxusnfbp         : qxusnfbp           : qxusnfbp           : qxusnfbp           :
| #dummy-mesgkaopbf | mesgkaopbfyowtamj | mesgkaopbfyowtamj | mesgkaopbfyowtamj | mesgkaopbfyowtamj | mesgkaopbfyowtamj | mesgkaopbfyowtamj | mesgkaopbfyowtamj | mesgkaopbfyowtamjf | mesgkaopbfyowtamjf | mesgkaopbfyowtamjf |
: yowtamjfzjiklbeo  : fzjiklbeo         : fzjiklbeo         : fzjiklbeo         : fzjiklbeo         : fzjiklbeo         : fzjiklbeo         : fzjiklbeo         : zjiklbeo           : zjiklbeo           : zjiklbeo           :
| #dummy-rwyxrjrqnr | rwyxrjrqnrptgcxug | rwyxrjrqnrptgcxug | rwyxrjrqnrptgcxug | rwyxrjrqnrptgcxug | rwyxrjrqnrptgcxug | rwyxrjrqnrptgcxug | rwyxrjrqnrptgcxug | rwyxrjrqnrptgcxugj | rwyxrjrqnrptgcxugj | rwyxrjrqnrptgcxugj |
: ptgcxugjdzqfaxrf  : jdzqfaxrf         : jdzqfaxrf         : jdzqfaxrf         : jdzqfaxrf         : jdzqfaxrf         : jdzqfaxrf         : jdzqfaxrf         : dzqfaxrf           : dzqfaxrf           : dzqfaxrf           :
| #dummy-jddmveyjgg | jddmveyjggqhhxchi | jddmveyjggqhhxchi | jddmveyjggqhhxchi | jddmveyjggqhhxchi | jddmveyjggqhhxchi | jddmveyjggqhhxchi | jddmveyjggqhhxchi | jddmveyjggqhhxchie | jddmveyjggqhhxchie | jddmveyjggqhhxchie |
: qhhxchiehurwwigu  : ehurwwigu         : ehurwwigu         : ehurwwigu         : ehurwwigu         : ehurwwigu         : ehurwwigu         : ehurwwigu         : hurwwigu           : hurwwigu           : hurwwigu           :
+-------------------+-------------------+-------------------+-------------------+-------------------+-------------------+-------------------+-------------------+--------------------+--------------------+--------------------+
10 tuples (8.156ms)
sql>select * from fruits limit 10;
+-----------+-------+--------+-------------+------+
| name      | price | weight | comments    | id   |
+===========+=======+========+=============+======+
| Apple     | 9.99  |     50 | null        |    1 |
| Bananna   | 3.99  |     30 | null        |    2 |
| Orange    | 7.99  |     60 | null        |    3 |
| Peach     | 5.00  |     80 | null        |    4 |
| Kiwi      | 9.00  |     20 | null        |    5 |
| Tomato    | 2.00  |     20 | Yes a fruit |    6 |
| Pear      | 4.00  |     30 | Juicy       |    7 |
| Nectarine | 6.00  |     50 | Juicy       |    8 |
+-----------+-------+--------+-------------+------+
8 tuples (9.972ms)
