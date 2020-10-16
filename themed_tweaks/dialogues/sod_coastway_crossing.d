//////////////////////////////////////////////////////////////////////
// Dialogue needed for the optional Coastway Bridge quest component //
// Compiled via coastway_bridge.tpa                                 //
//////////////////////////////////////////////////////////////////////

EXTEND_TOP BDCORWIN 5 #0
	IF ~Global("#L_SoDStatOptions","GLOBAL",1) OR(2) CheckStatGT(Player1,15,WIS) CheckStatGT(Player1,15,INT)~ THEN REPLY @2000 /* ~You should send out scouts.  Caelar will be expecting us to cross here.~ */ DO ~SetGlobal("bd_plot","global",101) SetGlobal("#L_CWBridgeQuest","GLOBAL",1)~ + CORWIN_BRIDGE_QUEST_1.1
END

ALTER_TRANS BDCORWIN
	BEGIN 9 END
	BEGIN 0 END
	BEGIN
		"EPILOGUE" ~GOTO CORWIN_BRIDGE_QUEST_1.2A~
	END

ALTER_TRANS BDCORWIN
	BEGIN 13 END
	BEGIN 0 END
	BEGIN
		"EPILOGUE" ~GOTO CORWIN_BRIDGE_QUEST_1.2B~
	END

APPEND BDCORWIN
	IF ~~ THEN BEGIN CORWIN_BRIDGE_QUEST_1.1
		SAY @2001 /* ~That's actually not a bad idea.  I'll have Bence see to it.~ */
		++ @2002 /* ~While you do that, I'll do a little scouting on my own.~ */ + 6
	END

	IF ~~ THEN BEGIN CORWIN_BRIDGE_QUEST_1.2A
		SAY @2003 /* ~Keep an eye out for Caelar's forces.  They could be lying in wait.~ */
		++ @2004 /* ~Tell ya what, you keep an eye out for Caelar, and I'll go see what else is out there.~ */ DO ~SetGlobal("#L_CWBridgeQuest","MYAREA",1) SetGlobalTimer("#L_CWBridgeScoutTimer","MYAREA",ONE_HOUR)~ UNSOLVED_JOURNAL @3000 EXIT
	END

	IF ~~ THEN BEGIN CORWIN_BRIDGE_QUEST_1.2B
		SAY @2005 /* ~We should keep an eye out for Caelar's forces.  They could be lying in wait.~ */
		IF ~~ THEN DO ~SetGlobal("#L_CWBridgeQuest","MYAREA",1) SetGlobalTimer("#L_CWBridgeScoutTimer","MYAREA",ONE_HOUR)~ UNSOLVED_JOURNAL @3000 EXIT
	END

	IF WEIGHT #-98 ~AreaCheck("BD1000") GlobalGT("#L_CWBridgeQuest","MYAREA",1) GlobalLT("#L_CWBridgeQuest","MYAREA",4)~ THEN BEGIN CORWIN_BRIDGE_QUEST_2.1A
		SAY	@2012 /* ~<CHARNAME>, welcome back.  I'm glad to see you're in one piece.  Do you have anything to report?~ */
		++ @2013 /* ~Only bad news, I'm afraid.  Caelar's forces have control of the bridge.~ */ UNSOLVED_JOURNAL @3003 + CORWIN_BRIDGE_QUEST_2.1A2
	END

	IF ~~ THEN BEGIN CORWIN_BRIDGE_QUEST_2.1A2
		SAY @2014 /* ~That is not what I had hoped to hear, but I can't say it's completely unexpected.  Any ideas on how we should proceed?~ */
		+ ~Global("#L_WeakPoison","GLOBAL",1)~ + @2015 /* ~Well, Caelar's attack on the palace wasn't meant to kill me.  So, they must be waiting for their people to return with me in tow or they'd have just destroyed the bridge and moved on.~ */ GOTO CORWIN_BRIDGE_QUEST_2.2A
		+ ~Global("#L_WeakPoison","GLOBAL",0) Global("#L_SoDStatOptions","GLOBAL",1) CheckStatGT(Player1,9,INT)~ + @2016 /* ~Well, they must be waiting for something, or they'd just have destroyed the bridge and move on.  Maybe they're waiting for their people who attacked the palace?~ */ GOTO CORWIN_BRIDGE_QUEST_2.2A
		++ @2020 /* ~We need to cross that bridge.  They're in our way.  We have to confront them sooner or later.  Now works for me.  I say we attack.~ */ + CORWIN_BRIDGE_QUEST_2.2B
	END

	IF WEIGHT #-97 ~AreaCheck("BD1000") Global("#L_CWBridgeQuest","MYAREA",1) GlobalTimerExpired("#L_CWBridgeScoutTimer","MYAREA") See(Player1)~ THEN BEGIN CORWIN_BRIDGE_QUEST_2.1B
		SAY	@2011 /* ~<CHARNAME>, I'm glad you're back.  The scouts have returned with bad news.  Caelar's forces have control of the bridge.  We need to discuss options.~ */
		+ ~Global("#L_WeakPoison","GLOBAL",1)~ + @2015 /* ~Well, Caelar's attack on the palace wasn't meant to kill me.  So, they must be waiting for their people to return with me in tow or they'd have just destroyed the bridge and moved on.~ */ UNSOLVED_JOURNAL @3004 GOTO CORWIN_BRIDGE_QUEST_2.2A
		+ ~Global("#L_WeakPoison","GLOBAL",0) Global("#L_SoDStatOptions","GLOBAL",1) CheckStatGT(Player1,9,INT)~ + @2016 /* ~Well, they must be waiting for something, or they'd just have destroyed the bridge and move on.  Maybe they're waiting for their people who attacked the palace?~ */ UNSOLVED_JOURNAL @3004 GOTO CORWIN_BRIDGE_QUEST_2.2A
		++ @2020 /* ~We need to cross that bridge.  They're in our way.  We have to confront them sooner or later.  Now works for me.  I say we attack.~ */ UNSOLVED_JOURNAL @3004 + CORWIN_BRIDGE_QUEST_2.2B
	END

	IF ~~ THEN BEGIN CORWIN_BRIDGE_QUEST_2.2A
		SAY @2017 /* ~We need to cross that bridge, no matter what they're waiting for.  I'll start preparations for launching an assault.~ */
		++ @2018 /* ~A little more information on the size of the force on the other side of the bridge might be in order, don't you think? */ + CORWIN_BRIDGE_QUEST_2.3A
	END

	IF ~~ THEN BEGIN CORWIN_BRIDGE_QUEST_2.3A
		SAY @2019 /*~That would be part of the preparations, yes.  It will take a while.  Meet here in a few hours.  I should know more by then.~ */
		IF ~~ THEN DO ~SetGlobalTimer("#L_CWBridgeScoutTimer","MYAREA",THREE_HOURS) SetGlobal("#L_CWBridgeQuest","MYAREA",4)~ EXIT
	END

	IF ~~ THEN BEGIN CORWIN_BRIDGE_QUEST_2.2B
		SAY @2021 /* ~I'll start preparations and get my people on gathering as much intel as possible.  It'll take a while.  Meet here in  a few hours.  I should know more by then.~ */
		IF ~~ THEN DO ~SetGlobalTimer("#L_CWBridgeScoutTimer","MYAREA",THREE_HOURS) SetGlobal("#L_CWBridgeQuest","MYAREA",4)~ EXIT
	END
END

APPEND BDCORWIJ
	IF WEIGHT #-99 ~AreaCheck("BD1000") GlobalGT("#L_CWBridgeQuest","MYAREA",1) GlobalLT("#L_CWBridgeQuest","MYAREA",4)~ THEN BEGIN CORWIN_BRIDGE_QUEST_2.1
		SAY	@2010 /* ~So, Caelar's forces have control of the bridge.  Just great!  Any ideas how should we proceed, <CHARNAME>?~ */
		+ ~Global("#L_WeakPoison","GLOBAL",1)~ + @2015 /* ~Well, Caelar's attack on the palace wasn't meant to kill me.  So, they must be waiting for their people to return with me in tow or they'd have just destroyed the bridge and moved on.~ */ UNSOLVED_JOURNAL @3005 GOTO CORWIN_BRIDGE_QUEST_2.2A
		+ ~Global("#L_WeakPoison","GLOBAL",0) Global("#L_SoDStatOptions","GLOBAL",1) CheckStatGT(Player1,9,INT)~ + @2016 /* ~Well, they must be waiting for something, or they'd just have destroyed the bridge and move on.  Maybe they're waiting for their people who attacked the palace?~ */ UNSOLVED_JOURNAL @3005 GOTO CORWIN_BRIDGE_QUEST_2.2A
		++ @2020 /* ~We need to cross that bridge.  They're in our way.  We have to confront them sooner or later.  Now works for me.  I say we attack.~ */ UNSOLVED_JOURNAL @3005 + CORWIN_BRIDGE_QUEST_2.2B
	END

	IF ~~ THEN BEGIN CORWIN_BRIDGE_QUEST_2.2A
		SAY @2017 /* ~We need to cross that bridge, no matter what they're waiting for.  I'll start preparations for launching an assault.~ */
		++ @2018 /* ~A little more information on the size of the force on the other side of the bridge might be in order, don't you think? */ + CORWIN_BRIDGE_QUEST_2.3A
	END

	IF ~~ THEN BEGIN CORWIN_BRIDGE_QUEST_2.3A
		SAY @2022 /* ~That would be part of the preparations, yes.  It will take a while.  Meet me back at camp in a few hours.  I should know more by then.~ */
		IF ~~ THEN DO ~SetGlobalTimer("#L_CWBridgeScoutTimer","MYAREA",THREE_HOURS) SetGlobal("#L_CWBridgeQuest","MYAREA",4) LeaveParty() MoveToPoint([570.3520])~ EXIT
	END

	IF ~~ THEN BEGIN CORWIN_BRIDGE_QUEST_2.2B
		SAY @2023 /* ~I'll start preparations and get my people on gathering as much intel as possible.  It'll take a while.  Meet me back at camp in a few hours.  I should know more by then.~ */
		IF ~~ THEN DO ~SetGlobalTimer("#L_CWBridgeScoutTimer","MYAREA",THREE_HOURS) SetGlobal("#L_CWBridgeQuest","MYAREA",4) LeaveParty() MoveToPoint([570.3520])~ EXIT
	END
END

APPEND BDPOOL21
	IF WEIGHT #-99 ~GlobalLT("#L_CWBridgeQuest","MYAREA",3) Global("#L_CWBridgeWarn","MYAREA",0)~ BEGIN CW_WARN_1
		SAY #%BRIDGE_HELD_1%
		IF ~~ THEN DO ~SetGlobal("#L_CWBridgeWarn","MYAREA",1) SetGlobal("#L_CWBridgeQuest","MYAREA",2)~ UNSOLVED_JOURNAL @3001 EXIT
	END

	IF WEIGHT #-98 ~GlobalLT("#L_CWBridgeQuest","MYAREA",3) Global("#L_CWBridgeWarn","MYAREA",1)~ BEGIN CW_WARN_2
		SAY #%BRIDGE_HELD_2%
		IF ~~ THEN DO ~SetGlobal("#L_CWBridgeWarn","MYAREA",2)~ EXIT
	END
END

APPEND BDREFG1
	IF WEIGHT #-99 ~GlobalLT("#L_CWBridgeQuest","MYAREA",3) Global("#L_CWBridgeWarn","MYAREA",0)~ BEGIN CW_WARN_1
		SAY #%BRIDGE_HELD_1%
		IF ~~ THEN DO ~SetGlobal("#L_CWBridgeWarn","MYAREA",1) SetGlobal("#L_CWBridgeQuest","MYAREA",2)~ UNSOLVED_JOURNAL @3001 EXIT
	END

	IF WEIGHT #-98 ~GlobalLT("#L_CWBridgeQuest","MYAREA",3) Global("#L_CWBridgeWarn","MYAREA",1)~ BEGIN CW_WARN_2
		SAY #%BRIDGE_HELD_2%
		IF ~~ THEN DO ~SetGlobal("#L_CWBridgeWarn","MYAREA",2)~ EXIT
	END
END

APPEND BDREFG2
	IF WEIGHT #-99 ~GlobalLT("#L_CWBridgeQuest","MYAREA",3) Global("#L_CWBridgeWarn","MYAREA",0)~ BEGIN CW_WARN_1
		SAY #%BRIDGE_HELD_1%
		IF ~~ THEN DO ~SetGlobal("#L_CWBridgeWarn","MYAREA",1) SetGlobal("#L_CWBridgeQuest","MYAREA",2)~ UNSOLVED_JOURNAL @3001 EXIT
	END

	IF WEIGHT #-98 ~GlobalLT("#L_CWBridgeQuest","MYAREA",3) Global("#L_CWBridgeWarn","MYAREA",1)~ BEGIN CW_WARN_2
		SAY #%BRIDGE_HELD_2%
		IF ~~ THEN DO ~SetGlobal("#L_CWBridgeWarn","MYAREA",2)~ EXIT
	END
END

APPEND BDREFG3
	IF WEIGHT #-99 ~GlobalLT("#L_CWBridgeQuest","MYAREA",3) Global("#L_CWBridgeWarn","MYAREA",0)~ BEGIN CW_WARN_1
		SAY #%BRIDGE_HELD_1%
		IF ~~ THEN DO ~SetGlobal("#L_CWBridgeWarn","MYAREA",1) SetGlobal("#L_CWBridgeQuest","MYAREA",2)~ UNSOLVED_JOURNAL @3001 EXIT
	END

	IF WEIGHT #-98 ~GlobalLT("#L_CWBridgeQuest","MYAREA",3) Global("#L_CWBridgeWarn","MYAREA",1)~ BEGIN CW_WARN_2
		SAY #%BRIDGE_HELD_2%
		IF ~~ THEN DO ~SetGlobal("#L_CWBridgeWarn","MYAREA",2)~ EXIT
	END
END

APPEND BDREFG4
	IF WEIGHT #-99 ~GlobalLT("#L_CWBridgeQuest","MYAREA",3) Global("#L_CWBridgeWarn","MYAREA",0)~ BEGIN CW_WARN_1
		SAY #%BRIDGE_HELD_1%
		IF ~~ THEN DO ~SetGlobal("#L_CWBridgeWarn","MYAREA",1) SetGlobal("#L_CWBridgeQuest","MYAREA",2)~ UNSOLVED_JOURNAL @3001 EXIT
	END

	IF WEIGHT #-98 ~GlobalLT("#L_CWBridgeQuest","MYAREA",3) Global("#L_CWBridgeWarn","MYAREA",1)~ BEGIN CW_WARN_2
		SAY #%BRIDGE_HELD_2%
		IF ~~ THEN DO ~SetGlobal("#L_CWBridgeWarn","MYAREA",2)~ EXIT
	END
END

EXTEND_TOP BDSCRY 0 #0
	IF ~Global("bd_sddd12_bridge","LOCALS",0) GlobalLT("BD_Plot","GLOBAL",156)~ THEN REPLY @2030 /* ~The Coast Way Bridge...~ */ GOTO SCRY_POOL_BRIDGE
END

APPEND BDSCRY
	IF ~~ THEN BEGIN SCRY_POOL_BRIDGE
		SAY @2031 /* ~Instead of a person, what weighs heavily on your mind is the bridge you must cross.  As you think of it, the pool grows calm. An indistinct image appears within it, quickly growing in clarity. You find yourself watching a scene unfold from above, as a god might do.~ */
		IF ~~ THEN DO ~SetGlobal("BD_SDDD12_CLOUDY","MYAREA",1) SetGlobal("bd_sddd12_bridge","LOCALS",1) StartCutSceneMode() StartCutSceneEx("#LCWBQ01",FALSE)~ EXIT
	END
END

