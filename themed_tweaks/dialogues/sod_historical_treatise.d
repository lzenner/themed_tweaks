/////////////////////////////////
// Dialogue involving the book //
/////////////////////////////////

// Dialogue file to be used by whomever reads the book aloud //
BEGIN ~#LHTRead~
	IF ~True()~ THEN BEGIN HISTORICAL_TREATISE_1
		SAY @2000 /* ~What is this?  Did you see this, <CHARNAME>?~ */
		= @2001 /* ~This book you found says there's a portal leading to Avernus under Dragonspear Castle.~ */
		= @2002	/* ~Not only that, but that it an be opened using the blood that has the essense of a god.~ */
		= @2003	/* ~Is that what Caelar has in mind?  Opening a portal to Avernus?  Is she mad?!~ */
		++ @2004 /* ~Ugh, so that's what she's up to.  I think you're right.  I think she's lost her mind.~ */ JOURNAL @3000 EXIT
	END
// END of new #LHTRead

