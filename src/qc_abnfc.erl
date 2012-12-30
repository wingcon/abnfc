%%%-------------------------------------------------------------------
%%% @copyright 2012 Joseph Wayne Norton
%%% @author Joseph Wayne Norton <norton@alum.mit.edu>
%%% @doc
%%% @end
%%%-------------------------------------------------------------------
-module(qc_abnfc).

-ifdef(QC).

-include_lib("qc/include/qc.hrl").

%% API
-export([prop/1, prop/2, prop/3]).

%%====================================================================
%% API
%%====================================================================

prop(Module) ->
    prop(Module, list).

prop(Module, Type) ->
    Names = Module:names(),
    ?FORALL(Name, oneof(Names),
            prop(Module, Type, Name)).

prop(Module, Type, Name) ->
    ?FORALL(X, Module:generator(Name),
            try
                prop(Module, Type, Name, X)
            catch
                error:Y ->
                    Args = [?FILE, ?LINE, Name, X, Y, erlang:get_stacktrace()],
                    ?WHENFAIL(io:format("~n~p:~p ~p ~p -> ~p (~p)~n", Args), false)
            end).

%%====================================================================
%% Internal
%%====================================================================

prop(Module, list, Name, X) ->
    X1 = if is_list(X) -> lists:flatten(X); is_integer(X) -> [X] end,
    case Module:decode(Name, X1) of
        {ok,Y,[]} ->
            Y1 = if is_list(Y) -> Y; is_integer(Y) -> Y end,
            Res = X =:= Y1,
            Args = [?FILE, ?LINE, Name, X, Y],
            ?WHENFAIL(io:format("~n~p:~p ~p ~p -> ~p~n", Args), Res);
        Y ->
            Args = [?FILE, ?LINE, Name, X, Y],
            ?WHENFAIL(io:format("~n~p:~p ~p ~p -> ~p~n", Args), false)
    end;
prop(Module, binary, Name, X) ->
    case Module:decode(Name, X) of
        {ok,Y,<<>>} ->
            Y1 = if is_list(Y) -> list_to_binary(Y); is_integer(Y) -> list_to_binary([Y]) end,
            Res = X =:= Y1,
            Args = [?FILE, ?LINE, Name, X, Y],
            ?WHENFAIL(io:format("~n~p:~p ~p ~p -> ~p~n", Args), Res);
        Y ->
            Args = [?FILE, ?LINE, Name, X, Y],
            ?WHENFAIL(io:format("~n~p:~p ~p ~p -> ~p~n", Args), false)
    end.

-endif. %% -ifdef(QC).
