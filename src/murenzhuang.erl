-module(murenzhuang).
 
-export([feature/2]).

-define(FILE_8, file_8).
-define(FILE_53, file_53).

feature(Feature, Input) ->
    Output = get_mutator_result(Feature, Input),
    std_or_file_out(Feature, Output).

get_mutator_result(Feature, Input) ->
    MutatorFun = get_mutator(Feature),
    MutatorFun(Input).

get_mutator(Feature) ->
    proplists:get_value(Feature, which_mutator()).
   
which_mutator() ->
    [{root, fun no_mutator/1},
     {feature_1, fun mutator_copy/1},
     {feature_2, fun mutator_copy/1},
     {feature_3, fun mutator_decrease/1},
     {feature_4, fun mutator_sum/1}
    ].

std_or_file_out(Feature, Output) ->
    case get_file(Feature) of
	undefined ->
	    std_out(Output);
	File ->
	    file_out(File, Output)
    end.

get_file(Feature) ->
    proplists:get_value(Feature, which_file()).

which_file() ->
    [{feature_2, ?FILE_8}].
     
file_out(File, Output) ->
    file:write_file(File, Output).

std_out(Output) ->
    io:format("~s", [Output]).

no_mutator(Input) ->
    Input.

mutator_copy(Input) when length(Input) < 5 ->
    [];
mutator_copy([A,B,C,D,E | T]) ->
    [D,D,D,D,A,B,B,C,C,C] ++ mutator_copy([E | T]).

mutator_decrease(Input) when length(Input) < 4 ->
    [];
mutator_decrease([A,_,C,D | T]) ->
    lists:map(fun decrease/1, [A,C,D]) ++ mutator_decrease([D | T]).

decrease($0) ->
    $9;
decrease($a) ->
    $z;
decrease(X) ->
    X-1.


mutator_sum(Input) when length(Input) < 5 ->
    [];
mutator_sum([_,_,C,D,E | T]) -> 
    Reply = case {type(C), type(D)} of
		{int, int} ->
		    A =sum_integers([D,C]),
		    translate_int_to_ascii(A);
		{char, char} ->
		    B = sum_chars([D,C]),
		    translate_char_to_ascii(B);
		{int, char}->
		    [D,C];
		{char, int} ->
		    [D,C]
	    end,
    Reply ++ mutator_sum([E|T]).


type(X) when X >= $0 andalso X =< $9->
    int;
type(_) ->
    char.
    
sum_integers([D,C]) ->
    ((C rem 48) + (D rem 48)) rem 10.

translate_int_to_ascii(A) ->
    [A + 48].
    
sum_chars([D,C]) ->
    ((C rem 96) + (D rem 96)) rem 26.

translate_char_to_ascii(A) ->
    [A + 96].

