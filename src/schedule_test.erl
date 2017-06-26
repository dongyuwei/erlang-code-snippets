-module(schedule_test).

%% API
-export([start/0, loop/1]).


start() ->
    spawn(?MODULE, loop, ["foo"]),
    spawn(?MODULE, loop, ["bar"]).


loop(Msg) ->
    io:format("~p ~n", [Msg]),
    loop(Msg).
