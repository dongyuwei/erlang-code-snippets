-module(udp_server).
-export([start/0, client/1]).

start() ->
    spawn(fun() -> server(4000) end).

server(Port) ->
    {ok, Socket} = gen_udp:open(Port, [binary, {active, false}]),
    io:format("server opened socket:~p~n",[Socket]),
    loop(Socket).

loop(Socket) ->
    inet:setopts(Socket, [{active, once}]),
    receive
        {udp, Socket, Host, Port, Bin} ->
            io:format("udp_server received:~p~n",[Bin]),
            gen_udp:send(Socket, Host, Port, reverse(Bin, <<>>)),
            loop(Socket)
    end.

reverse(<<>>, Acc) -> Acc;
reverse(<<H:1/binary, Rest/binary>>, Acc) ->
    reverse(Rest, <<H/binary, Acc/binary>>).

% Client code
client(Data) ->
    {ok, Socket} = gen_udp:open(0, [binary]),
    io:format("client opened socket=~p~n",[Socket]),
    ok = gen_udp:send(Socket, "localhost", 4000, Data),
    Value = receive
                {udp, Socket, _, _, Bin} ->
                    io:format("client received:~p~n",[Bin])
            after 2000 ->
                    0
            end,
    gen_udp:close(Socket),
    Value.

% server side:
% c(udp_server).
% udp_server:start().

% client side:
% c(udp_server).
% udp_server:client(<<"dyw">>).

