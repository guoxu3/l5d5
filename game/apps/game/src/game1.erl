%%%-------------------------------------------------------------------
%%% @author guoxu <guoxu3@qq.com>
%%% @copyright (C) 2016, guoxu
%%% @doc
%%%
%%% @end
%%% Created :  16 Seq 2016 by guoxu <guoxu3@qq.com>
%%%-------------------------------------------------------------------

-module(game1).
-export([start/0, fight_loop/0, create_player/0, create_monster/0, fight/2, fight_round_loop/2, fight_round/2]).
-record(role, {name, health, attack}).

start() ->
    fight_loop().

fight_loop() ->
    {PN, H, A} = create_player(),
    io:format("玩家:~ts HP: ~p 攻击: ~p~n", [PN, H, A]),
    {MN, MH, MA} = create_monster(),
    io:format("怪物:~ts HP: ~p 攻击: ~p~n", [MN, MH, MA]),
    fight({PN, H, A},  {MN, MH, MA}).
    %%fight_loop().

create_player() ->
    %% 随机生成姓名
    Names = #{ 1 => "刘三猫", 2 => "杨蝌蚪", 3 => "张咪咪", 4 => "成大腿", 5 => "二狗蛋"},
    Name_num = random:uniform(5),
    #{Name_num := Player_name} = Names,
     
    %% 随机生成hp值，200～250之间
    Hp_Radom = random:uniform(50),
    Hp = Hp_Radom + 200,
    
    %% 攻击值10～20之间
    Attack_Random = random:uniform(10),
    Attack = 10 + Attack_Random,

    #role{name=Player_name, health=Hp, attack=Attack}.
    
create_monster() ->
    %% 随机生成姓名
    M_Names = #{ 1 => "猴赛雷", 2 => "巴扎嘿", 3 => "呀咩蝶", 4 => "哥斯拉", 5 => "尼玛嗨"},
    M_Name_num = random:uniform(5),
    #{M_Name_num := Monster_name} = M_Names,
     
    %% 随机生成hp值，200～250之间
    M_Hp_Radom = random:uniform(50),
    M_Hp = M_Hp_Radom + 200,
    
    %% 攻击值10～20之间
    M_Attack_Random = random:uniform(10),
    M_attack = 10 + M_Attack_Random,
 
    #role{name=Monster_name, health=M_Hp, attack=M_attack}.


fight({P_N, P_H, P_A}, {M_N, M_H, M_A}) ->
    io:format("战斗开始 ~ts对阵~ts ~n", [P_N, M_N]),
    {{F_P_N, F_P_H, F_P_A}, {F_M_N, F_M_H, F_M_A}} = fight_round_loop({P_N, P_H, P_A}, {M_N, M_H, M_A}),
    Winner = if F_P_H > 0 -> F_P_N; true -> F_M_N end,
    io:format("战斗结束, ~ts获胜！~n", [Winner]).

fight_round_loop({P_N, P_H, P_A} = P0, {M_N, M_H, M_A} = M0) ->
    {P1, {_, M1_H, _} = M1} = fight_round(P0, M0),
    if M1_H < 0 ->
	    {P1, M1};
       true ->
	    {M2, {_, P2_H, _} = P2} = fight_round(M1, P1),
	    if P2_H < 0 ->
		    {P2, M2};
	       true ->
		    fight_round_loop(P2, M2)
	    end
    end.

%% args: A, B
%% A -> B
%% return: {A', B'}
fight_round(A, B) ->
    io:format("~ts 攻击 ~ts, 造成了~p点伤害, ~ts还剩~p点血。~n", [A#role.name, B#role.name, A#role.attack, B#role.name, B#role.health-A#role.attack]),
    NewB = B#role{health=B#role.health-A#role.attack},
    {A, NewB}.

