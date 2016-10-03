%%%-------------------------------------------------------------------
%%% @author guoxu <guoxu3@qq.com>
%%% @copyright (C) 2016, guoxu
%%% @doc
%%%
%%% @end
%%% Created :  3 Oct 2016 by guoxu <guoxu3@qq.com>
%%%-------------------------------------------------------------------

-module(game2).
-export([start/0, fight_loop/4, fight_loop/2, create_player/0, create_monster/0, fight/2, fight_round_loop/2, fight_round/2]).
-record(role, {name, health, attack}).

start() ->
    A = create_player(),
    %%A = #role{name = "张咪咪", health = 245, attack = 15},
    B = create_monster(),
    C = create_monster(),
    D = create_monster(),
    E = create_monster(),
    F = create_monster(),
    G = create_monster(),
    H = create_monster(),
    I = create_monster(),
    J = create_monster(),
    K = create_monster(),
    L = create_monster(),
    M = create_monster(),
    N = create_monster(),
    O = create_monster(),
    P = create_monster(),
    io:format("###############################第一轮战斗开始################################~n", []),
    fight_loop(A, B, C, D, E, F, G, H, I, J, K, L, M, N, O, P).

fight_loop(A, B, C, D, E, F, G, H, I, J, K, L, M, N, O, P) ->
    NewA = fight(A, P),
    NewB = fight(B, O),
    NewC = fight(C, N),
    NewD = fight(D, M),
    NewE = fight(E, L),
    NewF = fight(F, K),
    NewG = fight(G, J),
    NewH = fight(H, I),
    io:format("###############################第二轮战斗开始################################~n", []),
    fight_loop(NewA, NewB, NewC, NewD, NewE, NewF, NewG, NewH).

fight_loop(A, B, C, D, E, F, G, H) ->
    NewA = fight(A, H),
    NewB = fight(B, G),
    NewC = fight(C, F),
    NewD = fight(D, E),
    io:format("###############################第三轮战斗开始################################~n", []),
    fight_loop(NewA, NewB, NewC, NewD).


fight_loop(A, B, C, D) ->
    NewA = fight(A, D),
    NewB = fight(B, C),
    io:format("###############################第四轮战斗开始################################~n", []),
    fight_loop(NewA, NewB).

fight_loop(A, B) ->
    fight(A, B).
    

update_player(P) ->
    OldHealth = P#role.health,
    OldAttack = P#role.attack,
    NewHealth = trunc(OldHealth * 1.1),
    NewAttack = trunc(OldAttack * 1.1),
    P#role{health = NewHealth, attack = NewAttack}.

create_player() ->
    %% 随机生成姓名
    Names = #{ 1 => "刘三猫", 2 => "杨蝌蚪", 3 => "张咪咪", 4 => "成大腿", 5 => "二狗蛋"},
    Name_num = random:uniform(5),
    #{Name_num := Player_name} = Names,
     
    %% 随机生成hp值，230～250之间
    Hp_Radom = random:uniform(20),
    Hp = Hp_Radom + 230,
    
    %% 攻击值10～15之间
    Attack_Random = random:uniform(5),
    Attack = 10 + Attack_Random,

    #role{name = Player_name, health = Hp, attack = Attack}.
    
create_monster() ->
    %% 随机生成姓名
    M_Names = #{ 1 => "猴赛雷", 2 => "巴扎嘿", 3 => "呀咩蝶", 4 => "哥斯拉", 5 => "尼玛嗨"},
    M_Name_num = random:uniform(5),
    #{M_Name_num := Monster_name} = M_Names,
     
    %% 随机生成hp值，200～250之间
    M_Hp_Radom = random:uniform(20),
    M_Hp = M_Hp_Radom + 230,
    
    %% 攻击值10～20之间
    M_Attack_Random = random:uniform(5),
    M_attack = 10 + M_Attack_Random,
 
    #role{name = Monster_name, health = M_Hp, attack = M_attack}.


fight(A, B) ->
    io:format("玩家:~ts HP: ~p 攻击: ~p~n", [A#role.name, A#role.health, A#role.attack]),
    io:format("玩家:~ts HP: ~p 攻击: ~p~n", [B#role.name, B#role.health, B#role.attack]),
    io:format("战斗开始 ~ts对阵~ts ~n", [A#role.name, B#role.name]),
    {A1, B1} = fight_round_loop(A, B),
    if  A1#role.health > 0 -> 
            io:format("本轮战斗结束, ~ts获胜！~n", [A#role.name]),
            io:format("===============================~n", []),
            update_player(A); 
        true -> 
            io:format("本轮战斗结束, ~ts获胜！~n", [B#role.name]),
            io:format("===============================~n", []),
            update_player(B)
    end.


fight_round_loop(A, B) ->
    {A1, B1} = fight_round(A, B),
    if B1#role.health =< 0 ->
	    {A1, B1};
       true ->
	    {B2, A2} = fight_round(B1, A1),
	    if A2#role.health =< 0 ->
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

