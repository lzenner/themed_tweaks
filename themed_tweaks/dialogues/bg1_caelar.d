//////////////////////////////////////////////////////////////////////////////
// Dialogue changes for Caelar Argent's attemp to recruit the PC during BG1 //
//////////////////////////////////////////////////////////////////////////////

// Have her show up 3 game-days after the hand-in of Nashkel mines
REPLACE_ACTION_TEXT BERRUN ~TakePartyItem("MISC85")~ ~TakePartyItem("MISC85") SetGlobalTimer("#L_BG1Caelar_Timer","GLOBAL",THREE_DAYS) SetGlobal("#L_BG1Caelar_Visit","GLOBAL",1)~

BEGIN "#LCaelar"
	IF ~Global("#L_BG1Caelar_Visit","GLOBAL",1) NumInParty(1)~ THEN BEGIN FIRST_VISIT_1
		SAY @2000 // ~Excuse me, but are you the one who cleared the Nashkel mines of demons?~
		++ @2002 /* ~Don't believe everything you hear.  The mines were infested with kobolds, not demons.~ */ GOTO AH_KOBOLDS_1
		++ @2003 /* ~Why yes, I am. What can I do for you?~ */ GOTO LOOKING_FOR_WARRIORS_1
		++ @2005 /* ~And if I am?~ */ GOTO LOOKING_FOR_WARRIORS_1
	END
	
	IF ~~ THEN BEGIN AH_KOBOLDS_1
		SAY @2008 // ~I see.  I was hoping to find season warriors that would join me in the battle against demons in Avernus.~
		++ @2012 /* ~Ha! Best keep looking, lady.  I am neither seasoned enough nor foolish enough to join in that venture!~ */ GOTO FAREWELL
	END
	
	IF ~~ THEN BEGIN LOOKING_FOR_WARRIORS_1
		SAY @2007 // ~I am looking for seasoned warriors that would join me in the battle against demons in Avernus.~
		++ @2010 /* ~Don't believe everything you hear, lady.  The mines were infested with kobolds, not demons.  I'm not what you're looking for.~ */ GOTO FAREWELL
	END
	
	IF ~Global("#L_BG1Caelar_Visit","GLOBAL",1) NumInPartyGT(1)~ THEN BEGIN FIRST_VISIT_PARTY
		SAY @2000 // ~Excuse me, but are you the one who cleared the Nashkel mines of demons?~
		++ @2002 /* ~Don't believe everything you hear.  The mines were infested with kobolds, not demons.~ */ GOTO AH_KOBOLDS_PARTY
		++ @2004 /* ~Why yes, we are. What can we do for you?~ */ GOTO LOOKING_FOR_WARRIORS_PARTY
		++ @2006 /* ~And if we are?~ */ GOTO LOOKING_FOR_WARRIORS_PARTY
	END
	
	IF ~~ THEN BEGIN AH_KOBOLDS_PARTY
		SAY @2008 // ~I see.  I was hoping to find season warriors that would join me in the battle against demons in Avernus.~
		++ @2011 /* ~Ha! Best keep looking, lady.  We aren't seasoned enough or foolish enough to join in that venture!~ */ GOTO FAREWELL
	END
	
	IF ~~ THEN BEGIN LOOKING_FOR_WARRIORS_PARTY
		SAY @2007 // ~I am looking for seasoned warriors that would join me in the battle against demons in Avernus.~
		++ @2009 /* ~Don't believe everything you hear, lady.  The mines were infested with kobolds, not demons.  We're not what you're looking for.~ */ GOTO FAREWELL
	END

	IF ~~ THEN BEGIN FAREWELL
		SAY @2013 // ~I see. I shall bid you safe journeys, then.~
		IF ~~ THEN EXIT
	END
// End of new #LCaelar dialogue file