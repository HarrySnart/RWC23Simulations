
options casdatalimit=5000M;

proc sort data=PUBLIC.RWC23_SIM_DETAIL out=WORK.SORTTempTableSorted;
	by Iteration;
run;

proc transpose data=WORK.SORTTempTableSorted out=work.Transpose prefix=Column;
	var sf2_winner sf1_winner qf4_winner qf3_winner qf2_winner qf1_winner 
		PoolD_Second PoolD_Winner PoolC_Second PoolC_Winner PoolB_Second PoolB_Winner 
		PoolA_Second PoolA_Winner RWC_Third RWC_Second RWC_Winner;
	by Iteration;
run;

proc delete data=WORK.SORTTempTableSorted;
run;

data public.rwc_path_viz2(promote=yes);
length Event_Stage $30;
set work.transpose(rename=(_NAME_ = Stage));
Team = catx('',of Column:);
if Stage = 'PoolA_Winner' then Event_Stage = 'Pool A Winner';
if Stage = 'PoolB_Winner' then Event_Stage = 'Pool B Winner';
if Stage = 'PoolC_Winner' then Event_Stage = 'Pool C Winner';
if Stage = 'PoolD_Winner' then Event_Stage = 'Pool D Winner';

if Stage = 'PoolA_Second' then Event_Stage = 'Pool A Runner-Up';
if Stage = 'PoolB_Second' then Event_Stage = 'Pool B Runner-Up';
if Stage = 'PoolC_Second' then Event_Stage = 'Pool C Runner-Up';
if Stage = 'PoolD_Second' then Event_Stage = 'Pool D Runner-Up';

if Stage = 'qf1_winner' then Event_Stage = 'Quarter Final 1 Winner';
if Stage = 'qf2_winner' then Event_Stage = 'Quarter Final 2 Winner';
if Stage = 'qf3_winner' then Event_Stage = 'Quarter Final 3 Winner';
if Stage = 'qf4_winner' then Event_Stage = 'Quarter Final 4 Winner';

if Stage = 'sf1_winner' then Event_Stage = 'Semi Final 1 Winner';
if Stage = 'sf2_winner' then Event_Stage = 'Semi Final 2 Winner';

if Stage = 'RWC_Winner' then Event_Stage = 'RWC Final Winner';
if Stage = 'RWC_Second' then Event_Stage = 'RWC Runner-Up';
if Stage = 'RWC_Third' then Event_Stage = 'RWC Bronze';

if Stage in ('PoolA_Winner','PoolB_Winner','PoolC_Winner','PoolD_Winner','PoolA_Second','PoolB_Second','PoolC_Second','PoolD_Second') then Event_Seq = 1;
if Event_Stage in ('Quarter Final 1 Winner','Quarter Final 2 Winner','Quarter Final 3 Winner','Quarter Final 4 Winner') then Event_Seq = 2;
if Event_Stage in ('Semi Final 1 Winner','Semi Final 2 Winner') then Event_Seq = 3;
if Stage = 'RWC_Third' then Event_Seq=4;
if Stage = 'RWC_Second' then Event_Seq = 5;
if Stage = 'RWC_Winner' then Event_Seq = 6;

Team_Event = catx(':',Event_Stage,Team);

if Team='New Zealand' then TeamID = 1;
if Team='France' then TeamID = 2;
if Team='Italy' then TeamID = 3;
if Team='Uruguay' then TeamID = 4;
if Team='Namibia' then TeamID = 5;
if Team='South Africa' then TeamID = 6;
if Team='Ireland' then TeamID = 7;
if Team='Scotland' then TeamID = 8;
if Team='Tonga' then TeamID = 9;
if Team='Romania' then TeamID = 10;
if Team='Wales' then TeamID = 11;
if Team='Australia' then TeamID = 12;
if Team='Fiji' then TeamID = 13;
if Team='Georgia' then TeamID = 14;
if Team='Portugal' then TeamID = 15;
if Team='England' then TeamID = 16;
if Team='Japan' then TeamID = 17;
if Team='Argentina' then TeamID = 18;
if Team='Samoa' then TeamID = 19;
if Team='Chile' then TeamID = 20;

keep Iteration Event_Seq Event_Stage Team Team_Event TeamID;
run;