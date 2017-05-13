# crystal-monetdb-libmapi

Crystal binding for the MonetDB MAPI client interface

Tested on

Crystal 0.22

You will need the MonetDB client package installed for this to work and also an instance of MServer5 running

We can now perform a query that emits JSON useful for SELECT statements

For more details look at monetdb.org

Shards

Add this to your shard.yml and run shards install or crystal dep

```
  crystal-monetdb-libmapi:
    github: puppetpies/crystal-monetdb-libmapi
    version: ">= 0.1.1"

```

Examples schemas provided under examples/

```crystal
# Example code from shard crystal-monetdb-examples

require "crystal-monetdb-libmapi"
require "crystal-monetdb-libmapi/monetdb_data"
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
mero.connect

# Alternative connect overload method to allow easy connect
# conn = MonetDB::Client.new
# conn.connect("localhost", "username", "password", "testschema") 

result_json = mero.query_json(query)
result = mero.json_to_hash(result_json)
puts "Hash Created:".colorize(:red)
p result
puts "Display specific fields".colorize(:red)
result.each {|k,v|
  puts "Hash Key: #{k} Name: #{v["name"]} Price: #{v["price"]}"
}

```
Have fun!

Brian Hood
