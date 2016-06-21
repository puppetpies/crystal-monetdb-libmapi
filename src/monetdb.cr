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
    property? host : String
    property? port : Int32
    property? username : String
    property? password : String
    property? db : String
    property? mid : MonetDBMAPI::Mapi
    getter host, port, username, password, lang, db
    setter host, port, username, password, lang, db

    def initialize
      @host = "127.0.0.1"
      @port = 50000
      @username = "monetdb"
      @password = "monetdb"
      @lang = "sql"
      @db = "test"
      @mid = connect
    end

    def get_monet_version
      MonetDBMAPI.mapi_get_monet_version(@mid)
    end

    def ping
      ping = MonetDBMAPI.mapi_ping(@mid)
      if ping == 0
        return "OK"
      else
        return "FAILED"
      end
    end

    def connect
      @mid = MonetDBMAPI.mapi_connect(@host, @port, @username, @password, @lang, @db)
    end

    def disconnect
      MonetDBMAPI.mapi_disconnect(@mid)
    end

    def destroy
      MonetDBMAPI.mapi_destroy(@mid)
    end

    def is_connected?
      conn = MonetDBMAPI.mapi_is_connected(@mid)
      if conn == 1
        return true
      elsif conn == 0
        return false
      end
    end

    def query(cmd : String)
      MonetDBMAPI.mapi_query(@mid, cmd)
    end

    def query_handle(hdl, cmd : String)
      MonetDBMAPI.mapi_query_handle(hdl, cmd)
    end

    def execute(hdl)
      MonetDBMAPI.mapi_execute(hdl)
    end

    def fetch_line(hdl)
      MonetDBMAPI.mapi_fetch_line(hdl)
    end

    def get_uri
      MonetDBMAPI.mapi_get_uri(@mid)
    end

    def release_id(id : Int32)
      MonetDBMAPI.mapi_release_id(@mid, id)
    end

    def result_error(hdl)
      MonetDBMAPI.mapi_result_error(hdl)
    end

    def clear_params(hdl)
      MonetDBMAPI.mapi_clear_params(hdl)
    end
    
    def close_handle(hdl)
      MonetDBMAPI.mapi_close_handle(hdl)
    end

    def fetch_row(hdl)
      MonetDBMAPI.mapi_fetch_row(hdl)
    end

    def read_response(hdl)
      MonetDBMAPI.mapi_read_response(hdl)
    end

    def fetch_all_rows(hdl)
      MonetDBMAPI.mapi_fetch_all_rows(hdl)
    end

    def fetch_field(hdl, fnr : Int32)
      MonetDBMAPI.mapi_fetch_field(hdl, fnr)
    end

    def fetch_field_array(hdl)
      MonetDBMAPI.mapi_fetch_field_array(hdl)
    end

    def setAutocommit(autocommit : Bool)
      if autocommit == false
        autovalue = 0
      else
        autovalue = 1
      end
      MonetDBMAPI.mapi_setAutocommit(@mid, autovalue)
    end

    def next_result(hdl)
      MonetDBMAPI.mapi_next_result(hdl)
    end

    def seek_row(hdl, rowne : Int32, whence : Int32)
      MonetDBMAPI.mapi_seek_row(hdl, rowne, whence)
    end

    def rows_affected(hdl)
      MonetDBMAPI.mapi_rows_affected(hdl)
    end

    def error_str
      MonetDBMAPI.mapi_error_str(@mid)
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

    def get_trace
      MonetDBMAPI.mapi_get_trace(@mid)
    end

    def get_user
      MonetDBMAPI.mapi_get_user(@mid)
    end

    def get_host
      MonetDBMAPI.mapi_get_host(@mid)
    end
    
    def get_mapi_version
      MonetDBMAPI.mapi_get_mapi_version(@mid)
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

    def get_row_count(hdl)
      MonetDBMAPI.mapi_get_row_count(hdl)
    end

    def query_handle(hdl, cmd)
      MonetDBMAPI.mapi_query_handle(hdl, cmd)
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
  end
end
