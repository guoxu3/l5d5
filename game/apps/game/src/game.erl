%%%-------------------------------------------------------------------
%%% @author guoxu <guoxu3@qq.com>
%%% @copyright (C) 2016, guoxu
%%% @doc
%%% 
%%% @end
%%% Created :  4 Seq 2016 by guoxu <guoxu3@qq.com>
%%%-------------------------------------------------------------------

-module(game).
-export([start/0, stop/1, save/1, load/1, help/0]).

start() ->
    GameId = spwan(game, core, []),
    GameId ! {get, self()}
    receive
	Reslut ->
	    Reslut
    end.


stop(GameId) ->
    todo.

save(PlayerId) ->
    todo.

load(PlayerId) ->
    todo.

help() ->
    todo.
    
core ->
    PMId = player_manager:start_link(),
    loop

loop(PID) ->
    receive
	{get, From} ->
	    PID,
	    loop(PID)	
	stop->
	     exit
     end.
	     
