-module(murenzhuang_adapter).

-export([root/1,
	feature_1/1,
	feature_2/1,
	feature_3/1
	]).


root(Input) ->
    AdaptedInput = adapt(Input),
    murenzhuang:feature(root, AdaptedInput).

feature_1(Input) ->
    AdaptedInput = adapt(Input),
    murenzhuang:feature(feature_1, AdaptedInput).

feature_2(Input) ->
    AdaptedInput = adapt(Input),
    murenzhuang:feature(feature_2, AdaptedInput).

feature_3(Input) ->
    AdaptedInput = adapt(Input),
    murenzhuang:feature(feature_3, AdaptedInput).
 
adapt(Input) when is_atom(Input) ->
    atom_to_list(Input);
adapt(Input) ->
    Input.
