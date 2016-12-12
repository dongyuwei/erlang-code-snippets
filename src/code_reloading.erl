-module(code_reloading).

-export([test/0, loop/0]).

loop() ->
    receive
        upgrade ->
            code:purge(?MODULE),
            compile:file(?MODULE),
            code:load_file(?MODULE),
            ?MODULE:loop();
        hello ->
            io:format("This is a test~n"),
            loop();
        _ ->
            loop()
    end.

test() ->
    Pid = spawn(?MODULE, loop, []),
    register(code_reloading_foo, Pid),
    code_reloading_foo ! hello,
    code_reloading_foo ! upgrade.