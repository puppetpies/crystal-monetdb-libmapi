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

timeout = 10

conn = MonetDB::Client.new
# hostname, username, password, schema
conn.connect("localhost", "monetdb", "monetdb", "test")
conn.timeout(timeout)

if conn.is_connected?
  puts "Connected: #{conn.established}".colorize(:green)
  puts "MAPI URI: #{conn.mapiuri}".colorize(:yellow)
else
  abort "Failed to connect".colorize(:red)
end
p conn
