lib LibC
  alias Stream = UInt8
end

@[Link("mapi")]
lib MonetDBMAPI

# Constants
  #_MAPI_H_INCLUDED = 1
  MAPI_AUTO	= 0	# automatic type detection
  MAPI_TINY	= 1
  MAPI_UTINY	= 2
  MAPI_SHORT	= 3
  MAPI_USHORT	= 4
  MAPI_INT	= 5
  MAPI_UINT	= 6
  MAPI_LONG	= 7
  MAPI_ULONG	= 8
  MAPI_LONGLONG	= 9
  MAPI_ULONGLONG = 10
  MAPI_CHAR	= 11
  MAPI_VARCHAR	= 12
  MAPI_FLOAT	= 13
  MAPI_DOUBLE	= 14
  MAPI_DATE	= 15
  MAPI_TIME	= 16
  MAPI_DATETIME	= 17
  MAPI_NUMERIC	= 18
  PLACEHOLDER	= "?"
  MAPI_SEEK_SET	= 0
  MAPI_SEEK_CUR	= 1
  MAPI_SEEK_END	= 2
  MAPI_TRACE	= 1
  MAPI_TRACE_LANG = 2
  MOK		= 0
  MERROR	= -1
  MTIMEOUT	= -2
  MMORE		= -3
  MSERVER       = -4
  LANG_MAL	= 0
  LANG_SQL	= 2
  LANG_JAQL	= 3
  PROMPTBEG	= "\001"	# start prompt bracket
  PROMPT1	= "\001\001\n" # prompt: ready for new query
  PROMPT2	= "\001\002\n" # prompt: more data needed

  enum SQLQuery
    Q_PARSE = 0
    Q_TABLE = 1
    Q_UPDATE = 2
    Q_SCHEMA = 3
    Q_TRANS = 4
    Q_PREPARE = 5
    Q_BLOCK = 6
  end

# three structures used for communicating date/time information
# these structs are deliberately compatible with the ODBC versions
# SQL_DATE_STRUCT, SQL_TIME_STRUCT, and SQL_TIMESTAMP_STRUCT

struct MapiDate # used by MAPI_DATE
  year : UInt8
  month : UInt8
  day : UInt8
end

struct MapiTime # used by MAPI_TIME
  hour : UInt8
  minute : UInt8
  second : UInt8
end

struct MapiDateTime # used by MAPI_DATETIME
  year : Int8;
  month : UInt8
  day : UInt8
  hour : UInt8
  minute : UInt8
  second : UInt8
  fraction : Int32	# in 1000 millionths of a second (10e-9)
end

# connection-oriented functions

  type Mapi = Void*
  fun mapi_mapi(host : LibC::Char*, port : LibC::Int, username : LibC::Char*, password : LibC::Char*, lang : LibC::Char*, dbname : LibC::Char*) : Mapi
  fun mapi_mapiuri(url : LibC::Char*, user : LibC::Char*, pass : LibC::Char*, lang : LibC::Char*) : Mapi
  alias Mapimsg = LibC::Int
  fun mapi_destroy(mid : Mapi) : Mapimsg
  fun mapi_start_talking(mid : Mapi) : Mapimsg
  fun mapi_connect(host : LibC::Char*, port : LibC::Int, username : LibC::Char*, password : LibC::Char*, lang : LibC::Char*, dbname : LibC::Char*) : Mapi
  fun mapi_disconnect(mid : Mapi) : Mapimsg
  fun mapi_reconnect(mid : Mapi) : Mapimsg
  fun mapi_ping(mid : Mapi) : Mapimsg
  fun mapi_error(mid : Mapi) : Mapimsg
  fun mapi_noexplain(mid : Mapi, errorprefix : LibC::Char*)
  struct X_IoFile
    _flags : LibC::Int
    _io_read_ptr : LibC::Char*
    _io_read_end : LibC::Char*
    _io_read_base : LibC::Char*
    _io_write_base : LibC::Char*
    _io_write_ptr : LibC::Char*
    _io_write_end : LibC::Char*
    _io_buf_base : LibC::Char*
    _io_buf_end : LibC::Char*
    _io_save_base : LibC::Char*
    _io_backup_base : LibC::Char*
    _io_save_end : LibC::Char*
    _markers : X_IoMarker*
    _chain : X_IoFile*
    _fileno : LibC::Int
    _flags2 : LibC::Int
    _old_offset : X__OffT
    _cur_column : LibC::UShort
    _vtable_offset : LibC::Char
    _shortbuf : LibC::Char[1]
    _lock : X_IoLockT*
    _offset : X__Off64T
    __pad1 : Void*
    __pad2 : Void*
    __pad3 : Void*
    __pad4 : Void*
    __pad5 : LibC::SizeT
    _mode : LibC::Int
    _unused2 : LibC::Char[20]
  end
  type File = X_IoFile
  struct X_IoMarker
    _next : X_IoMarker*
    _sbuf : X_IoFile*
    _pos : LibC::Int
  end
  alias X__OffT = LibC::Long
  alias X_IoLockT = Void
  alias X__Off64T = LibC::Long
  fun mapi_explain(mid : Mapi, fd : File*) : Mapimsg
  type Mapihdl = Void*
  fun mapi_explain_query(hdl : Mapihdl, fd : File*) : Mapimsg
  fun mapi_explain_result(hdl : Mapihdl, fd : File*) : Mapimsg
  fun mapi_trace(mid : Mapi, flag : LibC::Int) : Mapimsg
  fun mapi_get_trace(mid : Mapi) : LibC::Int
  fun mapi_get_autocommit(mid : Mapi) : LibC::Int
  fun mapi_log(mid : Mapi, nme : LibC::Char*) : Mapimsg
  fun mapi_setAutocommit(mid : Mapi, autocommit : LibC::Int) : Mapimsg
  fun mapi_set_size_header(mid : Mapi, value : LibC::Int) : Mapimsg
  fun mapi_release_id(mid : Mapi, id : LibC::Int) : Mapimsg
  fun mapi_next_result(hdl : Mapihdl) : Mapimsg
  fun mapi_needmore(hdl : Mapihdl) : Mapimsg
  fun mapi_more_results(hdl : Mapihdl) : LibC::Int
  fun mapi_new_handle(mid : Mapi) : Mapihdl
  fun mapi_close_handle(hdl : Mapihdl) : Mapimsg
  fun mapi_bind(hdl : Mapihdl, fnr : LibC::Int, ptr : LibC::Char**) : Mapimsg
  fun mapi_bind_var(hdl : Mapihdl, fnr : LibC::Int, type : LibC::Int, ptr : Void*) : Mapimsg
  fun mapi_bind_numeric(hdl : Mapihdl, fnr : LibC::Int, scale : LibC::Int, precision : LibC::Int, ptr : Void*) : Mapimsg
  fun mapi_clear_bindings(hdl : Mapihdl) : Mapimsg
  fun mapi_param_type(hdl : Mapihdl, fnr : LibC::Int, ctype : LibC::Int, sqltype : LibC::Int, ptr : Void*) : Mapimsg
  fun mapi_param_string(hdl : Mapihdl, fnr : LibC::Int, sqltype : LibC::Int, ptr : LibC::Char*, sizeptr : LibC::Int*) : Mapimsg
  fun mapi_param(hdl : Mapihdl, fnr : LibC::Int, ptr : LibC::Char**) : Mapimsg
  fun mapi_param_numeric(hdl : Mapihdl, fnr : LibC::Int, scale : LibC::Int, precision : LibC::Int, ptr : Void*) : Mapimsg
  fun mapi_clear_params(hdl : Mapihdl) : Mapimsg
  fun mapi_prepare(mid : Mapi, cmd : LibC::Char*) : Mapihdl
  fun mapi_prepare_handle(hdl : Mapihdl, cmd : LibC::Char*) : Mapimsg
  fun mapi_virtual_result(hdl : Mapihdl, columns : LibC::Int, columnnames : LibC::Char**, columntypes : LibC::Char**, columnlengths : LibC::Int*, tuplecount : LibC::Int, tuples : LibC::Char***) : Mapimsg
  fun mapi_execute(hdl : Mapihdl) : Mapimsg
  fun mapi_execute_array(hdl : Mapihdl, val : LibC::Char**) : Mapimsg
  fun mapi_fetch_reset(hdl : Mapihdl) : Mapimsg
  fun mapi_finish(hdl : Mapihdl) : Mapimsg
  fun mapi_prepare_array(mid : Mapi, cmd : LibC::Char*, val : LibC::Char**) : Mapihdl
  fun mapi_query(mid : Mapi, cmd : LibC::Char*) : Mapihdl
  fun mapi_query_handle(hdl : Mapihdl, cmd : LibC::Char*) : Mapimsg
  fun mapi_query_prep(mid : Mapi) : Mapihdl
  fun mapi_query_part(hdl : Mapihdl, cmd : LibC::Char*, size : LibC::SizeT) : Mapimsg
  fun mapi_query_done(hdl : Mapihdl) : Mapimsg
  fun mapi_quick_query(mid : Mapi, cmd : LibC::Char*, fd : File*) : Mapihdl
  fun mapi_query_array(mid : Mapi, cmd : LibC::Char*, val : LibC::Char**) : Mapihdl
  fun mapi_quick_query_array(mid : Mapi, cmd : LibC::Char*, val : LibC::Char**, fd : File*) : Mapihdl
  fun mapi_send(mid : Mapi, cmd : LibC::Char*) : Mapihdl
  fun mapi_read_response(hdl : Mapihdl) : Mapimsg
  fun mapi_stream_query(mid : Mapi, cmd : LibC::Char*, windowsize : LibC::Int) : Mapihdl
  fun mapi_cache_limit(mid : Mapi, limit : LibC::Int) : Mapimsg
  fun mapi_cache_shuffle(hdl : Mapihdl, percentage : LibC::Int) : Mapimsg
  fun mapi_cache_freeup(hdl : Mapihdl, percentage : LibC::Int) : Mapimsg
  fun mapi_quick_response(hdl : Mapihdl, fd : File*) : Mapimsg
  alias MapiInt64 = LibC::LongLong
  fun mapi_seek_row(hdl : Mapihdl, rowne : MapiInt64, whence : LibC::Int) : Mapimsg
  fun mapi_timeout(mid : Mapi, time : LibC::UInt) : Mapimsg
  fun mapi_fetch_row(hdl : Mapihdl) : LibC::Int
  fun mapi_fetch_all_rows(hdl : Mapihdl) : MapiInt64
  fun mapi_get_field_count(hdl : Mapihdl) : LibC::Int
  fun mapi_get_row_count(hdl : Mapihdl) : MapiInt64
  fun mapi_get_last_id(hdl : Mapihdl) : MapiInt64
  fun mapi_rows_affected(hdl : Mapihdl) : MapiInt64
  fun mapi_fetch_field_len(hdl : Mapihdl, fnr : LibC::Int) : LibC::SizeT
  fun mapi_store_field(hdl : Mapihdl, fnr : LibC::Int, outtype : LibC::Int, outparam : Void*) : Mapimsg
  fun mapi_split_line(hdl : Mapihdl) : LibC::Int
  fun mapi_is_connected(mid : Mapi) : LibC::Int
  fun mapi_get_len(hdl : Mapihdl, fnr : LibC::Int) : LibC::Int
  fun mapi_get_digits(hdl : Mapihdl, fnr : LibC::Int) : LibC::Int
  fun mapi_get_scale(hdl : Mapihdl, fnr : LibC::Int) : LibC::Int
  fun mapi_get_querytype(hdl : Mapihdl) : LibC::Int
  fun mapi_get_tableid(hdl : Mapihdl) : LibC::Int
  fun mapi_get_active(mid : Mapi) : Mapihdl
  
  # * / ** converted functions from mapi.h file
  
  fun mapi_resolve(host : LibC::Char*, port : LibC::Int, pattern : LibC::Char*) : LibC::Char*
  fun mapi_error_str(mid : Mapi) : LibC::Char*
  fun mapi_get_from(mid : Mapi) : LibC::Stream*
  fun mapi_get_to(mid : Mapi) : LibC::Stream*
  fun mapi_result_error(hdl : Mapihdl) : LibC::Char*
  fun mapi_fetch_field(hdl : Mapihdl, fnr : LibC::Int) : LibC::Char*
  fun mapi_fetch_field_array(hdl : Mapihdl) : LibC::Char*
  fun mapi_fetch_line(hdl : Mapihdl) : LibC::Char*
  fun mapi_get_lang(mid : Mapi) : LibC::Char*
  fun mapi_get_uri(mid : Mapi) : LibC::Char*
  fun mapi_get_dbname(mid : Mapi) : LibC::Char*
  fun mapi_get_host(mid : Mapi) : LibC::Char*
  fun mapi_get_user(mid : Mapi) : LibC::Char*
  fun mapi_get_mapi_version(mid : Mapi) : LibC::Char*
  fun mapi_get_monet_version(mid : Mapi) : LibC::Char*
  fun mapi_get_motd(mid : Mapi) : LibC::Char*
  fun mapi_get_table(hdl : Mapihdl, fnr : LibC::Int) : LibC::Char*
  fun mapi_get_name(hdl : Mapihdl, fnr : LibC::Int) : LibC::Char*
  fun mapi_get_type(hdl : Mapihdl, fnr : LibC::Int) : LibC::Char*
  fun mapi_get_query(hdl : Mapihdl, fnr : LibC::Int) : LibC::Char*
  fun mapi_quote(msg : LibC::Char*, size : LibC::Int) : LibC::Char*
  fun mapi_unquote(msg : LibC::Char*) : LibC::Char*

end
