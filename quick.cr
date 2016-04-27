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

mero = MonetDB.new
mero.host = "172.17.0.2"
mero.db = "threatmonitor"
mid = mero.connect # Connect to a Mserver
isc = mero.is_connected?(mid)
puts "Is Connected?: #{isc}"
puts "Mid: #{mid}"
uri = mero.get_uri(mid)
puts "Merovingian URI: #{uri}"
query = "SELECT NOW() UNION ALL SELECT NOW() UNION ALL SELECT NOW()"
hdl = MonetDBMAPI::Mapihdl
hdl = mero.query(mid, query)
puts "Handle: #{hdl}"
row = mero.fetch_row(hdl)
puts "Row: #{row}"
count = mero.get_row_count(hdl)
puts "Count: #{count}"
res = mero.execute(hdl)
puts "Response Code: #{res}"
if res == MonetDBMAPI::MOK
  mero.close_handle(hdl) # Close query handle and free resources
  mero.disconnect(mid)  # Disconnect from server
  mero.destroy(mid) # Free handle resources
  isc = mero.is_connected?(mid) # Check we disconnected
  puts "Is Connected?: #{isc}"
elsif res == MonetDBMAPI::MSERVER
  raise "Query generated and invalid response please check your SQL"
end
