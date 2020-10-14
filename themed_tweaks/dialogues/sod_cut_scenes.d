///////////////////////////////////////////////////////
// Remove cut scenes that are initiated via dialogue //
///////////////////////////////////////////////////////

// Remove the one added by I4E
ALTER_TRANS BDSCHAEL
	BEGIN 247 END
	BEGIN 0 END
	BEGIN
		"ACTION" ~SetGlobal("bd_plot","global",60) SetGlobal("bd_no_retreat","locals",1) AddJournalEntry(%SOD_JOURNAL_01%,QUEST_DONE) ClearAllActions() StartCutSceneMode() StartCutSceneEx("bdcut08",FALSE)~
	END
	