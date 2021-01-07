//////////////////////////////////////////////////////////////
// Dialogue changes for stat based options                  //
// other than the poison used by Caelar's elites            //
// That's handled in a separate file because of it's volume //
//////////////////////////////////////////////////////////////

// Track if talked to Dauston (drunken fallen paladin) about Caelar
REPLACE_ACTION_TEXT BDDAUSTO ~SetGlobal("BD_PASSOUT_DAUSTON","BD0030",1)~ ~SetGlobal("BD_PASSOUT_DAUSTON","BD0030",1) SetGlobal("#L_SoDStat_Dauston","GLOBAL",1)~

// Ask Eltan to interview Dauston when he sobers up
EXTEND_TOP BDELTAN 10 #0
	IF ~Global("#L_SoDStat_Dauston","GLOBAL",1)~ THEN REPLY @2020 /* ~Well enough, sir. But I have a favor to ask of you concerning the fallen paladin named Dauston that is currently sleeping it off in your cells.~ */ GOTO ELTAN_ASK_ABOUT_DAUSTON
END

APPEND BDELTAN
	IF ~~ THEN BEGIN ELTAN_ASK_ABOUT_DAUSTON
		SAY @2021 /* ~Of course.  What can I do for the Hero of Baldur's Gate?~ */
		++ @2022 /* ~Can you interview him when he is awake.  He knows something of Caelar's past that might prove useful.~ */ GOTO ELTAN_CONTINUE
	END
	
	IF ~~ THEN BEGIN ELTAN_CONTINUE
		SAY @2023 /* ~Easy enough.  Consider it done.  I'll send a messenger with the results at the first opportunity.~ */
		++ @2024 /* ~Thank you, sir.  How are you holding up through all of this?~ */ DO ~SetGlobal("#L_SoDStat_Dauston","GLOBAL",2)~ GOTO 18
	END
END

// Track if PC knows about Hephernaan being an agent of the Umbral Accord
REPLACE_ACTION_TEXT BDSCRY ~SetGlobal("bd_sddd12_hood","LOCALS",1)~ ~SetGlobal("#L_SoDStat_HephUmbral","GLOBAL",1) SetGlobal("bd_sddd12_hood","LOCALS",1)~

/////////////////////////////////
// Dialogue involving the book //
/////////////////////////////////

// Dialogue file to be used by whomever reads the book aloud //
BEGIN ~#LHTRead~
	IF ~True()~ THEN BEGIN HISTORICAL_TREATISE_1
		SAY @2000 /* ~What is this?  Did you see this, <CHARNAME>?~ */
		= @2001 /* ~This book you found says there's a portal leading to Avernus under Dragonspear Castle.~ */
		= @2002	/* ~Not only that, but that it an be opened using the blood that has the essense of a god.~ */
		= @2003	/* ~Is that what Caelar has in mind?  Opening a portal to Avernus?  Is she mad?!~ */
		++ @2004 /* ~Ugh, so that's what she's up to.  I think you're right.  I think she's lost her mind.~ */ JOURNAL @3000 EXIT
	END
// END of new #LHTRead

