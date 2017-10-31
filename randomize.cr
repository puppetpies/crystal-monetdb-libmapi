# #######################################################################
#
# Author: Brian Hood
# Name: Data randomizer
# Email: <brianh6854@googlemail.com>                                   #
# Codename: Dagobert I
# Description:
#   Generate Schema and data
#
#   bin/randomize
# #######################################################################

require "./src/monetdb"
require "./src/monetdb_data"
require "./src/tools"
require "colorize"
require "option_parser"

def random_data(max : Int32)
  a = "abcdefghijklmnopqrstuvwxyz"
  c = ""
  max.times {
    b = rand(26)
    c += "#{a[b..b]}"
  }
  return c
end

def gen_schema(db : String, tbl : String, rows : Int32)
 schema = "CREATE TABLE \"#{db}\".#{tbl} (\n"
 1.upto(rows) {|n|
  schema += "text#{n} STRING"
  unless n == rows
    schema += ",\n"
  end
 }
 schema += ");"
end

def print_stamp
  puts "Author: Brian Hood"
  puts "Homepage: https://github.com/puppetpies/crystal-monetdb-libmapi\n"
  puts "Description: \n\nCrystal bindings for MonetDB Testing Suite"
end

appname = "randomize"
host = "127.0.0.1"
port = 50000
username = "monetdb"
password = "monetdb"
db = "test"
schema = "myschema"
timeout = 10
autocommit = false
data = ""
table = "genrand"
columns = 0
inserts = 0
width = 10
quiet = false

mero = MonetDB::ClientJSON.new
oparse = OptionParser.parse! do |parser|
  parser.banner = "Usage: #{appname} [options]"

  parser.on("-h 127.0.0.1", "--HOST=127.0.0.1", "\tIP / DNS Name") { |h|
    mero.host = h
  }
  parser.on("-P 50000", "--PORT=50000", "\tTCP Port") { |f|
    mero.port = f.to_i
  }
  parser.on("-u monetdb", "-USERNAME=monetdb", "\tUsername") { |f|
    mero.username = f
  }
  parser.on("-p monetdb", "-PASSWORD=monetdb", "\tPassword") { |f|
    mero.password = f
  }
  parser.on("-d database", "-DB=test", "\tDatabase / Schema") { |f|
    mero.db = f
    db = f
  }
  parser.on("-s schema", "-SCHEMA=schema", "\tSchema") { |f|
    mero.db = f
    schema = f
  }
  parser.on("-t table", "-TABLE=test", "\tTable for Random") { |f|
    table = f
  }
  parser.on("-c columns", "-COLUMNS=test", "\tNumber of Columns") { |f|
    columns = f.to_i
  }
  parser.on("-w width", "-WIDTH=10", "\tWidth of data") { |f|
    width = f.to_i
  }
  parser.on("-i inserts", "-INSERTS=test", "\tNumber of Inserts") { |f|
    inserts = f.to_i
  }
  parser.on("-q", "--quiet", "\tQuiet mode") { |f|
    quiet = true
  }
  parser.on("-a", "--autocommit", "\tAutocommit default false") { |f|
    autocommit = true
  }
  parser.on("-H", "--help", "Show this help") {
    puts parser
    puts
    print_stamp
    exit 0
  }
end
oparse.parse!

mero.host ||= host
mero.port ||= port
mero.username ||= username
mero.password ||= password
mero.db ||= db
mero.schema ||= schema
puts ">> Server Information".colorize(:red)
puts "\n"
puts " > Merovingian Server: #{mero.host}".colorize(:blue)
puts " > Port: #{mero.port}".colorize(:blue)
puts " > Username: #{mero.username}".colorize(:blue)
puts " > DB: #{mero.db}".colorize(:blue)
mero.connect # Connect to a MServer5
mero.timeout(timeout)
isc = mero.is_connected?
puts " > Is Connected?: #{isc}".colorize(:blue)
ping = mero.ping?
puts " > Ping?: #{ping}".colorize(:blue)
uri = mero.get_uri
puts " > Merovingian URI: #{uri}".colorize(:blue)
puts " > Autocommit: #{autocommit}".colorize(:blue)
mero.setAutocommit(autocommit)
p mero

r = random_data(width)
#puts r
schema = gen_schema(db, table, columns)
hdl = mero.query(schema)
#res = mero.execute(hdl)
#if res == MonetDBMAPI::MOK
1.upto(inserts) do |i|
  sql = "INSERT INTO \"#{db}\".#{table} VALUES ("
  1.upto(columns) {|n|
    sql += "'#{r}'"
    unless n == columns
      sql += ","
    end
  }
  sql += ");"
  puts sql unless quiet == true
  hdl = mero.query(sql)
end
hdl = mero.commit
#end
puts "Generated Schema".colorize(:red)
puts schema
begin
  mero.close_handle(hdl) # Close query handle and free resources
  mero.disconnect        # Disconnect from server
  mero.destroy           # Free handle resources
  puts "Session should now be closed down and disconnected"
  isc = mero.is_connected? # Check we disconnected
  puts "Checking ...."
  puts "Connected to MServer ? #{isc}"
rescue
  raise ConnectionError.new "Something went wrong closing down..."
end
