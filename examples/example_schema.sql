-- msqldump dump table test.fruits Wed Apr 27 22:23:01 2016
-- MonetDB v11.21.19 (Jul2015-SP4), 'mapi:monetdb://mdb-master-01:50000/test'
CREATE TABLE "test"."fruits" (
	"name"     VARCHAR(50),
	"price"    VARCHAR(10),
	"weight"   INTEGER,
	"comments" CHARACTER LARGE OBJECT,
	"id"       INTEGER
);
COPY 6 RECORDS INTO "test"."fruits" FROM stdin USING DELIMITERS '\t','\n','"';
"Apple"	"9.99"	50	NULL	1
"Bananna"	"3.99"	30	NULL	2
"Orange"	"7.99"	60	NULL	3
"Peach"	"5.00"	80	NULL	4
"Kiwi"	"9.00"	20	NULL	5
"Tomato"	"2.00"	20	"Yes a fruit"	6

CREATE TABLE "test"."guid_test" (
	"guid" CHAR(36)      NOT NULL,
	"f1"   CHAR(26),
	"f2"   CHAR(26),
	"f3"   CHAR(26),
	"f4"   CHAR(26),
	"f5"   CHAR(26),
	"f6"   CHAR(26),
	"f7"   CHAR(26),
	"f8"   CHAR(26),
	"f9"   CHAR(26),
	"f10"  CHAR(26)
);
