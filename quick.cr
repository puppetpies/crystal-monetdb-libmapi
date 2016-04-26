require "./src/monetdb"

db = "threatmonitor"

mid = MonetDBMAPI.mapi_connect("172.17.0.2", 50000, "monetdb", "monetdb", "sql", db);
p mid
hdl = MonetDBMAPI.mapi_query(mid, "SELECT 1")
p hdl
res = MonetDBMAPI.mapi_fetch_row(hdl)
p res


