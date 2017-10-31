require "./src/monetdb"
require "./src/monetdb_data"
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
schema = "test"

mero = MonetDB::ClientJSON.new
mero.host = host
mero.port = port
mero.username = username
mero.password = password
mero.db = db
mero.schema = schema

query = "SELECT * FROM #{schema}.fruits;"
mid = mero.connect
result_json = mero.query_json(query)
result = mero.json_to_hash(result_json)
puts "Hash Created:".colorize(:red)
p result
puts "Display specific fields".colorize(:red)
result.each {|k,v|
  puts "Hash Key: #{k} Name: #{v["name"]} Price: #{v["price"]}"
}
