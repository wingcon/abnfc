%%% Do not modify this file, it is automatically generated by abnfc.
%%% All changes will be lost when it is regenerated.
%%% Generated by abnfc_gen on 2013-01-19 18:58:21

-module(rfc4234_core).

-ifdef('QC').

-include_lib("qc/include/qc.hrl").

-endif.

-export([names/0]).

-export(['ALPHA'/0, 'BIT'/0, 'CHAR'/0, 'CR'/0, 'CRLF'/0,
	 'CTL'/0, 'DIGIT'/0, 'DQUOTE'/0, 'HEXDIG'/0, 'HTAB'/0,
	 'LF'/0, 'LWSP'/0, 'OCTET'/0, 'SP'/0, 'VCHAR'/0, 'WSP'/0,
	 decode/2]).

-ifdef('QC').

-export(['ALPHA_generator'/1, 'BIT_generator'/1,
	 'CHAR_generator'/1, 'CRLF_generator'/1,
	 'CR_generator'/1, 'CTL_generator'/1,
	 'DIGIT_generator'/1, 'DQUOTE_generator'/1,
	 'HEXDIG_generator'/1, 'HTAB_generator'/1,
	 'LF_generator'/1, 'LWSP_generator'/1,
	 'OCTET_generator'/1, 'SP_generator'/1,
	 'VCHAR_generator'/1, 'WSP_generator'/1, generator/1]).

-endif.

-include("rfc4234_core.hrl").

names() ->
    ['ALPHA', 'BIT', 'CHAR', 'CR', 'CRLF', 'CTL', 'DIGIT',
     'DQUOTE', 'HEXDIG', 'HTAB', 'LF', 'LWSP', 'OCTET', 'SP',
     'VCHAR', 'WSP'].

decode('ALPHA', Str) -> ('ALPHA'())(Str);
decode('BIT', Str) -> ('BIT'())(Str);
decode('CHAR', Str) -> ('CHAR'())(Str);
decode('CR', Str) -> ('CR'())(Str);
decode('CRLF', Str) -> ('CRLF'())(Str);
decode('CTL', Str) -> ('CTL'())(Str);
decode('DIGIT', Str) -> ('DIGIT'())(Str);
decode('DQUOTE', Str) -> ('DQUOTE'())(Str);
decode('HEXDIG', Str) -> ('HEXDIG'())(Str);
decode('HTAB', Str) -> ('HTAB'())(Str);
decode('LF', Str) -> ('LF'())(Str);
decode('LWSP', Str) -> ('LWSP'())(Str);
decode('OCTET', Str) -> ('OCTET'())(Str);
decode('SP', Str) -> ('SP'())(Str);
decode('VCHAR', Str) -> ('VCHAR'())(Str);
decode('WSP', Str) -> ('WSP'())(Str).

-ifdef('QC').

generator('ALPHA') -> 'ALPHA_generator'(0);
generator('BIT') -> 'BIT_generator'(0);
generator('CHAR') -> 'CHAR_generator'(0);
generator('CR') -> 'CR_generator'(0);
generator('CRLF') -> 'CRLF_generator'(0);
generator('CTL') -> 'CTL_generator'(0);
generator('DIGIT') -> 'DIGIT_generator'(0);
generator('DQUOTE') -> 'DQUOTE_generator'(0);
generator('HEXDIG') -> 'HEXDIG_generator'(0);
generator('HTAB') -> 'HTAB_generator'(0);
generator('LF') -> 'LF_generator'(0);
generator('LWSP') -> 'LWSP_generator'(0);
generator('OCTET') -> 'OCTET_generator'(0);
generator('SP') -> 'SP_generator'(0);
generator('VCHAR') -> 'VCHAR_generator'(0);
generator('WSP') -> 'WSP_generator'(0).

-endif.

'ALPHA'() ->
    fun ([C | Tl]) when (C >= 65) and (C =< 90) ->
	    {ok, C, Tl};
	([C | Tl]) when (C >= 97) and (C =< 122) -> {ok, C, Tl};
	(_) -> fail
    end.

'BIT'() ->
    fun ([C | Tl]) when (C >= 48) and (C =< 49) ->
	    {ok, C, Tl};
	(_) -> fail
    end.

'CHAR'() ->
    fun ([C | Tl]) when (C >= 1) and (C =< 127) ->
	    {ok, C, Tl};
	(_) -> fail
    end.

'CR'() ->
    fun ([13 | Tl]) -> {ok, 13, Tl};
	(_) -> fail
    end.

'CRLF'() ->
    '__alt'(['LF'(), '__seq'(['CR'(), 'LF'()])]).

'CTL'() ->
    fun ([C | Tl]) when (C >= 0) and (C =< 31) ->
	    {ok, C, Tl};
	([C | Tl]) when C == 127 -> {ok, C, Tl};
	(_) -> fail
    end.

'DIGIT'() ->
    fun ([C | Tl]) when (C >= 48) and (C =< 57) ->
	    {ok, C, Tl};
	(_) -> fail
    end.

'DQUOTE'() ->
    fun ([34 | Tl]) -> {ok, 34, Tl};
	(_) -> fail
    end.

'HEXDIG'() ->
    '__alt'(['DIGIT'(),
	     fun ([C | Tl]) when C == 97 -> {ok, C, Tl};
		 ([C | Tl]) when C == 65 -> {ok, C, Tl};
		 (_) -> fail
	     end,
	     fun ([C | Tl]) when C == 98 -> {ok, C, Tl};
		 ([C | Tl]) when C == 66 -> {ok, C, Tl};
		 (_) -> fail
	     end,
	     fun ([C | Tl]) when C == 99 -> {ok, C, Tl};
		 ([C | Tl]) when C == 67 -> {ok, C, Tl};
		 (_) -> fail
	     end,
	     fun ([C | Tl]) when C == 100 -> {ok, C, Tl};
		 ([C | Tl]) when C == 68 -> {ok, C, Tl};
		 (_) -> fail
	     end,
	     fun ([C | Tl]) when C == 101 -> {ok, C, Tl};
		 ([C | Tl]) when C == 69 -> {ok, C, Tl};
		 (_) -> fail
	     end,
	     fun ([C | Tl]) when C == 102 -> {ok, C, Tl};
		 ([C | Tl]) when C == 70 -> {ok, C, Tl};
		 (_) -> fail
	     end]).

'HTAB'() ->
    fun ([9 | Tl]) -> {ok, 9, Tl};
	(_) -> fail
    end.

'LF'() ->
    fun ([10 | Tl]) -> {ok, 10, Tl};
	(_) -> fail
    end.

'LWSP'() ->
    '__repeat'(0, infinity,
	       '__alt'(['WSP'(), '__seq'(['CRLF'(), 'WSP'()])])).

'OCTET'() ->
    fun ([C | Tl]) when (C >= 0) and (C =< 255) ->
	    {ok, C, Tl};
	(_) -> fail
    end.

'SP'() ->
    fun ([32 | Tl]) -> {ok, 32, Tl};
	(_) -> fail
    end.

'VCHAR'() ->
    fun ([C | Tl]) when (C >= 33) and (C =< 126) ->
	    {ok, C, Tl};
	(_) -> fail
    end.

'WSP'() -> '__alt'(['SP'(), 'HTAB'()]).

-ifdef('QC').

'ALPHA_generator'(Depth) when Depth >= 0 ->
    ?'LET'(V4,
	   (?'LET'(V3,
		   (oneof([?'LET'(V1, (choose(65, 90)), V1),
			   ?'LET'(V2, (choose(97, 122)), V2)])),
		   V3)),
	   V4).

'BIT_generator'(Depth) when Depth >= 0 ->
    ?'LET'(V3,
	   (?'LET'(V2, (oneof([?'LET'(V1, (choose(48, 49)), V1)])),
		   V2)),
	   V3).

'CHAR_generator'(Depth) when Depth >= 0 ->
    ?'LET'(V2, (?'LET'(V1, (choose(1, 127)), V1)), V2).

'CR_generator'(Depth) when Depth >= 0 ->
    ?'LET'(V2, (?'LET'(V1, 13, V1)), V2).

'CRLF_generator'(Depth) when Depth >= 0 ->
    ?'LET'(V10,
	   (?'LET'(V9,
		   ('__terminals_oneof_generator'(Depth, 10,
						  [?'SIZED'(V5,
							    (resize(erlang:round(math:sqrt(V5)),
								    'LF_generator'(Depth +
										     1)))),
						   ?'LET'(V8,
							  ('__seq_generator'([?'SIZED'(V6,
										       (resize(erlang:round(math:sqrt(V6)),
											       'CR_generator'(Depth
														+
														1)))),
									      ?'SIZED'(V7,
										       (resize(erlang:round(math:sqrt(V7)),
											       'LF_generator'(Depth
														+
														1))))])),
							  V8)],
						  [?'SIZED'(V1,
							    (resize(erlang:round(math:sqrt(V1)),
								    'LF_generator'(Depth +
										     1)))),
						   ?'LET'(V4,
							  ('__seq_generator'([?'SIZED'(V2,
										       (resize(erlang:round(math:sqrt(V2)),
											       'CR_generator'(Depth
														+
														1)))),
									      ?'SIZED'(V3,
										       (resize(erlang:round(math:sqrt(V3)),
											       'LF_generator'(Depth
														+
														1))))])),
							  V4)])),
		   V9)),
	   V10).

'CTL_generator'(Depth) when Depth >= 0 ->
    ?'LET'(V4,
	   (?'LET'(V3,
		   (oneof([?'LET'(V1, (choose(0, 31)), V1),
			   ?'LET'(V2, 127, V2)])),
		   V3)),
	   V4).

'DIGIT_generator'(Depth) when Depth >= 0 ->
    ?'LET'(V2, (?'LET'(V1, (choose(48, 57)), V1)), V2).

'DQUOTE_generator'(Depth) when Depth >= 0 ->
    ?'LET'(V2, (?'LET'(V1, 34, V1)), V2).

'HEXDIG_generator'(Depth) when Depth >= 0 ->
    ?'LET'(V40,
	   (?'LET'(V39,
		   ('__terminals_oneof_generator'(Depth, 10,
						  [?'SIZED'(V20,
							    (resize(erlang:round(math:sqrt(V20)),
								    'DIGIT_generator'(Depth +
											1)))),
						   ?'LET'(V23,
							  (oneof([?'LET'(V21, 97, V21),
								  ?'LET'(V22, 65, V22)])),
							  V23),
						   ?'LET'(V26,
							  (oneof([?'LET'(V24, 98, V24),
								  ?'LET'(V25, 66, V25)])),
							  V26),
						   ?'LET'(V29,
							  (oneof([?'LET'(V27, 99, V27),
								  ?'LET'(V28, 67, V28)])),
							  V29),
						   ?'LET'(V32,
							  (oneof([?'LET'(V30, 100, V30),
								  ?'LET'(V31, 68, V31)])),
							  V32),
						   ?'LET'(V35,
							  (oneof([?'LET'(V33, 101, V33),
								  ?'LET'(V34, 69, V34)])),
							  V35),
						   ?'LET'(V38,
							  (oneof([?'LET'(V36, 102, V36),
								  ?'LET'(V37, 70, V37)])),
							  V38)],
						  [?'SIZED'(V1,
							    (resize(erlang:round(math:sqrt(V1)),
								    'DIGIT_generator'(Depth +
											1)))),
						   ?'LET'(V4,
							  (oneof([?'LET'(V2, 97, V2),
								  ?'LET'(V3, 65, V3)])),
							  V4),
						   ?'LET'(V7,
							  (oneof([?'LET'(V5, 98, V5),
								  ?'LET'(V6, 66, V6)])),
							  V7),
						   ?'LET'(V10,
							  (oneof([?'LET'(V8, 99, V8),
								  ?'LET'(V9, 67, V9)])),
							  V10),
						   ?'LET'(V13,
							  (oneof([?'LET'(V11, 100, V11),
								  ?'LET'(V12, 68, V12)])),
							  V13),
						   ?'LET'(V16,
							  (oneof([?'LET'(V14, 101, V14),
								  ?'LET'(V15, 69, V15)])),
							  V16),
						   ?'LET'(V19,
							  (oneof([?'LET'(V17, 102, V17),
								  ?'LET'(V18, 70, V18)])),
							  V19)])),
		   V39)),
	   V40).

'HTAB_generator'(Depth) when Depth >= 0 ->
    ?'LET'(V2, (?'LET'(V1, 9, V1)), V2).

'LF_generator'(Depth) when Depth >= 0 ->
    ?'LET'(V2, (?'LET'(V1, 10, V1)), V2).

'LWSP_generator'(Depth) when Depth >= 0 ->
    ?'LET'(V11,
	   (?'LET'(V10,
		   ('__repeat_generator'(0, infinity,
					 ?'LET'(V9,
						('__terminals_oneof_generator'(Depth, 10,
									       [?'SIZED'(V5,
											 (resize(erlang:round(math:sqrt(V5)),
												 'WSP_generator'(Depth
														   +
														   1)))),
										?'LET'(V8,
										       ('__seq_generator'([?'SIZED'(V6,
														    (resize(erlang:round(math:sqrt(V6)),
															    'CRLF_generator'(Depth
																	       +
																	       1)))),
													   ?'SIZED'(V7,
														    (resize(erlang:round(math:sqrt(V7)),
															    'WSP_generator'(Depth
																	      +
																	      1))))])),
										       V8)],
									       [?'SIZED'(V1,
											 (resize(erlang:round(math:sqrt(V1)),
												 'WSP_generator'(Depth
														   +
														   1)))),
										?'LET'(V4,
										       ('__seq_generator'([?'SIZED'(V2,
														    (resize(erlang:round(math:sqrt(V2)),
															    'CRLF_generator'(Depth
																	       +
																	       1)))),
													   ?'SIZED'(V3,
														    (resize(erlang:round(math:sqrt(V3)),
															    'WSP_generator'(Depth
																	      +
																	      1))))])),
										       V4)])),
						V9))),
		   V10)),
	   V11).

'OCTET_generator'(Depth) when Depth >= 0 ->
    ?'LET'(V2, (?'LET'(V1, (choose(0, 255)), V1)), V2).

'SP_generator'(Depth) when Depth >= 0 ->
    ?'LET'(V2, (?'LET'(V1, 32, V1)), V2).

'VCHAR_generator'(Depth) when Depth >= 0 ->
    ?'LET'(V2, (?'LET'(V1, (choose(33, 126)), V1)), V2).

'WSP_generator'(Depth) when Depth >= 0 ->
    ?'LET'(V6,
	   (?'LET'(V5,
		   ('__terminals_oneof_generator'(Depth, 10,
						  [?'SIZED'(V3,
							    (resize(erlang:round(math:sqrt(V3)),
								    'SP_generator'(Depth +
										     1)))),
						   ?'SIZED'(V4,
							    (resize(erlang:round(math:sqrt(V4)),
								    'HTAB_generator'(Depth +
										       1))))],
						  [?'SIZED'(V1,
							    (resize(erlang:round(math:sqrt(V1)),
								    'SP_generator'(Depth +
										     1)))),
						   ?'SIZED'(V2,
							    (resize(erlang:round(math:sqrt(V2)),
								    'HTAB_generator'(Depth +
										       1))))])),
		   V5)),
	   V6).

-endif.

'__alt'(Ps) -> fun (T) -> '__do_alt'(Ps, T) end.

'__do_alt'([P | Ps], T) ->
    case P(T) of
      {ok, _R, _T1} = Res -> Res;
      fail -> '__do_alt'(Ps, T)
    end;
'__do_alt'([], _) -> fail.

'__repeat'(Min, Max, P) -> '__repeat'(Min, Max, P, 0).

'__repeat'(Min, Max, P, Found) ->
    fun (T) -> '__do_repeat'(Min, Max, P, Found, T) end.

'__do_repeat'(Min, Max, P, Found, T) ->
    case P(T) of
      {ok, R1, T1} when Max == Found + 1 -> {ok, [R1], T1};
      {ok, R1, T1} ->
	  case '__do_repeat'(Min, Max, P, Found + 1, T1) of
	    {ok, R2, T2} -> {ok, [R1 | R2], T2};
	    fail when Found >= Min -> {ok, [R1], T1};
	    fail -> fail
	  end;
      fail when Found >= Min -> {ok, [], T};
      fail -> fail
    end.

'__seq'(Ps) -> fun (T) -> '__do_seq'(Ps, T) end.

'__do_seq'([P | Ps], T) ->
    case P(T) of
      {ok, R1, T1} ->
	  case '__do_seq'(Ps, T1) of
	    {ok, R2, T2} -> {ok, [R1 | R2], T2};
	    fail -> fail
	  end;
      fail -> fail
    end;
'__do_seq'([], T) -> {ok, [], T}.

-ifdef('QC').

'__repeat_generator'(Min, Max, G) ->
    ?'SIZED'(Size,
	     begin
	       MAX = if Max /= infinity -> Max;
			true -> Size
		     end,
	       ?'LET'(K,
		      if Min >= MAX -> Min;
			 true -> choose(Min, MAX)
		      end,
		      (vector(K, G)))
	     end).

-endif.

-ifdef('QC').

'__seq_generator'(Gs) -> '__do_seq_generator'(Gs, []).

-endif.

-ifdef('QC').

'__do_seq_generator'([], Acc) -> lists:reverse(Acc);
'__do_seq_generator'([H | T], Acc) ->
    ?'LET'(K, H, ('__do_seq_generator'(T, [K | Acc]))).

-endif.

-ifdef('QC').

'__terminals_oneof_generator'(Depth, Limit, AltsT,
			      Alts) ->
    ?'SIZED'(Size,
	     (?'LET'(Choose, (choose(0, Limit)),
		     case Depth of
		       Depth when Depth >= Size + Choose -> oneof(AltsT);
		       _ -> oneof(Alts)
		     end))).

-endif.
