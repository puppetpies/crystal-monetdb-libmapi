# crystal-monetdb-libmapi

Crystal binding for the MonetDB MAPI client interface

This is currently experimental and needs a lot of work !

You will need the MonetDB client package installed for this to work and also an instance of MServer5 running

For more details look at monetdb.org

Examples schemas provided under examples/


````
>> Server Information

 > Merovingian Server: 172.17.0.2
 > Port: 50000
 > Username: monetdb
 > DB: threatmonitor
 > Is Connected?: true
 > Ping?: OK
 > Mid / Connection: Pointer(Void)@0xd94ff0
 > Merovingian URI: Pointer(UInt8)@0xd97300
 > Monet Version: Pointer(UInt8)@0x7fdbb05e4a18
 > Autocommit: false

>> Insert Test
 - INSERT iterations: 500
Query number: 250 SQL: INSERT INTO "threatmonitor".guid_test VALUES ('#dummy-mygmoztrolvqkfghmwflcpfkya', 'mygmoztrolvqkfghmwflcpfkya', 'mygmoztrolvqkfghmwflcpfkya', 'mygmoztrolvqkfghmwflcpfkya', 'mygmoztrolvqkfghmwflcpfkya', 'mygmoztrolvqkfghmwflcpfkya', 'mygmoztrolvqkfghmwflcpfkya', 'mygmoztrolvqkfghmwflcpfkya', 'mygmoztrolvqkfghmwflcpfkya', 'mygmoztrolvqkfghmwflcpfkya', 'mygmoztrolvqkfghmwflcpfkya')
( Duration ) : Start: 2016-04-30 13:30:53 +0000 Finish: 2016-04-30 13:30:54 +0000 Duration: 00:00:00.9316560

>> Update Test
 - Update Iteration: 0
UPDATE "threatmonitor".guid_test SET guid = 'Dagobert' WHERE f7 LIKE '%asd%';
Rows affected: 2
 - Update Iteration: 1
UPDATE "threatmonitor".guid_test SET guid = 'Dagobert' WHERE f2 LIKE '%asd%';
Rows affected: 2

>> Delete Test
DELETE FROM "threatmonitor".guid_test WHERE guid = 'Dagobert';
Rows affected: 2

>> Delete Test Empty Table
DELETE FROM "threatmonitor".guid_test;
Rows affected: 498

>> Create Table Test Empty Table
CREATE TABLE "threatmonitor".table1 ( id int, firstname char(50), lastname char(50), age int);
Query number: 0 SQL: INSERT INTO "threatmonitor".table1 VALUES (0, 'Ernest', 'Edwards', 57);
Query number: 250 SQL: INSERT INTO "threatmonitor".table1 VALUES (250, 'James', 'Stevens', 33);
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
Handle: Pointer(Void)@0xe9ebd0
Record Count: 8
MServer Response Key: MOK Code: 0

>> SELECT Test
Line: Pointer(UInt8)@0xe9ede0
Line: Pointer(UInt8)@0xea03b0
Line: Pointer(UInt8)@0xe9eed0
Line: Pointer(UInt8)@0xea0490
Line: Pointer(UInt8)@0xea0560
Line: Pointer(UInt8)@0xea0590
Line: Pointer(UInt8)@0xea05c0
Line: Pointer(UInt8)@0xea05f0
Line: Pointer(UInt8)@0xea0620
Line: Pointer(UInt8)@0xea0650
Line: Pointer(UInt8)@0xea0690
Line: Pointer(UInt8)@0xea06c0
Connected to MServer ? false

