///////////////////////////////////////////////////////
// Remove cut scenes that are initiated via dialogue //
///////////////////////////////////////////////////////

/* this removes any other transactions other mods added to this state. Removed for compatibility.
// Remove the one added by I4E
ALTER_TRANS BDSCHAEL
	BEGIN 247 END
	BEGIN 0 END
	BEGIN
		"ACTION" ~SetGlobal("bd_plot","global",60) SetGlobal("bd_no_retreat","locals",1) AddJournalEntry(%SOD_JOURNAL_01%,QUEST_DONE) ClearAllActions() StartCutSceneMode() StartCutSceneEx("bdcut08",FALSE)~
	END
*/
	
/* 	If you think you need to alter content from other mods the player explicitely installed at least make it compatible, like: */
/* (this will reverse the content from I4E component "Play cutscene with Imoen and Duke Jannath") */
	REPLACE_TRANS_ACTION bdschael BEGIN 247 END BEGIN END ~StartCutScene("bdscry01")~
	~StartCutScene("bdcut08")~ 
