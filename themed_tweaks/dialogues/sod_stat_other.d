//////////////////////////////////////////////////////////////
// Dialogue changes for stat based options                  //
// other than the poison used by Caelar's elites            //
// That's handled in a separate file because of it's volume //
//////////////////////////////////////////////////////////////

// Track if PC knows about Hephernaan being an agent of the Umbral Accord
REPLACE_ACTION_TEXT BDSCRY ~SetGlobal("bd_sddd12_hood","LOCALS",1)~ ~SetGlobal("#L_SoDStat_HephUmbral","GLOBAL",1) SetGlobal("bd_sddd12_hood","LOCALS",1)~
