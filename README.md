# crystal-monetdb-libmapi

Crystal binding for the MonetDB MAPI client interface

This is currently experimental and needs a lot of work !

You will need the MonetDB client package installed for this to work and also an instance of MServer5 running

We can now perform and query that emits JSON useful for SELECT statements

For more details look at monetdb.org

Examples schemas provided under examples/


````
[brian@orville crystal-monetdb-libmapi]$ make
crystal build --release quick.cr -o bin/quick
[brian@orville crystal-monetdb-libmapi]$ bin/quick -H 172.17.0.2 -u monetdb -d threatmonitor -l 300 -2 false
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
 - INSERT iterations: 300
Query number: 250 SQL: INSERT INTO "threatmonitor".guid_test VALUES ('#dummy-arbaxirohpyatwxuwdjsnbkxry', 'arbaxirohpyatwxuwdjsnbkxry', 'arbaxirohpyatwxuwdjsnbkxry', 'arbaxirohpyatwxuwdjsnbkxry', 'arbaxirohpyatwxuwdjsnbkxry', 'arbaxirohpyatwxuwdjsnbkxry', 'arbaxirohpyatwxuwdjsnbkxry', 'arbaxirohpyatwxuwdjsnbkxry', 'arbaxirohpyatwxuwdjsnbkxry', 'arbaxirohpyatwxuwdjsnbkxry', 'arbaxirohpyatwxuwdjsnbkxry')
( Duration ) : Start: 2016-05-07 16:09:58 +0100 Finish: 2016-05-07 16:09:58 +0100 Duration: 00:00:00.4979153

>> Update Test
 - Update Iteration: 0
UPDATE "threatmonitor".guid_test SET guid = 'Dagobert' WHERE f1 LIKE '%asd%';
Rows affected: 0
 - Update Iteration: 1
UPDATE "threatmonitor".guid_test SET guid = 'Dagobert' WHERE f5 LIKE '%asd%';
Rows affected: 0

>> Delete Test
DELETE FROM "threatmonitor".guid_test WHERE guid = 'Dagobert';
Rows affected: 0

>> Create Table Test Empty Table
CREATE TABLE "threatmonitor".table1 ( id int, firstname char(50), lastname char(50), age int);
Query number: 200 SQL: INSERT INTO "threatmonitor".table1 VALUES (200, 'Fred', 'Jones', 3);
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
SELECT Statement: SELECT * FROM "threatmonitor".guid_test LIMIT 5
Handle: Pointer(Void)@0x1c8a790
Table Width: 11
Record Count: 5
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
JSON Internal Data Type: Array(String)
JSON Generated:
{"guid":"#dummy-vwgydzzpinlwwzyqzfejpcxgod","f1":"vwgydzzpinlwwzyqzfejpcxgod","f2":"vwgydzzpinlwwzyqzfejpcxgod","f3":"vwgydzzpinlwwzyqzfejpcxgod","f4":"vwgydzzpinlwwzyqzfejpcxgod","f5":"vwgydzzpinlwwzyqzfejpcxgod","f6":"vwgydzzpinlwwzyqzfejpcxgod","f7":"vwgydzzpinlwwzyqzfejpcxgod","f8":"vwgydzzpinlwwzyqzfejpcxgod","f9":"vwgydzzpinlwwzyqzfejpcxgod","f10":"vwgydzzpinlwwzyqzfejpcxgod"}
{"guid":"#dummy-dynfzsvtzmpzofrgqebrlcznvb","f1":"dynfzsvtzmpzofrgqebrlcznvb","f2":"dynfzsvtzmpzofrgqebrlcznvb","f3":"dynfzsvtzmpzofrgqebrlcznvb","f4":"dynfzsvtzmpzofrgqebrlcznvb","f5":"dynfzsvtzmpzofrgqebrlcznvb","f6":"dynfzsvtzmpzofrgqebrlcznvb","f7":"dynfzsvtzmpzofrgqebrlcznvb","f8":"dynfzsvtzmpzofrgqebrlcznvb","f9":"dynfzsvtzmpzofrgqebrlcznvb","f10":"dynfzsvtzmpzofrgqebrlcznvb"}
{"guid":"#dummy-sqmckjiuxgygfkuntnrgxntpzh","f1":"sqmckjiuxgygfkuntnrgxntpzh","f2":"sqmckjiuxgygfkuntnrgxntpzh","f3":"sqmckjiuxgygfkuntnrgxntpzh","f4":"sqmckjiuxgygfkuntnrgxntpzh","f5":"sqmckjiuxgygfkuntnrgxntpzh","f6":"sqmckjiuxgygfkuntnrgxntpzh","f7":"sqmckjiuxgygfkuntnrgxntpzh","f8":"sqmckjiuxgygfkuntnrgxntpzh","f9":"sqmckjiuxgygfkuntnrgxntpzh","f10":"sqmckjiuxgygfkuntnrgxntpzh"}
{"guid":"#dummy-ekzpopvrqhstpfvxplhnjnphlf","f1":"ekzpopvrqhstpfvxplhnjnphlf","f2":"ekzpopvrqhstpfvxplhnjnphlf","f3":"ekzpopvrqhstpfvxplhnjnphlf","f4":"ekzpopvrqhstpfvxplhnjnphlf","f5":"ekzpopvrqhstpfvxplhnjnphlf","f6":"ekzpopvrqhstpfvxplhnjnphlf","f7":"ekzpopvrqhstpfvxplhnjnphlf","f8":"ekzpopvrqhstpfvxplhnjnphlf","f9":"ekzpopvrqhstpfvxplhnjnphlf","f10":"ekzpopvrqhstpfvxplhnjnphlf"}
{"guid":"#dummy-nuqnikukecgajmahyjogqjozap","f1":"nuqnikukecgajmahyjogqjozap","f2":"nuqnikukecgajmahyjogqjozap","f3":"nuqnikukecgajmahyjogqjozap","f4":"nuqnikukecgajmahyjogqjozap","f5":"nuqnikukecgajmahyjogqjozap","f6":"nuqnikukecgajmahyjogqjozap","f7":"nuqnikukecgajmahyjogqjozap","f8":"nuqnikukecgajmahyjogqjozap","f9":"nuqnikukecgajmahyjogqjozap","f10":"nuqnikukecgajmahyjogqjozap"}
SELECT Statement: SELECT * FROM "threatmonitor".fruits
Handle: Pointer(Void)@0x1c98b90
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
JSON Internal Data Type: Array(String)
JSON Generated:
{"name":"Apple","price":"9.99","weight":"50","comments":"NULL","id":"1"}
{"name":"Bananna","price":"3.99","weight":"30","comments":"NULL","id":"2"}
{"name":"Orange","price":"7.99","weight":"60","comments":"NULL","id":"3"}
{"name":"Peach","price":"5.00","weight":"80","comments":"NULL","id":"4"}
{"name":"Kiwi","price":"9.00","weight":"20","comments":"NULL","id":"5"}
{"name":"Tomato","price":"2.00","weight":"20","comments":"Yes a fruit","id":"6"}
{"name":"Pear","price":"4.00","weight":"30","comments":"Juicy","id":"7"}
{"name":"Nectarine","price":"6.00","weight":"50","comments":"Juicy","id":"8"}
Session should now be closed down and disconnected
Checking ....
Connected to MServer ? false
[brian@orville crystal-monetdb-libmapi]$ mclient -h 172.17.0.2 -u monetdb -d threatmonitor
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
10 tuples (39.225ms)
sql>select * from fruits;
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
8 tuples (5.715ms)
sql>
