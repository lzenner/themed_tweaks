//////////////////////////////////////////////////////////////////////////////
// Dialogue changes for Caelar Argent's attemp to recruit the PC during BG1 //
//////////////////////////////////////////////////////////////////////////////

// Have her show up 3 game-days after the hand-in of Nashkel mines
REPLACE_ACTION_TEXT BERRUN ~TakePartyItem("MISC85")~ ~TakePartyItem("MISC85") SetGlobalTimer("#L_BG1Caelar_Timer","GLOBAL",THREE_DAYS) SetGlobal("#L_BG1Caelar_Visit","GLOBAL",1)~

BEGIN "#LCaelar"
	IF ~Global("#L_BG1Caelar_Visit","GLOBAL",1) NumInParty(1)~ THEN BEGIN FIRST_VISIT_1
		SAY @2000 // ~Excuse me, but are you the one who cleared the Nashkel mines of demons?~
		++ @2002 /* ~Don't believe everything you hear.  The mines were infested with kobolds, not demons.~ */ GOTO KOBOLDS_HOPE
		++ @2003 /* ~Why yes, I am. What can I do for you?~ */ GOTO LOOKING_FOR_WARRIORS
		++ @2005 /* ~And if I am?~ */ GOTO LOOKING_FOR_WARRIORS
	END
	
	IF ~Global("#L_BG1Caelar_Visit","GLOBAL",1) NumInPartyGT(1)~ THEN BEGIN FIRST_VISIT_PARTY
		SAY @2001 // ~Excuse me, but are you the party that cleared the Nashkel mines of demons?~
		++ @2002 /* ~Don't believe everything you hear.  The mines were infested with kobolds, not demons.~ */ GOTO KOBOLDS_HOPE
		++ @2004 /* ~Why yes, we are. What can we do for you?~ */ GOTO LOOKING_FOR_WARRIORS
		++ @2006 /* ~And if we are?~ */ GOTO LOOKING_FOR_WARRIORS
	END
	
	IF ~~ THEN BEGIN LOOKING_FOR_WARRIORS
		SAY @2007 // ~I am looking for seasoned warriors that would join me in a perilous but rightous quest against fiends like those you just vanquished.~
		+ ~NumInPartyGT(1)~ + @2009 /* ~Don't believe everything you hear, lady. The mines were infested with kobolds, not demons. We're not what you're looking for.~ */ GOTO KOBOLDS_BYE
		+ ~NumInParty(1)~ + @2010 /* ~Don't believe everything you hear, lady. The mines were infested with kobolds, not demons. I'm not what you're looking for.~ */ GOTO KOBOLDS_BYE
		+ ~NumInPartyGT(1)~ + @2011	/* ~Ha! Best keep looking, lady.  We aren't seasoned enough or foolish enough to join in that venture!~ */ GOTO FAREWELL
		+ ~NumInParty(1)~ + @2012 /* ~Ha! Best keep looking, lady.  I am neither seasoned enough nor foolish enough to join in that venture!~ */ GOTO FAREWELL
		+ ~NumInPartyGT(1)~ + @2015	/* ~Against kobolds? Because that's what we just vanquish.~ */ GOTO KOBOLDS_BYE
		+ ~NumInParty(1)~ + @2016 /* ~Against kobolds? Because that's what I just vanquish.~ */ GOTO KOBOLDS_BYE
	END
	
	IF ~~ THEN BEGIN KOBOLDS_HOPE
		SAY @2017 // ~Kobolds? Not demons? I was misinformed.~
		= @2008 // ~I was hoping to find season warriors that would join me in a perilous but rightous quest against devils.~
		+ ~NumInPartyGT(1)~ + @2011 /* ~Ha! Best keep looking, lady.  We aren't seasoned enough or foolish enough to join in that venture!~ */ GOTO FAREWELL
		+ ~NumInParty(1)~ + @2012 /* ~Ha! Best keep looking, lady.  I am neither seasoned enough nor foolish enough to join in that venture!~ */ GOTO FAREWELL
		++ @2014 /* ~Against actual devils? Are you crazy?! Not a chance!~ */ GOTO FAREWELL
	END
	
	IF ~~ THEN BEGIN KOBOLDS_BYE
		SAY @2017 // ~Kobolds? Not demons? I was misinformed.~ 
		IF ~~ GOTO FAREWELL
	END
	
	IF ~~ THEN BEGIN FAREWELL
		SAY @2013 // ~Very well. I shall bid you safe journeys, then.~
		IF ~~ THEN DO ~SetGlobal("#L_BG1Caelar_Visit","GLOBAL",0) EscapeArea()~ EXIT
	END
// End of new #LCaelar dialogue file

