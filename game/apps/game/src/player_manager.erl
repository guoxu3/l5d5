%%%-------------------------------------------------------------------
%%% @author guoxu <guoxu3@qq.com>
%%% @copyright (C) 2016, guoxu
%%% @doc
%%% 
%%% @end
%%% Created :  4 Seq 2016 by guoxu <guoxu3@qq.com>
%%%-------------------------------------------------------------------

-module(player_manager).
-export([start_link/0, init/0]).

start_link() ->
    spawn_link(player_manager, init, []).

init() ->
    receive
	go ->
	    io:format("go a go")
    end.
    	

