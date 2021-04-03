/////////////////////////////////////////////////////////////////////////
// Cues to kick off bhaalspawn dialogues are now dependent upon locals //
/////////////////////////////////////////////////////////////////////////

REPLACE_TRIGGER_TEXT %AJANTIS_JOINED% ~Global("P#KnowBhaal","GLOBAL",1)~ ~TriggerOverride(Player1,Global("#L_BSRefKnows","LOCALS",1))~
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
%DIALOG_AMELIA%
%DIALOG_GORLET%

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
	BEGIN 0 END
	BEGIN "ACTION" ~ActionOverride(Player1,SetGlobal("#L_BSRefSarvSib","LOCALS",1)) ActionOverride(Player2,SetGlobal("#L_BSRefSarvSib","LOCALS",1)) ActionOverride(Player3,SetGlobal("#L_BSRefSarvSib","LOCALS",1)) ActionOverride(Player4,SetGlobal("#L_BSRefSarvSib","LOCALS",1)) ActionOverride(Player5,SetGlobal("#L_BSRefSarvSib","LOCALS",1)) ActionOverride(Player6,SetGlobal("#L_BSRefSarvSib","LOCALS",1))~ END
