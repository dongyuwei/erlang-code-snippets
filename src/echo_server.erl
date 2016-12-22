-module(echo_server).
-export([start/0]).

start() ->
     io:format("SERVER Trying to bind to port 2345\n"),
     {ok, Listen} = gen_tcp:listen(2345, [ binary
                                         , {packet, 0}
                                         , {reuseaddr, true}
                                         , {active, true}
                                         ]),
     io:format("SERVER Listening on port 2345\n"),
     accept(Listen).

 accept(Listen) ->
     {ok, Socket} = gen_tcp:accept(Listen),
     WorkerPid = spawn(fun() -> echo(Socket) end),
     gen_tcp:controlling_process(Socket, WorkerPid),
     accept(Listen).

 echo(Socket) ->
     receive
         {tcp, Socket, Bin} ->
             io:format("SERVER Received: ~p\n", [Bin]),
             gen_tcp:send(Socket, Bin),
             echo(Socket);
         {tcp_closed, Socket} ->
             io:format("SERVER: The client closed the connection\n")
     end.
