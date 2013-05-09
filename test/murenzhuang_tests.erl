-module(murenzhuang_tests).

-include_lib("eunit/include/eunit.hrl").

all_feature_test_() ->
    {foreach,
     fun setup/0,
     fun cleanup/1,
     [
      fun root_feature_empty_list/1,
      fun root_feature_some_letters_and_numbers/1
     ]
    }.

root_feature_empty_list(FileHandler) ->
    fun() ->
	    group_leader(FileHandler, self()),
	    murenzhuang:feature(root, ""),
	    assert_feature(<<"">>, stdout)
    end.

root_feature_some_letters_and_numbers(FileHandler) ->
    fun() ->
	    group_leader(FileHandler, self()),
	    murenzhuang:feature(root, "abc123"),
	    assert_feature(<<"abc123">>, stdout)
    end.

setup() ->
    {ok, F} = file:open(stdout, [write]),
    F.

cleanup(F) ->
    file:close(F),
    file:delete(stdout).

assert_feature(ExpectedResult, File) ->
    ?assertEqual({ok, ExpectedResult}, file:read_file(File)).
    
