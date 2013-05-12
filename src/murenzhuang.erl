-module(murenzhuang).
 
-export([feature/2]).

-define(FILE_8, file_8).

feature(root, Input) ->
    io:format("~s", [Input]);
feature(feature_1, Input) ->
    Output = mutator_copy(Input),
    feature(root, Output);
feature(feature_2, Input) ->
    Output = mutator_copy(Input),
    file:write_file(?FILE_8, Output);
feature(feature_3, Input) ->
    Output = mutator_decrease(Input),
    feature(root, Output).

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

mutator_copy(Input) when length(Input) < 5 ->
    [];
mutator_copy([A,B,C,D,E | T]) ->
    [D,D,D,D,A,B,B,C,C,C] ++ mutator_copy([E | T]).
	 
  
    
