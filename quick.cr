require "./src/monetdb"

db = "threatmonitor"

mid = MonetDBMAPI.mapi_connect("172.17.0.2", 50000, "monetdb", "monetdb", "sql", db);
p mid
hdl = MonetDBMAPI.mapi_query(mid, "SELECT NOW() UNION ALL SELECT NOW()")
p hdl
lang = MonetDBMAPI.mapi_get_lang(mid)
p lang
count = MonetDBMAPI.mapi_get_row_count(hdl)
p count
#while(line = MonetDBMAPI.mapi_fetch_row(hdl))
#  puts line.to_s
#end

