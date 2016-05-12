# crystal-monetdb-libmapi

Crystal binding for the MonetDB MAPI client interface

This is currently experimental and needs a lot of work !

You will need the MonetDB client package installed for this to work and also an instance of MServer5 running

We can now perform and query that emits JSON useful for SELECT statements

For more details look at monetdb.org

Examples schemas provided under examples/

````
# Example code from shard crystal-monetdb-examples

require "../libs/crystal-monetdb-libmapi/monetdb"
require "../libs/crystal-monetdb-libmapi/monetdb_data"
require "colorize"

class ConnectionError < Exception; end
class QueryError < Exception; end
class InternalError < Exception; end
class TimeoutError < Exception; end

host = "172.17.0.2"
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
result_json = mero.query_json(mid, query)
result = mero.json_to_hash(result_json)
puts "Hash Created:".colorize(:red)
p result
puts "Display specific fields".colorize(:red)
result.each {|k,v|
  puts "Hash Key: #{k} Name: #{v["name"]} Price: #{v["price"]}"
}


````
[brian@orville crystal-monetdb-libmapi]$ make
crystal build --release quick.cr -o bin/quick
[brian@orville crystal-monetdb-libmapi]$ bin/quick -H 172.17.0.2 -u monetdb -d threatmonitor -l 500 -2 false
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
 - INSERT iterations: 500
Query number: 250 SQL: INSERT INTO "threatmonitor".guid_test VALUES ('#dummy-olzwoiitibrxmwnfixcztdrqgq', 'olzwoiitibrxmwnfixcztdrqgq', 'olzwoiitibrxmwnfixcztdrqgq', 'olzwoiitibrxmwnfixcztdrqgq', 'olzwoiitibrxmwnfixcztdrqgq', 'olzwoiitibrxmwnfixcztdrqgq', 'olzwoiitibrxmwnfixcztdrqgq', 'olzwoiitibrxmwnfixcztdrqgq', 'olzwoiitibrxmwnfixcztdrqgq', 'olzwoiitibrxmwnfixcztdrqgq', 'olzwoiitibrxmwnfixcztdrqgq')
( Duration ) : Start: 2016-05-12 13:19:55 +0100 Finish: 2016-05-12 13:19:56 +0100 Duration: 00:00:00.9450592

>> Update Test
 - Update Iteration: 0
UPDATE "threatmonitor".guid_test SET guid = 'Dagobert' WHERE f4 LIKE '%asd%';
Rows affected: 2
 - Update Iteration: 1
UPDATE "threatmonitor".guid_test SET guid = 'Dagobert' WHERE f6 LIKE '%asd%';
Rows affected: 2

>> Delete Test
DELETE FROM "threatmonitor".guid_test WHERE guid = 'Dagobert';
Rows affected: 2

>> Create Table Test Empty Table
CREATE TABLE "threatmonitor".table1 ( id int, firstname char(50), lastname char(50), age int);
Query number: 0 SQL: INSERT INTO "threatmonitor".table1 VALUES (0, 'Dave', 'Smith', 63);
Query number: 250 SQL: INSERT INTO "threatmonitor".table1 VALUES (250, 'Ernest', 'Smith', 48);
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
SELECT Statement: SELECT * FROM "threatmonitor".fruits
Handle: Pointer(Void)@0x1987b90
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
JSON Generated:

{"name":"Apple","price":"9.99","weight":"50","comments":"NULL","id":"1"}
{"name":"Bananna","price":"3.99","weight":"30","comments":"NULL","id":"2"}
{"name":"Orange","price":"7.99","weight":"60","comments":"NULL","id":"3"}
{"name":"Peach","price":"5.00","weight":"80","comments":"NULL","id":"4"}
{"name":"Kiwi","price":"9.00","weight":"20","comments":"NULL","id":"5"}
{"name":"Tomato","price":"2.00","weight":"20","comments":"Yes a fruit","id":"6"}
{"name":"Pear","price":"4.00","weight":"30","comments":"Juicy","id":"7"}
{"name":"Nectarine","price":"6.00","weight":"50","comments":"Juicy","id":"8"}

Hash Table of Results
res_hash = {0 => {"name" => "Apple", "price" => "9.99", "weight" => "50", "comments" => "NULL", "id" => "1"}, 1 => {"name" => "Bananna", "price" => "3.99", "weight" => "30", "comments" => "NULL", "id" => "2"}, 2 => {"name" => "Orange", "price" => "7.99", "weight" => "60", "comments" => "NULL", "id" => "3"}, 3 => {"name" => "Peach", "price" => "5.00", "weight" => "80", "comments" => "NULL", "id" => "4"}, 4 => {"name" => "Kiwi", "price" => "9.00", "weight" => "20", "comments" => "NULL", "id" => "5"}, 5 => {"name" => "Tomato", "price" => "2.00", "weight" => "20", "comments" => "Yes a fruit", "id" => "6"}, 6 => {"name" => "Pear", "price" => "4.00", "weight" => "30", "comments" => "Juicy", "id" => "7"}, 7 => {"name" => "Nectarine", "price" => "6.00", "weight" => "50", "comments" => "Juicy", "id" => "8"}}

Select Specific Fields from Hash table

Row Number: 0 Name: Apple Price: 9.99
Row Number: 1 Name: Bananna Price: 3.99
Row Number: 2 Name: Orange Price: 7.99
Row Number: 3 Name: Peach Price: 5.00
Row Number: 4 Name: Kiwi Price: 9.00
Row Number: 5 Name: Tomato Price: 2.00
Row Number: 6 Name: Pear Price: 4.00
Row Number: 7 Name: Nectarine Price: 6.00
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

Have fun!

Brian Hood
