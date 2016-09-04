-module(player_manager).
-export([start_link/1]).

start_link() ->
    spwan_link(player_manager, _init, []).

_init() ->
    todo.

