%%%-------------------------------------------------------------------
%%% @author guoxu <guoxu3@qq.com>
%%% @copyright (C) 2016, guoxu
%%% @doc
%%% 
%%% @end
%%% Created :  4 Seq 2016 by guoxu <guoxu3@qq.com>
%%%-------------------------------------------------------------------

-module(player).
-export([create_player/0, create_monster/0]).
-record(role, {name, health, attack}).


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