-module(murenzhuang_tests).

-include_lib("eunit/include/eunit.hrl").

all_feature_test_() ->
    {foreach,
     fun setup/0,
     fun cleanup/1,
     [
      fun root_feature_input_is_empty_list/1,
      fun root_feature_input_contains_letters_and_numbers/1,
      fun feature_1_input_is_empty_list/1,
      fun feature_1_input_size_less_than_one_transform_trigger/1,
      fun feature_1_input_size_allows_one_transform/1,
      fun feature_1_input_size_greater_than_one_transform_trigger/1,
      fun feature_1_input_size_allows_two_transforms/1,
      fun feature_2_input_is_empty_list/1,
      fun feature_2_input_size_not_allow_transform_execution/1,
      fun feature_2_input_size_allows_one_transform/1,
      fun feature_3_input_is_empty_list/1,
      fun feature_3_input_size_less_than_one_transform_trigger/1,
      fun feature_3_no_boundry_input_and_size_allows_one_transform/1,
      fun feature_3_boundry_input_and_size_allows_one_transform/1,
      fun feature_3_mix_input_and_size_greater_than_one_transform_trigger/1,
      fun feature_4_input_is_empty_list/1,
      fun feature_4_input_size_less_than_one_transform_trigger/1,
      fun feature_4_only_integer_input_and_size_allows_one_transform/1,
      fun feature_4_only_character_input_and_size_allows_one_transform/1,
      fun feature_4_mix_input_and_allows_one_transform/1,
      fun feature_4_boundry_input_and_size_allows_one_transform/1,
      fun feature_4_input_size_allows_two_transforms/1
     ]
    }.

root_feature_input_is_empty_list(FileHandler) ->
    fun() ->
	    group_leader(FileHandler, self()),
	    murenzhuang:feature(root, ""),
	    assert_feature(<<"">>, stdout)
    end.

root_feature_input_contains_letters_and_numbers(FileHandler) ->
    fun() ->
	    group_leader(FileHandler, self()),
	    murenzhuang:feature(root, "abc123"),
	    assert_feature(<<"abc123">>, stdout)
    end.

feature_1_input_is_empty_list(FileHandler) ->
    fun() ->
	    group_leader(FileHandler, self()),
	    murenzhuang:feature(feature_1, ""),
	    assert_feature(<<"">>, stdout)
    end.

feature_1_input_size_less_than_one_transform_trigger(FileHandler) ->
    fun() ->
	    group_leader(FileHandler, self()),
	    murenzhuang:feature(feature_1, "a1b2"),
	    assert_feature(<<"">>, stdout)
    end.

feature_1_input_size_allows_one_transform(FileHandler) ->
    fun() ->
	    group_leader(FileHandler, self()),
	    murenzhuang:feature(feature_1, "a1b2c"),
	    assert_feature(<<"2222a11bbb">>, stdout)
    end.

feature_1_input_size_greater_than_one_transform_trigger(FileHandler) ->
    fun() ->
	    group_leader(FileHandler, self()),
	    murenzhuang:feature(feature_1, "a1b2c3"),
	    assert_feature(<<"2222a11bbb">>, stdout)
    end.

feature_1_input_size_allows_two_transforms(FileHandler) ->
    fun() ->
	    group_leader(FileHandler, self()),
	    murenzhuang:feature(feature_1, "a1b2c3d4e"),
	    assert_feature(<<"2222a11bbb4444c33ddd">>, stdout)
    end.

feature_2_input_is_empty_list(FileHandler) ->
    fun() ->
	    group_leader(FileHandler, self()),
	    murenzhuang:feature(feature_2, ""),
	    assert_feature(<<"">>, file_8)
    end.

feature_2_input_size_not_allow_transform_execution(FileHandler) ->
    fun() ->
	    group_leader(FileHandler, self()),
	    murenzhuang:feature(feature_2, "abcd"),
	    assert_feature(<<"">>, file_8)
    end.

feature_2_input_size_allows_one_transform(FileHandler) ->
    fun() ->
	    group_leader(FileHandler, self()),
	    murenzhuang:feature(feature_2, "9z8y7"),
	    assert_feature(<<"yyyy9zz888">>, file_8)
    end.

feature_3_input_is_empty_list(FileHandler) ->
    fun() ->
	    group_leader(FileHandler, self()),
	    murenzhuang:feature(feature_3, ""),
	    assert_feature(<<"">>, stdout)
    end.

feature_3_input_size_less_than_one_transform_trigger(FileHandler) ->
    fun() ->
	    group_leader(FileHandler, self()),
	    murenzhuang:feature(feature_3, "aaa"),
	    assert_feature(<<"">>, stdout)
    end.

feature_3_no_boundry_input_and_size_allows_one_transform(FileHandler) ->
    fun() ->
	    group_leader(FileHandler, self()),
	    murenzhuang:feature(feature_3, "2345"),
	    assert_feature(<<"134">>, stdout)
    end.

feature_3_boundry_input_and_size_allows_one_transform(FileHandler) ->
    fun() ->
	    group_leader(FileHandler, self()),
	    murenzhuang:feature(feature_3, "aa00"),
	    assert_feature(<<"z99">>, stdout)
    end.

feature_3_mix_input_and_size_greater_than_one_transform_trigger(FileHandler) ->
    fun() ->
	    group_leader(FileHandler, self()),
	    murenzhuang:feature(feature_3, "ab01x"),
	    assert_feature(<<"z90">>, stdout)
    end.

feature_4_input_is_empty_list(FileHandler) ->
    fun() ->
	    group_leader(FileHandler, self()),
	    murenzhuang:feature(feature_4, ""),
	    assert_feature(<<"">>, stdout)
    end.

feature_4_input_size_less_than_one_transform_trigger(FileHandler) ->
    fun() ->
	    group_leader(FileHandler, self()),
	    murenzhuang:feature(feature_4, "abc"),
	    assert_feature(<<"">>, stdout)
    end.

feature_4_only_integer_input_and_size_allows_one_transform(FileHandler) ->
    fun() ->
	    group_leader(FileHandler, self()),
	    murenzhuang:feature(feature_4, "12345"),
	    assert_feature(<<"7">>, stdout)
    end.

feature_4_only_character_input_and_size_allows_one_transform(FileHandler) ->
    fun() ->
	    group_leader(FileHandler, self()),
	    murenzhuang:feature(feature_4, "abcde"),
	    assert_feature(<<"g">>, stdout)
    end.

feature_4_mix_input_and_allows_one_transform(FileHandler) ->
    fun() ->
	    group_leader(FileHandler, self()),
	    murenzhuang:feature(feature_4, "abc2e"),
	    assert_feature(<<"2c">>, stdout)
    end.

feature_4_boundry_input_and_size_allows_one_transform(FileHandler) ->
    fun() ->
	    group_leader(FileHandler, self()),
	    murenzhuang:feature(feature_4, "00190aaz0"),
	    assert_feature(<<"0a">>, stdout)
    end.

feature_4_input_size_allows_two_transforms(FileHandler) ->
    fun() ->
	    group_leader(FileHandler, self()),
	    murenzhuang:feature(feature_4, "111111111"),
	    assert_feature(<<"22">>, stdout)
    end.
    
setup() ->
    {ok, F} = file:open(stdout, [write]),
    F.

cleanup(F) ->
    file:close(F),
    file:delete(stdout).

assert_feature(ExpectedResult, File) ->
    ?assertEqual({ok, ExpectedResult}, file:read_file(File)).
    
