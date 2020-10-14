//////////////////////////////////////////////////////////////////////
// Dialogue needed for the optional Coastway Bridge quest component //
// Compiled via coastway_bridge.tpa                                 //
//////////////////////////////////////////////////////////////////////

EXTEND_TOP BDCORWIN 5 #0
	IF ~Global("#L_SoDStatOptions","GLOBAL",1) OR(2) CheckStatGT(Player1,15,WIS) CheckStatGT(Player1,15,INT)~ THEN REPLY @2000 /* ~You should send out scouts.  Caelar will be expecting us to cross here.~ */ DO ~SetGlobal("bd_plot","global",101) SetGlobal("#L_CWBridgeQuest","GLOBAL",1)~ + CORWIN_BRIDGE_QUEST_1.1
END

APPEND BDCORWIN
	IF ~~ THEN BEGIN CORWIN_BRIDGE_QUEST_1.1
		SAY @2001 /* ~That's actually not a bad idea.  I'll have Bence see to it.~ */
		++ @2002 /* ~While you do that, I'll do a little scouting on my own.~ */ + 6
	END

	IF ~~ THEN BEGIN CORWIN_BRIDGE_QUEST_1.2
		SAY @2003 /* ~Keep an eye out for Caelar's forces.  They could be lying in wait.~ */
		++ @2004 /* ~Tell ya what, you keep an eye out for Caelar, and I'll go see what else is out there.~ */ DO ~SetGlobal("#L_CWBridgeQuest","MYAREA",1)~ UNSOLVED_JOURNAL @3000 EXIT
	END

	IF ~~ THEN BEGIN CORWIN_BRIDGE_QUEST_1.3
		SAY @2005 /* ~We should keep an eye out for Caelar's forces.  They could be lying in wait.~ */
		IF ~~ THEN DO ~SetGlobal("#L_CWBridgeQuest","MYAREA",1)~ UNSOLVED_JOURNAL @3000 EXIT
	END
END

ALTER_TRANS BDCORWIN
	BEGIN 9 END
	BEGIN 0 END
	BEGIN
		"EPILOGUE" ~GOTO CORWIN_BRIDGE_QUEST_1.2~
	END

ALTER_TRANS BDCORWIN
	BEGIN 13 END
	BEGIN 0 END
	BEGIN
		"EPILOGUE" ~GOTO CORWIN_BRIDGE_QUEST_1.3~
	END

