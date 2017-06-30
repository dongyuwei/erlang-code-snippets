-module(tuple_module_tests).
-include_lib("eunit/include/eunit.hrl").

foo_test()->
    Result = tuple_module:foo("aa", "bb"),
    ?assertEqual(Result, ["aa","bb"]).

fooz_test()->
    T = {tuple_module, ["foo", "bar"]},
    Result = T:foo("hi"),
    ?debugFmt("~p~n", [Result]),
    ?assertEqual(Result, ["hi", T]).