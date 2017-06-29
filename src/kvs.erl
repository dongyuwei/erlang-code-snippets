-module(kvs).
-behaviour(gen_server).

%% API
-export([start_link/0, store/2, lookup/1, remove/1, all/0]).

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

remove(Key) ->
    gen_server:cast(?SERVER, {remove, Key}).

all() ->
    gen_server:call(?SERVER, all).

%%%===================================================================
%%% gen_server callbacks
%%%===================================================================

init([]) ->
    {ok, #{}}.


handle_call({lookup, Key}, _From, State) ->
    Value = maps:get(Key, State, nil),
    {reply, Value, State};

handle_call(all, _From, State) ->
    {reply, State, State}.

handle_cast({store, Key, Value}, State) ->
    State2 = State#{Key => Value},
    {noreply, State2};

handle_cast({remove, Key}, State) ->
    State2 = maps:remove(Key, State),
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