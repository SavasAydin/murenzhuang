-module(murenzhuang_adapter).

-export([feature/2,adapt/1]).

feature(Feature, Input) ->
    AdaptedInput = adapt(Input),
    murenzhuang:feature(Feature, AdaptedInput).
 
adapt(Input) when is_atom(Input) ->
    atom_to_list(Input);
adapt(Input) ->
    Input.
