########################################################################
#
# Author: Brian Hood
# Name: Quick a test script for MonetDB functionality
# Codename: Dagobert I
# Description: 
#   Will eventually be made into unit tests basic functionality
#   thus far !   
#
########################################################################

require "./src/monetdb"
require "colorize"
require "option_parser"

class ConnectionError < Exception; end
class QueryError < Exception; end

def random_alphabet
  a = "abcdefghijklmnopqrstuvwxyz"
  c = ""
  26.times {
    b = rand(26)
    c = "#{c}#{a[b..b]}"
  }
  return c
end

def print_stamp
  puts "Author: Brian Hood"
  puts "Homepage: https://github.com/puppetpies/crystal-monetdb-libmapi\n"
  puts "Description: \n\nCrystal bindings for MonetDB Testing Suite"
end

host = "127.0.0.1"
port = 50000
username = "monetdb"
password = "monetdb"
db = "test"
insloop = 3_000
displayinterval = 250

mero = MonetDB.new
oparse = OptionParser.parse! do |parser|
  parser.banner = "Usage: quick [options]"

  parser.on("-H 127.0.0.1", "--HOST=127.0.0.1", "\tIP / DNS Name") {|f|
    mero.host = f
  }
  parser.on("-P 50000", "--PORT=50000", "\tTCP Port") {|f|
    mero.port = f.to_i
  }
  parser.on("-u monetdb", "-USERNAME=monetdb", "\tUsername") {|f|
    mero.username = f
  }
  parser.on("-p monetdb", "-PASSWORD=monetdb", "\tPassword") {|f|
    mero.password = f
  }
  parser.on("-d database", "-DB=test", "\tDatabase") {|f|
    mero.db = f
  }
  parser.on("-l ITERATIONS", "-LOOP=3000", "\tINSERT Iterations") {|f|
    insloop = f.to_i
  }
  parser.on("-i INTERVAL", "-INTERVAL=250", "\tDisplay Interval") {|f|
    displayinterval = f.to_i
  }
  parser.on("-h", "--help", "Show this help") {|h|
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
mero.db ||= password

puts "Merovingian Server: #{mero.host}".colorize(:blue)
puts "Port: #{mero.port}".colorize(:blue)
puts "Username: #{mero.username}".colorize(:blue)
puts "DB: #{mero.db}".colorize(:blue)
 
mid = mero.connect # Connect to a MServer5
isc = mero.is_connected?(mid)
puts "Is Connected?: #{isc}".colorize(:blue)
ping = mero.ping(mid)
puts "Ping?: #{ping}".colorize(:blue)
puts "Mid: #{mid}".colorize(:blue)
uri = mero.get_uri(mid)
puts "Merovingian URI: #{uri}".colorize(:blue)
ver = mero.get_monet_version(mid)
puts "Monet Version: #{ver.to_s}".colorize(:blue)
puts ">> Insert Test".colorize(:red)
if isc == false
  raise ConnectionError.new "Not connected make sure the MServer is started and see ./quick -h for details"
  exit
end

puts "Number of INSERT iterations: #{insloop}"
c = 0
mero.setAutocommit(mid, false)
insloop.times {|n|
  alpha = random_alphabet
  print "Query number: #{n} " if c == displayinterval
  sql = "INSERT INTO \"threatmonitor\".guid_test VALUES ('#dummy-#{alpha}', '#{alpha}', '#{alpha}', '#{alpha}', '#{alpha}', '#{alpha}', '#{alpha}', '#{alpha}', '#{alpha}', '#{alpha}', '#{alpha}')"
  hdl = mero.query(mid, sql)
  puts "SQL: #{sql}".colorize(:green) if c == displayinterval
  if c == displayinterval
    c = 0;
  end
  c += 1
}
mero.query(mid, "COMMIT;");

puts ">> Update Test".colorize(:red)
sql = "UPDATE \"threatmonitor\".guid_test SET guid = 'Dagobert' WHERE f#{rand(10)} LIKE '%asd%';"
puts sql.colorize(:green)
hdl = mero.query(mid, sql)
aft = mero.rows_affected(hdl)
puts "Rows affected: #{aft}".colorize(:blue)
hdl = mero.query(mid, "COMMIT;")

puts ">> Delete Test".colorize(:red)
sql = "DELETE FROM \"threatmonitor\".guid_test WHERE guid = 'Dagobert';"
puts sql.colorize(:green)
hdl = mero.query(mid, sql)
aft = mero.rows_affected(hdl)
puts "Rows affected: #{aft}".colorize(:blue)
hdl = mero.query(mid, "COMMIT;")

puts ">> Delete Test Empty Table".colorize(:red)
sql = "DELETE FROM \"threatmonitor\".guid_test;"
puts sql.colorize(:green)
hdl = mero.query(mid, sql)
aft = mero.rows_affected(hdl)
puts "Rows affected: #{aft}".colorize(:blue)
hdl = mero.query(mid, "COMMIT;")

query = "SELECT * FROM \"threatmonitor\".fruits;"
puts "SELECT Statement: #{query}".colorize(:green)
hdl = mero.query(mid, query)

puts "Handle: #{hdl}".colorize(:blue)
tblwidth = mero.fetch_row(hdl)
puts "Table Width: #{tblwidth}".colorize(:blue)
count = mero.get_row_count(hdl)
puts "Record Count: #{count}".colorize(:blue)
res = mero.execute(hdl)
puts "MServer Response Code: #{res}".colorize(:blue)
if res == MonetDBMAPI::MOK
  0.upto(count) {|n|
    fruit = mero.fetch_field(hdl, 0)
    price = mero.fetch_field(hdl, 1)
    puts "Fruit: #{fruit} Price: #{price}"
    mero.seek_row(hdl, n, 0) # Seek to next row
  }
  begin
    mero.close_handle(hdl) # Close query handle and free resources
    mero.disconnect(mid)  # Disconnect from server
    mero.destroy(mid) # Free handle resources
    isc = mero.is_connected?(mid) # Check we disconnected
    puts "Connected to MServer ? #{isc}"
  rescue
    raise ConnectionError.new "Something went wrong closing down..."
  end
elsif res == MonetDBMAPI::MSERVER
  raise QueryError.new "Query generated and invalid response please check your SQL"
end
