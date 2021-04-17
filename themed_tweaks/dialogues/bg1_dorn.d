///////////////////////////////////
// Allows Dorn to join the group //
// to have Simmeon fight         //
///////////////////////////////////

REPLACE_STATE_TRIGGER %DORN_POST% 0 ~Global("DORNPARTY","GLOBAL",0) OR(2) ReputationLT(Player1,19) GlobalGT("Chapter","GLOBAL",4) OR(2) ReputationLT(Player1,19) Global("DornPlot","GLOBAL",3)~
