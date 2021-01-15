/////////////////////////////////////////////////////
// Dialogue changes for BG1 Good Reasons component //
/////////////////////////////////////////////////////

ALTER_TRANS JOIA
	BEGIN 0 END
	BEGIN 0 1 2 END
	BEGIN "ACTION" ~SetGlobal("#L_GRJoia","GLOBAL",1)~ END

EXTEND_BOTTOM JOIA 7
	IF ~GlobalGT("TICamryn","GLOBAL",0)~ THEN GOTO JOIA_GIVE_BOOK
END

APPEND JOIA
	IF ~~ THEN BEGIN JOIA_GIVE_BOOK
		SAY @2004 // ~I have this old book you can have.  It's all I have to give you in thanks.~
		IF ~~ THEN DO ~AddexperienceParty(400) ReputationInc(1) TakePartyItem("RINGJOIA") GiveItemCreate("TITOME01",Player1,0,0,0) EraseJournalEntry(227188) EscapeArea()~ SOLVED_JOURNAL #227189 EXIT
	END
END

APPEND BENTLY
	IF WEIGHT #-99 ~GlobalGT("TICamryn","GLOBAL",0) Global("#L_GRBently","MYAREA",0)~ THEN BEGIN BENTLY_GIVE_BOOK
		SAY @2005 // ~It's a right shame you got yourself attacked right outside my door.  I never!  Well here...it's not much, but I hope it helps smooth out any ruffles.~
		IF ~~ THEN DO ~GiveItemCreate("TITOME02",Player1,0,0,0)~ GOTO BENTLY_GO_UPSTAIRS		
	END
	
	IF WEIGHT #-98 ~Global("#L_GRBently","MYAREA",0)~ THEN BEGIN BENTLY_GO_UPSTAIRS
		SAY @2006 // ~You look like sturdy types that could help folks out.  There's a couple folk upstairs that need some work done, if you're interested.~
		IF ~~ THEN DO ~SetGlobal("#L_GRBently","MYAREA",1) StartDialogueNoSet(LastTalkedToBy(Myself))~ EXIT
	END
	
	IF WEIGHT #-97 ~PartyHasItem("RINGJOIA") Global("#L_GRBentlyJoia","MYAREA",0)~ THEN BEGIN JOIAS_RING
		SAY @2007 // ~That looks like Joia's ring.  I know she'd really appreciate seeing it again.  She lives in the first house you come to, on the left, when you come in through the gates.~
		IF ~~ THEN DO ~SetGlobal("#L_GRBentlyJoia","MYAREA",1) StartDialogueNoSet(LastTalkedToBy(Myself))~ EXIT
	END
END