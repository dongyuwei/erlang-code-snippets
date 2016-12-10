-module (observer).
-export ([start/0]).

start() ->
    spawn(fun() -> observer(fun() -> worker() end) end).
    
% c(observer).
% observer:start().
% worker_test ! test.
% worker_test ! exit.

%%====================================================================
%% Internal functions
%%====================================================================
observer(Fun) ->
    io:format("observer started: ~p ~n", [self()]),
    % the trap exit is needed, because if you don't have it the watching process will die if the linked process dies.
    process_flag(trap_exit, true),
    start_worker(Fun).

start_worker(Fun) ->
    Pid = spawn_link(Fun),
    register(worker_test, Pid), % `worker_test` for test in erl shell

    receive
        {'EXIT', Pid, Why} ->
            io:format("~p worker died with:~p~n",[Pid, Why]),
            io:format("restart worker... ~n", []),
            start_worker(Fun)
    end.

worker() ->
    % register(worker_test, self()),
    io:format("worker started: ~p ~n", [self()]),
    worker_loop().

worker_loop() ->
    io:format("~p ~n", ["worker waiting for msg..."]),
    receive 
        exit ->
            exit("oops, some one kill me.");
        Any -> 
            io:format("worker received msg: ~p ~n", [Any]),
            worker_loop()
    end.