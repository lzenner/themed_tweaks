// Keep your options open about taking Corwin with you to town
ALTER_TRANS BDELTAN
	BEGIN 16 END 
	BEGIN 0 END
	BEGIN
		"REPLY" ~@800~ // ~Of course.~
	END
EXTEND_BOTTOM BDELTAN 16
	IF ~~ THEN REPLY @801 /* ~I'll think about it.~ */ EXIT
	IF ~~ THEN REPLY @802 /* ~I'm afraid I work alone.  I'll be fine.~ */ EXIT
END

EXTEND_BOTTOM BDBELT 40
	IF ~~ THEN REPLY @803 /* ~That isn't necessary.  Just tell me where they are...I'm assuming taverns will be involved.~ */ EXTERN ~BDSCHAEL~ 20
END

ALTER_TRANS BDSCHAEL
	BEGIN 32 END
	BEGIN 0 END
	BEGIN
		"REPLY" ~@804~	// ~Lead on.~
	END
EXTEND_BOTTOM BDSCHAEL 32
	IF ~~ THEN REPLY @805 /* ~You can stay here.  I'm heading out alone.~ */ GOTO STAY_PUT
END	

EXTEND_BOTTOM BDSCHAEL 227
	IF ~Global("#L_NoCorwin","GLOBAL",1) Global("#L_CorwinDrink","GLOBAL",0) Global("bd_drinks_corwin","GLOBAL",0)~ THEN REPLY @809 /* ~Corwin, would you like to join me for a glass of wine before turning in for the night?~ */ GOTO CORWIN_DRINK_1
END

ALTER_TRANS BDSCHAEL
	BEGIN 192 END
	BEGIN 0 END
	BEGIN
		"REPLY" ~@816~
	END
EXTEND_BOTTOM BDSCHAEL 192
	IF ~Global("#L_NoCorwin","GLOBAL",1) Global("#L_CorwinDrink","GLOBAL",0) Global("bd_drinks_corwin","GLOBAL",0)~ THEN REPLY @817	/* ~No problem, Corwin.  Stick around for a while.  Meet me downstairs for a drink.~ */ GOTO CORWIN_STAY_FOR_DRINK_1
END

APPEND BDSCHAEL
	IF ~~ THEN BEGIN STAY_PUT
		SAY @806 /* ~I don't think that's such a good idea.~ */
		IF ~OR(2) !Global("BD_MET_OPHYLLIS","GLOBAL",0) !Global("bd_ophyllis_mentioned","locals",1)~ THEN REPLY @807 /* ~Your concerns are noted.  Stay here nonetheless.~ */ DO ~SetGlobal("#L_NoCorwin","GLOBAL",1)~ EXIT
		IF ~Global("#L_Snark","GLOBAL",1) OR(2) !Global("BD_MET_OPHYLLIS","GLOBAL",0) !Global("bd_ophyllis_mentioned","locals",1)~ THEN REPLY @808 /* ~Honestly, Captain Corwin, the only thing that matters here is that I do think it's a good idea.~ */ DO ~SetGlobal("#L_NoCorwin","GLOBAL",1)~ EXIT
		IF ~Global("BD_MET_OPHYLLIS","GLOBAL",0) Global("bd_ophyllis_mentioned","locals",1)~ THEN REPLY @807 /* ~Your concerns are noted.  Stay here nonetheless.~ */ DO ~SetGlobal("#L_NoCorwin","GLOBAL",1) AddJournalEntry(259625,QUEST)~ EXIT
		IF ~Global("#L_Snark","GLOBAL",1) Global("BD_MET_OPHYLLIS","GLOBAL",0) Global("bd_ophyllis_mentioned","locals",1)~ THEN REPLY @808 /* ~Honestly, Captain Corwin, the only thing that matters here is that I do think it's a good idea.~ */ DO ~SetGlobal("#L_NoCorwin","GLOBAL",1) AddJournalEntry(259625,QUEST)~ EXIT
	END

	IF ~~ THEN BEGIN CORWIN_DRINK_1
		SAY @810 /* ~What brought this on?~ */
		IF ~~ THEN REPLY @811 /* ~I thought it would be a good idea if we got to know one another a bit better.~ */ GOTO CORWIN_DRINK_2
	END

	IF ~~ THEN BEGIN CORWIN_DRINK_2
		SAY @812 /* ~Ok.  I'll meet you at the Three Old Kegs.~ */
		IF ~~ THEN DO ~SetGlobal("#L_CorwinDrink","GLOBAL",1)~ EXIT
	END

	IF WEIGHT #-999 ~OR(2) Global("bd_heard_seditious_talk","GLOBAL",1) PartyHasItem("bdscrl01")~ THEN BEGIN SEDITION_1
		SAY @813 /* ~Fancy meeting you here, <CHARNAME>.~ */
		IF ~~ THEN REPLY @814 /* ~Perfect timing, Captain Corwin!~ */ GOTO SEDITION_2
	END

	IF ~~ THEN BEGIN SEDITION_2
		SAY @815 /* ~How so?~ */
		IF ~Global("bd_heard_seditious_talk","GLOBAL",1) !Dead("bdmaxwel") !Dead("bdtherto") !Dead("bdaraya")~ THEN REPLY #244522 /* ~A plot against the Council of Four is being hatched upstairs.~ */ DO ~SetGlobal("bd_heard_seditious_talk","GLOBAL",2)~ GOTO 181
		IF ~Global("bd_heard_seditious_talk","GLOBAL",0) PartyHasItem("bdscrl01") !Dead("bdmaxwel") !Dead("bdtherto") !Dead("bdaraya")~ THEN REPLY #244525 /* ~I found this letter upstairs. It implicates three nobles in this inn of plotting against the dukes of Baldur's Gate.~ */ DO ~SetGlobal("bd_heard_seditious_talk","GLOBAL",3) TakePartyItemNum("BDSCRL01",1)~ GOTO 184
		IF ~PartyHasItem("bdscrl01") Dead("bdmaxwel") Dead("bdtherto") Dead("bdaraya")~ THEN REPLY #244526 /* ~I slew three nobles upstairs. They were plotting against the city. Here, one of them was carrying this note.~ */ DO ~SetGlobal("bd_heard_seditious_talk","GLOBAL",2) TakePartyItemNum("BDSCRL01",1)~ GOTO 185
	END

	IF ~~ THEN BEGIN CORWIN_STAY_FOR_DRINK_1
		SAY @810 /* ~What brought this on?~ */
		IF ~~ THEN REPLY @811 /* ~I thought it would be a good idea if we got to know one another a bit better.~ */ GOTO CORWIN_STAY_FOR_DRINK_2
	END

	IF ~~ THEN BEGIN CORWIN_STAY_FOR_DRINK_2
		SAY @818 /* ~Ok, I'll meet you downstairs.~ */
		IF ~~ THEN DO ~SetGlobal("#L_CorwinDrink","GLOBAL",1) AddJournalEntry(261609,QUEST_DONE) AddexperienceParty(750) ActionOverride("bdtyle",DialogueInterrupt(FALSE)) ActionOverride("bdfistcc",DialogueInterrupt(FALSE)) ActionOverride("bdmaxwel",EscapeAreaMove("BD0104",1412,551,NWW)) ActionOverride("bdtherto",EscapeAreaMove("BD0104",1496,462,W)) ActionOverride("bdaraya",EscapeAreaMove("BD0104",1593,377,NWW)) ActionOverride("Safana",SetSequence(SEQ_AWAKE)) ActionOverride("Safana",SmallWait(6)) ActionOverride("Safana",JumpToPoint([588.216])) ActionOverride("Safana",SetSequence(SEQ_READY)) ActionOverride("bdtyle",Wait(4)) ActionOverride("bdfistcc",Face(S)) ActionOverride("bdfistcc",Wait(3)) ActionOverride("bdtyle",EscapeArea()) ActionOverride("bdfistcc",EscapeArea()) EscapeArea()~ EXIT
	END
END

