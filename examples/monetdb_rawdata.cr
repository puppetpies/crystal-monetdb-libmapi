########################################################################
#
# Author: Brian Hood
# Name: Crystal bindings for MonetDB
# Codename: Dagobert I
# Description: 
#   MonetDB RAW Data processor
#   
#   For clarity this is just a test for parsing the RAW output
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

b_fields = Array(String).new
fields.split(",").each {|n| b_fields << n.strip }
b_types = Array(String).new
types.split(",").each {|n| b_types << n.strip }

puts "Header Data:\n"
puts "#{monetdb_hdr_data}"

puts "\nRaw Data:\n"
monetdb_raw_data.each_line {|n|
  puts n
}

#puts "\nGenerated JSON Data:\n"
t = 0
#puts "JSON Fields / Types:\n"
  result = String.build do |io|
    io.json_object do |object|
    b_fields.each {|n|
      object.field "#{n}", "#{b_types[t]}"
      t += 1
    }
    end
  end
#puts result

#puts "\nJSON Data:\n"
rowcounter = 0
monetdb_raw_data.each_line {|n|
  comma_sep = Array(String).new
  mraw = 0
  nextrec = 0
  comma_sep << n.gsub("\t", "").gsub("\\\"", "").gsub("\n", "").gsub("NULL", "\"NULL\"").gsub("[ ", "").gsub("[", "").gsub("]", "")
  #puts comma_sep
  result = String.build do |io|
    io.json_object do |object|
      fields.split(",").each {|field|
        object.field "#{field.strip.gsub("\"", "")}", "#{comma_sep[nextrec].split(",")[mraw].strip.gsub("\"", "")}"
        mraw += 1
      }
      rowcounter += 1
    end
  end
  #puts result
}

result = String.build do |io|
  io.json_object do |object|
    object.field "rowcount", "#{rowcounter}"
  end
end
#puts result
