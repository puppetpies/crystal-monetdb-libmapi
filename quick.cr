require "./src/monetdb"

db = "threatmonitor"
mid = MonetDBMAPI.mapi_connect("172.17.0.7", 50000, "monetdb", "monetdb", "sql", db);
p mid

