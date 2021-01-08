//////////////////////////////////////////////////////////////
// Dialogue changes for stat based options                  //
// other than the poison used by Caelar's elites            //
// That's handled in a separate file because of it's volume //
//////////////////////////////////////////////////////////////

// Track who has talked to Dauston (drunken fallen paladin) about Caelar
REPLACE_ACTION_TEXT BDDAUSTO ~SetGlobal("BD_PASSOUT_DAUSTON","BD0030",1)~ ~SetGlobal("BD_PASSOUT_DAUSTON","BD0030",1) SetGlobal("#L_SoDStat_DaustonTalk","GLOBAL",1) ActionOverride(Player2,SetGlobal("#L_SoDStat_DaustonTalk","LOCALS",1)) ActionOverride(Player3,SetGlobal("#L_SoDStat_DaustonTalk","LOCALS",1)) ActionOverride(Player4,SetGlobal("#L_SoDStat_DaustonTalk","LOCALS",1)) ActionOverride(Player5,SetGlobal("#L_SoDStat_DaustonTalk","LOCALS",1)) ActionOverride(Player6,SetGlobal("#L_SoDStat_DaustonTalk","LOCALS",1))~

// Ask Eltan to interview Dauston when he sobers up
EXTEND_TOP BDELTAN 10 #0
	IF ~Global("#L_SoDStat_DaustonTalk","GLOBAL",1) Global("#L_SoDStat_DaustonPrompt","MYAREA",2)~ THEN REPLY @2020 /* ~Well enough, sir. But I have a favor to ask of you concerning the fallen paladin named Dauston that is currently sleeping it off in your cells.~ */ GOTO ELTAN_ASK_ABOUT_DAUSTON
END

APPEND BDELTAN
	IF ~~ THEN BEGIN ELTAN_ASK_ABOUT_DAUSTON
		SAY @2021 /* ~Of course.  What can I do for the Hero of Baldur's Gate?~ */
		++ @2022 /* ~Can you interview him when he is awake.  He knows something of Caelar's past that might prove useful.~ */ GOTO ELTAN_CONTINUE
	END
	
	IF ~~ THEN BEGIN ELTAN_CONTINUE
		SAY @2023 /* ~Easy enough.  Consider it done.  I'll send a messenger with the results to Corwin at the first opportunity.~ */
		++ @2024 /* ~Thank you, sir.  How are you holding up through all of this?~ */ DO ~SetGlobal("#L_SoDStat_DaustonTalk","GLOBAL",2)~ UNSOLVED_JOURNAL @3003 GOTO 18
	END
END

// Have Corwin have a message from Eltan for you if you speak with her more than once
EXTEND_BOTTOM BDCORWIN 17
	IF ~Global("#L_SoDStat_DaustonTalk","GLOBAL",2)~ THEN DO ~AddJournalEntry(266861,QUEST_DONE) AddJournalEntry(266862,QUEST) ActionOverride("bdbence",EscapeAreaObject("ff_camp"))~ GOTO MESSAGE_FOR_YOU_SIR
END

EXTEND_BOTTOM BDCORWIN 20
	IF ~Global("#L_SoDStat_DaustonTalk","GLOBAL",2)~ THEN DO ~AddJournalEntry(266861,QUEST_DONE) AddJournalEntry(266862,QUEST) ActionOverride("bdbence",EscapeAreaObject("ff_camp"))~ GOTO MESSAGE_FOR_YOU_SIR
END

EXTEND_BOTTOM BDCORWIN 27
	IF ~Global("#L_SoDStat_DaustonTalk","GLOBAL",2)~ THEN GOTO MESSAGE_FOR_YOU_SIR_THEN_JOIN
END

EXTEND_BOTTOM BDCORWIN 28
	IF ~Global("#L_SoDStat_DaustonTalk","GLOBAL",2)~ THEN GOTO MESSAGE_FOR_YOU_SIR
END

EXTEND_BOTTOM BDCORWIN 30
	IF ~Global("#L_SoDStat_DaustonTalk","GLOBAL",2)~ THEN DO ~SetGlobal("bd_fists_attack","global",3)~ GOTO MESSAGE_FOR_YOU_SIR
END

EXTEND_BOTTOM BDCORWIN 31
	IF ~Global("#L_SoDStat_DaustonTalk","GLOBAL",2)~ THEN GOTO MESSAGE_FOR_YOU_SIR
END

EXTEND_BOTTOM BDCORWIN 32
	IF ~Global("#L_SoDStat_DaustonTalk","GLOBAL",2)~ THEN DO ~AddJournalEntry(259776,INFO)~ GOTO MESSAGE_FOR_YOU_SIR
END

EXTEND_BOTTOM BDCORWIN 33
	IF ~Global("#L_SoDStat_DaustonTalk","GLOBAL",2)~ THEN GOTO MESSAGE_FOR_YOU_SIR
END

EXTEND_BOTTOM BDCORWIN 34
	IF ~Global("#L_SoDStat_DaustonTalk","GLOBAL",2)~ THEN DO ~SetGlobal("bd_fists_attack","global",3)~ GOTO MESSAGE_FOR_YOU_SIR_THEN_JOIN
END

EXTEND_BOTTOM BDCORWIN 35
	IF ~Global("#L_SoDStat_DaustonTalk","GLOBAL",2)~ THEN DO ~AddJournalEntry(259776,INFO)~ GOTO MESSAGE_FOR_YOU_SIR
END

EXTEND_BOTTOM BDCORWIN 37
	IF ~Global("#L_SoDStat_DaustonTalk","GLOBAL",2)~ THEN GOTO MESSAGE_FOR_YOU_SIR
END

EXTEND_BOTTOM BDCORWIN 41
	IF ~Global("#L_SoDStat_DaustonTalk","GLOBAL",2)~ THEN GOTO MESSAGE_FOR_YOU_SIR
END

EXTEND_BOTTOM BDCORWIN 42
	IF ~Global("#L_SoDStat_DaustonTalk","GLOBAL",2)~ THEN GOTO MESSAGE_FOR_YOU_SIR
END

EXTEND_BOTTOM BDCORWIN 46
	IF ~Global("#L_SoDStat_DaustonTalk","GLOBAL",2)~ THEN GOTO MESSAGE_FOR_YOU_SIR
END

EXTEND_BOTTOM BDCORWIN 54
	IF ~Global("#L_SoDStat_DaustonTalk","GLOBAL",2)~ THEN GOTO MESSAGE_FOR_YOU_SIR_THEN_JOIN
END

EXTEND_BOTTOM BDCORWIN 55
	IF ~Global("#L_SoDStat_DaustonTalk","GLOBAL",2)~ THEN GOTO MESSAGE_FOR_YOU_SIR
END

EXTEND_BOTTOM BDCORWIN 56
	IF ~Global("#L_SoDStat_DaustonTalk","GLOBAL",2)~ THEN GOTO MESSAGE_FOR_YOU_SIR
END

APPEND BDCORWIN
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
		IF ~~ THEN REPLY @4036 /* ~How awful.  But that does explain a lot.~ */ DO ~SetGlobal("#L_SoDStat_DaustonTalk","GLOBAL",3)~ SOLVED_JOURNAL @3004 EXIT
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
		IF ~~ THEN REPLY @4036 /* ~How awful.  But that does explain a lot.~ */ DO ~SetGlobal("#L_SoDStat_DaustonTalk","GLOBAL",3) JoinParty()~ SOLVED_JOURNAL @3004 EXIT
	END
END

// Track if PC knows about Hephernaan being an agent of the Umbral Accord
REPLACE_ACTION_TEXT BDSCRY ~SetGlobal("bd_sddd12_hood","LOCALS",1)~ ~SetGlobal("#L_SoDStat_HephUmbral","GLOBAL",1) SetGlobal("bd_sddd12_hood","LOCALS",1)~

// Track if PC learned that Hephernaan is Caelar's advisor from Edwin
ALTER_TRANS BDEDWIN
	BEGIN 48 END
	BEGIN 0 END
	BEGIN
		"ACTION" ~SetGlobal("#L_SodStat_HephEdwin","GLOBAL",1)~
	END

ALTER_TRANS BDEDWINJ
	BEGIN 5 6 END
	BEGIN 0 END
	BEGIN
		"ACTION" ~SetGlobal("#L_SodStat_HephEdwin","GLOBAL",1)~
	END

// Dialogue file to be used by whomever in the party meets the requirements //
BEGIN ~#LS0Temp~
	IF ~Global("#L_SoDStat_TreatiseFound","GLOBAL",1)~ THEN BEGIN READ_HISTORICAL_TREATISE
		SAY @2000 /* ~What is this?  Did you see this, <CHARNAME>?~ */
		= @2001 /* ~This book you found says there's a portal leading to Avernus under Dragonspear Castle.~ */
		= @2002	/* ~Not only that, but that it an be opened using the blood that has the essense of a god.~ */
		= @2003	/* ~Is that what Caelar has in mind?  Opening a portal to Avernus?  Is she mad?!~ */
		++ @2004 /* ~Ugh, so that's what she's up to.  I think you're right.  I think she's lost her mind.~ */ DO ~SetGlobal("#L_SoDStat_TreatiseFound","GLOBAL",2)~ JOURNAL @3000 EXIT
	END

	// If PC isn't the sharpest tool in the shed, but someone in the group is, have them tell the PC to ask Eltan about Dauston
	IF ~Global("#L_SoDStat_DaustonTalk","GLOBAL",1) Global("#L_SoDStat_DaustonPrompt","MYAREA",1) !Name("Dynaheir",MYSELF)~ THEN BEGIN PROMPT_PC_ABOUT_DAUSTON
		SAY @2010 /* ~<CHARNAME>, perhaps you should talk to Duke Eltan about that fallen paladin we spoke to...Dauston.~ */
		IF ~~ THEN DO ~SetGlobal("#L_SoDStat_DaustonPrompt","MYAREA",2)~ UNSOLVED_JOURNAL @3002 EXIT
	END

	IF ~Global("#L_SoDStat_DaustonTalk","GLOBAL",1) Global("#L_SoDStat_DaustonPrompt","MYAREA",1) Name("Dynaheir",MYSELF)~ THEN BEGIN PROMPT_PC_ABOUT_DAUSTON
		SAY @2011 /* ~<CHARNAME>, perhaps thou shouldst talk to Duke Eltan about the unfortunate fallen paladin we spoke to...Dauston.~ */
		IF ~~ THEN DO ~SetGlobal("#L_SoDStat_DaustonPrompt","MYAREA",2)~ UNSOLVED_JOURNAL @3002 EXIT
	END
// END of new #LHTRead

////////////////////////////////////////////////////
// Dialogue with Caelar at the Coast Way Crossing //
////////////////////////////////////////////////////
