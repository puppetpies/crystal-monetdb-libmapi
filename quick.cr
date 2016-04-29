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

enum MServer
  MOK = 0
  MERROR = -1
  MTIMEOUT = -2
  MMORE = -3
  MSERVER  = -4
end

class ConnectionError < Exception; end
class QueryError < Exception; end
class InternalError < Exception; end
class TimeoutError < Exception; end

class Timers
  
  property? start : Time
  property? finish : Time
  
  def initialize
    @start = Time.now
    @finish = Time.now
    @duration = Time.now
  end
  
  def start
    @start = Time.now
  end
  
  def stop
    @finish = Time.now
  end
  
  def stats
    @duration = @finish - @start
    return "Start: #{@start} Finish: #{@finish} Duration: #{@duration.to_s}"
  end
    
end

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
updaterands = 1
autocommit = false

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
  parser.on("-d database", "-DB=test", "\tDatabase / Schema") {|f|
    mero.db = f
    db = f
  }
  parser.on("-l ITERATIONS", "-LOOP=3000", "\tINSERT Iterations") {|f|
    insloop = f.to_i
  }
  parser.on("-i INTERVAL", "-INTERVAL=250", "\tDisplay Interval") {|f|
    displayinterval = f.to_i
  }
  parser.on("-1 UPDATERAND", "-UPDATERAND=4", "\tUpdate Randomization") {|f|
    updaterands = f.to_i
  }
  parser.on("-a BOOLEAN", "-AUTOCOMMIT=true", "\tAuto Commit value") {|f|
    if f == "true"
      autocommit = true
    else
      autocommit = false
    end 
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
mero.password ||= password
mero.db ||= db
puts ">> Server Information".colorize(:red)
puts "\n"
puts " > Merovingian Server: #{mero.host}".colorize(:blue)
puts " > Port: #{mero.port}".colorize(:blue)
puts " > Username: #{mero.username}".colorize(:blue)
puts " > DB: #{mero.db}".colorize(:blue)
 
mid = mero.connect # Connect to a MServer5
isc = mero.is_connected?(mid)
puts " > Is Connected?: #{isc}".colorize(:blue)
ping = mero.ping(mid)
puts " > Ping?: #{ping}".colorize(:blue)
puts " > Mid / Connection: #{mid}".colorize(:blue)
uri = mero.get_uri(mid)
puts " > Merovingian URI: #{uri}".colorize(:blue)
ver = mero.get_monet_version(mid)
puts " > Monet Version: #{ver.to_s}".colorize(:blue)
puts " > Autocommit: #{autocommit}".colorize(:blue)
puts "\n>> Insert Test".colorize(:red)
if isc == false
  raise ConnectionError.new "Not connected make sure the MServer is started and see ./quick -h for details"
  exit
end

puts " - INSERT iterations: #{insloop}".colorize(:yellow)
c = 0
mero.setAutocommit(mid, autocommit)
tm = Timers.new
tm.start
insloop.times {|n|
  alpha = random_alphabet
  print "Query number: #{n} " if c == displayinterval
  sql = "INSERT INTO \"#{db}\".guid_test VALUES ('#dummy-#{alpha}', '#{alpha}', '#{alpha}', '#{alpha}', '#{alpha}', '#{alpha}', '#{alpha}', '#{alpha}', '#{alpha}', '#{alpha}', '#{alpha}')"
  hdl = mero.query(mid, sql)
  puts "SQL: #{sql}".colorize(:green) if c == displayinterval
  if c == displayinterval
    c = 0;
  end
  c += 1
}
mero.query(mid, "COMMIT;");
tm.stop
print "( Duration ) : ".colorize(:cyan)
puts tm.stats

puts "\n>> Update Test".colorize(:red)
0.upto(updaterands) {|n|
  puts " - Update Iteration: #{n}".colorize(:yellow)
  sql = "UPDATE \"#{db}\".guid_test SET guid = 'Dagobert' WHERE f#{rand(10)} LIKE '%asd%';"
  puts sql.colorize(:green)
  hdl = mero.query(mid, sql)
  aft = mero.rows_affected(hdl)
  puts "Rows affected: #{aft}".colorize(:blue)
  hdl = mero.query(mid, "COMMIT;")
}

puts "\n>> Delete Test".colorize(:red)
sql = "DELETE FROM \"#{db}\".guid_test WHERE guid = 'Dagobert';"
puts sql.colorize(:green)
hdl = mero.query(mid, sql)
aft = mero.rows_affected(hdl)
puts "Rows affected: #{aft}".colorize(:blue)
hdl = mero.query(mid, "COMMIT;")

puts "\n>> Delete Test Empty Table".colorize(:red)
sql = "DELETE FROM \"#{db}\".guid_test;"
puts sql.colorize(:green)
hdl = mero.query(mid, sql)
aft = mero.rows_affected(hdl)
puts "Rows affected: #{aft}".colorize(:blue)
hdl = mero.query(mid, "COMMIT;")

puts "\n>> Create Table Test Empty Table".colorize(:red)
sql = "CREATE TABLE \"#{db}\".table1 ( id int, firstname char(50), lastname char(50), age int);"
puts sql.colorize(:green)
hdl = mero.query(mid, sql)
hdl = mero.query(mid, "COMMIT;")

firstnames = ["John", "Fred", "Dave", "Ernest", "James"]
lastnames = ["Smith", "Jones", "Edwards", "Stevens", "Williams"]
insloop.times {|n|
  alpha = random_alphabet
  print "Query number: #{n} " if c == displayinterval
  sql = "INSERT INTO \"#{db}\".table1 VALUES (#{n}, '#{firstnames[rand(firstnames.size)]}', '#{lastnames[rand(lastnames.size)]}', #{rand(80)});"
  hdl = mero.query(mid, sql)
  puts "SQL: #{sql}".colorize(:green) if c == displayinterval
  if c == displayinterval
    c = 0;
  end
  c += 1
}
aft = mero.rows_affected(hdl)
puts "Rows affected: #{aft}".colorize(:blue)
hdl = mero.query(mid, "COMMIT;")

puts "\n>> ALTER TABLE Test ADD COLUMN".colorize(:red)
sql = "ALTER TABLE \"#{db}\".table1 ADD COLUMN sex CHAR(1);"
puts sql.colorize(:green)
hdl = mero.query(mid, sql)
aft = mero.rows_affected(hdl)
puts "Rows affected: #{aft}".colorize(:blue)
hdl = mero.query(mid, "COMMIT;")

puts "\n>> ALTER TABLE Test DROP COLUMN".colorize(:red)
sql = "ALTER TABLE \"#{db}\".table1 DROP COLUMN sex;"
puts sql.colorize(:green)
hdl = mero.query(mid, sql)
aft = mero.rows_affected(hdl)
puts "Rows affected: #{aft}".colorize(:blue)
hdl = mero.query(mid, "COMMIT;")

puts "\n>> DROP TABLE Test".colorize(:red)
sql = "DROP TABLE \"#{db}\".table1;"
puts sql.colorize(:green)
hdl = mero.query(mid, sql)
aft = mero.rows_affected(hdl)
puts "Rows affected: #{aft}".colorize(:blue)
hdl = mero.query(mid, "COMMIT;")

query = "SELECT * FROM \"#{db}\".fruits"
puts "SELECT Statement: #{query}".colorize(:green)
hdl = mero.query(mid, query)

puts "Handle: #{hdl}".colorize(:blue)
#tblwidth = mero.fetch_row(hdl, 1)
#puts "Table Width: #{tblwidth}".colorize(:blue)
count = mero.get_row_count(hdl)
puts "Record Count: #{count}".colorize(:blue)
res = mero.execute(hdl)
puts "MServer Response Key: #{MServer.new(res)} Code: #{res}".colorize(:blue)
puts "\n>> SELECT Test".colorize(:red)
if res == MonetDBMAPI::MOK
  while (line = mero.fetch_line(hdl))
    puts "Line: #{line}"
  end
  #row = mero.fetch_row(hdl, -1)
  #res2 = mero.read_response(hdl)
  #p res2
  #  name = mero.fetch_field(hdl, 0)
  #  price = mero.fetch_field(hdl, 1)
  #  puts "#{name} #{price}"
  #end
  begin
    mero.close_handle(hdl) # Close query handle and free resources
    mero.disconnect(mid)  # Disconnect from server
    mero.destroy(mid) # Free handle resources
    isc = mero.is_connected?(mid) # Check we disconnected
    puts "Connected to MServer ? #{isc}"
  rescue
    raise ConnectionError.new "Something went wrong closing down..."
  end
elsif res == MonetDBMAPI::MERROR
  raise InternalError.new "Mapi internal error."
elsif res == MonetDBMAPI::MTIMEOUT
  raise TimeoutError.new "Error communicating with the server."
elsif res == MonetDBMAPI::MSERVER
  raise QueryError.new "Query generated and invalid response please check your SQL"
end
