-module(tuple_module).

%% API
-export([foo/2]).


foo(P1, P2) ->
    io:format("~p ~p ~n", [P1, P2]),
    [P1, P2].