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
		++ @2004 /* ~Tell ya what, you keep an eye out for Caelar, and I'll go see what else is out there.~ */ DO ~SetGlobal("#L_CWBridgeQuest","GLOBAL",1) SetGlobalTimer("#L_CWBridgeScoutTimer","MYAREA",EIGHT_HOURS)~ UNSOLVED_JOURNAL @3000 EXIT
	END

	IF ~~ THEN BEGIN CORWIN_BRIDGE_QUEST_1.2B
		SAY @2005 /* ~We should keep an eye out for Caelar's forces.  They could be lying in wait.~ */
		IF ~~ THEN DO ~SetGlobal("#L_CWBridgeQuest","GLOBAL",1) SetGlobalTimer("#L_CWBridgeScoutTimer","MYAREA",EIGHT_HOURS)~ UNSOLVED_JOURNAL @3000 EXIT
	END

	IF WEIGHT #-98 ~AreaCheck("BD1000") GlobalGT("#L_CWBridgeQuest","GLOBAL",1) GlobalLT("#L_CWBridgeQuest","GLOBAL",4)~ THEN BEGIN CORWIN_BRIDGE_QUEST_2.1A
		SAY	@2012 /* ~<CHARNAME>, welcome back.  I'm glad to see you're in one piece.  Do you have anything to report?~ */
		++ @2013 /* ~Only bad news, I'm afraid.  Caelar's forces have control of the bridge.~ */ UNSOLVED_JOURNAL @3003 + CORWIN_BRIDGE_QUEST_2.1A2
	END

	IF ~~ THEN BEGIN CORWIN_BRIDGE_QUEST_2.1A2
		SAY @2014 /* ~That is not what I had hoped to hear, but I can't say it's completely unexpected.  Any ideas on how we should proceed?~ */
		+ ~Global("#L_WeakPoison","GLOBAL",1)~ + @2015 /* ~Well, Caelar's attack on the palace wasn't meant to kill me.  So, they must be waiting for their people to return with me in tow or they'd have just destroyed the bridge and moved on.~ */ GOTO CORWIN_BRIDGE_QUEST_2.2A
		+ ~Global("#L_WeakPoison","GLOBAL",0) Global("#L_SoDStatOptions","GLOBAL",1) CheckStatGT(Player1,9,INT)~ + @2016 /* ~Well, they must be waiting for something, or they'd just have destroyed the bridge and move on.  Maybe they're waiting for their people who attacked the palace?~ */ GOTO CORWIN_BRIDGE_QUEST_2.2A
		++ @2020 /* ~We need to cross that bridge.  They're in our way.  We have to confront them sooner or later.  Now works for me.  I say we attack.~ */ + CORWIN_BRIDGE_QUEST_2.2B
	END

	IF WEIGHT #-97 ~AreaCheck("BD1000") Global("#L_CWBridgeQuest","GLOBAL",1) GlobalTimerExpired("#L_CWBridgeScoutTimer","MYAREA") See(Player1)~ THEN BEGIN CORWIN_BRIDGE_QUEST_2.1B
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
		IF ~~ THEN DO ~SetGlobalTimer("#L_CWBridgeScoutTimer","MYAREA",THREE_HOURS) SetGlobal("#L_CWBridgeQuest","GLOBAL",4)~ EXIT
	END

	IF ~~ THEN BEGIN CORWIN_BRIDGE_QUEST_2.2B
		SAY @2021 /* ~I'll start preparations and get my people on gathering as much intel as possible.  It'll take a while.  Meet here in  a few hours.  I should know more by then.~ */
		IF ~~ THEN DO ~SetGlobalTimer("#L_CWBridgeScoutTimer","MYAREA",THREE_HOURS) SetGlobal("#L_CWBridgeQuest","GLOBAL",4)~ EXIT
	END
	
	IF WEIGHT #-96 ~AreaCheck("BD1000") Global("#L_CWBridgeExplosivesTalk","GLOBAL",0) Global("#L_CWBridgeQuest","GLOBAL",4) Global("#L_CWBridgeRigged","GLOBAL",1)~ BEGIN CORWIN_BRIDGE_QUEST_3.1A
		SAY	@2042 /* ~Ahh, good you're back, <CHARNAME>.  Have you been able to learn anything more about Caelar's forces on the bridge?~ */
		++ @2043 /* ~The news keeps getting worse, I'm afraid.  The bridge is rigged with barrels of explosives.  One fire arrow and the whole bridge could come down.~ */ DO ~SetGlobal("#L_CWBridgeExplosivesTalk","GLOBAL",1)~ GOTO CORWIN_BRIDGE_QUEST_3.2A
	END
	
	IF ~~ THEN BEGIN CORWIN_BRIDGE_QUEST_3.2A
		SAY @2040 /* ~This complicates things.  We'll need to get rid of those barrels before making any sort of assault.~ */
		IF ~~ THEN GOTO CORWIN_BRIDGE_QUEST_3.2B
	END
	
	IF WEIGHT #-95 ~AreaCheck("BD1000") Global("#L_CWBridgeExplosivesTalk","GLOBAL",0) Global("#L_CWBridgeRigged","GLOBAL",0) GlobalTimerExpired("#L_CWBridgeScoutTimer","MYAREA")~ BEGIN CORWIN_BRIDGE_QUEST_3.1B
		SAY @2041 /* ~Good timing <CHARNAME>.  We've been able to ascertain that the bridge is very likely rigged with barrels of explosives.  We'll need to get rid of them before making any sort of assault.~ */
		IF ~~ THEN DO ~SetGlobal("#L_CWBridgeExplosivesTalk","GLOBAL",1)~ GOTO CORWIN_BRIDGE_QUEST_3.2B
	END
	
	IF ~~ THEN BEGIN CORWIN_BRIDGE_QUEST_3.2B
		SAY @2044 /* ~Do you have any ideas how we should deal with them?~ */
		IF ~Global("#L_WeakPoison","GLOBAL",1) RandomNum(10,1)~ THEN REPLY @2045 /* ~I do have one crazy idea.  They are expecting those assassins Caelar sent to the palace to return with me in tow.  We could give them that. Half way across we might be able to throw those barrels into the river before they're able to be lit.~ */ DO ~SetGlobal("#L_CWBridgeQuest","GLOBAL",6)~ UNSOLVED_JOURNAL @3009 + CORWIN_BRIDGE_QUEST_3.3A
		IF ~Global("#L_WeakPoison","GLOBAL",1) RandomNumGT(10,1)~ THEN REPLY @2045 /* ~I do have one crazy idea.  They are expecting those assassins Caelar sent to the palace to return with me in tow.  We could give them that. Half way across we might be able to throw those barrels into the river before they're able to be lit.~ */ DO ~SetGlobal("#L_CWBridgeQuest","GLOBAL",6)~ UNSOLVED_JOURNAL @3011 + CORWIN_BRIDGE_QUEST_3.3B1
		IF ~Global("#L_WeakPoison","GLOBAL",0) Global("#L_SoDStatOptions","GLOBAL",1) CheckStatGT(Player1,9,INT) RandomNumLT(10,6)~ THEN REPLY @2046 /* ~I do have one crazy idea.  They're probably expecting Caelar's assassins to return from their attack on the palace.  We could give them that.  Half way across we might be able to throw those barrels into the river before they're able to be lit.~ */ DO ~SetGlobal("#L_CWBridgeQuest","GLOBAL",5)~ UNSOLVED_JOURNAL @3008 + CORWIN_BRIDGE_QUEST_3.3C
		IF ~Global("#L_WeakPoison","GLOBAL",0) Global("#L_SoDStatOptions","GLOBAL",1) CheckStatGT(Player1,9,INT) RandomNumGT(10,5)~ THEN REPLY @2046 /* ~I do have one crazy idea.  They're probably expecting Caelar's assassins to return from their attack on the palace.  We could give them that.  Half way across we might be able to throw those barrels into the river before they're able to be lit.~ */ DO ~SetGlobal("#L_CWBridgeQuest","GLOBAL",5)~ UNSOLVED_JOURNAL @3010 + CORWIN_BRIDGE_QUEST_3.3D1
		IF ~RandomNumGT(10,1)~ THEN REPLY @2047 /* ~If we can get a small group disguised as Caelar's crusaders past the guards at the bridge entrance, we might be able to throw those barrels into the river before they're able to be lit.~ */ DO ~SetGlobal("#L_CWBridgeQuest","GLOBAL",5)~ UNSOLVED_JOURNAL @3008 + CORWIN_BRIDGE_QUEST_3.3C
		IF ~RandomNum(10,1)~ THEN REPLY @2047 /* ~If we can get a small group disguised as Caelar's crusaders past the guards at the bridge entrance, we might be able to throw those barrels into the river before they're able to be lit.~ */ DO ~SetGlobal("#L_CWBridgeQuest","GLOBAL",5)~ UNSOLVED_JOURNAL @3010 + CORWIN_BRIDGE_QUEST_3.3D1
	END
	
	IF ~~ THEN BEGIN CORWIN_BRIDGE_QUEST_3.3A // Didn't think of password - going with Fist as their wookiee
		SAY @2048 /* ~This could work.  It's risky, but I don't see a better option.  If we try to rush it, they'll blow the bridge for sure.~ */
		IF ~~ THEN GOTO CORWIN_BRIDGE_QUEST_3.4A
	END
	
	IF ~~ THEN BEGIN CORWIN_BRIDGE_QUEST_3.3B1 // Thought of password - going with Fist as their wookiee
		SAY @2048 /* ~This could work.  It's risky, but I don't see a better option.  If we try to rush it, they'll blow the bridge for sure.~ */
		IF ~~ THEN REPLY @2051 /* ~What if a password is required?~ */ GOTO CORWIN_BRIDGE_QUEST_3.3B2
	END
	
	IF ~~ THEN BEGIN CORWIN_BRIDGE_QUEST_3.3B2
		SAY @2052 /* ~Hmm...I'll get one of our mages to charm a guard.  If there's a password, we'll learn what it is.~ */
		IF ~~ THEN DO ~SetGlobal("#L_CWBridgePassword","GLOBAL",1)~ GOTO CORWIN_BRIDGE_QUEST_3.4A
	END
	
	IF ~~ THEN BEGIN CORWIN_BRIDGE_QUEST_3.3C // Didn't think of password - not going with Fist as their wookiee
		SAY @2048 /* ~This could work.  It's risky, but I don't see a better option.  If we try to rush it, they'll blow the bridge for sure.~ */
		IF ~~ THEN GOTO CORWIN_BRIDGE_QUEST_3.4B
	END
	
	IF ~~ THEN BEGIN CORWIN_BRIDGE_QUEST_3.3D1 // Thought of password - not going with Fist as their wookiee
		SAY @2048 /* ~This could work.  It's risky, but I don't see a better option.  If we try to rush it, they'll blow the bridge for sure.~ */
		IF ~~ THEN REPLY @2051 /* ~What if a password is required?~ */ GOTO CORWIN_BRIDGE_QUEST_3.3B2
	END
	
	IF ~~ THEN BEGIN CORWIN_BRIDGE_QUEST_3.3D2
		SAY @2052 /* ~Hmm...I'll get one of our mages to charm a guard.  If there's a password, we'll learn what it is.~ */
		IF ~~ THEN DO ~SetGlobal("#L_CWBridgePassword","GLOBAL",1)~ GOTO CORWIN_BRIDGE_QUEST_3.4B
	END
	
	IF ~~ THEN BEGIN CORWIN_BRIDGE_QUEST_3.4A // Going with Fist as their wookiee
		SAY @2053 /* ~The disguised Fist will meet you near the bridge entrance when you're ready.~ */
		++ @2058 /* ~Understood.  I'll head over there shortly.~ */ EXIT
	END
	
	IF ~~ THEN BEGIN CORWIN_BRIDGE_QUEST_3.4B // Going with Fist in disguise
		SAY @2053 /* ~The disguised Fist will meet you near the bridge entrance when you're ready.~ */
		++ @2054 /* ~Don't you think they will recognize me?  My face is fairly well known.  They did try to kill me, remember.~ */ GOTO CORWIN_BRIDGE_QUEST_3.5
	END
	
	IF ~~ THEN BEGIN CORWIN_BRIDGE_QUEST_3.5
		SAY @2055 /* ~We will disguise your features as much as possible.  Some of the Fist hold you in high esteem.  It will bolster their confidence.~ */
		IF ~!Global("#L_Snark","GLOBAL",0)~ THEN REPLY @2056 /* ~If you say so.  Whatever.~ */ EXIT
		IF ~~ THEN REPLY @2057 /* ~If you're sure it'll help.  Ok.~ */ EXIT
	END
END

APPEND BDCORWIJ
	IF WEIGHT #-99 ~AreaCheck("BD1000") GlobalGT("#L_CWBridgeQuest","GLOBAL",1) GlobalLT("#L_CWBridgeQuest","GLOBAL",4)~ THEN BEGIN CORWIN_BRIDGE_QUEST_2.1
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
		IF ~~ THEN DO ~SetGlobalTimer("#L_CWBridgeScoutTimer","MYAREA",THREE_HOURS) SetGlobal("#L_CWBridgeQuest","GLOBAL",4) LeaveParty() MoveToPoint([570.3520])~ EXIT
	END

	IF ~~ THEN BEGIN CORWIN_BRIDGE_QUEST_2.2B
		SAY @2023 /* ~I'll start preparations and get my people on gathering as much intel as possible.  It'll take a while.  Meet me back at camp in a few hours.  I should know more by then.~ */
		IF ~~ THEN DO ~SetGlobalTimer("#L_CWBridgeScoutTimer","MYAREA",THREE_HOURS) SetGlobal("#L_CWBridgeQuest","GLOBAL",4) LeaveParty() MoveToPoint([570.3520])~ EXIT
	END
	
	IF WEIGHT #-98 ~AreaCheck("BD1200") Global("#L_CWBridgeRigged","GLOBAL",1) Global("#L_CWBridgeExplosivesTalk","GLOBAL",0)~ BEGIN CORWIN_BRIDGE_QUEST_3.1
		SAY @2040 /* ~This complicates things.  We'll need to get rid of those barrels before making any sort of assault.~ */
		IF ~~ THEN DO ~SetGlobal("#L_CWBridgeExplosivesTalk","GLOBAL",1)~ GOTO CORWIN_BRIDGE_QUEST_3.2
	END
	
	IF ~~ THEN BEGIN CORWIN_BRIDGE_QUEST_3.2
		SAY @2044 /* ~Do you have any ideas how we should deal with them?~ */
		IF ~Global("#L_WeakPoison","GLOBAL",1) RandomNum(10,1)~ THEN REPLY @2045 /* ~I do have one crazy idea.  They are expecting those assassins Caelar sent to the palace to return with me in tow.  We could give them that. Half way across we might be able to throw those barrels into the river before they're able to be lit.~ */ DO ~SetGlobal("#L_CWBridgeQuest","GLOBAL",6)~ UNSOLVED_JOURNAL @3009 + CORWIN_BRIDGE_QUEST_3.3A
		IF ~Global("#L_WeakPoison","GLOBAL",1) RandomNumGT(10,1)~ THEN REPLY @2045 /* ~I do have one crazy idea.  They are expecting those assassins Caelar sent to the palace to return with me in tow.  We could give them that. Half way across we might be able to throw those barrels into the river before they're able to be lit.~ */ DO ~SetGlobal("#L_CWBridgeQuest","GLOBAL",6)~ UNSOLVED_JOURNAL @3011 + CORWIN_BRIDGE_QUEST_3.3B1
		IF ~Global("#L_WeakPoison","GLOBAL",0) Global("#L_SoDStatOptions","GLOBAL",1) CheckStatGT(Player1,9,INT) RandomNumLT(10,6)~ THEN REPLY @2046 /* ~I do have one crazy idea.  They're probably expecting Caelar's assassins to return from their attack on the palace.  We could give them that.  Half way across we might be able to throw those barrels into the river before they're able to be lit.~ */ DO ~SetGlobal("#L_CWBridgeQuest","GLOBAL",5)~ UNSOLVED_JOURNAL @3008 + CORWIN_BRIDGE_QUEST_3.3A
		IF ~Global("#L_WeakPoison","GLOBAL",0) Global("#L_SoDStatOptions","GLOBAL",1) CheckStatGT(Player1,9,INT) RandomNumGT(10,5)~ THEN REPLY @2046 /* ~I do have one crazy idea.  They're probably expecting Caelar's assassins to return from their attack on the palace.  We could give them that.  Half way across we might be able to throw those barrels into the river before they're able to be lit.~ */ DO ~SetGlobal("#L_CWBridgeQuest","GLOBAL",5)~ UNSOLVED_JOURNAL @3010 + CORWIN_BRIDGE_QUEST_3.3B1
		IF ~RandomNumGT(10,1)~ THEN REPLY @2047 /* ~If we can get a small group disguised as Caelar's crusaders past the guards at the bridge entrance, we might be able to throw those barrels into the river before they're able to be lit.~ */ DO ~SetGlobal("#L_CWBridgeQuest","GLOBAL",5)~ UNSOLVED_JOURNAL @3008 + CORWIN_BRIDGE_QUEST_3.3A
		IF ~RandomNum(10,1)~ THEN REPLY @2047 /* ~If we can get a small group disguised as Caelar's crusaders past the guards at the bridge entrance, we might be able to throw those barrels into the river before they're able to be lit.~ */ DO ~SetGlobal("#L_CWBridgeQuest","GLOBAL",5)~ UNSOLVED_JOURNAL @3010 + CORWIN_BRIDGE_QUEST_3.3B1
	END
	
	IF ~~ THEN BEGIN CORWIN_BRIDGE_QUEST_3.3A
		SAY @2048 /* ~This could work.  It's risky, but I don't see a better option.  If we try to rush it, they'll blow the bridge for sure.~ */
		IF ~~ THEN GOTO CORWIN_BRIDGE_QUEST_3.4
	END
	
	IF ~~ THEN BEGIN CORWIN_BRIDGE_QUEST_3.3B1
		SAY @2048 /* ~This could work.  It's risky, but I don't see a better option.  If we try to rush it, they'll blow the bridge for sure.~ */
		IF ~~ THEN REPLY @2051 /* ~What if a password is required?~ */ GOTO CORWIN_BRIDGE_QUEST_3.3B2
	END
	
	IF ~~ THEN BEGIN CORWIN_BRIDGE_QUEST_3.3B2
		SAY @2052 /* ~Hmm...I'll get one of our mages to charm a guard.  If there's a password, we'll learn what it is.~ */
		IF ~~ THEN DO ~SetGlobal("#L_CWBridgePassword","GLOBAL",1)~ GOTO CORWIN_BRIDGE_QUEST_3.4
	END
	
	IF ~~ THEN BEGIN CORWIN_BRIDGE_QUEST_3.4
		SAY @2049 /* ~As soon as we're out of this dungeon, I'll go get my people prepared for this.~ */
		IF ~~ THEN EXIT
	END
	
	IF WEIGHT #-97 ~AreaCheck("BD1000") Global("#L_CWBridgeRigged","GLOBAL",1) Global("#L_CWBridgeExplosivesTalk","GLOBAL",1) Global("#L_CWBridgeFFPrepped","GLOBAL",0)~ BEGIN CORWIN_BRIDGE_QUEST_4.1
		SAY @2050 /* ~I need to get our plan in motion.  Meet me at the bridge as soon as you can.  We'll be ready and I can rejoin you there.~ */
		IF ~~ THEN REPLY @2058 /* ~Understood.  I'll head over there shortly.~ */ DO ~SetGlobal("#L_CWBridgeFFPrepped","GLOBAL",1) LeaveParty() EscapeAreaMove("bd1000",2905,1495,NE)~ EXIT
	END
END

APPEND BDPOOL21
	IF WEIGHT #-99 ~GlobalLT("#L_CWBridgeQuest","GLOBAL",3) Global("#L_CWBridgeWarn","GLOBAL",0)~ BEGIN CW_WARN_1
		SAY #%BRIDGE_HELD_1%
		IF ~~ THEN DO ~SetGlobal("#L_CWBridgeWarn","GLOBAL",1) SetGlobal("#L_CWBridgeQuest","GLOBAL",2)~ UNSOLVED_JOURNAL @3001 EXIT
	END

	IF WEIGHT #-98 ~GlobalLT("#L_CWBridgeQuest","GLOBAL",3) Global("#L_CWBridgeWarn","GLOBAL",1)~ BEGIN CW_WARN_2
		SAY #%BRIDGE_HELD_2%
		IF ~~ THEN DO ~SetGlobal("#L_CWBridgeWarn","GLOBAL",2)~ EXIT
	END
END

APPEND BDREFG1
	IF WEIGHT #-99 ~GlobalLT("#L_CWBridgeQuest","GLOBAL",3) Global("#L_CWBridgeWarn","GLOBAL",0)~ BEGIN CW_WARN_1
		SAY #%BRIDGE_HELD_1%
		IF ~~ THEN DO ~SetGlobal("#L_CWBridgeWarn","GLOBAL",1) SetGlobal("#L_CWBridgeQuest","GLOBAL",2)~ UNSOLVED_JOURNAL @3001 EXIT
	END

	IF WEIGHT #-98 ~GlobalLT("#L_CWBridgeQuest","GLOBAL",3) Global("#L_CWBridgeWarn","GLOBAL",1)~ BEGIN CW_WARN_2
		SAY #%BRIDGE_HELD_2%
		IF ~~ THEN DO ~SetGlobal("#L_CWBridgeWarn","GLOBAL",2)~ EXIT
	END
END

APPEND BDREFG2
	IF WEIGHT #-99 ~GlobalLT("#L_CWBridgeQuest","GLOBAL",3) Global("#L_CWBridgeWarn","GLOBAL",0)~ BEGIN CW_WARN_1
		SAY #%BRIDGE_HELD_1%
		IF ~~ THEN DO ~SetGlobal("#L_CWBridgeWarn","GLOBAL",1) SetGlobal("#L_CWBridgeQuest","GLOBAL",2)~ UNSOLVED_JOURNAL @3001 EXIT
	END

	IF WEIGHT #-98 ~GlobalLT("#L_CWBridgeQuest","GLOBAL",3) Global("#L_CWBridgeWarn","GLOBAL",1)~ BEGIN CW_WARN_2
		SAY #%BRIDGE_HELD_2%
		IF ~~ THEN DO ~SetGlobal("#L_CWBridgeWarn","GLOBAL",2)~ EXIT
	END
END

APPEND BDREFG3
	IF WEIGHT #-99 ~GlobalLT("#L_CWBridgeQuest","GLOBAL",3) Global("#L_CWBridgeWarn","GLOBAL",0)~ BEGIN CW_WARN_1
		SAY #%BRIDGE_HELD_1%
		IF ~~ THEN DO ~SetGlobal("#L_CWBridgeWarn","GLOBAL",1) SetGlobal("#L_CWBridgeQuest","GLOBAL",2)~ UNSOLVED_JOURNAL @3001 EXIT
	END

	IF WEIGHT #-98 ~GlobalLT("#L_CWBridgeQuest","GLOBAL",3) Global("#L_CWBridgeWarn","GLOBAL",1)~ BEGIN CW_WARN_2
		SAY #%BRIDGE_HELD_2%
		IF ~~ THEN DO ~SetGlobal("#L_CWBridgeWarn","GLOBAL",2)~ EXIT
	END
END

APPEND BDREFG4
	IF WEIGHT #-99 ~GlobalLT("#L_CWBridgeQuest","GLOBAL",3) Global("#L_CWBridgeWarn","GLOBAL",0)~ BEGIN CW_WARN_1
		SAY #%BRIDGE_HELD_1%
		IF ~~ THEN DO ~SetGlobal("#L_CWBridgeWarn","GLOBAL",1) SetGlobal("#L_CWBridgeQuest","GLOBAL",2)~ UNSOLVED_JOURNAL @3001 EXIT
	END

	IF WEIGHT #-98 ~GlobalLT("#L_CWBridgeQuest","GLOBAL",3) Global("#L_CWBridgeWarn","GLOBAL",1)~ BEGIN CW_WARN_2
		SAY #%BRIDGE_HELD_2%
		IF ~~ THEN DO ~SetGlobal("#L_CWBridgeWarn","GLOBAL",2)~ EXIT
	END
END

EXTEND_TOP BDSCRY 0 #0
	IF ~Global("bd_sddd12_bridge","LOCALS",0) GlobalLT("BD_Plot","GLOBAL",156)~ THEN REPLY @2030 /* ~The Coast Way Crossing...~ */ GOTO SCRY_POOL_CWBridge
END

APPEND BDSCRY
	IF ~~ THEN BEGIN SCRY_POOL_CWBridge
		SAY @2031 /* ~Instead of a person, what weighs heavily on your mind is the bridge you must cross.  As you think of it, the pool grows calm. An indistinct image appears within it, quickly growing in clarity. You find yourself watching a scene unfold from above, as a god might do.~ */
		IF ~~ THEN DO ~SetGlobal("BD_SDDD12_CLOUDY","MYAREA",1) SetGlobal("bd_sddd12_bridge","LOCALS",1) StartCutSceneMode() StartCutSceneEx("#LCWBQ01",FALSE)~ EXIT
	END
END

