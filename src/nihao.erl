-module (nihao).
-export ([start/0]).

start() ->
    io:format("nihao~n"),
    {ok, C} = eredis:start_link(),
    {ok, <<"OK">>} = eredis:q(C, ["SET", "foo", "bar"]),
    {ok, Bin} = eredis:q(C, ["GET", "foo"]),
    io:format(Bin),
    init:stop().