# crystal-monetdb-libmapi

Crystal binding for the MonetDB MAPI client interface

This is currently experimental and needs a lot of work !

````
[brian@orville crystal-monetdb-libmapi]$ make clean
rm -f quick
rm -Rf .crystal
[brian@orville crystal-monetdb-libmapi]$ make
crystal build --release quick.cr -o quick
[brian@orville crystal-monetdb-libmapi]$ ./quick 
Is Connected?: true
Mid: Pointer(Void)@0x12b8000
Merovingian URI: Pointer(UInt8)@0x12ba2f0
Start 10000
Query number: 1000 SQL: INSERT INTO "threatmonitor".guid_test VALUES ('#dummy-urpbjhkjatzbvftyrswuwvdjku', 'urpbjhkjatzbvftyrswuwvdjku', 'zarblcmiewjrrkwqlpqcrykhlt', 'pwmbyiqmmvqxuvbsoozcbygykg', 'tciosxqjsohzaqrpiyzgmynbhk', 'jkwombrskewcimpdzooxljnzdu', 'vjugqoqxpiyimpcnltqjssefiq', 'mawcryaaaicrmhjpstwtufopzg', 'rtrwqyhhfyrvthmxioskiodjmw', 'ldvbcrjvtjonncrcjyoaxtwxuy', 'avsatiwvliiddnttxcqlirxfdh');
Query number: 2000 SQL: INSERT INTO "threatmonitor".guid_test VALUES ('#dummy-kqnjtxdsielmhyqtokqkxaejpk', 'kqnjtxdsielmhyqtokqkxaejpk', 'lukmcqmpgjvigemrtaufonacye', 'kyujnkvdjysnyujcnbhxztfpld', 'meqkdjcramebbmehkwmritnilh', 'eksinnckudpanrybsrbabsytlt', 'yosdumehbvitisacrdcflhgcka', 'twlnvolclbeoiazwgbqowroand', 'hrgxbleovazykuyvrfbgrsyhax', 'fompynhlqplxfmdxqwdfgspznt', 'llieytvqnjlopufulwolhctxto');
Query number: 3000 SQL: INSERT INTO "threatmonitor".guid_test VALUES ('#dummy-gnelrcdzlciuahuybsllyppbzi', 'gnelrcdzlciuahuybsllyppbzi', 'prqxfykqdqtfwwujnrxvxmmtji', 'kflqjnfjhefygulbqswgyayopn', 'ufitoarcvbbxmxfuhfnldsqpqc', 'nghqnrjhppdtriwlkjbhkhonni', 'nfinthikxjscllaojabqxeaorg', 'egneohluaynsyqcicafmwgantx', 'oxkpfrxfxiuhgxmkprlbhrqpqk', 'hbptdblnmoaqrlfiehhtrstlav', 'vxpomryyvcntbcawmdoycphype');
Query number: 4000 SQL: INSERT INTO "threatmonitor".guid_test VALUES ('#dummy-etcpeanfzzfniqaqpaovcauyyf', 'etcpeanfzzfniqaqpaovcauyyf', 'kurbhdmsvsqdqqonboaldbsfuj', 'gloljljxgdrpflboakftfnlvqu', 'eyledhnjkpsdpjkibsogvmmdje', 'amwqxurqyezxqtduhqeqfezcdr', 'jkrpaupuzupoaiddfvnedfsfea', 'noqnajndzsidchnpmeavsfuujc', 'qbnrwjczmmqesqbnmaollngfdx', 'kqlnzjxpidlhntxuuvjidyrhrk', 'vmuaecfifvkxumbbrufgxzhcce');
Query number: 5000 SQL: INSERT INTO "threatmonitor".guid_test VALUES ('#dummy-eamnmelqlatxxritkxpcbgshxj', 'eamnmelqlatxxritkxpcbgshxj', 'znvhqnkfsfycbucgkksqsxdben', 'nbehndilcpgggdudvamxephabk', 'ltsnturhtyagzbxsicrxsgxqew', 'orywehdijjhhgwrdbzetlavgwg', 'vxabpqkpvclmpqmxixkuqiwizu', 'llkjmvnxnprnrzquojvrbpeger', 'iugtmiouwmbunvwddclxaiaavq', 'mbnbzktznpnlwgjuhontcvnzis', 'dkyuxoeoelmazumvunpjsmosno');
Query number: 6000 SQL: INSERT INTO "threatmonitor".guid_test VALUES ('#dummy-paicrhnbiijzgbuymhwsgysony', 'paicrhnbiijzgbuymhwsgysony', 'ufvkxwyscpfbfdadpdwsahmrex', 'nnmcjmwjeurjvytuttuxhucrmw', 'ccfyprqxdkncrawyzccbvqfaiq', 'nbwmlwfvodiiuxbknpxkwgimwk', 'gfzwlbzxrbbhifumyuxlauqfzm', 'fwyorptywsnkadkhuwbxitlrod', 'avarrxbebcdsxeornfmfqjyghm', 'cohvgveqtyqgsvzzfhhtvnmzim', 'zrvbcpvaionfavzjrwleilwrhh');
Query number: 7000 SQL: INSERT INTO "threatmonitor".guid_test VALUES ('#dummy-llgyluaxbrhfimxkkukgnmikge', 'llgyluaxbrhfimxkkukgnmikge', 'xvfzqwgldoldwzeojwmmgumqqa', 'yqjunmgbizjmzpdrugyvumihhv', 'bxvkqghviqqlksxfrydojtmjee', 'bwaxlsnmnnqwryxueyeccywjzz', 'rsyqjuspuqhsudmtgbzhuaxlft', 'nsqptcpjwkvesbygckqajfgtnt', 'kcuuyhxnavxvaqtoyorxuzdigt', 'anxsibxqofrjstwbcfbjqfszrs', 'nbtaijbacogmxtfpivswjmbrmr');
Query number: 8000 SQL: INSERT INTO "threatmonitor".guid_test VALUES ('#dummy-cnrrgjcxvmvlwyxyswsjffmzsd', 'cnrrgjcxvmvlwyxyswsjffmzsd', 'jijkuxgzonhsjleluqvczasqgf', 'ksjxawxhheksfnqahojimbokjw', 'jaukydboqonuufgkzqsrnwcrmo', 'jcuafxamhnxhjhznaaptcnkytz', 'syxidnpquomsufcqayqdgjbifc', 'hgxngrjwlscjmkxvqdxqgpdepa', 'btiqqdmiosyaukvlvozpagridg', 'evusczgvmfwvcavybngfmgvlob', 'swbevizamdtjtqisjwmrqvvuhv');
Query number: 9000 SQL: INSERT INTO "threatmonitor".guid_test VALUES ('#dummy-bwnekdfneiyjjccucpubyjqrsu', 'bwnekdfneiyjjccucpubyjqrsu', 'mlhsdgespzovuwnfiideblszhs', 'kqubhvqwbtusloqjawwitcicnr', 'kunaknukkcqizioykazudvipms', 'vuzmbwnjcwetcfumoougqlxlof', 'ydobtppahyosxvnovzvpnsemgu', 'tbultosihuosacsprxllwccqeh', 'fjfxjndcoocsmdjagzdbogjalq', 'yfpuzwrgvhjvdobwydnhghlqmd', 'kaciqyvwxjvvjcuphdhubqaisf');
Handle: Pointer(Void)@0x19ab740
Table Width: 5
Record Count: 6
Response Code: 0
Insert Test
Fruit: Pointer(UInt8).null Price: Pointer(UInt8).null
Fruit: Pointer(UInt8).null Price: Pointer(UInt8).null
Fruit: Pointer(UInt8).null Price: Pointer(UInt8).null
Fruit: Pointer(UInt8).null Price: Pointer(UInt8).null
Fruit: Pointer(UInt8).null Price: Pointer(UInt8).null
Fruit: Pointer(UInt8).null Price: Pointer(UInt8).null
Fruit: Pointer(UInt8).null Price: Pointer(UInt8).null
Connection closed ? false

-- MonetDB

[root@mdb-master-01 /]# mclient -u monetdb -d threatmonitor
password:
Welcome to mclient, the MonetDB/SQL interactive terminal (Jul2015-SP4)
Database: MonetDB v11.21.19 (Jul2015-SP4), 'mapi:monetdb://mdb-master-01:50000/threatmonitor'
Type \q to quit, \? for a list of available commands
auto commit mode: on
sql>set schema "threatmonitor";
auto commit mode: on
sql>select count(*) as num from guid_test;
+-------+
| num   |
+=======+
| 10000 |
+-------+
1 tuple (2.341ms)
sql>
