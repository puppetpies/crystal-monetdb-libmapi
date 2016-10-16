# #######################################################################
#
# Author: Brian Hood
# Name: Crystal bindings for MonetDB
# Email: <brianh6854@googlemail.com>                                   #
# Codename: Dagobert I
# Description:
#   MonetDB Client functionality
#
#
# #######################################################################

require "./monetdb/*"

class ConnectionError < Exception; end
class QueryError < Exception; end
class InternalError < Exception; end
class TimeoutError < Exception; end

module MonetDB
  class Client
    getter established : Bool
    getter mapiuri : String
    property? host : String
    property? port : Int32
    property? username : String
    property? password : String
    property? db : String
    getter mid : MonetDBMAPI::Mapi
    property host, port, username, password, lang, db

    def initialize
      @established = false
      @host = "127.0.0.1"
      @port = 50000
      @username = "monetdb"
      @password = "monetdb"
      @lang = "sql"
      @db = "test"
      @mapiuri = "mapi:monetdb://#{@host}:#{@port}/#{@db}"
      @mid = connect
    end

    def cache_limit(limit : Int32)
      MonetDBMAPI.mapi_cache_limit(@mid, limit)
    end

    def cache_shuffle(hdl, percentage : Int32)
      MonetDBMAPI.mapi_cache_shuffle(hdl, percentage)
    end

    def cache_freeup(hdl, percentage : Int32)
      MonetDBMAPI.mapi_cache_freeup(hdl, percentage)
    end

    def clear_params(hdl)
      MonetDBMAPI.mapi_clear_params(hdl)
    end

    def close_handle(hdl)
      MonetDBMAPI.mapi_close_handle(hdl)
    end

    def connect
      @mid = MonetDBMAPI.mapi_connect(@host, @port, @username, @password, @lang, @db)
    end

    # Overload to allow easy connect
    # conn = MonetDB::Client.new
    # conn.connect("localhost", "monetdb", "monetdb", "myschema") 
    def connect(host : String, username : String, password : String, database : String, port : Int32 = @port, lang : String = @lang)
      @host = host
      @username = username
      @password = password
      @db = database
      @port = port
      @lang = lang
      @mapiuri = "mapi:monetdb://#{@host}:#{@port}/#{@db}"
      @mid = MonetDBMAPI.mapi_connect(host, port, username, password, lang, db)
    end

    def disconnect
      MonetDBMAPI.mapi_disconnect(@mid)
    end

    def destroy
      MonetDBMAPI.mapi_destroy(@mid)
    end

    def error_str
      MonetDBMAPI.mapi_error_str(@mid)
    end
    
    def execute(hdl)
      MonetDBMAPI.mapi_execute(hdl)
    end

    def explain(fd)
      MonetDBMAPI.mapi_explain(@mid, fd)
    end

    def explain_query(hdl, fd)
      MonetDBMAPI.mapi_explain_query(hdl, fd)
    end

    def explain_result(hdl, fd)
      MonetDBMAPI.mapi_explain_result(hdl, fd)
    end

    def fetch_field(hdl, fnr : Int32)
      MonetDBMAPI.mapi_fetch_field(hdl, fnr)
    end

    def get_field_count(hdl) : LibC::Int
      MonetDBMAPI.mapi_get_field_count(hdl)
    end

    def is_connected?
      conn = MonetDBMAPI.mapi_is_connected(@mid)
      case conn
      when 1
        @established = true
      when 0
        @established = false
      else
        @established = false
      end
    end

    def new_handle
      MonetDBMAPI.mapi_new_handle(@mid)
    end

    def next_result(hdl)
      MonetDBMAPI.mapi_next_result(hdl)
    end

    def ping
      ping = MonetDBMAPI.mapi_ping(@mid)
      case ping
      when 0
        return "OK"
      else
        return "FAILED"
      end
    end
    
    def query(cmd : String)
      MonetDBMAPI.mapi_query(@mid, cmd)
    end

    def query_handle(hdl, cmd : String)
      MonetDBMAPI.mapi_query_handle(hdl, cmd)
    end

    def release_id(id : Int32)
      MonetDBMAPI.mapi_release_id(@mid, id)
    end

    def result_error(hdl)
      MonetDBMAPI.mapi_result_error(hdl)
    end

    def read_response(hdl)
      MonetDBMAPI.mapi_read_response(hdl)
    end

    def rows_affected(hdl)
      MonetDBMAPI.mapi_rows_affected(hdl)
    end

    def setAutocommit(autocommit : Bool)
      if autocommit == false
        autovalue = 0
      else
        autovalue = 1
      end
      MonetDBMAPI.mapi_setAutocommit(@mid, autovalue)
    end

    def seek_row(hdl, rowne : Int32, whence : Int32)
      MonetDBMAPI.mapi_seek_row(hdl, rowne, whence)
    end

    def trace(flag : Bool)
      if flag == false
        flagvalue = 0
      else
        flagvalue = 1
      end
      MonetDBMAPI.mapi_trace(@mid, flagvalue)
    end

    def timeout(time : Int32)
      MonetDBMAPI.mapi_timeout(@mid, time)
    end

    {% for method in %w(query_type tableid) %}
      def get_{{ method.id }}(hdl)
        MonetDBMAPI.mapi_get_{{ method.id }}(hdl)
      end
    {% end %}
    
    {% for method in %w(row_count last_id) %}
      def get_{{ method.id }}(hdl) : MonetDBMAPI::MapiInt64
        MonetDBMAPI.mapi_get_{{ method.id }}(hdl)
      end
    {% end %}
    
    {% for method in %w(len digits scale table name type query) %}
      def get_{{ method.id }}(hdl, fnr : Int32)
        mapi_get_{{ method.id }}(hdl, fnr)
      end
    {% end %}
    
    # Get methods thats are all the same using @mid
    {% for method in %w(trace autocommit active from to lang uri dbname host user mapi_version monet_version motd) %}
      def get_{{ method.id }}
        MonetDBMAPI.mapi_get_{{ method.id }}(@mid)
      end
    {% end %}
    
    {% for method in %w(line row all_rows field_array) %}
      def fetch_{{ method.id }}(hdl)
        MonetDBMAPI.mapi_fetch_{{ method.id }}(hdl)
      end
    {% end %}
    
  end
end
