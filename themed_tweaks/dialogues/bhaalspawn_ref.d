/////////////////////////////////////////////////////////////////////////
// Cues to kick off bhaalspawn dialogues are now dependent upon locals //
/////////////////////////////////////////////////////////////////////////

ADD_STATE_TRIGGER %DYNAHEIR_BANTER% %STATE_DYN_BMINSC% ~Global("#L_BSRefKnows","LOCALS",1)~
ADD_STATE_TRIGGER %DYNAHEIR_BANTER% %STATE_DYN_BXZAR% ~Global("#L_BSRefKnows","LOCALS",1) TriggerOverride("XZAR",Global("#L_BSRefKnows","LOCALS",1))~
ADD_STATE_TRIGGER %DYNAHEIR_BANTER% %STATE_DYN_BXAN% ~Global("#L_BSRefKnows","LOCALS",1) TriggerOverride("XAN",Global("#L_BSRefKnows","LOCALS",1))~
REPLACE_TRIGGER_TEXT %CORAN_JOINED% ~Global("P#KnowBhaal","GLOBAL"~ ~Global("#L_BSRefKnows","LOCALS"~
REPLACE_TRIGGER_TEXT %DYNAHEIR_JOINED% ~Global("P#KnowBhaal","GLOBAL"~ ~Global("#L_BSRefKnows","LOCALS"~
REPLACE_TRIGGER_TEXT TETHTO2 ~Global("P#KnowBhaal","GLOBAL",1)~ ~GlobalGT("P#KnowBhaal","GLOBAL",0)~

ALTER_TRANS X#GORLET
	BEGIN 1 END
	BEGIN 0 END
	BEGIN "ACTION" ~SetGlobal("X#GorionTalkingLetter","GLOBAL",4) ActionOverride(Player1,SetGlobal("#L_BSRefKnows","LOCALS",1)) ActionOverride(Player2,SetGlobal("#L_BSRefKnows","LOCALS",1)) ActionOverride(Player3,SetGlobal("#L_BSRefKnows","LOCALS",1)) ActionOverride(Player4,SetGlobal("#L_BSRefKnows","LOCALS",1)) ActionOverride(Player5,SetGlobal("#L_BSRefKnows","LOCALS",1)) ActionOverride(Player6,SetGlobal("#L_BSRefKnows","LOCALS",1)) SetGlobal("P#KnowBhaal","GLOBAL",2) ActionOverride("X#GORLET",DestroySelf())~ END
