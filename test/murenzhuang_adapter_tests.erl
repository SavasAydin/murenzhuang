-module(murenzhuang_adapter_tests).

-include_lib("eunit/include/eunit.hrl").

input_is_atom_test_() ->
    {foreach,
     fun setup/0,
     fun cleanup/1,
     [
      fun root_feature_input_is_empty/1,
      fun feature_1_input_is_some_atom/1,
      fun feature_2_input_is_atom/1,
      fun feature_3_input_is_atom/1
     ]
    }.

root_feature_input_is_empty(FileHandler) ->
    fun() ->
	    group_leader(FileHandler, self()),
	    murenzhuang_adapter:feature(root, ''),
	    assert_feature(<<"">>, stdout)
    end.

feature_1_input_is_some_atom(FileHandler) ->
    fun() ->
	    group_leader(FileHandler, self()),
	    murenzhuang_adapter:feature(feature_1, 'a1b2'),
	    assert_feature(<<"">>, stdout)
    end.

feature_2_input_is_atom(FileHandler) ->
    fun() ->
	    group_leader(FileHandler, self()),
	    murenzhuang_adapter:feature(feature_2, '9z8y7'),
	    assert_feature(<<"yyyy9zz888">>, file_8)
    end.

feature_3_input_is_atom(FileHandler) ->
    fun() ->
	    group_leader(FileHandler, self()),
	    murenzhuang_adapter:feature(feature_3, 'ab01x'),
	    assert_feature(<<"z90">>, stdout)
    end.

setup() ->
    {ok, F} = file:open(stdout, [write]),
    F.

cleanup(F) ->
    file:close(F),
    file:delete(stdout).

assert_feature(ExpectedResult, File) ->
    ?assertEqual({ok, ExpectedResult}, file:read_file(File)).
