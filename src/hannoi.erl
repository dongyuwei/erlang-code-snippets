-module (hannoi).
-export ([move_count/1, move/4]).

move_count(0) -> 0;
move_count(1) -> 1;
move_count(2) -> 3;
move_count(N) -> move_count(N - 1) * 2 + 1.

move(0, Source, Middle, Target) -> 0;

move(1, Source, Middle, Target) ->
    io:format("~p --> ~p ~n", [Source, Target]);

move(2, Source, Middle, Target) ->
    io:format("~p --> ~p ~n", [Source, Middle]),
    io:format("~p --> ~p ~n", [Source, Target]),
    io:format("~p --> ~p ~n", [Middle, Target]);

move(N, Source, Middle, Target) ->
    move(N - 1, Source, Target, Middle),
    io:format("~p --> ~p ~n", [Source, Target]),
    move(N - 1, Middle, Source, Target).

% c(hannoi).
% hannoi:move(3, a, b, c).