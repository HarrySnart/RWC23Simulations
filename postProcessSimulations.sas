cas casauto;
caslib _all_ assign;

data public.rwc_sim;
set work.import;
run;


data public.rwc23_sim_detail(promote=yes);
set public.rwc_sim;
length Section $15 Event_Stage $30 Winner $30 RWC_Winner $30 RWC_Second $30 RWC_Third $30 
PoolA_Winner PoolA_Second PoolB_Winner PoolB_Second PoolC_Winner PoolC_Second PoolD_Winner PoolD_Second $30
qf1_winner qf2_winner qf3_winner qf4_winner sf1_winner sf2_winner $30;
/* Relabel pool */
if Stage in ('A','B','C','D') then Section = 'Pool';
else Section = 'Knock-Out';
if Stage = 'A' then Event_Stage = 'Pool A';
if Stage = 'B' then Event_Stage = 'Pool B';
if Stage = 'C' then Event_Stage = 'Pool C';
if Stage = 'D' then Event_Stage = 'Pool D';
/* relabel knock-out */
if Stage = 'quarter final 1' then Event_Stage = 'Quarter Final 1';
if Stage = 'quarter final 2' then Event_Stage = 'Quarter Final 2';
if Stage = 'quarter final 3' then Event_Stage = 'Quarter Final 3';
if Stage = 'quarter final 4' then Event_Stage = 'Quarter Final 4';
if Stage = 'semi final 1' then Event_Stage = 'Semi Final 1';
if Stage = 'semi final 2' then Event_Stage = 'Semi Final 2';
if Stage = 'RWC Final' then Event_Stage = 'RWC Final';
if Stage = 'RWC Bronze' then Event_Stage = 'RWC Bronze';
/* Add sequence */
if Section = 'Pool' then Sequence = 1;
if Event_Stage = 'Quarter Final 1' then Sequence = 2;
if Event_Stage = 'Quarter Final 2' then Sequence = 2;
if Event_Stage = 'Quarter Final 3' then Sequence = 2;
if Event_Stage = 'Quarter Final 4' then Sequence = 2;
if Event_Stage = 'Semi Final 1' then Sequence = 3;
if Event_Stage = 'Semi Final 2' then Sequence = 3;
if Event_Stage = 'RWC Final' then Sequence = 4;
if Event_Stage = 'RWC Bronze' then Sequence = 4;
/* derive fixture winner */
if Side1_Win = 1 then Winner = Side1;
else Winner = Side2;
/* RWC WInner */
if Event_Stage = 'RWC Final' then RWC_Winner = Winner;
/* RWC Second */
if Event_Stage = 'RWC Final' and Side1 = Winner then RWC_Second = Side2;
else if Event_Stage = 'RWC Final' and Side2 = Winner then RWC_Second = Side1;
/* RWC Third */
if Event_Stage = 'RWC Bronze' then RWC_Third = Winner;
/* Pool Winners */
if Event_Stage = 'Quarter Final 1' then PoolC_Winner = Side1;
if Event_Stage = 'Quarter Final 1' then PoolD_Second = Side2;

if Event_Stage = 'Quarter Final 2' then PoolB_Winner = Side1;
if Event_Stage = 'Quarter Final 2' then PoolA_Second = Side2;

if Event_Stage = 'Quarter Final 3' then PoolD_Winner = Side1;
if Event_Stage = 'Quarter Final 3' then PoolC_Second = Side2;

if Event_Stage = 'Quarter Final 4' then PoolA_Winner = Side1;
if Event_Stage = 'Quarter Final 4' then PoolB_Second = Side2;
/* Quarter final winners */

if Event_Stage = 'Semi Final 1' then qf1_winner = Side1;
if Event_Stage = 'Semi Final 1' then qf2_winner = Side2;
if Event_Stage = 'Semi Final 2' then qf3_winner = Side1;
if Event_Stage = 'Semi Final 2' then qf4_winner = Side2;

/* Semi-Final winners */
if Event_Stage = 'RWC Final' then sf1_winner = Side1;
if Event_Stage = 'RWC Final' then sf2_winner = Side2;

run;

options casdatalimit=5000M;