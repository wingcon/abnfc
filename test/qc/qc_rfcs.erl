%%%-------------------------------------------------------------------
%%% @copyright 2012 Joseph Wayne Norton
%%% @author Joseph Wayne Norton <norton@alum.mit.edu>
%%% @doc
%%% @end
%%%-------------------------------------------------------------------
-module(qc_rfcs).

-ifdef(QC).

-include_lib("qc/include/qc.hrl").

-export([run/0]).
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

prop_rfc3629_list() ->
    qc_abnfc:prop(rfc3629_list, list).

prop_rfc3629_binary() ->
    qc_abnfc:prop(rfc3629_binary, binary).

prop_rfc4234_core() ->
    qc_abnfc:prop(rfc4234_core).

prop_rfc4234ext_core() ->
    qc_abnfc:prop(rfc4234ext_core).

-endif. %% -ifdef(QC).
