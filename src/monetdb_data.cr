########################################################################
#
# Author: Brian Hood
# Name: Crystal bindings for MonetDB
# Codename: Dagobert I
# Description: 
#   Data functions extending MonetDB class
#   
#
########################################################################
require "json"

class MonetDBJSON < MonetDB

  def initialize
    super
    @monetdb_raw_data = ""
    @fields = ""
    @types = ""
    @result = ""
  end
  
  def process_from_raw(raw)
    monetdb_hdr_data = Array(String).new
    monetdb_raw_data = Array(String).new
    hdrinc = 0
    skipfirst = 0
    @fields = ""
    @types = ""
    puts raw
    raw.each {|l|
      unless hdrinc == 4
        monetdb_hdr_data = "#{monetdb_hdr_data}#{l}"
        if hdrinc == 1
          @fields = l.gsub("% ", "").split("#")[0].strip
        elsif hdrinc == 2
          @types = l.gsub("% ", "").split("#")[0].strip
        end
        hdrinc += 1
      end
      if hdrinc == 4
        if skipfirst > 0
          @monetdb_raw_data = "{#{@monetdb_raw_data}#{l}"
        end
        skipfirst += 1
      end
    }
    json_process_result
  end
  
  def json_process_result
    rowcounter = 0
    @monetdb_raw_data.each_line {|n|
      comma_sep = Array(String).new
      mraw = 0
      nextrec = 0
      comma_sep << n.gsub("\t", "").gsub("\\\"", "").gsub("\n", "").gsub("NULL", "\"NULL\"").gsub("[ ", "").gsub("[", "").gsub("]", "")
      #puts comma_sep
      @result = String.build do |io|
        io.json_object do |object|
          @fields.split(",").each {|field|
            object.field "#{field.strip.gsub("\"", "")}", "#{comma_sep[nextrec].split(",")[mraw].strip.gsub("\"", "")}"
            mraw += 1
          }
          rowcounter += 1
        end
      end
      #puts result
    }
    return @result
  end
  
  def query_json(mid, cmd : String)
    hdl = self.query(mid, cmd)
    rawdata = Array(String).new
    res = self.execute(hdl)
    if res == MonetDBMAPI::MOK
      while (line = self.fetch_line(hdl)); rawdata << String.new(line); end
      puts "Type: #{rawdata.class}"
      json = process_from_raw(rawdata)
      return json
    elsif res == MonetDBMAPI::MERROR
      raise InternalError.new "Mapi internal error."
    elsif res == MonetDBMAPI::MTIMEOUT
      raise TimeoutError.new "Error communicating with the server."
    elsif res == MonetDBMAPI::MSERVER
      raise QueryError.new "Query generated and invalid response please check your SQL"
    end
  end
  
end
