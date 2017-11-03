# #######################################################################
#
# Author: Brian Hood
# Name: Quick a test script for MonetDB functionality
# Email: <brianh6854@googlemail.com>                                   #
# Codename: Dagobert I
# Description:
#   Will eventually be made into unit tests basic functionality
#   thus far !
#
#   bin/quick -H 172.17.0.2 -u monetdb -d threatmonitor -l 500 -i 250 -1 5 -2 false
# #######################################################################

require "./src/monetdb"
require "./src/monetdb_data"
require "./src/tools"
require "colorize"
require "option_parser"

enum MServer
  MOK      =  0
  MERROR   = -1
  MTIMEOUT = -2
  MMORE    = -3
  MSERVER  = -4
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

appname = "quick"
host = "127.0.0.1"
port = 50000
username = "monetdb"
password = "monetdb"
db = "test"
schema = "myschema"
insloop = 3_000
displayinterval = 250
timeout = 10
updaterands = 1
autocommit = false
deleterecordsall = false


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
    mero.schema = f
    schema = f
  }
  parser.on("-l ITERATIONS", "-LOOP=3000", "\tINSERT Iterations") { |f|
    insloop = f.to_i
  }
  parser.on("-i INTERVAL", "-INTERVAL=250", "\tDisplay Interval") { |f|
    displayinterval = f.to_i
  }
  parser.on("-1 UPDATERAND", "-UPDATERAND=4", "\tUpdate Randomization") { |f|
    updaterands = f.to_i
  }
  parser.on("-a BOOLEAN", "-AUTOCOMMIT=true", "\tAuto Commit value") { |f|
    if f == "true"
      autocommit = true
    else
      autocommit = false
    end
  }
  parser.on("-2 BOOLEAN", "-DELETERECORDSALL=true", "\tDELETE RECORDS ALL") { |f|
    if f == "true"
      deleterecordsall = true
    else
      deleterecordsall = false
    end
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
p mero

puts "\n>> Insert Test".colorize(:red)
if isc == false
  abort ConnectionError.new "Not connected make sure the MServer is started and see ./quick -h for details"
end

puts " - INSERT iterations: #{insloop}".colorize(:yellow)
c = 0
mero.setAutocommit(autocommit)
tm = Timers.new
tm.start
insloop.times_with_progress { |n|
  alpha = random_alphabet
  print "Query number: #{n} " if c == displayinterval
  sql = "INSERT INTO \"#{db}\".guid_test VALUES ('#dummy-#{alpha}', '#{alpha}', '#{alpha}', '#{alpha}', '#{alpha}', '#{alpha}', '#{alpha}', '#{alpha}', '#{alpha}', '#{alpha}', '#{alpha}')"
  hdl = mero.query(sql)
  puts "SQL: #{sql}".colorize(:green) if c == displayinterval
  if c == displayinterval
    c = 0
  end
  c += 1
}
mero.commit
tm.stop
print "( Duration ) : ".colorize(:cyan)
puts tm.stats

puts "\n>> Update Test".colorize(:red)
0.upto_with_progress(updaterands) { |n|
  puts " - Update Iteration: #{n}".colorize(:yellow)
  sql = "UPDATE \"#{db}\".guid_test SET guid = 'Dagobert' WHERE f#{rand(10)} LIKE '%asd%';"
  puts sql.colorize(:green)
  hdl = mero.query(sql)
  aft = mero.rows_affected(hdl)
  puts "Rows affected: #{aft}".colorize(:blue)
  hdl = mero.commit
}

puts "\n>> Delete Test".colorize(:red)
sql = "DELETE FROM \"#{db}\".guid_test WHERE guid = 'Dagobert';"
puts sql.colorize(:green)
hdl = mero.query(sql)
aft = mero.rows_affected(hdl)
puts "Rows affected: #{aft}".colorize(:blue)
hdl = mero.commit

if deleterecordsall == true
  puts "\n>> Delete Test Empty Table".colorize(:red)
  sql = "DELETE FROM \"#{db}\".guid_test;"
  puts sql.colorize(:green)
  hdl = mero.query(sql)
  aft = mero.rows_affected(hdl)
  puts "Rows affected: #{aft}".colorize(:blue)
  hdl = mero.commit
end

puts "\n>> Create Table Test Empty Table".colorize(:red)
sql = "CREATE TABLE \"#{db}\".table1 ( id int, firstname char(50), lastname char(50), age int);"
puts sql.colorize(:green)
hdl = mero.query(sql)
hdl = mero.commit

firstnames = ["John", "Fred", "Dave", "Ernest", "James"]
lastnames = ["Smith", "Jones", "Edwards", "Stevens", "Williams"]
insloop.times_with_progress { |n|
  alpha = random_alphabet
  print "Query number: #{n} " if c == displayinterval
  sql = "INSERT INTO \"#{db}\".table1 VALUES (#{n}, '#{firstnames[rand(firstnames.size)]}', '#{lastnames[rand(lastnames.size)]}', #{rand(80)});"
  hdl = mero.query(sql)
  puts "SQL: #{sql}".colorize(:green) if c == displayinterval
  if c == displayinterval
    c = 0
  end
  c += 1
}
aft = mero.rows_affected(hdl)
puts "Rows affected: #{aft}".colorize(:blue)
hdl = mero.commit

puts "\n>> ALTER TABLE Test ADD COLUMN".colorize(:red)
sql = "ALTER TABLE \"#{db}\".table1 ADD COLUMN sex CHAR(1);"
puts sql.colorize(:green)
hdl = mero.query(sql)
hdl = mero.commit

puts "\n>> ALTER TABLE Test DROP COLUMN".colorize(:red)
sql = "ALTER TABLE \"#{db}\".table1 DROP COLUMN sex;"
puts sql.colorize(:green)
hdl = mero.query(sql)
hdl = mero.commit

puts "\n>> Enable Trace query"
trace = mero.trace(true)
puts "\n> - Trace"

puts "\n>> DROP TABLE Test".colorize(:red)
sql = "DROP TABLE \"#{db}\".table1;"
puts sql.colorize(:green)
hdl = mero.query(sql)
hdl = mero.commit
p trace
mero.trace(false) # disable trace

query = "SELECT 1"
2.times { |q|
  if q == 0
    query = "SELECT * FROM \"#{db}\".guid_test LIMIT 5;"
    puts "Test query 1: #{query}"
  elsif q == 1
    query = "SELECT * FROM \"#{db}\".fruits;"
    puts "Test query 2: #{query}"
  end
  mero.close_handle(hdl)
  mero.new_handle
  puts "SELECT Statement: #{query}".colorize(:green)
  hdl = mero.query(query)
  puts "Handle: #{hdl}".colorize(:blue)
  tblwidth = mero.fetch_row(hdl)
  puts "Table Width: #{tblwidth}".colorize(:blue)
  count = mero.get_row_count(hdl)
  puts "Record Count: #{count}".colorize(:blue)
  res = mero.execute(hdl)
  puts "MServer Response Key: #{MServer.new(res)} Code: #{res}".colorize(:blue)
  puts "\n>> SELECT Test".colorize(:red)
  if res == MonetDBMAPI::MOK
    while (line = mero.fetch_line(hdl))
      puts String.new(line)
    end
    result_json = mero.query_json(query)
    # puts "JSON Internal Data Type: #{result_json.class}\n".colorize(:red)
    puts "JSON Generated:\n".colorize(:red)
    # Sample process JSON
    # crystal eval 'require "json"; str = "{\"name\":\"Apple\",\"price\":\"0.65\"}"
    # jsn = JSON.parse(str); p jsn.each {|k,v| puts k; puts v; }'
    result_json.each { |j|
      puts j
    }
    # res_hash = mero.json_to_hash(result_json)
    print "\nHash Table of Results\n".colorize(:red)
    # Sample Res hash
    # {0 => {"name" => "Apple", "price" => "9.99", "weight" => "50", "comments" => "NULL", "id" => "1"},
    #  1 => {"name" => "Bananna", "price" => "3.99", "weight" => "30", "comments" => "NULL", "id" => "2"},
    #  2 => {"name" => "Orange", "price" => "7.99", "weight" => "60", "comments" => "NULL", "id" => "3"},
    #  3 => {"name" => "Peach", "price" => "5.00", "weight" => "80", "comments" => "NULL", "id" => "4"},
    #  4 => {"name" => "Kiwi", "price" => "9.00", "weight" => "20", "comments" => "NULL", "id" => "5"},
    #  5 => {"name" => "Tomato", "price" => "2.00", "weight" => "20", "comments" => "Yes a fruit", "id" => "6"},
    #  6 => {"name" => "Pear", "price" => "4.00", "weight" => "30", "comments" => "Juicy", "id" => "7"},
    #  7 => {"name" => "Nectarine", "price" => "6.00", "weight" => "50", "comments" => "Juicy", "id" => "8"}}
    # pp res_hash
    print "\n"
    print "Select Specific Fields from Hash table\n\n".colorize(:red)
    if q == 0
      res_hash_f1 = mero.json_to_hash(result_json)
      pp res_hash_f1
      res_hash_f1.each { |k, v|
        puts "Hash ID: #{k} F1: #{v["f1"]} F2: #{v["f2"]}"
      }
    elsif q == 1
      res_hash_f2 = mero.json_to_hash(result_json)
      pp res_hash_f2
      res_hash_f2.each { |k, v|
        puts "Hash ID: #{k} Name: #{v["name"]} Price: #{v["price"]}"
      }
    end
  elsif res == MonetDBMAPI::MERROR
    raise InternalError.new "Mapi internal error."
  elsif res == MonetDBMAPI::MTIMEOUT
    raise TimeoutError.new "Error communicating with the server."
  elsif res == MonetDBMAPI::MSERVER
    raise QueryError.new "Query generated and invalid response please check your SQL"
  end
}
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
