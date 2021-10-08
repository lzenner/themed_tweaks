//////////////////////////////////////////////////////////////////////
// Dialogue needed for the optional Coastway Bridge quest component //
// Compiled via coastway_bridge.tpa                                 //
//////////////////////////////////////////////////////////////////////

EXTEND_BOTTOM BDCORWIN 5
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
	
ADD_STATE_TRIGGER BDCORWIN 14 ~GlobalLT("#L_CWBridgeQuest","GLOBAL",98)~
ADD_STATE_TRIGGER BDBENCE 15 ~GlobalLT("#L_CWBridgeQuest","GLOBAL",98)~

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
		+ ~Global("#L_SoDStat_WeakPoison","GLOBAL",1)~ + @2015 /* ~Well, Caelar's attack on the palace wasn't meant to kill me.  So, they must be waiting for their people to return with me in tow or they'd have just destroyed the bridge and moved on.~ */ GOTO CORWIN_BRIDGE_QUEST_2.2A
		+ ~Global("#L_SoDStat_WeakPoison","GLOBAL",0) Global("#L_SoDStatOptions","GLOBAL",1) CheckStatGT(Player1,9,INT)~ + @2016 /* ~Well, they must be waiting for something, or they'd just have destroyed the bridge and move on.  Maybe they're waiting for their people who attacked the palace?~ */ GOTO CORWIN_BRIDGE_QUEST_2.2A
		++ @2020 /* ~We need to cross that bridge.  They're in our way.  We have to confront them sooner or later.  Now works for me.  I say we attack.~ */ + CORWIN_BRIDGE_QUEST_2.2B
	END

	IF WEIGHT #-97 ~AreaCheck("BD1000") Global("#L_CWBridgeQuest","GLOBAL",1) GlobalTimerExpired("#L_CWBridgeScoutTimer","MYAREA") See(Player1)~ THEN BEGIN CORWIN_BRIDGE_QUEST_2.1B
		SAY	@2011 /* ~<CHARNAME>, I'm glad you're back.  The scouts have returned with bad news.  Caelar's forces have control of the bridge.  We need to discuss options.~ */
		+ ~Global("#L_SoDStat_WeakPoison","GLOBAL",1)~ + @2015 /* ~Well, Caelar's attack on the palace wasn't meant to kill me.  So, they must be waiting for their people to return with me in tow or they'd have just destroyed the bridge and moved on.~ */ UNSOLVED_JOURNAL @3004 GOTO CORWIN_BRIDGE_QUEST_2.2A
		+ ~Global("#L_SoDStat_WeakPoison","GLOBAL",0) Global("#L_SoDStatOptions","GLOBAL",1) CheckStatGT(Player1,9,INT)~ + @2016 /* ~Well, they must be waiting for something, or they'd just have destroyed the bridge and move on.  Maybe they're waiting for their people who attacked the palace?~ */ UNSOLVED_JOURNAL @3004 GOTO CORWIN_BRIDGE_QUEST_2.2A
		++ @2020 /* ~We need to cross that bridge.  They're in our way.  We have to confront them sooner or later.  Now works for me.  I say we attack.~ */ UNSOLVED_JOURNAL @3004 + CORWIN_BRIDGE_QUEST_2.2B
	END

	IF ~~ THEN BEGIN CORWIN_BRIDGE_QUEST_2.2A
		SAY @2017 /* ~We need to cross that bridge, no matter what they're waiting for.  I'll start preparations for launching an assault.~ */
		++ @2018 /* ~A little more information on the size of the force on the other side of the bridge might be in order, don't you think? */ + CORWIN_BRIDGE_QUEST_2.3A
	END

	IF ~~ THEN BEGIN CORWIN_BRIDGE_QUEST_2.3A
		SAY @2019 /*~That would be part of the preparations, yes.  It will take a while.  Meet here in a few hours.  I should know more by then.~ */
		IF ~~ THEN DO ~SetGlobalTimer("#L_CWBridgeScoutTimer","MYAREA",THREE_HOURS) SetGlobal("#L_CWBridgeQuest","GLOBAL",4)~ EXIT
		IF ~Global("#L_SoDStat_DaustonTalk","GLOBAL",2)~ THEN DO ~SetGlobalTimer("#L_CWBridgeScoutTimer","MYAREA",THREE_HOURS) SetGlobal("#L_CWBridgeQuest","GLOBAL",4)~ GOTO MESSAGE_FOR_YOU_SIR
	END

	IF ~~ THEN BEGIN CORWIN_BRIDGE_QUEST_2.2B
		SAY @2021 /* ~I'll start preparations and get my people on gathering as much intel as possible.  It'll take a while.  Meet here in  a few hours.  I should know more by then.~ */
		IF ~~ THEN DO ~SetGlobalTimer("#L_CWBridgeScoutTimer","MYAREA",THREE_HOURS) SetGlobal("#L_CWBridgeQuest","GLOBAL",4)~ EXIT
		IF ~Global("#L_SoDStat_DaustonTalk","GLOBAL",2)~ THEN DO ~SetGlobalTimer("#L_CWBridgeScoutTimer","MYAREA",THREE_HOURS) SetGlobal("#L_CWBridgeQuest","GLOBAL",4)~ GOTO MESSAGE_FOR_YOU_SIR
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
		IF ~Global("#L_SoDStat_WeakPoison","GLOBAL",1) RandomNum(10,1)~ THEN REPLY @2045 /* ~I do have one crazy idea.  They are expecting those assassins Caelar sent to the palace to return with me in tow.  We could give them that. Half way across we might be able to throw those barrels into the river before they're able to be lit.~ */ DO ~SetGlobal("#L_CWBridgeQuest","GLOBAL",6)~ UNSOLVED_JOURNAL @3009 + CORWIN_BRIDGE_QUEST_3.3A
		IF ~Global("#L_SoDStat_WeakPoison","GLOBAL",1) RandomNumGT(10,1)~ THEN REPLY @2045 /* ~I do have one crazy idea.  They are expecting those assassins Caelar sent to the palace to return with me in tow.  We could give them that. Half way across we might be able to throw those barrels into the river before they're able to be lit.~ */ DO ~SetGlobal("#L_CWBridgeQuest","GLOBAL",6)~ UNSOLVED_JOURNAL @3011 + CORWIN_BRIDGE_QUEST_3.3B1
		IF ~Global("#L_SoDStat_WeakPoison","GLOBAL",0) Global("#L_SoDStatOptions","GLOBAL",1) CheckStatGT(Player1,9,INT) RandomNumLT(10,6)~ THEN REPLY @2046 /* ~I do have one crazy idea.  They're probably expecting Caelar's assassins to return from their attack on the palace.  We could give them that.  Half way across we might be able to throw those barrels into the river before they're able to be lit.~ */ DO ~SetGlobal("#L_CWBridgeQuest","GLOBAL",5)~ UNSOLVED_JOURNAL @3008 + CORWIN_BRIDGE_QUEST_3.3C
		IF ~Global("#L_SoDStat_WeakPoison","GLOBAL",0) Global("#L_SoDStatOptions","GLOBAL",1) CheckStatGT(Player1,9,INT) RandomNumGT(10,5)~ THEN REPLY @2046 /* ~I do have one crazy idea.  They're probably expecting Caelar's assassins to return from their attack on the palace.  We could give them that.  Half way across we might be able to throw those barrels into the river before they're able to be lit.~ */ DO ~SetGlobal("#L_CWBridgeQuest","GLOBAL",5)~ UNSOLVED_JOURNAL @3010 + CORWIN_BRIDGE_QUEST_3.3D1
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
		++ @2071 /* ~Join me.  I've something to do before heading to the bridge, but I still want your help.~ */ GOTO CORWIN_BRIDGE_QUEST_3.6A
		++ @2098 /* ~Corwin, would you like to join me?~ */ GOTO CORWIN_BRIDGE_QUEST_3.6B
		IF ~!Global("#L_SoDStat_DaustonTalk","GLOBAL",2)~ THEN REPLY @2058 /* ~Understood.  I'll head over there shortly.~ */ EXIT
		IF ~Global("#L_SoDStat_DaustonTalk","GLOBAL",2)~ THEN REPLY @2058 /* ~Understood.  I'll head over there shortly.~ */ GOTO MESSAGE_FOR_YOU_SIR
	END
	
	IF ~~ THEN BEGIN CORWIN_BRIDGE_QUEST_3.4B // Going with Fist in disguise
		SAY @2053 /* ~The disguised Fist will meet you near the bridge entrance when you're ready.~ */
		++ @2054 /* ~Don't you think they will recognize me?  My face is fairly well known.  They did try to kill me, remember.~ */ GOTO CORWIN_BRIDGE_QUEST_3.5
	END
	
	IF ~~ THEN BEGIN CORWIN_BRIDGE_QUEST_3.5
		SAY @2055 /* ~We will disguise your features as much as possible.  Some of the Fist hold you in high esteem.  It will bolster their confidence.~ */
		++ @2071 /* ~Join me.  I've something to do before heading to the bridge, but I still want your help.~ */ GOTO CORWIN_BRIDGE_QUEST_3.6A
		++ @2098 /* ~Corwin, would you like to join me?~ */ GOTO CORWIN_BRIDGE_QUEST_3.6B
		IF ~!Global("#L_SoDStat_DaustonTalk","GLOBAL",2) !Global("#L_Snark","GLOBAL",0)~ THEN REPLY @2056 /* ~If you say so.  Whatever.~ */ EXIT
		IF ~!Global("#L_SoDStat_DaustonTalk","GLOBAL",2)~ THEN REPLY @2057 /* ~If you're sure it'll help.  Ok.~ */ EXIT
		IF ~Global("#L_SoDStat_DaustonTalk","GLOBAL",2) !Global("#L_Snark","GLOBAL",0)~ THEN REPLY @2056 /* ~If you say so.  Whatever.~ */ GOTO MESSAGE_FOR_YOU_SIR
		IF ~Global("#L_SoDStat_DaustonTalk","GLOBAL",2)~ THEN REPLY @2057 /* ~If you're sure it'll help.  Ok.~ */ GOTO MESSAGE_FOR_YOU_SIR
	END
	
	IF ~~ THEN BEGIN CORWIN_BRIDGE_QUEST_3.6A
		SAY @2075 /* ~Alright, but let's not keep the Fist waiting too long.~ */
		IF ~!Global("#L_SoDStat_DaustonTalk","GLOBAL",2)~ THEN DO ~JoinParty()~ EXIT
		IF ~Global("#L_SoDStat_DaustonTalk","GLOBAL",2)~ THEN GOTO MESSAGE_FOR_YOU_SIR_THEN_JOIN
	END
	
	IF ~~ THEN BEGIN CORWIN_BRIDGE_QUEST_3.6B
		SAY @2096 /* ~Yes, the rest of the troops will be watching for my signal~ */
		IF ~!Global("#L_SoDStat_DaustonTalk","GLOBAL",2)~ THEN DO ~JoinParty()~ EXIT
		IF ~Global("#L_SoDStat_DaustonTalk","GLOBAL",2)~ THEN GOTO MESSAGE_FOR_YOU_SIR_THEN_JOIN
	END
	
	IF WEIGHT #-90 ~AreaCheck("BD1000") Global("#L_CWBridgeQuest","GLOBAL",4)~ THEN BEGIN CORWIN_BRIDGE_QUEST_4
		SAY @2024 /* ~I have my people gathering more intel. Do you need me for something?~ */
		IF ~~ THEN REPLY #%CORWIN_NEED_1% /* ~I want you to come with me.~ */ GOTO 54
		IF ~~ THEN REPLY #%CORWIN_NEED_2% /* ~Your skills are wasted here. Stay here and they'll waste away entirely. Join me and I promise I'll find a way to put them to better use.~ */ GOTO 54
		IF ~~ THEN REPLY #%CORWIN_NEED_3% /* ~For the moment, nothing.~ */ GOTO 55
		IF ~~ THEN REPLY #%CORWIN_NEED_4% /* ~From you? Don't flatter yourself.~ */ GOTO 56
	END

	IF WEIGHT #-90 ~AreaCheck("BD1000") TriggerOverride("FF_Camp",IsOverMe("CORWIN")) OR(2) Global("#L_CWBridgeQuest","GLOBAL",5) Global("#L_CWBridgeQuest","GLOBAL",6)~ THEN BEGIN CORWIN_BRIDGE_QUEST_5
		SAY @2070 /* ~The Fist are in place and I'm ready to head to the bridge.  Are you?~ */
		++ @2071 /* ~Join me.  I've something to do before heading to the bridge, but I still want your help.~ */ GOTO CORWIN_BRIDGE_QUEST_5.1A
		++ @2072 /* ~Yes, I'm ready.  Join me.  Let's go.~ */ GOTO CORWIN_BRIDGE_QUEST_5.1B
		++ @2073 /* ~I'll meet you up there when I'm ready.~ */ GOTO CORWIN_BRIDGE_QUEST_5.1C
		++ @2074 /* ~I'm heading there now, but I won't be needing you with me.~ */ GOTO CORWIN_BRIDGE_QUEST_5.1D
	END
	
	IF ~~ THEN BEGIN CORWIN_BRIDGE_QUEST_5.1A
		SAY @2075 /* ~Alright, but let's not keep the Fist waiting too long.~ */
		IF ~!Global("#L_SoDStat_DaustonTalk","GLOBAL",2)~ THEN DO ~JoinParty()~ EXIT
		IF ~Global("#L_SoDStat_DaustonTalk","GLOBAL",2)~ THEN GOTO MESSAGE_FOR_YOU_SIR_THEN_JOIN
	END
	
	IF ~~ THEN BEGIN CORWIN_BRIDGE_QUEST_5.1B
		SAY @2076 /* ~Excellent.  Let's go!~ */
		IF ~!Global("#L_SoDStat_DaustonTalk","GLOBAL",2)~ THEN DO ~JoinParty()~ EXIT
		IF ~Global("#L_SoDStat_DaustonTalk","GLOBAL",2)~ THEN GOTO MESSAGE_FOR_YOU_SIR_THEN_JOIN
	END

	IF ~~ THEN BEGIN CORWIN_BRIDGE_QUEST_5.1C
		SAY @2077 /* ~Alright.  But don't keep us waiting too long.~ */
		IF ~!Global("#L_SoDStat_DaustonTalk","GLOBAL",2)~ THEN EXIT
		IF ~Global("#L_SoDStat_DaustonTalk","GLOBAL",2)~ THEN GOTO MESSAGE_FOR_YOU_SIR
	END
	
	IF ~~ THEN BEGIN CORWIN_BRIDGE_QUEST_5.1D
		SAY @2078 /* ~Ok, if you're sure.  I'll meet you up there, just the same.~ */
		IF ~!Global("#L_SoDStat_DaustonTalk","GLOBAL",2)~ THEN EXIT
		IF ~Global("#L_SoDStat_DaustonTalk","GLOBAL",2)~ THEN GOTO MESSAGE_FOR_YOU_SIR
	END
	
	IF WEIGHT #-89 ~AreaCheck("BD1000") !TriggerOverride("FF_Camp",IsOverMe("CORWIN")) OR(2) Global("#L_CWBridgeQuest","GLOBAL",5) Global("#L_CWBridgeQuest","GLOBAL",6) Global("#L_CWBridgeHailed","BD1000",1)~ THEN BEGIN CORWIN_BRIDGE_QUEST_6
		SAY @2095 /* ~Everything's in place.  Are you ready to do this, <CHARNAME>?~ */
		IF ~Global("#L_CWBridgePassword","GLOBAL",1)~ THEN REPLY @2096 /* ~Did we learn anything about a password? */ GOTO CORWIN_BRIDGE_QUEST_NIKTO
		IF ~!Global("#L_CWBridgePassword","GLOBAL",1) NumInParty(6)~ THEN REPLY @2097 /* ~I'm ready.  Let's go.~ */ GOTO CORWIN_BRIDGE_QUEST_HEAD_OUT
		IF ~!Global("#L_CWBridgePassword","GLOBAL",1) NumInPartyLT(6)~ THEN REPLY @2097 /* ~I'm ready.  Let's go.~ */ GOTO CORWIN_BRIDGE_QUEST_CAN_I_COME
		IF ~!Global("#L_CWBridgePassword","GLOBAL",1) NumInPartyLT(6)~ THEN REPLY @2098 /* ~I'm ready.  Would you like to join me, Corwin?~ */ GOTO CORWIN_BRIDGE_QUEST_ME_TOO
	END
	
	IF ~~ THEN BEGIN CORWIN_BRIDGE_QUEST_NIKTO
		SAY @2099 /* ~Yes, a mage was able to charm one of the guards.  The password is 'nikto'.~ */
		IF ~~ THEN REPLY @2110 /* ~And where's this informant?~ */ GOTO CORWIN_BRIDGE_QUEST_BENCE_GUARDING
	END

	IF ~~ THEN BEGIN CORWIN_BRIDGE_QUEST_BENCE_GUARDING
		SAY @2111 /* ~The charm should last a good long while yet.  Bence is making sure she doesn't wander.~  */
		IF ~NumInParty(6)~ THEN REPLY @2100 /* ~Alright, let's go.~ */ GOTO CORWIN_BRIDGE_QUEST_HEAD_OUT
		IF ~NumInPartyLT(6)~ THEN REPLY @2100 /* ~Alright, let's go.~ */ GOTO CORWIN_BRIDGE_QUEST_CAN_I_COME
		IF ~NumInPartyLT(6)~ THEN REPLY @2101 /* ~Alright.  Would you like to join me, Corwin?~ */ GOTO CORWIN_BRIDGE_QUEST_ME_TOO
	END

	IF ~~ THEN BEGIN CORWIN_BRIDGE_QUEST_CAN_I_COME
		SAY @2103 /* ~Would you like me to join you, <CHARNAME>?~ */
		++ @2104 /* ~No, that's not necessary.  You coordinate things on this end.~ */ GOTO CORWIN_BRIDGE_QUEST_HEAD_OUT
		++ @2105 /* ~I think that would be best, yes.  Let's do this!~ */ GOTO CORWIN_BRIDGE_QUEST_REST_OF_YOU
	END
	
	IF ~~ THEN BEGIN CORWIN_BRIDGE_QUEST_HEAD_OUT
		SAY @2106 /* ~You heard <PRO_HIMHER>.  Head out!~ */
		IF ~!Global("#L_SoDStat_DaustonTalk","GLOBAL",2)~ THEN DO ~StartCutSceneMode() StartCutSceneEx("#LCWBQ030",TRUE)~ EXIT
		IF ~Global("#L_SoDStat_DaustonTalk","GLOBAL",2)~ THEN GOTO MESSAGE_FOR_YOU_SIR_THEN_CUT
	END
	
	IF ~~ THEN BEGIN CORWIN_BRIDGE_QUEST_ME_TOO
		SAY @2102 /* ~Yes, I'll be right behind you.  The rest of the troops will be watching for my signal~ */
		IF ~~ THEN DO ~JoinParty() StartCutSceneMode() StartCutSceneEx("#LCWBQ030",TRUE)~ EXIT
		IF ~Global("#L_SoDStat_DaustonTalk","GLOBAL",2)~ THEN GOTO MESSAGE_FOR_YOU_SIR_THEN_JOIN_CUT
	END
	
	IF ~~ THEN BEGIN CORWIN_BRIDGE_QUEST_REST_OF_YOU
		SAY @2107 /* ~The rest of you, watch for my signal.  Let's go!~ */
		IF ~~ THEN DO ~JoinParty() StartCutSceneMode() StartCutSceneEx("#LCWBQ030",TRUE)~ EXIT
		IF ~Global("#L_SoDStat_DaustonTalk","GLOBAL",2)~ THEN GOTO MESSAGE_FOR_YOU_SIR_THEN_JOIN_CUT
	END

	IF ~~ THEN BEGIN MESSAGE_FOR_YOU_SIR
		SAY @4030 /* ~By the way, I have a message for you from Duke Eltan, <CHARNAME>.~ */
		IF ~GlobalGT("BD_PLOT","GLOBAL",160)~ THEN REPLY @4032 /* ~Better late than never I guess.  What did he find out?~ */ GOTO DAUSTON_MESSAGE_1
		IF ~GlobalLT("BD_PLOT","GLOBAL",160)~ THEN REPLY @4031 /* ~Excellent!  What did he find out?~ */ GOTO DAUSTON_MESSAGE_2
	END
	
	IF ~~ THEN BEGIN DAUSTON_MESSAGE_1
		SAY @4033 /* ~Had you kept in contact with the camp, you'd have received it much sooner.  I've had it for a while now.~ */
		IF ~~ THEN GOTO DAUSTON_MESSAGE_2
	END
	
	IF ~~ THEN BEGIN DAUSTON_MESSAGE_2
		SAY @4034 /* ~He found out that Caelar, through some fault of her own, wound up a prisoner in Avernus.~ */
		IF ~~ THEN GOTO DAUSTON_MESSAGE_3
	END
	
	IF ~~ THEN BEGIN DAUSTON_MESSAGE_3
		SAY @4035 /* ~Her uncle managed to get her out by sacrificing himself.  He is now a prisoner in Avernus...in her place.~ */
		IF ~~ THEN REPLY @4036 /* ~How awful.  But that does explain a lot.~ */ DO ~SetGlobal("#L_SoDStat_DaustonTalk","GLOBAL",3)~ SOLVED_JOURNAL @3015 EXIT
	END

	IF ~~ THEN BEGIN MESSAGE_FOR_YOU_SIR_THEN_JOIN
		SAY @4030 /* ~By the way, I have a message for you from Duke Eltan, <CHARNAME>.~ */
		IF ~GlobalGT("BD_PLOT","GLOBAL",160)~ THEN REPLY @4032 /* ~Better late than never I guess.  What did he find out?~ */ GOTO DAUSTON_MESSAGE_1J
		IF ~GlobalLT("BD_PLOT","GLOBAL",160)~ THEN REPLY @4031 /* ~Excellent!  What did he find out?~ */ GOTO DAUSTON_MESSAGE_2J
	END
	
	IF ~~ THEN BEGIN DAUSTON_MESSAGE_1J
		SAY @4033 /* ~Had you kept in contact with the camp, you'd have received it much sooner.  I've had it for a while now.~ */
		IF ~~ THEN GOTO DAUSTON_MESSAGE_2J
	END
	
	IF ~~ THEN BEGIN DAUSTON_MESSAGE_2J
		SAY @4034 /* ~He found out that Caelar, through some fault of her own, wound up a prisoner in Avernus.~ */
		IF ~~ THEN GOTO DAUSTON_MESSAGE_3J
	END
	
	IF ~~ THEN BEGIN DAUSTON_MESSAGE_3J
		SAY @4035 /* ~Her uncle managed to get her out by sacrificing himself.  He is now a prisoner in Avernus...in her place.~ */
		IF ~~ THEN REPLY @4036 /* ~How awful.  But that does explain a lot.~ */ DO ~SetGlobal("#L_SoDStat_DaustonTalk","GLOBAL",3) JoinParty()~ SOLVED_JOURNAL @3015 EXIT
	END

	IF ~~ THEN BEGIN MESSAGE_FOR_YOU_SIR_THEN_CUT
		SAY @4030 /* ~By the way, I have a message for you from Duke Eltan, <CHARNAME>.~ */
		IF ~GlobalGT("BD_PLOT","GLOBAL",160)~ THEN REPLY @4032 /* ~Better late than never I guess.  What did he find out?~ */ GOTO DAUSTON_MESSAGE_1C
		IF ~GlobalLT("BD_PLOT","GLOBAL",160)~ THEN REPLY @4031 /* ~Excellent!  What did he find out?~ */ GOTO DAUSTON_MESSAGE_2C
	END
	
	IF ~~ THEN BEGIN DAUSTON_MESSAGE_1C
		SAY @4033 /* ~Had you kept in contact with the camp, you'd have received it much sooner.  I've had it for a while now.~ */
		IF ~~ THEN GOTO DAUSTON_MESSAGE_2C
	END
	
	IF ~~ THEN BEGIN DAUSTON_MESSAGE_2C
		SAY @4034 /* ~He found out that Caelar, through some fault of her own, wound up a prisoner in Avernus.~ */
		IF ~~ THEN GOTO DAUSTON_MESSAGE_3C
	END
	
	IF ~~ THEN BEGIN DAUSTON_MESSAGE_3C
		SAY @4035 /* ~Her uncle managed to get her out by sacrificing himself.  He is now a prisoner in Avernus...in her place.~ */
		IF ~~ THEN REPLY @4036 /* ~How awful.  But that does explain a lot.~ */ DO ~SetGlobal("#L_SoDStat_DaustonTalk","GLOBAL",3) StartCutSceneMode() StartCutSceneEx("#LCWBQ030",TRUE)~ SOLVED_JOURNAL @3015 EXIT
	END

	IF ~~ THEN BEGIN MESSAGE_FOR_YOU_SIR_THEN_JOIN_CUT
		SAY @4030 /* ~By the way, I have a message for you from Duke Eltan, <CHARNAME>.~ */
		IF ~GlobalGT("BD_PLOT","GLOBAL",160)~ THEN REPLY @4032 /* ~Better late than never I guess.  What did he find out?~ */ GOTO DAUSTON_MESSAGE_1JC
		IF ~GlobalLT("BD_PLOT","GLOBAL",160)~ THEN REPLY @4031 /* ~Excellent!  What did he find out?~ */ GOTO DAUSTON_MESSAGE_2JC
	END
	
	IF ~~ THEN BEGIN DAUSTON_MESSAGE_1JC
		SAY @4033 /* ~Had you kept in contact with the camp, you'd have received it much sooner.  I've had it for a while now.~ */
		IF ~~ THEN GOTO DAUSTON_MESSAGE_2JC
	END
	
	IF ~~ THEN BEGIN DAUSTON_MESSAGE_2JC
		SAY @4034 /* ~He found out that Caelar, through some fault of her own, wound up a prisoner in Avernus.~ */
		IF ~~ THEN GOTO DAUSTON_MESSAGE_3JC
	END
	
	IF ~~ THEN BEGIN DAUSTON_MESSAGE_3JC
		SAY @4035 /* ~Her uncle managed to get her out by sacrificing himself.  He is now a prisoner in Avernus...in her place.~ */
		IF ~~ THEN REPLY @4036 /* ~How awful.  But that does explain a lot.~ */ DO ~SetGlobal("#L_SoDStat_DaustonTalk","GLOBAL",3) JoinParty() StartCutSceneMode() StartCutSceneEx("#LCWBQ030",TRUE)~ SOLVED_JOURNAL @3015 EXIT
	END
	
	IF WEIGHT #-88 ~Global("#L_CWBridgeWrap","MYAREA",1)~ THEN BEGIN THAT_WAS_UNFORTUNATE
		SAY @2150 /* ~I saw what happened.  That was unfortunate.~ */
		IF ~Global("#L_CWBridgePassword","GLOBAL",0)~ THEN REPLY @2151 /* ~Yeah, it never occured to me to check for a password.~ */ GOTO NEITHER_DID_WE
		IF ~Global("#L_CWBridgePassword","GLOBAL",1)~ THEN REPLY @2153 /* ~Unfortunate?! More like incompentence!~ */ GOTO NEED_ANOTHER_WAY
	END
	
	IF ~~ THEN BEGIN NEITHER_DID_WE
		SAY @2152 /* ~It's not your fault.  It never occured to any of us.~ */ 
		IF ~~ THEN GOTO NEED_ANOTHER_WAY
	END
	
	IF ~~ THEN BEGIN NEED_ANOTHER_WAY
		SAY @2154 /* ~Looks like we'll have to find another way to cross the bridge.~ */
		= @2155 /* ~Follow me back to camp. I need to inform Bence of our need to head for Boareskyr Bridge as soon as possible.~ */
		IF ~~ THEN DO ~SetInterrupt(FALSE) ApplySpellRES("BDHaste","CORWIN") EscapeAreaObjectMove("BD1000","FF_Camp",570,3520,W) ApplySpellRES("#LUnHast","CORWIN") SetInterrupt(TRUE)~ EXIT
	END
	
	IF WEIGHT #-87 ~Global("BD_PLOT","GLOBAL",170) Global("#L_CWBridgeWrap","MYAREA",2)~ THEN BEGIN CORPORAL_MOVE
		SAY #%CORWIN_BRIDGEFORT% /* ~We need to get to Bridgefort. Corporal, spread the word to the troops to strike camp. Make sure to mark our new path on everyone's maps. We move out as soon as our friend is ready.~ [BD35933] */
		IF ~~ THEN DO ~SetGlobal("BD_PLOT","GLOBAL",175)~ EXTERN ~BDBENCE~ 14
	END
END

APPEND BDCORWIJ
	IF WEIGHT #-99 ~AreaCheck("BD1000") GlobalGT("#L_CWBridgeQuest","GLOBAL",1) GlobalLT("#L_CWBridgeQuest","GLOBAL",4)~ THEN BEGIN CORWINJ_BRIDGE_QUEST_2.1
		SAY	@2010 /* ~So, Caelar's forces have control of the bridge.  Just great!  Any ideas how should we proceed, <CHARNAME>?~ */
		+ ~Global("#L_SoDStat_WeakPoison","GLOBAL",1)~ + @2015 /* ~Well, Caelar's attack on the palace wasn't meant to kill me.  So, they must be waiting for their people to return with me in tow or they'd have just destroyed the bridge and moved on.~ */ UNSOLVED_JOURNAL @3005 GOTO CORWINJ_BRIDGE_QUEST_2.2A
		+ ~Global("#L_SoDStat_WeakPoison","GLOBAL",0) Global("#L_SoDStatOptions","GLOBAL",1) CheckStatGT(Player1,9,INT)~ + @2016 /* ~Well, they must be waiting for something, or they'd just have destroyed the bridge and move on.  Maybe they're waiting for their people who attacked the palace?~ */ UNSOLVED_JOURNAL @3005 GOTO CORWINJ_BRIDGE_QUEST_2.2A
		++ @2020 /* ~We need to cross that bridge.  They're in our way.  We have to confront them sooner or later.  Now works for me.  I say we attack.~ */ UNSOLVED_JOURNAL @3005 + CORWINJ_BRIDGE_QUEST_2.2B
	END

	IF ~~ THEN BEGIN CORWINJ_BRIDGE_QUEST_2.2A
		SAY @2017 /* ~We need to cross that bridge, no matter what they're waiting for.  I'll start preparations for launching an assault.~ */
		++ @2018 /* ~A little more information on the size of the force on the other side of the bridge might be in order, don't you think? */ + CORWINJ_BRIDGE_QUEST_2.3A
	END

	IF ~~ THEN BEGIN CORWINJ_BRIDGE_QUEST_2.3A
		SAY @2022 /* ~That would be part of the preparations, yes.  It will take a while.  Meet me back at camp in a few hours.  I should know more by then.~ */
		IF ~~ THEN DO ~SetInterrupt(FALSE) SetGlobalTimer("#L_CWBridgeScoutTimer","MYAREA",THREE_HOURS) SetGlobal("#L_CWBridgeQuest","GLOBAL",4) LeaveParty() SetGlobal("#L_CWBridgeCorwinLeft","GLOBAL",1) ChangeAIScript("BDSHOUT",RACE) ChangeAIScript("BDFIGH01",GENERAL) ChangeAIScript("",DEFAULT) MoveToPoint([570.3520]) SetInterrupt(TRUE)~ EXIT
		IF ~NotStateCheck(MYSELF,STATE_HASTED) !Global("A7_AutoHasteActive","GLOBAL",1)~ THEN DO ~SetInterrupt(FALSE) SetGlobalTimer("#L_CWBridgeScoutTimer","MYAREA",THREE_HOURS) SetGlobal("#L_CWBridgeQuest","GLOBAL",4) LeaveParty() SetGlobal("#L_CWBridgeCorwinLeft","GLOBAL",1) ChangeAIScript("BDSHOUT",RACE) ChangeAIScript("BDFIGH01",GENERAL) ChangeAIScript("",DEFAULT) ApplySpellRES("BDHaste","CORWIN") EscapeAreaObjectMove("BD1000","FF_Camp",570,3520,W) ApplySpellRES("#LUnHast","CORWIN")~ EXIT
	END

	IF ~~ THEN BEGIN CORWINJ_BRIDGE_QUEST_2.2B
		SAY @2023 /* ~I'll start preparations and get my people on gathering as much intel as possible.  It'll take a while.  Meet me back at camp in a few hours.  I should know more by then.~ */
		IF ~~ THEN DO ~SetInterrupt(FALSE) SetGlobalTimer("#L_CWBridgeScoutTimer","MYAREA",THREE_HOURS) SetGlobal("#L_CWBridgeQuest","GLOBAL",4) LeaveParty() SetGlobal("#L_CWBridgeCorwinLeft","GLOBAL",1) ChangeAIScript("BDSHOUT",RACE) ChangeAIScript("BDFIGH01",GENERAL) ChangeAIScript("",DEFAULT) MoveToPoint([570.3520]) SetInterrupt(TRUE)~ EXIT
		IF ~NotStateCheck(MYSELF,STATE_HASTED) !Global("A7_AutoHasteActive","GLOBAL",1)~ THEN DO ~SetInterrupt(FALSE) SetGlobalTimer("#L_CWBridgeScoutTimer","MYAREA",THREE_HOURS) SetGlobal("#L_CWBridgeQuest","GLOBAL",4) LeaveParty() SetGlobal("#L_CWBridgeCorwinLeft","GLOBAL",1) ChangeAIScript("BDSHOUT",RACE) ChangeAIScript("BDFIGH01",GENERAL) ChangeAIScript("",DEFAULT) ApplySpellRES("BDHaste","CORWIN") EscapeAreaObjectMove("BD1000","FF_Camp",570,3520,W) ApplySpellRES("#LUnHast","CORWIN")~ EXIT
	END
	
	IF WEIGHT #-98 ~AreaCheck("BD1200") Global("#L_CWBridgeRigged","GLOBAL",1) Global("#L_CWBridgeExplosivesTalk","GLOBAL",0)~ BEGIN CORWINJ_BRIDGE_QUEST_3.1
		SAY @2040 /* ~This complicates things.  We'll need to get rid of those barrels before making any sort of assault.~ */
		IF ~~ THEN DO ~SetGlobal("#L_CWBridgeExplosivesTalk","GLOBAL",1)~ GOTO CORWINJ_BRIDGE_QUEST_3.2
	END
	
	IF ~~ THEN BEGIN CORWINJ_BRIDGE_QUEST_3.2
		SAY @2044 /* ~Do you have any ideas how we should deal with them?~ */
		IF ~Global("#L_SoDStat_WeakPoison","GLOBAL",1) RandomNum(10,1)~ THEN REPLY @2045 /* ~I do have one crazy idea.  They are expecting those assassins Caelar sent to the palace to return with me in tow.  We could give them that. Half way across we might be able to throw those barrels into the river before they're able to be lit.~ */ DO ~SetGlobal("#L_CWBridgeQuest","GLOBAL",6)~ UNSOLVED_JOURNAL @3009 + CORWINJ_BRIDGE_QUEST_3.3A
		IF ~Global("#L_SoDStat_WeakPoison","GLOBAL",1) RandomNumGT(10,1)~ THEN REPLY @2045 /* ~I do have one crazy idea.  They are expecting those assassins Caelar sent to the palace to return with me in tow.  We could give them that. Half way across we might be able to throw those barrels into the river before they're able to be lit.~ */ DO ~SetGlobal("#L_CWBridgeQuest","GLOBAL",6)~ UNSOLVED_JOURNAL @3011 + CORWINJ_BRIDGE_QUEST_3.3B1
		IF ~Global("#L_SoDStat_WeakPoison","GLOBAL",0) Global("#L_SoDStatOptions","GLOBAL",1) CheckStatGT(Player1,9,INT) RandomNumLT(10,6)~ THEN REPLY @2046 /* ~I do have one crazy idea.  They're probably expecting Caelar's assassins to return from their attack on the palace.  We could give them that.  Half way across we might be able to throw those barrels into the river before they're able to be lit.~ */ DO ~SetGlobal("#L_CWBridgeQuest","GLOBAL",5)~ UNSOLVED_JOURNAL @3008 + CORWINJ_BRIDGE_QUEST_3.3A
		IF ~Global("#L_SoDStat_WeakPoison","GLOBAL",0) Global("#L_SoDStatOptions","GLOBAL",1) CheckStatGT(Player1,9,INT) RandomNumGT(10,5)~ THEN REPLY @2046 /* ~I do have one crazy idea.  They're probably expecting Caelar's assassins to return from their attack on the palace.  We could give them that.  Half way across we might be able to throw those barrels into the river before they're able to be lit.~ */ DO ~SetGlobal("#L_CWBridgeQuest","GLOBAL",5)~ UNSOLVED_JOURNAL @3010 + CORWINJ_BRIDGE_QUEST_3.3B1
		IF ~RandomNumGT(10,1)~ THEN REPLY @2047 /* ~If we can get a small group disguised as Caelar's crusaders past the guards at the bridge entrance, we might be able to throw those barrels into the river before they're able to be lit.~ */ DO ~SetGlobal("#L_CWBridgeQuest","GLOBAL",5)~ UNSOLVED_JOURNAL @3008 + CORWINJ_BRIDGE_QUEST_3.3A
		IF ~RandomNum(10,1)~ THEN REPLY @2047 /* ~If we can get a small group disguised as Caelar's crusaders past the guards at the bridge entrance, we might be able to throw those barrels into the river before they're able to be lit.~ */ DO ~SetGlobal("#L_CWBridgeQuest","GLOBAL",5)~ UNSOLVED_JOURNAL @3010 + CORWINJ_BRIDGE_QUEST_3.3B1
	END
	
	IF ~~ THEN BEGIN CORWINJ_BRIDGE_QUEST_3.3A
		SAY @2048 /* ~This could work.  It's risky, but I don't see a better option.  If we try to rush it, they'll blow the bridge for sure.~ */
		IF ~~ THEN GOTO CORWINJ_BRIDGE_QUEST_3.4
	END
	
	IF ~~ THEN BEGIN CORWINJ_BRIDGE_QUEST_3.3B1
		SAY @2048 /* ~This could work.  It's risky, but I don't see a better option.  If we try to rush it, they'll blow the bridge for sure.~ */
		IF ~~ THEN REPLY @2051 /* ~What if a password is required?~ */ GOTO CORWINJ_BRIDGE_QUEST_3.3B2
	END
	
	IF ~~ THEN BEGIN CORWINJ_BRIDGE_QUEST_3.3B2
		SAY @2052 /* ~Hmm...I'll get one of our mages to charm a guard.  If there's a password, we'll learn what it is.~ */
		IF ~~ THEN DO ~SetGlobal("#L_CWBridgePassword","GLOBAL",1)~ GOTO CORWINJ_BRIDGE_QUEST_3.4
	END
	
	IF ~~ THEN BEGIN CORWINJ_BRIDGE_QUEST_3.4
		SAY @2049 /* ~As soon as we're out of this dungeon, I'll go get my people prepared for this.~ */
		IF ~~ THEN EXIT
	END
	
	IF WEIGHT #-97 ~AreaCheck("BD1000") Global("#L_CWBridgeRigged","GLOBAL",1) Global("#L_CWBridgeExplosivesTalk","GLOBAL",1) Global("#L_CWBridgeFFPrepped","GLOBAL",0)~ BEGIN CORWINJ_BRIDGE_QUEST_4.1
		SAY @2050 /* ~I need to get our plan in motion.  Meet me at camp or the bridge as soon as you can.  We'll be ready and I can rejoin you there.~ */
		IF ~OR(2) StateCheck(MYSELF,STATE_HASTED) Global("A7_AutoHasteActive","GLOBAL",1)~ THEN REPLY @2058 /* ~Understood.  I'll head over there shortly.~ */ DO ~SetInterrupt(FALSE) SetGlobal("#L_CWBridgeFFPrepped","GLOBAL",1) LeaveParty() SetGlobal("#L_CWBridgeCorwinLeft","GLOBAL",1) ChangeAIScript("BDSHOUT",RACE) ChangeAIScript("BDFIGH01",GENERAL) ChangeAIScript("",DEFAULT) MoveToPoint([570.3520]) SetInterrupt(TRUE)~ EXIT
		IF ~NotStateCheck(MYSELF,STATE_HASTED) !Global("A7_AutoHasteActive","GLOBAL",1)~ THEN REPLY @2058 /* ~Understood.  I'll head over there shortly.~ */ DO ~SetInterrupt(FALSE) SetGlobal("#L_CWBridgeFFPrepped","GLOBAL",1) LeaveParty() SetGlobal("#L_CWBridgeCorwinLeft","GLOBAL",1) ChangeAIScript("BDSHOUT",RACE) ChangeAIScript("BDFIGH01",GENERAL) ChangeAIScript("",DEFAULT) ApplySpellRES("BDHaste",MYSELF) MoveToPoint([570.3520]) SetInterrupt(TRUE) ApplySpellRES("#LUnHast",MYSELF)~ EXIT
	END

	IF WEIGHT #-96 ~AreaCheck("BD1000") !TriggerOverride("FF_Camp",IsOverMe("CORWIN")) OR(2) Global("#L_CWBridgeQuest","GLOBAL",5) Global("#L_CWBridgeQuest","GLOBAL",6) Global("#L_CWBridgeHailed","BD1000",1)~ THEN BEGIN CORWIN_BRIDGE_QUEST_6
		SAY @2095 /* ~Everything's in place.  Are you ready to do this, <CHARNAME>?~ */
		IF ~Global("#L_CWBridgePassword","GLOBAL",1)~ THEN REPLY @2096 /* ~Did we learn anything about a password? */ GOTO CORWIN_BRIDGE_QUEST_NIKTO
		IF ~!Global("#L_CWBridgePassword","GLOBAL",1)~ THEN REPLY @2097 /* ~I'm ready.  Let's go.~ */ GOTO CORWIN_BRIDGE_QUEST_REST_OF_YOU
	END
	
	IF ~~ THEN BEGIN CORWIN_BRIDGE_QUEST_NIKTO
		SAY @2099 /* ~Yes, a mage was able to charm one of the guards.  The password is 'nikto'.~ */
		IF ~~ THEN REPLY @2100 /* ~Alright, let's go.~ */ GOTO CORWIN_BRIDGE_QUEST_REST_OF_YOU
	END

	IF ~~ THEN BEGIN CORWIN_BRIDGE_QUEST_REST_OF_YOU
		SAY @2108 /* ~I'll be just a little ways behind you, <CHARNAME>. The rest of you, watch for my signal.  Let's head out!~ */
		IF ~~ THEN DO ~StartCutSceneMode() StartCutSceneEx("#LCWBQ030",TRUE)~ EXIT
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

EXTEND_BOTTOM BDSCRY 0
	IF ~Global("bd_sddd12_bridge","LOCALS",0) GlobalLT("BD_Plot","GLOBAL",156)~ THEN REPLY @2030 /* ~The Coast Way Crossing...~ */ GOTO SCRY_POOL_CWBridge
END

APPEND BDSCRY
	IF ~~ THEN BEGIN SCRY_POOL_CWBridge
		SAY @2031 /* ~Instead of a person, what weighs heavily on your mind is the bridge you must cross.  As you think of it, the pool grows calm. An indistinct image appears within it, quickly growing in clarity. You find yourself watching a scene unfold from above, as a god might do.~ */
		IF ~~ THEN DO ~SetGlobal("BD_SDDD12_CLOUDY","MYAREA",1) SetGlobal("bd_sddd12_bridge","LOCALS",1) StartCutSceneMode() StartCutSceneEx("#LCWBQ01",FALSE)~ EXIT
	END
END

// Gnome crusader guarding the bridge (BDCRUS13 but his dialogue is BDCRUS10)
APPEND BDCRUS10
	IF WEIGHT #-99 ~AreaCheck("BD1000") OR(2) Global("#L_CWBridgeQuest","GLOBAL",5) Global("#L_CWBridgeQuest","GLOBAL",6) Global("#L_CWBridgeHailed","BD1000",1)~ THEN BEGIN WHO_ARE_YOU
		SAY #%KNOW_YOU_NOT%
		IF ~Global("#L_CWBridgeQuest","GLOBAL",5)~ THEN EXTERN "#LFFAss1" BG_NO_PRISONER
		IF ~Global("#L_CWBridgeQuest","GLOBAL",6)~ THEN EXTERN "#LFFAss1" BG_WITH_PRISONER
	END
	
	IF ~~ THEN BEGIN WHATS_THE_PASSWORD
		SAY @2122 /* ~I don't recognize ya.  What's the password?~ */
		IF ~Global("#L_CWBridgePassword","GLOBAL",0)~ THEN EXTERN "#LFFAss1" NO_PASSWORD
		IF ~!Global("#L_CWBridgePassword","GLOBAL",0)~ THEN EXTERN "#LFFAss1" KNOW_PASSWORD
	END
	
	IF ~~ THEN BEGIN OH_YES_YOU_DO
		SAY @2132 /* ~Oh yes you do!  Hey!  That's the Hero!! And these aren't no stickin' elites!~ */
		IF ~~ THEN DO ~ClearAllActions() StartCutSceneMode() StartCutSceneEx("#LCWBQ04",TRUE)~ EXIT
	END
	
	IF ~~ THEN BEGIN ALRIGHT_THEN
		SAY @2125 /* ~Alright, that's it alright.~ */
		IF ~~ THEN DO ~ClearAllActions() StartCutSceneMode() StartCutSceneEx("#LCWBQ04",TRUE)~ EXIT
	END
END

// Disguised FF Veteran
BEGIN "#LFFAss1"
	IF ~~ THEN BEGIN BG_NO_PRISONER
		SAY @2120 /* ~We're Caelar's elites returning from Baldur's Gate.~ */
		IF ~~ THEN EXTERN BDCRUS10 WHATS_THE_PASSWORD
	END
	
	IF ~~ THEN BEGIN BG_WITH_PRISONER
		SAY @2121 /* ~We're Caelar's elites returning from Baldur's Gate with a prisoner.~ */
		IF ~~ THEN EXTERN BDCRUS10 WHATS_THE_PASSWORD
	END
	
	IF ~~ THEN BEGIN NO_PASSWORD
		SAY @2123 /* ~Uh...password?  Uh, we don't need no stinkin' password!~ */
		IF ~~ THEN EXTERN BDCRUS10 OH_YES_YOU_DO
	END
	
	IF ~~ THEN BEGIN KNOW_PASSWORD
		SAY @2124 /* ~It's nikto.~ */
		IF ~~ THEN EXTERN BDCRUS10 ALRIGHT_THEN
	END
// End of new dialogue file #LFFAss1

// Allow a line even if solo because Fist are present (if they're still alive)
ALTER_TRANS BDCAELAR
	BEGIN 7 END
	BEGIN 1 END
	BEGIN
		"TRIGGER" ~OR(2) NumInPartyGT(1) GlobalGT("#L_CWBridgeQuest","GLOBAL",97) OR(4) !GlobalGT("#L_CWBridgeQuest","GLOBAL",97) !Dead("#LFFAss1") !Dead("#LFFAss2") !Dead("#LFFAss3")~
	END

