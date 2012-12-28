%%%-------------------------------------------------------------------
%%% @copyright 2012 Joseph Wayne Norton
%%% @author Joseph Wayne Norton <norton@alum.mit.edu>
%%% @doc
%%% @end
%%%-------------------------------------------------------------------
-module(qc_unicode).

-ifdef(QC).

-include_lib("qc/include/qc.hrl").

-compile(export_all).

%% run from eunit
eunit_test_() ->
    qc:eunit_module(?MODULE, 5000).

run() ->
    run(5000).

run(NumTests) ->
    qc:module({numtests,NumTests}, ?MODULE).

%%====================================================================
%% Properties
%%====================================================================

prop_roundtrip() ->
    ?FORALL(X, rfc3629_binary:generator('UTF8-octets'),
            try
                prop_roundtrip(X)
            catch
                error:Y ->
                    Args = [?FILE, ?LINE, X, Y, erlang:get_stacktrace()],
                    ?WHENFAIL(io:format("~n~p:~p ~p -> ~p (~p)~n", Args), false)
            end).

%%====================================================================
%% Internal
%%====================================================================

prop_roundtrip(X) ->
    case unicode:characters_to_list(X, utf8) of
        Y when is_list(Y) ->
            case unicode:characters_to_binary(Y, unicode, utf8) of
                Z when is_binary(Z) ->
                    case rfc3629_binary:decode('UTF8-octets', Z) of
                        {ok, A, <<>>} ->
                            A1 = if is_list(A) -> list_to_binary(A); is_integer(A) -> list_to_binary([A]) end,
                            Res = X =:= A1,
                            Args = [?FILE, ?LINE, X, Z, A1],
                            ?WHENFAIL(io:format("~n~p:~p ~p -> ~p -> ~p~n", Args), Res);
                        A ->
                            Args = [?FILE, ?LINE, X, Z, A],
                            ?WHENFAIL(io:format("~n~p:~p ~p -> ~p -> ~p~n", Args), false)
                    end;
                Z ->
                    Args = [?FILE, ?LINE, X, Z],
                    ?WHENFAIL(io:format("~n~p:~p ~p -> ~p~n", Args), false)
            end;
        Y ->
            Args = [?FILE, ?LINE, X, Y],
            ?WHENFAIL(io:format("~n~p:~p ~p -> ~p~n", Args), false)
    end.

-endif. %% -ifdef(QC).
