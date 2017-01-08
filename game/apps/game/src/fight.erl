%%%-------------------------------------------------------------------
%%% @author guoxu <guoxu3@qq.com>
%%% @copyright (C) 2016, guoxu
%%% @doc
%%% 
%%% @end
%%% Created :  4 Seq 2016 by guoxu <guoxu3@qq.com>
%%%-------------------------------------------------------------------

-module(fight).
-export([fight_loop/2, fight/2, fight_round_loop/2, fight_round/2]).
-record(role, {name, health, attack}).


fight_loop(A, B) ->
    W = fight(A, B),
    if  W#role.name =:= B#role.name ->
            io:format("战斗结束, ~ts获胜！~n", [B#role.name]);
        true ->
            io:format(" ~ts获胜！重新生成怪物再打~n", [W#role.name])
        end.

fight(A, B) ->
    io:format("战斗开始 ~ts对阵~ts ~n", [A#role.name, B#role.name]),
    {A1, B1} = fight_round_loop(A, B),
    if  A1#role.health > 0 -> 
            A1; 
        true -> 
            B1
    end.


fight_round_loop(A, B) ->
    {A1, B1} = fight_round(A, B),
    if B1#role.health < 0 ->
	    {A1, B1};
       true ->
	    {B2, A2} = fight_round(B1, A1),
	    if A2#role.health < 0 ->
		    {A2, B2};
	       true ->
		    fight_round_loop(A2, B2)
	    end
    end.


%% args: A, B
%% A -> B
%% return: {A', B'}
fight_round(A, B) ->
    io:format("~ts 攻击 ~ts, 造成了~p点伤害, ~ts还剩~p点血。~n", [A#role.name, B#role.name, A#role.attack, B#role.name, B#role.health-A#role.attack]),
    NewB = B#role{health=B#role.health-A#role.attack},
    {A, NewB}.

