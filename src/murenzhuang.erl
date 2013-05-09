-module(murenzhuang).
 
-export([feature/2]).

feature(root, Input) ->
    io:format("~s", [Input]).
