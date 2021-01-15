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

