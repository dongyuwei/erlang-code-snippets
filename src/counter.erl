%%% counter.erl
% spawns a counter loop that listens for a click message
-module(counter).
-export([new/0, click/1]).

% spawn a counter, returning the pid
new() ->
  spawn(fun() -> loop(0) end).

% recursive loop with receive block
loop(N) ->
  receive
    {click, From} ->
      From ! N + 1,
      loop(N + 1)
  end.

% API function to increment a counter given its pid
click(Pid) ->
  Pid ! {click, self()},
  receive V -> V end.
