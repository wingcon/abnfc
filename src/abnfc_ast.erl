%%%-------------------------------------------------------------------
%%% @copyright 2009 Anders Nygren
%%% @author Anders Nygren <anders.nygren@gmail.com>
%%% @author Joseph Wayne Norton <norton@alum.mit.edu>
%%% @doc
%%% @end
%%%-------------------------------------------------------------------
-module(abnfc_ast).

%% API
%%-export([transform/2]).
-compile(export_all).

-include("abnfc_ast.hrl").

%%====================================================================
%% API
%%====================================================================
%%--------------------------------------------------------------------
%% @spec (AST) -> INT_FORM
%% @doc Transform an AST to the intermediate format.
%% @end
%%--------------------------------------------------------------------
ast_to_int_form(#rulelist{rules=Rules}) ->
    [R#rule{body=int_form(R#rule.body)}||R <- Rules].

%%--------------------------------------------------------------------
%% @spec (INT_FORM) -> DGH_FORM
%% @doc Transform an intermediate format to the digraph format.
%% @end
%%--------------------------------------------------------------------
int_to_dgh_form(INT) ->
    G    = dgh_new(),
    Root = dgh_new_vertex(G, []),
    Vs   = [{R,dgh_new_vertex(G, R#rule.name)}||R <- INT],
    Es   = [dgh_new_edge(G, Root, R, V)||{R,V} <- Vs],
    _    = [dgh_form(G,E)||E <- Es],
    G.

%%--------------------------------------------------------------------
%% @spec (DGH_FORM) -> true
%% @doc Delete a digraph format.
%% @end
%%--------------------------------------------------------------------
delete_dgh_form(G) ->
    digraph:delete(G).

%%====================================================================
%% Internal functions
%%====================================================================

int_form(#rule{body=Body}=R) ->
    R#rule{body=int_form(Body)};
int_form(#alt{alts=Alts}=A) ->
    Alts1 = [int_form(Alt)||Alt <- Alts],
    case int_char_alts(Alts1) of
        [C] when is_record(C,char_alt) ->
            C;
        Alts2 ->
            A#alt{alts=Alts2}
    end;
int_form(#seq{elements=Elems}=S) ->
    Elems1 = [int_form(Elem)||Elem <- Elems],
    S#seq{elements=Elems1};
int_form(#repeat{body=Body}=R) ->
    R#repeat{body=int_form(Body)};
int_form(Element) ->
    Element.

int_char_alts(Alts) ->
    int_char_alts(Alts, {[],[]}).

int_char_alts([Alt|Alts], {Chars,Others}) when is_record(Alt, char_val);
                                               is_record(Alt, char_range) ->
    int_char_alts(Alts,{Chars++[Alt], Others});
int_char_alts([Alt|Alts], {Chars,Others}) ->
    int_char_alts(Alts,{Chars, Others++[Alt]});
int_char_alts([], {[], Others}) ->
    Others;
int_char_alts([], {Chars, Others}) ->
    Merged = int_merge_alts(Chars),
    [#char_alt{alts=Merged}|Others].

int_cmp_chars(#char_val{value=V},#char_range{from=F,to=_T}) when V =< F ->
    true;
int_cmp_chars(#char_range{from=_F,to=T},#char_val{value=V}) when T =< V->
    true;
int_cmp_chars(X,Y) ->
    X =< Y.

int_merge_alts(Chars) ->
    [A|As]=lists:sort(fun int_cmp_chars/2, Chars),
    int_sort_alts(lists:foldl(fun int_merge_alts/2, [A], As)).

int_merge_alts(#char_val{value=V}, [#char_val{value=Prev}|Acc]) when V==Prev+1 ->
    [#char_range{from=Prev,to=V}|Acc];
int_merge_alts(#char_val{}=N, [#char_val{}|_]=Acc) ->
    [N|Acc];
int_merge_alts(#char_val{value=V}, [#char_range{from=From,to=To}|Acc]) when V==To+1 ->
    [#char_range{from=From,to=V}|Acc];
int_merge_alts(#char_val{}=N, [#char_range{}|_]=Acc) ->
    [N|Acc];
int_merge_alts(#char_range{from=F1,to=T1}, [#char_val{value=V}|Acc]) when F1==V+1 ->
    [#char_range{from=V,to=T1}|Acc];
int_merge_alts(#char_range{}=N, [#char_val{}|_]=Acc) ->
    [N|Acc];

int_merge_alts(#char_range{from=F1,to=T1}, [#char_range{from=From,to=To}|Acc]) when F1==To+1 ->
    [#char_range{from=From,to=T1}|Acc];
int_merge_alts(#char_range{}=N, [#char_range{}|_]=Acc) ->
    [N|Acc].

int_sort_alts(Alts) ->
    lists:reverse([A||{_,A} <- lists:keysort(1,[{int_range_size(A),A}||A<-Alts])]).

int_range_size(#char_range{from=F,to=T}) ->
    T-F+1;
int_range_size(#char_val{}) ->
    1.

dgh_form(G, {_,_,V,#rule{body=Body}}) ->
    dgh_form(G, dgh_new_edge(G, V, Body));
dgh_form(G, {_,_,V,#alt{alts=Alts}}) ->
    [dgh_form(G, dgh_new_edge(G, V, Alt, dgh_new_vertex(G, [N|V])))||{Alt,N} <- lists:zip(Alts,lists:seq(1,length(Alts)))];
dgh_form(G, {_,_,V,#seq{elements=Elems}}) ->
    [dgh_form(G, dgh_new_edge(G, V, Elem, dgh_new_vertex(G, [N|V])))||{Elem,N} <- lists:zip(Elems,lists:seq(1,length(Elems)))];
dgh_form(G, {_,_,V,#repeat{body=Body}}) ->
    dgh_form(G, dgh_new_edge(G, V, Body));
dgh_form(G, {_,_,V,#rulename{name=N}}) ->
    dgh_new_edge(G, V, [], N);
dgh_form(_G, {_,_,_,C}) when is_record(C, char_val);
                             is_record(C, char_range);
                             is_record(C, char_alt);
                             is_record(C, char_seq) ->
    true.

dgh_new() ->
    digraph:new().

dgh_new_vertex(G) ->
    digraph:add_vertex(G).

dgh_new_vertex(G, Id) ->
    digraph:add_vertex(G, Id).

dgh_new_edge(G, From, Label) ->
    To = dgh_new_vertex(G),
    digraph:edge(G, digraph:add_edge(G, From, To, Label)).

dgh_new_edge(G, From, Label, To) ->
    digraph:edge(G, digraph:add_edge(G, From, To, Label)).

%%====================================================================
%% Test functions
%%====================================================================
