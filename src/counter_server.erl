%%% counter_server.erl
% simple counter implemented as a gen_server
-module(counter_server).
-behavior(gen_server).

% API
-export([new/0, click/1]).

% required by gen_server
-export([init/1, handle_call/3, handle_cast/2, handle_info/2, terminate/2, code_change/3]).

%%% API methods
new() ->
  gen_server:start(?MODULE, [], []).

click(Pid) ->
  gen_server:call(Pid, click).

%%% gen_server callbacks
%%%   these are required to implement the gen_server behavior
%%%   we're really only using init and handle_call
init([]) ->
  % the second value is the initial counter state
  {ok, 0}.

set(Value, Pid) ->
  gen_server:call(Pid, {set, Value}).

handle_call({set, Value}, _From, _N) ->
  {reply, ok, Value};

handle_call(click, _From, N) ->
  % the second value is sent back to the caller
  % the third value is the new state
  {reply, N + 1, N + 1}.

% basically, we ignore these, but keep the same counter state
handle_cast(_Msg, N) ->
  {noreply, N}.
handle_info(_Msg, N) ->
  {noreply, N}.
code_change(_OldVsn, N, _Other) ->
  {ok, N}.
terminate(_Reason, _N) ->
  ok.