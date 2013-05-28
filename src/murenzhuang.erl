-module(murenzhuang).
 
-export([feature/2]).

-define(FILE_8, file_8).

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
     {feature_3, fun mutator_decrease/1}
    ].

std_or_file_out(Feature, Output) ->
    case get_file(Feature) of
	undefined ->
	    io:format("~s", [Output]);
	File ->
	    file:write_file(File, Output)
    end.

get_file(Feature) ->
    proplists:get_value(Feature, which_file()).

which_file() ->
    [{feature_2, ?FILE_8}].

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


  
    
