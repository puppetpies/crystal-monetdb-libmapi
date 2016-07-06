# crystal-monetdb-libmapi

Crystal binding for the MonetDB MAPI client interface

This is currently experimental and needs a lot of work !

You will need the MonetDB client package installed for this to work and also an instance of MServer5 running

We can now perform a query that emits JSON useful for SELECT statements

For more details look at monetdb.org

Examples schemas provided under examples/

```crystal
# Example code from shard crystal-monetdb-examples

require "../libs/crystal-monetdb-libmapi/monetdb"
require "../libs/crystal-monetdb-libmapi/monetdb_data"
require "colorize"

class ConnectionError < Exception; end
class QueryError < Exception; end
class InternalError < Exception; end
class TimeoutError < Exception; end

host = "127.0.0.1"
port = 50000
username = "monetdb"
password = "monetdb"
db = "threatmonitor"

mero = MonetDB::ClientJSON.new
mero.host = host
mero.port = port
mero.username = username
mero.password = password
mero.db = db

myschema = "\"threatmonitor\""

query = "SELECT * FROM #{myschema}.fruits;"
mid = mero.connect
result_json = mero.query_json(query)
result = mero.json_to_hash(result_json)
puts "Hash Created:".colorize(:red)
p result
puts "Display specific fields".colorize(:red)
result.each {|k,v|
  puts "Hash Key: #{k} Name: #{v["name"]} Price: #{v["price"]}"
}

```
[brian@orville crystal-monetdb-libmapi]$ make
crystal build --release quick.cr -o bin/quick
[brian@orville crystal-monetdb-libmapi]$ bin/quick -h 172.17.0.2 -u monetdb -d threatmonitor -l 500
>> Server Information

 > Merovingian Server: 172.17.0.2
 > Port: 50000
 > Username: monetdb
 > DB: threatmonitor
 > Is Connected?: true
 > Ping?: OK
 > Merovingian URI: mapi:monetdb://172.17.0.2:50000/threatmonitor
 > Monet Version: 
 > Release ID: 0
 > Autocommit: false

>> Insert Test
 - INSERT iterations: 500
Query number: 250 SQL: INSERT INTO "threatmonitor".guid_test VALUES ('#dummy-wlbgqqbyqtfklfdklaxbvybfjc', 'wlbgqqbyqtfklfdklaxbvybfjc', 'wlbgqqbyqtfklfdklaxbvybfjc', 'wlbgqqbyqtfklfdklaxbvybfjc', 'wlbgqqbyqtfklfdklaxbvybfjc', 'wlbgqqbyqtfklfdklaxbvybfjc', 'wlbgqqbyqtfklfdklaxbvybfjc', 'wlbgqqbyqtfklfdklaxbvybfjc', 'wlbgqqbyqtfklfdklaxbvybfjc', 'wlbgqqbyqtfklfdklaxbvybfjc', 'wlbgqqbyqtfklfdklaxbvybfjc')
( Duration ) : Start: 2016-06-21 15:19:27 +0100 Finish: 2016-06-21 15:19:28 +0100 Duration: 00:00:00.9013414

>> Update Test
 - Update Iteration: 0
UPDATE "threatmonitor".guid_test SET guid = 'Dagobert' WHERE f0 LIKE '%asd%';
Rows affected: 0
 - Update Iteration: 1
UPDATE "threatmonitor".guid_test SET guid = 'Dagobert' WHERE f2 LIKE '%asd%';
Rows affected: 1

>> Delete Test
DELETE FROM "threatmonitor".guid_test WHERE guid = 'Dagobert';
Rows affected: 1

>> Create Table Test Empty Table
CREATE TABLE "threatmonitor".table1 ( id int, firstname char(50), lastname char(50), age int);
Query number: 0 SQL: INSERT INTO "threatmonitor".table1 VALUES (0, 'John', 'Smith', 7);
Query number: 250 SQL: INSERT INTO "threatmonitor".table1 VALUES (250, 'Fred', 'Edwards', 70);
Rows affected: 1

>> ALTER TABLE Test ADD COLUMN
ALTER TABLE "threatmonitor".table1 ADD COLUMN sex CHAR(1);

>> ALTER TABLE Test DROP COLUMN
ALTER TABLE "threatmonitor".table1 DROP COLUMN sex;

>> Enable Trace query

> - Trace

>> DROP TABLE Test
DROP TABLE "threatmonitor".table1;
mapi_query:34:DROP TABLE "threatmonitor".table1;
fetch next block: start at:2053
got next block: length:3
text:&3

got complete block: 
text:&3

read_line:&3
allocating new result set
fetch next block: start at:2056
got next block: length:0
text:
got complete block: 
text:


read_line:

mapi_query:7:COMMIT;
fetch next block: start at:2058
got next block: length:5
text:&4 f

got complete block: 
text:&4 f

read_line:&4 f
allocating new result set
fetch next block: start at:2063
got next block: length:0
text:
got complete block: 
text:


read_line:

0
Test query 1: SELECT * FROM "threatmonitor".guid_test LIMIT 5
SELECT Statement: SELECT * FROM "threatmonitor".guid_test LIMIT 5
Handle: Pointer(Void)@0x136dc20
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
JSON Generated:

{"guid":"#dummy-vwgydzzpinlwwzyqzfejpcxgod","f1":"vwgydzzpinlwwzyqzfejpcxgod","f2":"vwgydzzpinlwwzyqzfejpcxgod","f3":"vwgydzzpinlwwzyqzfejpcxgod","f4":"vwgydzzpinlwwzyqzfejpcxgod","f5":"vwgydzzpinlwwzyqzfejpcxgod","f6":"vwgydzzpinlwwzyqzfejpcxgod","f7":"vwgydzzpinlwwzyqzfejpcxgod","f8":"vwgydzzpinlwwzyqzfejpcxgod","f9":"vwgydzzpinlwwzyqzfejpcxgod","f10":"vwgydzzpinlwwzyqzfejpcxgod"}
{"guid":"#dummy-dynfzsvtzmpzofrgqebrlcznvb","f1":"dynfzsvtzmpzofrgqebrlcznvb","f2":"dynfzsvtzmpzofrgqebrlcznvb","f3":"dynfzsvtzmpzofrgqebrlcznvb","f4":"dynfzsvtzmpzofrgqebrlcznvb","f5":"dynfzsvtzmpzofrgqebrlcznvb","f6":"dynfzsvtzmpzofrgqebrlcznvb","f7":"dynfzsvtzmpzofrgqebrlcznvb","f8":"dynfzsvtzmpzofrgqebrlcznvb","f9":"dynfzsvtzmpzofrgqebrlcznvb","f10":"dynfzsvtzmpzofrgqebrlcznvb"}
{"guid":"#dummy-sqmckjiuxgygfkuntnrgxntpzh","f1":"sqmckjiuxgygfkuntnrgxntpzh","f2":"sqmckjiuxgygfkuntnrgxntpzh","f3":"sqmckjiuxgygfkuntnrgxntpzh","f4":"sqmckjiuxgygfkuntnrgxntpzh","f5":"sqmckjiuxgygfkuntnrgxntpzh","f6":"sqmckjiuxgygfkuntnrgxntpzh","f7":"sqmckjiuxgygfkuntnrgxntpzh","f8":"sqmckjiuxgygfkuntnrgxntpzh","f9":"sqmckjiuxgygfkuntnrgxntpzh","f10":"sqmckjiuxgygfkuntnrgxntpzh"}
{"guid":"#dummy-ekzpopvrqhstpfvxplhnjnphlf","f1":"ekzpopvrqhstpfvxplhnjnphlf","f2":"ekzpopvrqhstpfvxplhnjnphlf","f3":"ekzpopvrqhstpfvxplhnjnphlf","f4":"ekzpopvrqhstpfvxplhnjnphlf","f5":"ekzpopvrqhstpfvxplhnjnphlf","f6":"ekzpopvrqhstpfvxplhnjnphlf","f7":"ekzpopvrqhstpfvxplhnjnphlf","f8":"ekzpopvrqhstpfvxplhnjnphlf","f9":"ekzpopvrqhstpfvxplhnjnphlf","f10":"ekzpopvrqhstpfvxplhnjnphlf"}
{"guid":"#dummy-nuqnikukecgajmahyjogqjozap","f1":"nuqnikukecgajmahyjogqjozap","f2":"nuqnikukecgajmahyjogqjozap","f3":"nuqnikukecgajmahyjogqjozap","f4":"nuqnikukecgajmahyjogqjozap","f5":"nuqnikukecgajmahyjogqjozap","f6":"nuqnikukecgajmahyjogqjozap","f7":"nuqnikukecgajmahyjogqjozap","f8":"nuqnikukecgajmahyjogqjozap","f9":"nuqnikukecgajmahyjogqjozap","f10":"nuqnikukecgajmahyjogqjozap"}

Hash Table of Results

Select Specific Fields from Hash table

res_hash_f1 # => {0 => {"guid" => "#dummy-vwgydzzpinlwwzyqzfejpcxgod", "f1" => "vwgydzzpinlwwzyqzfejpcxgod", "f2" => "vwgydzzpinlwwzyqzfejpcxgod", "f3" => "vwgydzzpinlwwzyqzfejpcxgod", "f4" => "vwgydzzpinlwwzyqzfejpcxgod", "f5" => "vwgydzzpinlwwzyqzfejpcxgod", "f6" => "vwgydzzpinlwwzyqzfejpcxgod", "f7" => "vwgydzzpinlwwzyqzfejpcxgod", "f8" => "vwgydzzpinlwwzyqzfejpcxgod", "f9" => "vwgydzzpinlwwzyqzfejpcxgod", "f10" => "vwgydzzpinlwwzyqzfejpcxgod"}, 1 => {"guid" => "#dummy-dynfzsvtzmpzofrgqebrlcznvb", "f1" => "dynfzsvtzmpzofrgqebrlcznvb", "f2" => "dynfzsvtzmpzofrgqebrlcznvb", "f3" => "dynfzsvtzmpzofrgqebrlcznvb", "f4" => "dynfzsvtzmpzofrgqebrlcznvb", "f5" => "dynfzsvtzmpzofrgqebrlcznvb", "f6" => "dynfzsvtzmpzofrgqebrlcznvb", "f7" => "dynfzsvtzmpzofrgqebrlcznvb", "f8" => "dynfzsvtzmpzofrgqebrlcznvb", "f9" => "dynfzsvtzmpzofrgqebrlcznvb", "f10" => "dynfzsvtzmpzofrgqebrlcznvb"}, 2 => {"guid" => "#dummy-sqmckjiuxgygfkuntnrgxntpzh", "f1" => "sqmckjiuxgygfkuntnrgxntpzh", "f2" => "sqmckjiuxgygfkuntnrgxntpzh", "f3" => "sqmckjiuxgygfkuntnrgxntpzh", "f4" => "sqmckjiuxgygfkuntnrgxntpzh", "f5" => "sqmckjiuxgygfkuntnrgxntpzh", "f6" => "sqmckjiuxgygfkuntnrgxntpzh", "f7" => "sqmckjiuxgygfkuntnrgxntpzh", "f8" => "sqmckjiuxgygfkuntnrgxntpzh", "f9" => "sqmckjiuxgygfkuntnrgxntpzh", "f10" => "sqmckjiuxgygfkuntnrgxntpzh"}, 3 => {"guid" => "#dummy-ekzpopvrqhstpfvxplhnjnphlf", "f1" => "ekzpopvrqhstpfvxplhnjnphlf", "f2" => "ekzpopvrqhstpfvxplhnjnphlf", "f3" => "ekzpopvrqhstpfvxplhnjnphlf", "f4" => "ekzpopvrqhstpfvxplhnjnphlf", "f5" => "ekzpopvrqhstpfvxplhnjnphlf", "f6" => "ekzpopvrqhstpfvxplhnjnphlf", "f7" => "ekzpopvrqhstpfvxplhnjnphlf", "f8" => "ekzpopvrqhstpfvxplhnjnphlf", "f9" => "ekzpopvrqhstpfvxplhnjnphlf", "f10" => "ekzpopvrqhstpfvxplhnjnphlf"}, 4 => {"guid" => "#dummy-nuqnikukecgajmahyjogqjozap", "f1" => "nuqnikukecgajmahyjogqjozap", "f2" => "nuqnikukecgajmahyjogqjozap", "f3" => "nuqnikukecgajmahyjogqjozap", "f4" => "nuqnikukecgajmahyjogqjozap", "f5" => "nuqnikukecgajmahyjogqjozap", "f6" => "nuqnikukecgajmahyjogqjozap", "f7" => "nuqnikukecgajmahyjogqjozap", "f8" => "nuqnikukecgajmahyjogqjozap", "f9" => "nuqnikukecgajmahyjogqjozap", "f10" => "nuqnikukecgajmahyjogqjozap"}}
Hash ID: 0 F1: vwgydzzpinlwwzyqzfejpcxgod F2: vwgydzzpinlwwzyqzfejpcxgod
Hash ID: 1 F1: dynfzsvtzmpzofrgqebrlcznvb F2: dynfzsvtzmpzofrgqebrlcznvb
Hash ID: 2 F1: sqmckjiuxgygfkuntnrgxntpzh F2: sqmckjiuxgygfkuntnrgxntpzh
Hash ID: 3 F1: ekzpopvrqhstpfvxplhnjnphlf F2: ekzpopvrqhstpfvxplhnjnphlf
Hash ID: 4 F1: nuqnikukecgajmahyjogqjozap F2: nuqnikukecgajmahyjogqjozap
Session should now be closed down and disconnected
Checking ....
Connected to MServer ? false



-- MClient output

Welcome to mclient, the MonetDB/SQL interactive terminal (Jul2015-SP2)
Database: MonetDB v11.21.19 (Jul2015-SP4), 'mapi:monetdb://mdb-master-01:50000/threatmonitor'
Type \q to quit, \? for a list of available commands
auto commit mode: on
sql>set schema "threatmonitor";
auto commit mode: on
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
8 tuples (6.206ms)

# Hope this helps you for more examples of how to use all of this look at quick.cr it has everything i've done so far.

Here is an Example of insperf_fiber that i wrote to do a benchmarks.

bin/insperf_fiber -h 172.17.0.7 -u monetdb -d threatmonitor -l 10000 -i 1000 -s 2
>> Server Information

 > Merovingian Server: 172.17.0.7
 > Port: 50000
 > Username: monetdb
 > DB: threatmonitor
 > Is Connected?: true
 > Ping?: OK
 > Merovingian URI: mapi:monetdb://172.17.0.7:50000/threatmonitor
 > Monet Version: 
 > Release ID: 0
 > Autocommit: false

>> Insert Test

>> Create Table Test Empty Table
CREATE TABLE "threatmonitor".table2 ( id int, thread int, firstname char(50), lastname char(50), age int);
 - INSERT iterations: 10000
Worksplit: 5000
Insloop: 10000
Split num: 2
Swarm thread 0...
t: 0 Query number: 1000 SQL: INSERT INTO "threatmonitor".table2 VALUES (1000, 0, 'Edward', 'Johnston', 10);
Start: 2016-06-02 17:18:02 +0100 Finish: 2016-06-02 17:18:03 +0100 Duration: 00:00:00.6526265
t: 0 Query number: 2000 SQL: INSERT INTO "threatmonitor".table2 VALUES (2000, 0, 'Joe', 'Smith', 8);
Start: 2016-06-02 17:18:03 +0100 Finish: 2016-06-02 17:18:04 +0100 Duration: 00:00:00.6508747
t: 0 Query number: 3000 SQL: INSERT INTO "threatmonitor".table2 VALUES (3000, 0, 'Henry', 'Smith', 51);
Start: 2016-06-02 17:18:04 +0100 Finish: 2016-06-02 17:18:04 +0100 Duration: 00:00:00.6307390
t: 0 Query number: 4000 SQL: INSERT INTO "threatmonitor".table2 VALUES (4000, 0, 'Michael', 'Jones', 79);
Start: 2016-06-02 17:18:04 +0100 Finish: 2016-06-02 17:18:05 +0100 Duration: 00:00:00.6303559
Swarm thread 1...
t: 1 Query number: 0 SQL: INSERT INTO "threatmonitor".table2 VALUES (0, 1, 'Henry', 'Smith', 31);
Start: 2016-06-02 17:18:05 +0100 Finish: 2016-06-02 17:18:06 +0100 Duration: 00:00:00.6079269
t: 1 Query number: 1000 SQL: INSERT INTO "threatmonitor".table2 VALUES (1000, 1, 'Edward', 'Warbutton', 44);
Start: 2016-06-02 17:18:06 +0100 Finish: 2016-06-02 17:18:06 +0100 Duration: 00:00:00.6431800
t: 1 Query number: 2000 SQL: INSERT INTO "threatmonitor".table2 VALUES (2000, 1, 'Edward', 'Johnston', 69);
Start: 2016-06-02 17:18:06 +0100 Finish: 2016-06-02 17:18:07 +0100 Duration: 00:00:00.6241604
t: 1 Query number: 3000 SQL: INSERT INTO "threatmonitor".table2 VALUES (3000, 1, 'Joe', 'Blake', 40);
Start: 2016-06-02 17:18:07 +0100 Finish: 2016-06-02 17:18:08 +0100 Duration: 00:00:00.6287455
t: 1 Query number: 4000 SQL: INSERT INTO "threatmonitor".table2 VALUES (4000, 1, 'Kev', 'Warbutton', 5);
Start: 2016-06-02 17:18:08 +0100 Finish: 2016-06-02 17:18:08 +0100 Duration: 00:00:00.6090169
Record Count: 
10000
SUCCESS - Record count matches
Total time:
Start: 2016-06-02 17:18:02 +0100 Finish: 2016-06-02 17:18:09 +0100 Duration: 00:00:06.3378785
```

Have fun!

Brian Hood
