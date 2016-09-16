%%%-------------------------------------------------------------------
%%% @author guoxu <guoxu3@qq.com>
%%% @copyright (C) 2016, guoxu
%%% @doc
%%% 
%%% @end
%%% Created :  4 Seq 2016 by guoxu <guoxu3@qq.com>
%%%-------------------------------------------------------------------

-module(game).
-export([start/0, stop/1, save/1, load/1, help/0, core/0, loop/1]).

start() ->
    GameId = spawn(game, core, []),
    GameId ! {get, self()},
    receive
	Pmid ->
	   {GameId, Pmid}    
    end.

stop(GameId) ->
    %io:format('Game stop, bye~', []),
    exit(GameId,"Game stop").

save(PlayerId) ->
    todo.

load(PlayerId) ->
    todo.

help() ->
    todo.
    
core() ->
    PMId = player_manager:start_link(),
    loop(PMId).

loop(PID) ->
    receive
	{get, From} ->
	    From ! PID,
	    loop(PID);	
	stop ->
	    todo
    end.
	     
