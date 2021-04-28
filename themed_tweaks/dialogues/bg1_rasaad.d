////////////////////////////////////////////////
// Changes so Sorrem can be found in Beregost //
////////////////////////////////////////////////

ADD_TRANS_TRIGGER %RASAAD_JOINED% 8 ~Global("#L_DarkMoonBeregost","GLOBAL",0)~ DO 0
ADD_TRANS_ACTION %RASAAD_JOINED% BEGIN 40 END BEGIN 0 END ~EraseJournalEntry(@3000) EraseJournalEntry(@3001) EraseJournalEntry(@3002)~ 
EXTEND_BOTTOM %RASAAD_JOINED% 8
	IF ~Global("#L_DarkMoonBeregost","GLOBAL",1)~ GOTO SORREM_WIZARD
END
APPEND %RASAAD_JOINED%
	IF ~~ BEGIN SORREM_WIZARD
		SAY @2000 // ~When I spent some time in Beregost, a man named Sorrem used to come to my demonstrations of martial skill. I sometimes saw him returning to the Burning Wizard.~
		IF ~~ THEN REPLY #%REPLY_LETS_GO% EXIT 
		IF ~~ THEN REPLY #%REPLY_LETS_NOT% EXIT 
	END
END

ADD_TRANS_TRIGGER RSSORREM 3 ~Global("#L_DarkMoonBeregost","GLOBAL",0)~ DO 2
ADD_TRANS_TRIGGER RSSORREM 4 ~Global("#L_DarkMoonBeregost","GLOBAL",0)~ DO 0
ADD_TRANS_TRIGGER RSSORREM 8 ~Global("#L_DarkMoonBeregost","GLOBAL",0)~ DO 0
ADD_TRANS_TRIGGER RSSORREM 9 ~Global("#L_DarkMoonBeregost","GLOBAL",0)~ DO 0
ADD_TRANS_TRIGGER RSSORREM 10 ~Global("#L_DarkMoonBeregost","GLOBAL",0)~ DO 0
ADD_TRANS_TRIGGER RSSORREM 16 ~Global("#L_DarkMoonBeregost","GLOBAL",0)~ DO 0
REPLACE_ACTION_TEXT RSSORREM ~StartCutSceneEx("CUTRS1E",FALSE)~ ~StartCutSceneEx("CUTRS1E",TRUE)~
REPLACE_ACTION_TEXT RSSORREM ~StartCutSceneEx("CUTRS1C",FALSE)~ ~StartCutSceneEx("CUTRS1C",TRUE)~
EXTEND_BOTTOM RSSORREM 3
	IF ~Global("#L_DarkMoonBeregost","GLOBAL",1)~ THEN REPLY #%REPLY_WHAT_KNOW% GOTO BEREGOST_1
END
EXTEND_BOTTOM RSSORREM 4
	IF ~Global("#L_DarkMoonBeregost","GLOBAL",1)~ THEN GOTO BEREGOST_1
END
EXTEND_BOTTOM RSSORREM 10
	IF ~Global("#L_DarkMoonBeregost","GLOBAL",1)~ THEN DO ~SetGlobal("SORREM_SEVEN_SUNS","GLOBAL",3) ClearAllActions() StartCutSceneMode() StartCutSceneEx("CUTRS1E",TRUE) AddJournalEntry(@3001,QUEST)~ EXIT
END
EXTEND_BOTTOM RSSORREM 16
	IF ~Global("#L_DarkMoonBeregost","GLOBAL",1)~ THEN DO ~StartCutSceneMode() StartCutSceneEx("CUTRS1D",FALSE) ActionOverride("RSDMNK04",Enemy()) Shout(99) Enemy() ActionOverride("RSDMNK04",EscapeAreaMove("#LBG1102",758,643,S)) EscapeAreaMove("#LBG1102",799,611,NEE)~ EXIT
END
APPEND RSSORREM
	IF ~~ THEN BEGIN BEREGOST_1
		SAY @2001 // ~There is a cult that calls itself the Dark Moon. They've been in the area for less than a year, but they're always looking for new recruits.~
		IF ~~ GOTO BEREGOST_2
	END
	
	IF ~~ THEN BEGIN BEREGOST_2
		SAY @2002 // ~They're pretty rough characters, so yeah, when they asked me about your buddy Rasaad, I told them what I knew. A while back, I saw him in Nashkel, and then I spotted him again here in town.~
		IF ~~ GOTO BEREGOST_3
	END
	
	IF ~~ THEN BEGIN BEREGOST_3
		SAY @2003 // ~They have a safe house not far from here. I can show you the way if you meet me there tonight.~
		IF ~~ THEN REPLY #%REPLY_WHY_NOT_NOW% GOTO 8
		IF ~~ THEN REPLY #%REPLY_AT_NIGHT% GOTO 8
		IF ~~ THEN REPLY #%REPLY_SIMPLER% GOTO 11
	END
END

