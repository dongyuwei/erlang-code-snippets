-module(kvs).
-behaviour(gen_server).

%% API
-export([start_link/0, store/2, lookup/1]).

%% gen_server callbacks
-export([init/1,
    handle_call/3,
    handle_cast/2,
    handle_info/2,
    terminate/2,
    code_change/3]).

-define(SERVER, ?MODULE).

%%%===================================================================
%%% API
%%%===================================================================

start_link() ->
    gen_server:start_link({local, ?SERVER}, ?MODULE, [], []).

store(Key, Value) ->
    gen_server:cast(?SERVER, {store, Key, Value}).

lookup(Key) ->
    gen_server:call(?SERVER, {lookup, Key}).

%%%===================================================================
%%% gen_server callbacks
%%%===================================================================

init([]) ->
    {ok, #{}}.


handle_call({lookup, Key}, _From, State) ->
    Value = maps:get(Key, State, [Key, " is not in kvs"]),
    {reply, Value, State}.

handle_cast({store, Key, Value}, State) ->
    State2 = State#{Key => Value},
    io:format("handle_cast: store ~p ~n", [State2]),
    {noreply, State2}.

handle_info(_Info, State) ->
    {noreply, State}.

terminate(_Reason, _State) ->
    ok.

code_change(_OldVsn, State, _Extra) ->
    {ok, State}.


%% to test:
%%1. c(kvs).
%%2. kvs:start_link().
%%3. kvs:store("foo", "bar").
%%4. kvs:lookup("foo").