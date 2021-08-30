////////////////////////////////////////////////////////////////////
// Extra dialogue added to Ajantis so he knows about the heritage //
////////////////////////////////////////////////////////////////////

APPEND %AJANTIS_JOINED%
	IF WEIGHT #-99 ~Global("#L_BSRefTalk","LOCALS",1) Global("X#AjantisRomanceActive","GLOBAL",1)~ THEN BEGIN BSREF_TALK_1_1
		SAY @2020 // ~My lady, you appear to have a heavy weight on your mind.  Would you care to share it with me?~
		IF ~~ THEN REPLY @2022 /* ~It is very personal, Ajantis, and not something I care to discuss.~ */ GOTO BSREF_NOTALK_1_1
		IF ~~ THEN REPLY @2025 /* ~I should probably tell you.  You deserve to know.  I recently found out that I am a child of Bhaal.~ */ GOTO BSREF_BHAAL
	END

	IF WEIGHT #-98 ~Global("#L_BSRefTalk","LOCALS",1) Global("X#AjantisRomanceActive","GLOBAL",2)~ THEN BEGIN BSREF_TALK_1_2
		SAY @2021 // ~My love, you appear to have a heavy weight on your mind.  Would you care to share it with me?~
		IF ~~ THEN REPLY @2022 /* ~It is very personal, Ajantis, and not something I care to discuss.~ */ GOTO BSREF_NOTALK_1_2
		IF ~~ THEN REPLY @2025 /* ~I should probably tell you.  You deserve to know.  I recently found out that I am a child of Bhaal.~ */ GOTO BSREF_BHAAL
	END
	
	IF ~~ THEN BEGIN BSREF_NOTALK_1_1
		SAY @2023 // ~As you wish, of course, my lady.~
		IF ~~ THEN DO ~SetGlobal("#L_BSRefTalk","LOCALS",2) RealSetGlobalTimer("X#AjantisRomance","GLOBAL",XAROM_TIMER)~ EXIT
	END
	
	IF ~~ THEN BEGIN BSREF_NOTALK_1_2
		SAY @2024 // ~As you wish, of course, my love.~
		IF ~~ THEN DO ~SetGlobal("#L_BSRefTalk","LOCALS",2) RealSetGlobalTimer("X#AjantisRomance","GLOBAL",XAROM_TIMER)~ EXIT
	END
	
	IF WEIGHT #-97 ~Global("#L_BSRefTalk","LOCALS",3) Global("X#AjantisRomanceActive","GLOBAL",1)~ THEN BEGIN BSREF_TALK_2_1_1
		SAY @2030 // ~Lady <CHARNAME>, if I may have a moment of your time.~
		IF ~~ THEN REPLY @2032 /* ~Not now, Ajantis.~ */ GOTO BSREF_TALK_2_1_2
		IF ~~ THEN REPLY @2036 /* ~Of course, Ajantis.  What is it?~ */ GOTO BSREF_TALK_2_X_3
	END

	IF WEIGHT #-96 ~Global("#L_BSRefTalk","LOCALS",3) Global("X#AjantisRomanceActive","GLOBAL",2)~ THEN BEGIN BSREF_TALK_2_2_1
		SAY @2031 // ~My love, if I may have a moment of your time.~
		IF ~~ THEN REPLY @2032 /* ~Not now, Ajantis.~ */ GOTO BSREF_TALK_2_2_2
		IF ~~ THEN REPLY @2036 /* ~Of course, Ajantis.  What is it?~ */ GOTO BSREF_TALK_2_X_3
	END

	IF ~~ THEN BEGIN BSREF_TALK_2_1_2
		SAY @2033 // ~It cannot wait, my lady.  Please, we must talk.~
		IF ~~ THEN REPLY @2035 /* ~Fine, what is it?~ */ GOTO BSREF_TALK_2_X_3
	END

	IF ~~ THEN BEGIN BSREF_TALK_2_2_2
		SAY @2034 // ~It cannot wait, my love.  Please, we must talk.~
		IF ~~ THEN REPLY @2035 /* ~Fine, what is it?~ */ GOTO BSREF_TALK_2_X_3
	END
	
	IF ~~ THEN BEGIN BSREF_TALK_2_X_3
		SAY @2037 // ~The weight you carry on your mind has not lessened and I fear it will affect our ... mission. Please share it with me.~
		IF ~Global("X#AjantisRomanceActive","GLOBAL",1)~ THEN REPLY @2038 /* ~I'm sorry Ajantis, I'm not eager to talk about it.~ */ GOTO BSREF_TALK_2_1_4
		IF ~Global("X#AjantisRomanceActive","GLOBAL",2)~ THEN REPLY @2038 /* ~I'm sorry Ajantis, I'm not eager to talk about it.~ */ GOTO BSREF_TALK_2_2_4
		IF ~~ THEN REPLY @2041 /* ~You're right.  It will affect our mission.  It affects everything.  There's no easy way to say this, but you deserve to know.  I recently found out that I am a child of Bhaal.~ */ GOTO BSREF_BHAAL
	END
		
	IF ~~ THEN BEGIN BSREF_TALK_2_1_4
		SAY @2039 // ~I'm afraid I must insist, my lady.~
		IF ~~ THEN REPLY @2041 /* ~You're right.  It will affect our mission.  It affects everything.  There's no easy way to say this, but you deserve to know.  I recently found out that I am a child of Bhaal.~ */ GOTO BSREF_BHAAL
	END

	IF ~~ THEN BEGIN BSREF_TALK_2_2_4
		SAY @2040 // ~I'm afraid I must insist, my love.~
		IF ~~ THEN REPLY @2041 /* ~You're right.  It will affect our mission.  It affects everything.  There's no easy way to say this, but you deserve to know.  I recently found out that I am a child of Bhaal.~ */ GOTO BSREF_BHAAL
	END

	IF ~~ THEN BEGIN BSREF_BHAAL
		SAY @2050 // ~You... you are an offspring of *Bhaal*, the God of Murder?!  How long would you have kept this from me?!~
		IF ~Global("X#AjantisRomanceActive","GLOBAL",1)~ THEN REPLY @2051 /* ~And you wonder why I hesitated to tell you?!  It's my business, Ajantis.  Why is this even of interest to you?~ */ DO ~ActionOverride(Player2,SetGlobal("#L_BSRefKnows","LOCALS",1)) ActionOverride(Player3,SetGlobal("#L_BSRefKnows","LOCALS",1)) ActionOverride(Player4,SetGlobal("#L_BSRefKnows","LOCALS",1)) ActionOverride(Player5,SetGlobal("#L_BSRefKnows","LOCALS",1)) ActionOverride(Player6,SetGlobal("#L_BSRefKnows","LOCALS",1)) SetGlobal("#L_BSRefTalk","LOCALS",99) SetGlobal("X#AjantisKnowBhaalTalkNoRom","GLOBAL",2)~ GOTO %STATE_AJA_FLIP_1%
		IF ~Global("X#AjantisRomanceActive","GLOBAL",2)~ THEN REPLY @2051 /* ~And you wonder why I hesitated to tell you?!  It's my business, Ajantis.  Why is this even of interest to you?~ */ DO ~ActionOverride(Player2,SetGlobal("#L_BSRefKnows","LOCALS",1)) ActionOverride(Player3,SetGlobal("#L_BSRefKnows","LOCALS",1)) ActionOverride(Player4,SetGlobal("#L_BSRefKnows","LOCALS",1)) ActionOverride(Player5,SetGlobal("#L_BSRefKnows","LOCALS",1)) ActionOverride(Player6,SetGlobal("#L_BSRefKnows","LOCALS",1)) SetGlobal("#L_BSRefTalk","LOCALS",99) SetGlobal("X#AjantisKnowBhaalTalkNoRom","GLOBAL",2)~ GOTO %STATE_AJA_FLIP_2%
	END

END