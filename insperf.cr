#!/usr/bin/ruby
# #######################################################################
#
# Author: Brian Hood
# Name: Insert performance test with Ruby / Crystal driver
# Codename: Dagobert I
# Description:
#
#
#
# #######################################################################

require "./src/monetdb"
require "./src/monetdb_data"
require "./src/tools"
require "colorize"
require "option_parser"

host = "127.0.0.1"
port = 50000
username = "monetdb"
password = "monetdb"
db = "test"
insloop = 10_000
displayinterval = 1000
updaterands = 1
autocommit = false
deleterecordsall = false

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

mero = MonetDB::ClientJSON.new
oparse = OptionParser.parse! do |parser|
  parser.banner = "Usage: quick [options]"

  parser.on("-H 127.0.0.1", "--HOST=127.0.0.1", "\tIP / DNS Name") { |f|
    mero.host = f
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
  parser.on("-a true", "--AUTOCOMMIT=true", "Enabled / Disable Autocommit") {|a|
    if a == "true"
      autocommit = true
    else
      autocommit = false
    end
  }
  parser.on("-l ITERATIONS", "-LOOP=3000", "\tINSERT Iterations") { |f|
    insloop = f.to_i
  }
  parser.on("-i INTERVAL", "-INTERVAL=250", "\tDisplay Interval") { |f|
    displayinterval = f.to_i
  }
  parser.on("-h", "--help", "\tDisplay options") { |h|
    print_stamp
    puts parser
    exit
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
mero.timeout(mid, 10)
isc = mero.is_connected?(mid)
puts " > Is Connected?: #{isc}".colorize(:blue)
ping = mero.ping(mid)
puts " > Ping?: #{ping}".colorize(:blue)
uri = mero.get_uri(mid)
puts " > Merovingian URI: #{String.new(uri)}".colorize(:blue)
ver = mero.get_monet_version(mid)
puts " > Monet Version: #{String.new(ver)}".colorize(:blue)
rel = mero.release_id(mid, 1)
puts " > Release ID: #{rel}".colorize(:blue)
puts " > Autocommit: #{autocommit}".colorize(:blue)
puts "\n>> Insert Test".colorize(:red)
if isc == false
  raise ConnectionError.new "Not connected make sure the MServer is started and see ./insperf -h for details"
  exit
end

puts "\n>> Create Table Test Empty Table".colorize(:red)
sql = "CREATE TABLE \"#{db}\".table1 ( id int, firstname char(50), lastname char(50), age int);"
puts sql.colorize(:green)
hdl = mero.query(mid, sql)
hdl = mero.query(mid, "COMMIT;")

puts " - INSERT iterations: #{insloop}".colorize(:yellow)
firstnames = ["Edward", "Henry", "Robert", "Michael", "Dave", "Joe", "Kev"]
lastnames = ["Smith", "Jones", "Warbutton", "Blake", "Ward", "Johnston", "Abbot"]
c = 0
mero.setAutocommit(mid, autocommit)
dur = Timers.new
dur.start
tm = Timers.new
tm.start
m = 0_u32
m_res = 0
insloop.times { |n|
  alpha = random_alphabet
  print "Query number: #{n} " if c == displayinterval
  sql = "INSERT INTO \"#{db}\".table1 VALUES (#{n}, '#{firstnames[rand(firstnames.size)]}', '#{lastnames[rand(lastnames.size)]}', #{rand(80)});"
  hdl = mero.query(mid, sql)
  puts "SQL: #{sql}".colorize(:green) if c == displayinterval
  if c == displayinterval
    c = 0
    tm.stop
    puts tm.stats
    tm.start
  end
  c += 1
  m += 1
}
mero.query(mid, "COMMIT;")
results_json = mero.query_json(mid, "SELECT count(*) as num FROM \"#{db}\".table1;")
hash_results = mero.json_to_hash(results_json)
puts "Record Count: ".colorize(:cyan)
hash_results.each { |x, n| puts n["num"]; m_res = n["num"] }
# m_res_int = m_res.to_i
m_res_int = m_res.to_s.to_i
if m == m_res_int
  puts "SUCCESS - Record count matches"
else
  puts "FAIL - Actual records in table is different to records inserted ?"
end
puts "Total time:"
puts dur.stats
