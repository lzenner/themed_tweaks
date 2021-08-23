/////////////////////////////////////////////////////////////////////////
// Cues to kick off bhaalspawn dialogues are now dependent upon locals //
/////////////////////////////////////////////////////////////////////////

REPLACE_TRIGGER_TEXT %AJANTIS_JOINED% ~Global("P#KnowBhaal","GLOBAL"~ ~Global("#L_BSRefKnows","LOCALS"~
REPLACE_TRIGGER_TEXT %AJANTIS_JOINED% ~Global("X#AjTamokoKnowBhaal","GLOBAL"~ ~Global("X#AjTamokoKnowBhaal","LOCALS"~
REPLACE_TRIGGER_TEXT %CORAN_JOINED% ~Global("P#KnowBhaal","GLOBAL"~ ~Global("#L_BSRefKnows","LOCALS"~
REPLACE_TRIGGER_TEXT CYTHAN ~InParty("dynaheir")~ ~InParty("dynaheir") TriggerOverride("DYNAHEIR",Global("#L_BSRefKnows","LOCALS",1)) TriggerOverride("DYNAHEIR",Global("#L_BSRefSarvSib","LOCALS",1))~
REPLACE_TRIGGER_TEXT %DYNAHEIR_BANTER% ~Global("P#KnowBhaal","GLOBAL"~ ~Global("#L_BSRefKnows","LOCALS"~
REPLACE_TRIGGER_TEXT %DYNAHEIR_JOINED% ~Global("P#KnowBhaal","GLOBAL"~ ~Global("#L_BSRefKnows","LOCALS"~
REPLACE_TRIGGER_TEXT %EDWIN_JOINED% ~Global("P#KnowBhaal","GLOBAL"~ ~Global("#L_BSRefKnows","LOCALS"~
REPLACE_TRIGGER_TEXT %ELDOTH_BANTER% ~Global("P#KnowBhaal","GLOBAL"~ ~Global("#L_BSRefKnows","LOCALS"~
REPLACE_TRIGGER_TEXT %SHARTEEL_BANTER% ~Global("P#KnowBhaal","GLOBAL"~ ~Global("#L_BSRefKnows","LOCALS"~
REPLACE_TRIGGER_TEXT %SHARTEEL_JOINED% ~Global("P#KnowBhaal","GLOBAL"~ ~Global("#L_BSRefKnows","LOCALS"~
REPLACE_TRIGGER_TEXT TETHTO2 ~Global("P#KnowBhaal","GLOBAL",1)~ ~NextTriggerObject(Player1) Global("#L_BSRefKnows","LOCALS",1)~
REPLACE_TRIGGER_TEXT TETHTO2 ~Global("P#KnowBhaal","GLOBAL",0)~ ~NextTriggerObject(Player1) Global("#L_BSRefKnows","LOCALS",0)~
REPLACE_ACTION_TEXT TETHTO2 ~SetGlobal("P#KnowBhaal","GLOBAL",1)~ ~~
REPLACE_TRIGGER_TEXT %XAN_JOINED% ~Global("P#KnowBhaal","GLOBAL"~ ~Global("#L_BSRefKnows","LOCALS"~
REPLACE_TRIGGER_TEXT %XZAR_BANTER% ~Global("P#KnowBhaal","GLOBAL"~ ~Global("#L_BSRefKnows","LOCALS"~

%DIALOG_DYN_BXAN%
%DIALOG_DYN_BXZAR%
%DIALOG_JAH_BHAAL%
%REPLY_GOTO_1%
%REPLY_GOTO_2%
%DIALOG_AMELIA%

REPLACE_ACTION_TEXT TAMOKO ~SetGlobal("X#AjTamokoKnowBhaal","GLOBAL",1)~ ~~
REPLACE_ACTION_TEXT TAMOKO ~SetGlobal("X#TamokoBhaal","GLOBAL",1)~ ~~

REPLACE_ACTION_TEXT TAMOKO ~SetGlobal("X#HalfBrotherRevealed","GLOBAL",1)~ ~ActionOverride(Player1,SetGlobal("#L_BSRefSarvSib","LOCALS",1)) ActionOverride(Player2,SetGlobal("#L_BSRefSarvSib","LOCALS",1)) ActionOverride(Player3,SetGlobal("#L_BSRefSarvSib","LOCALS",1)) ActionOverride(Player4,SetGlobal("#L_BSRefSarvSib","LOCALS",1)) ActionOverride(Player5,SetGlobal("#L_BSRefSarvSib","LOCALS",1)) ActionOverride(Player6,SetGlobal("#L_BSRefSarvSib","LOCALS",1))~

REPLACE_ACTION_TEXT TAMOKO ~SetGlobal("P#KnowBhaal","GLOBAL",1)~ ~ActionOverride(Player1,SetGlobal("#L_BSRefKnows","LOCALS",1)) ActionOverride(Player2,SetGlobal("#L_BSRefKnows","LOCALS",1)) ActionOverride(Player3,SetGlobal("#L_BSRefKnows","LOCALS",1)) ActionOverride(Player4,SetGlobal("#L_BSRefKnows","LOCALS",1)) ActionOverride(Player5,SetGlobal("#L_BSRefKnows","LOCALS",1)) ActionOverride(Player6,SetGlobal("#L_BSRefKnows","LOCALS",1)) ActionOverride("AJANTIS",SetGlobal("X#AjTamokoKnowBhaal","LOCALS",1))~

ADD_TRANS_ACTION TAMOKO
	BEGIN 12 END
	BEGIN 0 1 END
	~ActionOverride(Player1,SetGlobal("#L_BSRefSarvSib","LOCALS",1)) ActionOverride(Player2,SetGlobal("#L_BSRefSarvSib","LOCALS",1)) ActionOverride(Player3,SetGlobal("#L_BSRefSarvSib","LOCALS",1)) ActionOverride(Player4,SetGlobal("#L_BSRefSarvSib","LOCALS",1)) ActionOverride(Player5,SetGlobal("#L_BSRefSarvSib","LOCALS",1)) ActionOverride(Player6,SetGlobal("#L_BSRefSarvSib","LOCALS",1))~

ALTER_TRANS TAMOKO
	BEGIN 14 END
	BEGIN 0 1 END
	BEGIN "ACTION" ~ActionOverride(Player1,SetGlobal("#L_BSRefSarvSib","LOCALS",1)) ActionOverride(Player2,SetGlobal("#L_BSRefSarvSib","LOCALS",1)) ActionOverride(Player3,SetGlobal("#L_BSRefSarvSib","LOCALS",1)) ActionOverride(Player4,SetGlobal("#L_BSRefSarvSib","LOCALS",1)) ActionOverride(Player5,SetGlobal("#L_BSRefSarvSib","LOCALS",1)) ActionOverride(Player6,SetGlobal("#L_BSRefSarvSib","LOCALS",1))~ END

BEGIN ~X#GORLET~
	IF ~GlobalGT("X#GorionTalkingLetter","GLOBAL",1) AreaCheck("%Candlekeep_Library_L5%")~ THEN BEGIN GORION_ROOM_READING
		SAY @2000 // ~*You read a note found among Gorion's belongings that is addressed to you*~
		IF ~~ THEN REPLY @2002 /* ~*Read the note silently to yourself*~ */ GOTO READ_SILENTLY
		%REPLY_READ_ALOUD%
	END

	IF ~GlobalGT("X#GorionTalkingLetter","GLOBAL",1) !AreaCheck("%Candlekeep_Library_L5%")~ THEN BEGIN OTHER_READING
		SAY @2001 // ~*You read a note that was among your possessions given to you by Tethtoril*~
		IF ~~ THEN REPLY @2002 /* ~*Read the note silently to yourself*~ */ GOTO READ_SILENTLY
		IF ~IsValidForPartyDialogue("jaheira")~ THEN REPLY @2003 /* ~*Read the note out loud to your group*~ */ GOTO READ_ALOUD_JAHEIRA
		IF ~!IsValidForPartyDialogue("jaheira")~ THEN REPLY @2003 /* ~*Read the note out loud to your group*~ */ GOTO READ_ALOUD_NO_JAHEIRA
	END
	
	IF ~~ THEN BEGIN READ_SILENTLY
		SAY @2004 // ~Hello <CHARNAME>, If you are reading this, it means I have met an untimely death...
		IF ~~ THEN DO ~SetGlobal("X#GorionTalkingLetter","GLOBAL",4) ActionOverride(Player1,SetGlobal("#L_BSRefKnows","LOCALS",1))~ EXIT
	END

	IF ~~ THEN BEGIN READ_ALOUD_NO_JAHEIRA
		SAY @2004 // ~Hello <CHARNAME>, If you are reading this, it means I have met an untimely death...
		IF ~~ THEN DO ~SetGlobal("X#GorionTalkingLetter","GLOBAL",4) ActionOverride(Player1,SetGlobal("#L_BSRefKnows","LOCALS",1)) ActionOverride(Player2,SetGlobal("#L_BSRefKnows","LOCALS",1)) ActionOverride(Player3,SetGlobal("#L_BSRefKnows","LOCALS",1)) ActionOverride(Player4,SetGlobal("#L_BSRefKnows","LOCALS",1)) ActionOverride(Player5,SetGlobal("#L_BSRefKnows","LOCALS",1)) ActionOverride(Player6,SetGlobal("#L_BSRefKnows","LOCALS",1))~ EXIT
	END

	%DIALOG_JAH_LETTER%
// End of new X#GORLET dialogue file
