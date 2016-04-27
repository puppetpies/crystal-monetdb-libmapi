require "./monetdb/*"

class MonetDB
  setter host, port, username, password, lang, db
  def initialize
    @host = "127.0.0.1"
    @port = 50000
    @username = "monetdb"
    @password = "monetdb"
    @lang = "sql"
    @db = "test"
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
  
  def query(mid, query)
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
  
  def get_row_count(hdl)
    MonetDBMAPI.mapi_get_row_count(hdl)
  end
  
  def disconnect(mid)
    MonetDBMAPI.mapi_disconnect(mid)
  end
  
  def destroy(mid)
    MonetDBMAPI.mapi_destroy(mid)
  end
  
end
