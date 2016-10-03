%%%-------------------------------------------------------------------
%%% @author guoxu <guoxu3@qq.com>
%%% @copyright (C) 2016, guoxu
%%% @doc
%%%
%%% @end
%%% Created :  16 Seq 2016 by guoxu <guoxu3@qq.com>
%%%-------------------------------------------------------------------

-module(game1).
-export([start/0, fight_loop/0, fight_loop/2, create_player/0, create_monster/0, fight/2, fight_round_loop/2, fight_round/2]).
-record(role, {name, health, attack}).


start() ->
    fight_loop().


fight_loop() ->
    A = create_player(),
    io:format("玩家:~ts HP: ~p 攻击: ~p~n", [A#role.name, A#role.health, A#role.attack]),
    B = create_monster(),
    io:format("怪物:~ts HP: ~p 攻击: ~p~n", [B#role.name, B#role.health, B#role.attack]),
    fight_loop(A, B).


fight_loop(A, B) ->
    W = fight(A, B),
    if  W#role.name =:= B#role.name ->
            io:format("战斗结束, ~ts获胜！~n", [B#role.name]);
        true ->
            io:format(" ~ts获胜！重新生成怪物再打~n", [W#role.name]),
            NewB = create_monster(),
            io:format("怪物:~ts HP: ~p 攻击: ~p~n", [NewB#role.name, NewB#role.health, NewB#role.attack]),
            NewA = fix_player(W),
            io:format("玩家回血:~ts HP: ~p 攻击: ~p~n", [NewA#role.name, NewA#role.health, NewA#role.attack]),
            fight_loop(NewA, NewB)
        end.


fix_player(P) ->
    OldHealth = P#role.health,
    NewHealth = OldHealth + 150,
    P#role{health=NewHealth}.


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

