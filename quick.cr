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

def random_alphabet
  a = "abcdefghijklmnopqrstuvwxyz"
  c = ""
  26.times {
    b = rand(26)
    c = "#{c}#{a[b..b]}"
  }
  return c
end

mero = MonetDB.new
mero.host = "172.17.0.2"
mero.db = "threatmonitor"
mid = mero.connect # Connect to a MServer5
isc = mero.is_connected?(mid)
puts "Is Connected?: #{isc}"
puts "Mid: #{mid}"
uri = mero.get_uri(mid)
puts "Merovingian URI: #{uri}"
query = "SELECT * FROM \"threatmonitor\".fruits"
hdl = MonetDBMAPI::Mapihdl
hdl = mero.query(mid, query)
puts "Handle: #{hdl}"
tblwidth = mero.fetch_row(hdl)
puts "Table Width: #{tblwidth}"
count = mero.get_row_count(hdl)
puts "Record Count: #{count}"
res = mero.execute(hdl)
puts "Response Code: #{res}"
puts "Insert Test"

num = 10_000
puts "Start #{num}"
c = 0
mero.setAutocommit(mid, false) # Assume zero is 
num.times {|n|
  f1 = random_alphabet
  f2 = random_alphabet
  f3 = random_alphabet
  f4 = random_alphabet
  f5 = random_alphabet
  f6 = random_alphabet
  f7 = random_alphabet
  f8 = random_alphabet
  f9 = random_alphabet
  f10 = random_alphabet
  print "Query number: #{n} " if c == 1000
  sql = "INSERT INTO \"threatmonitor\".guid_test VALUES ('#dummy-#{f1}', '#{f1}', '#{f2}', '#{f3}', '#{f4}', '#{f5}', '#{f6}', '#{f7}', '#{f8}', '#{f9}', '#{f10}');"
  hdl = mero.query(mid, sql)
  puts "SQL: #{sql}" if c == 1000
  if c == 1000; c = 0; end
  c += 1
}
hdl = mero.query(mid, "COMMIT;")

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
    puts "Connection closed ? #{isc}"
  rescue
    raise "Something went wrong closing down..."
  end
elsif res == MonetDBMAPI::MSERVER
  raise "Query generated and invalid response please check your SQL"
end
