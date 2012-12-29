%%%-------------------------------------------------------------------
%%% @copyright 2009 Anders Nygren
%%% @author Anders Nygren <anders.nygren@gmail.com>
%%% @doc
%%% @end
%%%-------------------------------------------------------------------
-module(abnfc).

%% API
-export([file/1, file/2, parse/1, parse/2]).
-export([erlangcode/0]).

%%====================================================================
%% Types
%%====================================================================

-type filename() :: file:filename().
-type options() :: [verbose | {verbose,boolean()} | {parser,module()} | {prefix,atom()} | binary | list | {o,filename()} | {i,filename()} | {mod,module()} | noobj | {noobj,boolean()}].
-type text() :: string() | binary().

%%====================================================================
%% API
%%====================================================================
%%--------------------------------------------------------------------
%% @doc Compile an ABNF file.
%% @end
%%--------------------------------------------------------------------
-spec file(filename()) -> ok | {ok,module()} | error.
file(File) ->
    file(File,[]).

%%--------------------------------------------------------------------
%% @doc Compile an ABNF file.
%% @end
%%--------------------------------------------------------------------
-spec file(filename(), options()) -> ok | {ok,module()} | {error,Rest::term()} | error.
file(File, Opts) when is_list(Opts) ->
    {ok, Name, Text} = read_file(File),
    POpts = [],
    GenOpts = gen_opts(Name, Opts),
    COpts = compiler_opts(Opts),
    case parse(Text, POpts) of
        {ok, AST, []} ->
            AST1 = abnfc_ast:ast_to_int_form(AST),
            case proplists:get_bool(verbose,Opts) of
                true -> io:format("~p~n",[AST1]);
                false -> ok
            end,
            {ok, Code} = abnfc_gen:generate(AST1, GenOpts),
            {ok, GenFile} = write_file(Code, GenOpts ++ Opts),
            compile_file(GenFile, COpts, Opts);
        {ok, _AST, Rest} ->
            {error, Rest}
    end.

%%--------------------------------------------------------------------
%% @doc Parse a list or binary.
%% @end
%%--------------------------------------------------------------------
-spec parse(text()) -> {ok, AST::term(), Rest::term()}.
parse(Text) ->
    parse(Text, []).

%%--------------------------------------------------------------------
%% @doc Parse a list or binary.
%% @end
%%--------------------------------------------------------------------
-spec parse(text(), options()) -> {ok, AST::term(), Rest::term()}.
parse(Bin, Opts) when is_binary(Bin) ->
    parse(binary_to_list(Bin), Opts);

parse(String, Opts) when is_list(String) ->
    Parser = proplists:get_value(parser, parse_opts(Opts)),
    Parser:decode(rulelist, String).

%%--------------------------------------------------------------------
%% @doc Scan erlang code.
%% @end
%%--------------------------------------------------------------------
-spec erlangcode() -> fun(('eof' | string()) -> {ok, Abs::term(), Extra::binary()}).
erlangcode() ->
    fun (T) -> scan(T) end.

scan(Input) ->
    case erl_scan:tokens([], Input, 1) of
        {done, {ok, Toks, _EndLine}, Extra} ->
            {ok,Abs} = erl_parse:parse_exprs(Toks),
            {ok, Abs, Extra};
        {more, _Cont} ->
            throw(end_of_input)
    end.

%%====================================================================
%% Internal functions
%%====================================================================
read_file(File) ->
    case string:tokens(filename:basename(File), ".") of
        [Name,"set","abnf"] ->
            {ok, Files} = file:consult(File),
            {ok, Name, lists:flatten([read_file1(F) || F <- Files])};
        [Name, "abnf"] ->
            {ok, Name, read_file1(File)}
    end.

read_file1(File) ->
    {ok, Bin} = file:read_file(File),
    binary_to_list(Bin).

parse_opts(Opts) ->
    Parser = proplists:get_value(parser, Opts, abnfc_rfc4234),
    [{parser,Parser}].

gen_opts(Name, Opts) ->
    Mod = proplists:get_value(mod, Opts, Name),
    Prefix = proplists:get_value(prefix, Opts, ''),
    Type = case proplists:get_bool(binary, Opts) of
               true -> binary;
               false -> list
           end,
    Verbose = proplists:get_bool(verbose,Opts),
    [{mod,Mod},{prefix,Prefix},{verbose,Verbose},Type].

compiler_opts(Opts) ->
    OutDir = proplists:get_value(o, Opts, "./"),
    IncludeDirs = [{i,Dir}||Dir <- proplists:get_all_values(i, Opts)],
    [report,{outdir,OutDir}|IncludeDirs].

write_file(Code, Opts) ->
    Name = filename:join(proplists:get_value(o, Opts, "."),
                         proplists:get_value(mod, Opts))++".erl",

    maybe_write("abnfc: writing to ~p~n",[Name],Opts),
    ok = file:write_file(Name, Code),
    ok = erl_tidy:file(Name,[{paper, 95},{backups,false}]),
    {ok,Name}.

compile_file(File, COpts, MyOpts) ->
    maybe_write("abnfc: compiling ~p opts = ~p~n",[File, COpts],MyOpts),
    case proplists:get_bool(noobj,MyOpts) of
        true -> ok;
        false -> compile:file(File, COpts)
    end.

maybe_write(Fmt,Args,Opts) ->
    case proplists:get_bool(verbose,Opts) of
        true -> io:format(Fmt,Args);
        false -> ok
    end.
