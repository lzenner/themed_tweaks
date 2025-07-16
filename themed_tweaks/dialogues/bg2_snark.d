/////////////////////////////////////////////////////////////
// Snarky additions to BG2 dialogue to lighten it up a bit //
// Compiled via add_snark.tpa using snark.tra              //
/////////////////////////////////////////////////////////////

EXTEND_BOTTOM SUELLE2 18
	IF ~ReputationLT(Player1,10) !Global("#L_Snark","GLOBAL",0)~ THEN REPLY @3000 /* ~Only partially?~ */ DO ~SetGlobal("soa_complete","GLOBAL",1)
ClearAllActions()
StartCutSceneMode()
StartCutSceneEx("cut100a",FALSE)
~ EXIT
	IF ~ReputationGT(Player1,9) !Global("#L_Snark","GLOBAL",0)~ THEN REPLY @3000 /* ~Only partially?~ */ DO ~SetGlobal("soa_complete","GLOBAL",1)
ClearAllActions()
StartCutSceneMode()
StartCutSceneEx("cut100b",FALSE)
~ EXIT
END
