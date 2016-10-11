# #######################################################################
#
# Author: Brian Hood
# Name: Quick a test script for MonetDB functionality
# Email: <brianh6854@googlemail.com>                                   #
# Codename: Dagobert I
# Description:
#   Simple usage of new easy connect overload method and 
#   connection established check.
# #######################################################################

require "./src/monetdb"
require "colorize"

conn = MonetDB::Client.new
conn.connect("localhost", "monetdb", "monetdb", "test")

if conn.is_connected?
  puts "Connected".colorize(:red)
else
  abort "Failed to connect".colorize(:red)
end
p conn
