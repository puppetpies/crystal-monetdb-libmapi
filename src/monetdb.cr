require "./monetdb/*"

class MonetDB

  property? host : String
  property? port : Int32
  property? username : String
  property? password : String
  property? db : String
  
  getter host, port, username, password, lang, db
  setter host, port, username, password, lang, db
  
  def initialize
    @host = "127.0.0.1"
    @port = 50000
    @username = "monetdb"
    @password = "monetdb"
    @lang = "sql"
    @db = "test"
  end
  
  def get_monet_version(mid)
    MonetDBMAPI.mapi_get_monet_version(mid)
  end
  
  def connect
    MonetDBMAPI.mapi_connect(@host, @port, @username, @password, @lang, @db)
  end
  
  def is_connected?(mid)
    conn = MonetDBMAPI.mapi_is_connected(mid)
    if conn == 1
      return true
    elsif conn == 0
      return false
    end
  end
  
  def query(mid, query : String)
    MonetDBMAPI.mapi_query(mid, query)
  end
  
  def execute(hdl)
    MonetDBMAPI.mapi_execute(hdl)
  end
  
  def fetch_line(hdl)
    MonetDBMAPI.mapi_fetch_line(hdl)
  end
  
  def get_uri(mid)
    MonetDBMAPI.mapi_get_uri(mid)
  end
  
  def result_error(hdl)
    MonetDBMAPI.mapi_result_error(hdl)
  end
  
  def close_handle(hdl)
    MonetDBMAPI.mapi_close_handle(hdl)
  end
  
  def fetch_row(hdl)
    MonetDBMAPI.mapi_fetch_row(hdl)
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
  
  def setAutocommit(mid, autocommit : Bool)
    if autocommit == false
      autovalue = 0
    else
      autovalue = 1
    end
    MonetDBMAPI.mapi_setAutocommit(mid, autovalue)
  end
  
  def seek_row(hdl, rowne : Int32, whence : Int32)
    MonetDBMAPI.mapi_seek_row(hdl, rowne, whence)
  end
  
  def rows_affected(hdl)
    MonetDBMAPI.mapi_rows_affected(hdl)
  end
  
  def explain(mid, fd)
    MonetDBMAPI.mapi_explain(mid, fd)
  end

  def explain_query(hdl)
    MonetDBMAPI.mapi_explain_query(hdl, fd)
  end
  
  def explain_result(hdl)
    MonetDBMAPI.mapi_explain_result(hdl, fd)
  end
  
  def get_row_count(hdl)
    MonetDBMAPI.mapi_get_row_count(hdl)
  end
  
  def query_handle(hdl, cmd)
    MonetDBMAPI.mapi_query_handle(hdl, cmd)
  
  def disconnect(mid)
    MonetDBMAPI.mapi_disconnect(mid)
  end
  
  def destroy(mid)
    MonetDBMAPI.mapi_destroy(mid)
  end
  
end
