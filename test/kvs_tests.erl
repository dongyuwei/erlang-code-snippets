-module(kvs_tests).
-include_lib("eunit/include/eunit.hrl").

store_test() ->
    {ok, _pid} = kvs:start_link(),
    ok = kvs:store("foo", "bar").

lookup_test() ->
    kvs:start_link(),
    nil = kvs:lookup("not-exist-key").

lookup2_test() ->
    kvs:start_link(),
    ok = kvs:store(foo, bar),
    bar = kvs:lookup(foo).

remove_test() ->
    kvs:start_link(),
    ok = kvs:store(foo, bar),
    ok = kvs:remove(foo).

all_test() ->
    kvs:start_link(),

    ok = kvs:store(foo, bar),
    ok = kvs:store("foo", "bar"),
    ok = kvs:store("a", "b"),
    ?assertEqual(#{foo => bar, "foo" => "bar", "a" => "b"}, kvs:all()),

    ok = kvs:remove(foo),
    All = kvs:all(),
    ?debugFmt("all: ~p~n", [All]),
    ?assertEqual(#{"foo" => "bar", "a" => "b"}, All).