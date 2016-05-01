########################################################################
#
# Author: Brian Hood
# Name: Crystal bindings for MonetDB
# Codename: Dagobert I
# Description: 
#   MonetDB RAW Data processor
#   
#
########################################################################

require "json"

monetdb_hdr_data = ""
monetdb_raw_data = ""
hdrinc = 0
skipfirst = 0
fields = ""
types = ""
File.open("monetdb_raw_result.txt", "r") {|n|
  n.each_line {|l|
    unless hdrinc == 4
      monetdb_hdr_data = "#{monetdb_hdr_data}#{l}"
      if hdrinc == 1
        fields = l.gsub("% ", "").split("#")[0].strip
      elsif hdrinc == 2
        types = l.gsub("% ", "").split("#")[0].strip
      end
      hdrinc += 1
    end
    if hdrinc == 4
      if skipfirst > 0
        monetdb_raw_data = "#{monetdb_raw_data}#{l}"
      end
      skipfirst += 1
    end
  }
}

#result = String.build do |io|
#  io.json_object do |object|
#    object.field "address", "Crystal Road 1234"
#    object.field "location" 
#  end
#end

b_fields = Array(String).new
fields.split(",").each {|n| b_fields << n.strip }
b_types = Array(String).new
types.split(",").each {|n| b_types << n.strip }

puts "Header Data:\n"
puts "#{monetdb_hdr_data}"

t = 0
b_fields.each {|n|
  puts "Field: #{n} Type: #{b_types[t]}"
  t += 1
}

puts "\nRaw Data:\n"
#puts "#{monetdb_raw_data}"
puts b_fields.join(" | ")
monetdb_raw_data.each_line {|n|
  #a = Tuple.new(n.gsub("NULL", "\"NULL\"").gsub("[", "").gsub("]", "").gsub("\t", "").gsub("\\", "").strip)
  str = n.gsub("\t", "").gsub("\\\"", "").gsub("\n", "").gsub("NULL", "\"NULL\"").gsub("[ ", "").gsub("[", "").gsub("]", "")
  puts str
}
