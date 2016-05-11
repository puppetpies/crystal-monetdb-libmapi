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

class ConnectionError < Exception; end
class QueryError < Exception; end
class InternalError < Exception; end
class TimeoutError < Exception; end

module MonetDB

  class ClientJSON < Client

    property? monetdb_raw_data : String
    property? fields : String
    property? types : String
    
    def initialize
      super
      @monetdb_raw_data = ""
      @fields = ""
      @types = ""
    end
    
    # No Alias method ?
    def reset
      @monetdb_raw_data = ""
      @fields = ""
      @types = ""
    end
    
    private def process_from_raw(raw)
      monetdb_hdr_data = Array(String).new
      monetdb_raw_data = Array(String).new
      hdrinc = 0
      skipfirst = 0
      @fields = ""
      @types = ""
  #   puts raw
      raw.each {|l|
  #   puts "RAW Line: #{l}"
        unless hdrinc == 4
          monetdb_hdr_data = "#{monetdb_hdr_data}#{l}"
          if hdrinc == 1
            @fields = l.gsub("% ", "").split("#")[0].strip
            #puts "Field: #{@fields}"
          elsif hdrinc == 2
            @types = l.gsub("% ", "").split("#")[0].strip
            #puts "Type: #{@types}"
          end
          hdrinc += 1
        end
        if hdrinc == 4
          if skipfirst > 0
            @monetdb_raw_data = "#{@monetdb_raw_data}#{l}\n"
          end
          skipfirst += 1
        end
      }
    end
    
    private def json_process_result
      rowcounter = 0
      ln = 0
      result = Array(String).new
      @monetdb_raw_data.each_line {|n|
        #puts "#{ln} RAW Line: #{n}"
        comma_sep = Array(String).new
        mraw = 0
        nextrec = 0
        comma_sep << n.gsub("\t", "").gsub("\\\"", "").gsub("\n", "").gsub("NULL", "\"NULL\"").gsub("[ ", "").gsub("[", "").gsub("]", "")
        #puts comma_sep
        result << String.build do |io|
          io.json_object do |object|
            @fields.split(",").each {|field|
              object.field "#{field.strip.gsub("\"", "")}", "#{comma_sep[nextrec].split(",")[mraw].strip.gsub("\"", "")}"
              mraw += 1
            }
            rowcounter += 1
          end
        end
        #puts result
        ln += 1
      }
      #puts "Result: #{@result.class}"
      return result.not_nil!
    end

    def json_to_hash(result_json)
      #fields_once = 0
      valiter = 0
      res_hash = Hash(Int32, Hash(JSON::Any, JSON::Any)).new
      result_json.each {|j|
        build_kv = Hash(JSON::Any, JSON::Any).new
        parser = JSON.parse(j)
        #parser.each {|k, v|
        #  print "#{k} " if fields_once == 0
        #}
        #fields_once += 1
        #print "\n"
        parser.each {|k, v|
          #print "#{v} "
          build_kv.merge!({k => v})
        }
        res_hash.merge!({valiter => build_kv})
        valiter += 1
      }
      return res_hash
    end
    
    def query_json(mid, cmd : String)
      hdl = self.query(mid, cmd)
      rawdata = Array(String).new
      res = self.execute(hdl)
      case res  
      when MonetDBMAPI::MOK
        while (line = self.fetch_line(hdl)); rawdata << String.new(line).not_nil!; end
        #puts "query_json: Internal Type: #{rawdata.class}"
        process_from_raw(rawdata)
        json_result = json_process_result
        self.reset # Reinitialize instance variables to blank
        return json_result
      when MonetDBMAPI::MERROR
        raise InternalError.new "Mapi internal error."
      when res == MonetDBMAPI::MTIMEOUT
        raise TimeoutError.new "Error communicating with the server."
      when res == MonetDBMAPI::MSERVER
        raise QueryError.new "Query generated and invalid response please check your SQL"
      else
        json_result = Array(String).new
        json_result << String.build do |io|
          io.json_object do |object|
            object.field "result", "Unknown MServer Response code / MAPI Implementation outdated ?"
            object.field "troubleshooting", "Maybe you missing specifying Schema SELECT * FROM \"myschema\".table ..."
          end
        end
        self.reset
        return json_result
      end
    end
    
  end
  
end
