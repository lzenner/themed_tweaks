/////////////////////////////////////////////////////
// Dialogue changes for BG1 Good Reasons component //
/////////////////////////////////////////////////////

ADD_TRANS_ACTION JOIA
	BEGIN 0 END
	BEGIN 0 1 2 END
	~SetGlobal("#L_GRJoia","GLOBAL",1)~

EXTEND_BOTTOM JOIA 7
	IF ~GlobalGT("TICamryn","GLOBAL",0)~ THEN GOTO JOIA_GIVE_BOOK
END

APPEND JOIA
	IF ~~ THEN BEGIN JOIA_GIVE_BOOK
		SAY @2004 // ~I have this old book you can have.  It's all I have to give you in thanks.~
		IF ~~ THEN DO ~AddexperienceParty(400) ReputationInc(1) TakePartyItem("RINGJOIA") GiveItemCreate("TITOME01",Player1,0,0,0) EraseJournalEntry(227188) EscapeArea()~ SOLVED_JOURNAL #%JOURNAL_JOIA% EXIT
	END
END

APPEND BENTLY
	IF WEIGHT #-99 ~GlobalGT("TICamryn","GLOBAL",0) Global("#L_GRBently","MYAREA",0)~ THEN BEGIN BENTLY_GIVE_BOOK
		SAY @2005 // ~It's a right shame you got yourself attacked right outside my door.  I never!  Well here...it's not much, but I hope it helps smooth out any ruffles.~
		IF ~~ THEN DO ~GiveItemCreate("TITOME02",Player1,0,0,0)~ GOTO BENTLY_GO_UPSTAIRS		
	END
	
	IF WEIGHT #-98 ~Global("#L_GRBently","MYAREA",0)~ THEN BEGIN BENTLY_GO_UPSTAIRS
		SAY @2006 // ~You look like sturdy types that could help folks out.  There's a couple folk upstairs that need some work done, if you're interested.~
		IF ~~ THEN DO ~SetGlobal("#L_GRBently","MYAREA",1)~ EXIT
	END
	
	IF WEIGHT #-97 ~PartyHasItem("RINGJOIA") Global("#L_GRBentlyJoia","MYAREA",0)~ THEN BEGIN JOIAS_RING
		SAY @2007 // ~That looks like Joia's ring.  I know she'd really appreciate seeing it again.  She lives in the first house you come to, on the left, when you come in through the gates.~
		IF ~~ THEN DO ~SetGlobal("#L_GRBentlyJoia","MYAREA",1)~ EXIT
	END
END

// Get the RE (Camryn) book from Firebead
EXTEND_BOTTOM FIREBE 4 5 6
	IF ~Global("#L_GRxREBeregost","GLOBAL",1) Global("#L_GRFirebead","MYAREA",0)~ THEN REPLY @2016 /* ~I've heard that you may have a book I'm looking for, actually.  A rather romantic book?~ */ GOTO THIS_OLD_BOOK
END
APPEND FIREBE
	IF ~~ THEN BEGIN THIS_OLD_BOOK
		SAY @2017 // ~You want this?  Sure.  I'm more interested in history than poetry.~APPEND FIREBE
		IF ~~ THEN DO ~GiveItemCreate("TITome04",Player1,0,0,0) SetGlobal("#L_GRFirebead","MYAREA",1)~ EXIT
	END
END

// Additions to all vendors in Beregost so they'll give directions to Mirianne and Colquetle for quest hand-ins
EXTEND_BOTTOM BART5 0	// Feldepost bartender
	IF ~GlobalGT("TICamryn","GLOBAL",0) Global("#L_GRxREBeregost","GLOBAL",0)~ THEN REPLY @2009 /* ~I am looking for books... */ GOTO FIND_BOOKS
	IF ~PartyHasItem("SCRL3I")~ THEN REPLY @2011 /* ~Do you know anyone by the name of Mirianne? */ GOTO FIND_MIRIANNE
	IF ~PartyHasItem("AMUL13CO")~ THEN REPLY @2013 /* ~Does this amulet look familiar to you?  I'm trying to find its owner.~ */ GOTO ITS_COLQUETLE
END
APPEND BART5
	IF WEIGHT #-99 ~Global("#L_GRFeldBar","MYAREA",0) Global("FirebeadDone","GLOBAL",0)~ THEN BEGIN BUY_THIS_FOR_FIREBEAD
		SAY @2008 // ~If yer lookin' to make a bit of extra coin, ol' Firebead across the street is lookin' fer this book I got here on "The History of the Fateful Coin".
		IF ~~ THEN DO ~SetGlobal("#L_GRFeldBar","MYAREA",1) StartDialogueNoSet(LastTalkedToBy(Myself))~ EXIT
	END
	
	IF ~~ THEN BEGIN FIND_BOOKS
		SAY @2010 // ~Firebead probably has one, if I know that old book worm.  Other than that, the only one with a library of any size is Travenhurst Manor.  Could ask over there.~
		IF ~~ THEN DO ~SetGlobal("#L_GRxREBeregost","GLOBAL",1)~ EXIT
	END
	
	IF ~~ THEN BEGIN FIND_MIRIANNE
		SAY @2012 // ~Yeah, I know Mirianne.  She has a house just north of the smithy, on the east side of town.~
		IF ~~ THEN EXIT
	END

	IF ~~ THEN BEGIN ITS_COLQUETLE
		SAY @2014 // ~I'd recognize that in the dark!  It's belongs to the Colquetle family.  They have a house across the street, just north of old Firebead.~
		IF ~~ THEN EXIT
	END
END
EXTEND_BOTTOM BART3 0 // Red Sheaf bartender
	IF ~GlobalGT("TICamryn","GLOBAL",0) Global("#L_GRxREBeregost","GLOBAL",0)~ THEN REPLY @2009 /* ~I am looking for books... */ GOTO FIND_BOOKS
	IF ~PartyHasItem("SCRL3I")~ THEN REPLY @2011 /* ~Do you know anyone by the name of Mirianne? */ GOTO FIND_MIRIANNE
	IF ~PartyHasItem("AMUL13CO")~ THEN REPLY @2013 /* ~Does this amulet look familiar to you?  I'm trying to find its owner.~ */ GOTO ITS_COLQUETLE
END
APPEND BART3	
	IF ~~ THEN BEGIN FIND_BOOKS
		SAY @2010 // ~Firebead probably has one, if I know that old book worm.  Other than that, the only one with a library of any size is Travenhurst Manor.  Could ask over there.~
		IF ~~ THEN DO ~SetGlobal("#L_GRxREBeregost","GLOBAL",1)~ EXIT
	END
	
	IF ~~ THEN BEGIN FIND_MIRIANNE
		SAY @2012 // ~Yeah, I know Mirianne.  She has a house just north of the smithy, on the east side of town.~
		IF ~~ THEN EXIT
	END

	IF ~~ THEN BEGIN ITS_COLQUETLE
		SAY @2015 // ~I'd recognize that amulet anywhere!  ...
		IF ~~ THEN EXIT
	END
END
EXTEND_BOTTOM BART4 0 1 // Jovial Juggler bartender
	IF ~GlobalGT("TICamryn","GLOBAL",0) Global("#L_GRxREBeregost","GLOBAL",0)~ THEN REPLY @2009 /* ~I am looking for books... */ GOTO FIND_BOOKS
	IF ~PartyHasItem("SCRL3I")~ THEN REPLY @2011 /* ~Do you know anyone by the name of Mirianne? */ GOTO FIND_MIRIANNE
	IF ~PartyHasItem("AMUL13CO")~ THEN REPLY @2013 /* ~Does this amulet look familiar to you?  I'm trying to find its owner.~ */ GOTO ITS_COLQUETLE
END
APPEND BART4
	IF ~~ THEN BEGIN FIND_BOOKS
		SAY @2010 // ~Firebead probably has one, if I know that old book worm.  Other than that, the only one with a library of any size is Travenhurst Manor.  Could ask over there.~
		IF ~~ THEN DO ~SetGlobal("#L_GRxREBeregost","GLOBAL",1)~ EXIT
	END
	
	IF ~~ THEN BEGIN FIND_MIRIANNE
		SAY @2012 // ~Yeah, I know Mirianne.  She has a house just north of the smithy, on the east side of town.~
		IF ~~ THEN EXIT
	END

	IF ~~ THEN BEGIN ITS_COLQUETLE
		SAY @2015 // ~I'd recognize that amulet anywhere!  ...
		IF ~~ THEN EXIT
	END
END
EXTEND_BOTTOM BART13 0 // Burning Wizard bartender
	IF ~GlobalGT("TICamryn","GLOBAL",0) Global("#L_GRxREBeregost","GLOBAL",0)~ THEN REPLY @2009 /* ~I am looking for books... */ GOTO FIND_BOOKS
	IF ~PartyHasItem("SCRL3I")~ THEN REPLY @2011 /* ~Do you know anyone by the name of Mirianne? */ GOTO FIND_MIRIANNE
	IF ~PartyHasItem("AMUL13CO")~ THEN REPLY @2013 /* ~Does this amulet look familiar to you?  I'm trying to find its owner.~ */ GOTO ITS_COLQUETLE
END
APPEND BART13	
	IF ~~ THEN BEGIN FIND_BOOKS
		SAY @2010 // ~Firebead probably has one, if I know that old book worm.  Other than that, the only one with a library of any size is Travenhurst Manor.  Could ask over there.~
		IF ~~ THEN DO ~SetGlobal("#L_GRxREBeregost","GLOBAL",1)~ EXIT
	END
	
	IF ~~ THEN BEGIN FIND_MIRIANNE
		SAY @2012 // ~Yeah, I know Mirianne.  She has a house just north of the smithy, on the east side of town.~
		IF ~~ THEN EXIT
	END

	IF ~~ THEN BEGIN ITS_COLQUETLE
		SAY @2015 // ~I'd recognize that amulet anywhere!  ...
		IF ~~ THEN EXIT
	END
END

// Travenhurst Manor and the RE Camryn book
EXTEND_BOTTOM HOUSG2 0 1 2 // Guard 2
	IF ~Global("#L_GRxREBeregost","GLOBAL",1) Global("#L_GRxRETravenhurst","GLOBAL",0)~ THEN REPLY @2018	/* ~I heard that the library here may have a book... */ GOTO HAVE_BOOK
	IF ~~ THEN REPLY @2028 /* ~Ok, I'll be off then.~ */ EXIT
END
APPEND HOUSG2
	IF ~~ THEN BEGIN HAVE_BOOK
		SAY @2019 /* ~Hey Mister Travenhurst, you got a romantic book?  This person here is looking for one.~ */
		IF ~Contains("TITOME08","Container7")~ THEN EXTERN NOBL10 WE_HAVE_THE_BOOK
		IF ~!Contains("TITOME08","Container7")~ THEN EXTERN NOBL10 BOOK_STOLEN
	END
END
APPEND NOBL10
	IF ~~ THEN BEGIN WE_HAVE_THE_BOOK
		SAY @2020 // ~Yes, in fact we do have one.  If they can part with 100gp, they can have it.~
		++ @2021 EXIT // ~That's a little more than I had hoped to pay.  Perhaps I'll come back later.~
		IF ~GlobalGT("TITamah","GLOBAL",0)~ THEN REPLY @2026 /* ~I just need the letter inside the binding.  It's for a woman who has been petrified by a basilisk for many years.~ */ GOTO HERE_YA_GO
		++ @2022 /* ~Alright.  100gp it is.~ */ DO ~SetGlobal("#L_GRxRETravenhurst","GLOBAL",1) TakePartyGold(100) ActionOverride("Container7",DestroyItem("TITOME08")) GiveItemCreate("TITOME08",Player1,0,0,0)~ EXIT
	END
	
	IF ~~ THEN BEGIN BOOK_STOLEN
		SAY @2023 // ~I should have one, but it seems it's been stolen. You wouldn't know anything about that would you?!~
		++ @2024 /* ~No, of course not.  I'd not come here to look for it if I already had it~ */ DO ~SetGlobal("#L_GRxRETravenhurst","GLOBAL",1)~ GOTO BE_OFF_WITH_YOU
	END
	
	IF ~~ THEN BEGIN BE_OFF_WITH_YOU
		SAY @2025 // ~Ok.  Well, be off with you!~
		IF ~~ THEN EXIT
	END
	
	IF ~~ THEN BEGIN HERE_YA_GO
		SAY @2027 // ~Letter...oh well, what do you know.  Sure, you can have the letter.  Here.~
		IF ~~ THEN DO ~SetGlobal("#L_GRxRETravenhurst","GLOBAL",1) ActionOverride("Container7",DestroyItem("TITOME08")) GiveItemCreate("TIC8SCRL",Player1,0,0,0)~ EXIT
	END
END

// Nashkel vendors prompting about Joseph's ring
EXTEND_BOTTOM INNKN2 0 // Inn Keeper
	IF ~GlobalGT("TICamryn","GLOBAL",0) Global("#L_GRxRENashkel","GLOBAL",0)~ THEN REPLY @2009 /* ~I am looking for books... */ GOTO FIND_BOOKS
	IF ~PartyHasItem("RINGJOS")~ THEN REPLY @2031 /* ~Does this ring look familiar to you?  I'm trying to find its owner.~ */ GOTO FIND_WIDOW
END
APPEND INNKN2
	IF ~~ THEN BEGIN FIND_BOOKS
		SAY @2030 // ~The only place in town with a library of any size is the Manor...northeast end of town. Could ask over there.~
		IF ~~ THEN DO ~SetGlobal("#L_GRxRENashkel","GLOBAL",1)~ EXIT
	END
	
	IF ~~ THEN BEGIN FIND_WIDOW
		SAY @2032 // ~Sure looks like Joseph's ring.  He and his wife have a place east side of town, just past the Belching Dragon.~
		IF ~~ THEN DO ~SetGlobal("#L_GRNashkelWidow","GLOBAL",1)~ EXIT
	END
END
EXTEND_BOTTOM SHOPKN 0 1 // Shop keeper
	IF ~GlobalGT("TICamryn","GLOBAL",0) Global("#L_GRxRENashkel","GLOBAL",0)~ THEN REPLY @2009 /* ~I am looking for books... */ GOTO FIND_BOOKS
	IF ~PartyHasItem("RINGJOS")~ THEN REPLY @2031 /* ~Does this ring look familiar to you?  I'm trying to find its owner.~ */ GOTO FIND_WIDOW
END
APPEND SHOPKN
	IF ~~ THEN BEGIN FIND_BOOKS
		SAY @2030 // ~The only place in town with a library of any size is the Manor...northeast end of town. Could ask over there.~
		IF ~~ THEN DO ~SetGlobal("#L_GRxRENashkel","GLOBAL",1)~ EXIT
	END
	
	IF ~~ THEN BEGIN FIND_WIDOW
		SAY @2032 // ~Sure looks like Joseph's ring.  He and his wife have a place east side of town, just past the Belching Dragon.~
		IF ~~ THEN DO ~SetGlobal("#L_GRNashkelWidow","GLOBAL",1)~ EXIT
	END
END
EXTEND_BOTTOM BART2 0 // Belching Dragon Bartender
	IF ~GlobalGT("TICamryn","GLOBAL",0) Global("#L_GRxRENashkel","GLOBAL",0)~ THEN REPLY @2009 /* ~I am looking for books... */ GOTO FIND_BOOKS
	IF ~PartyHasItem("RINGJOS")~ THEN REPLY @2031 /* ~Does this ring look familiar to you?  I'm trying to find its owner.~ */ GOTO FIND_WIDOW
END
APPEND BART2
	IF ~~ THEN BEGIN FIND_BOOKS
		SAY @2030 // ~The only place in town with a library of any size is the Manor...northeast end of town. Could ask over there.~
		IF ~~ THEN DO ~SetGlobal("#L_GRxRENashkel","GLOBAL",1)~ EXIT
	END
	
	IF ~~ THEN BEGIN FIND_WIDOW
		SAY @2032 // ~Sure looks like Joseph's ring.  He and his wife have a place east side of town, just past the Belching Dragon.~
		IF ~~ THEN DO ~SetGlobal("#L_GRNashkelWidow","GLOBAL",1)~ EXIT
	END
END

// Update to Joseph's wife to bypass the 'uh...what am I doing here' when they already have the ring and prompt to be there
ADD_TRANS_TRIGGER %DLG_WIDOW% 0 ~OR(2) !PartyHasItem("RINGJOS") Global("#L_GRNashkelWidow","GLOBAL",0)~ DO 2
	
EXTEND_BOTTOM %DLG_WIDOW% 0
	IF ~PartyHasItem("RINGJOS") Global("#L_GRNashkelWidow","GLOBAL",1)~ THEN REPLY @2040 /* ~I found this ring in ... */ DO ~SetGlobal("#L_GRNashkelWidow","GLOBAL",2)~ GOTO 6
END

// Naskel Manor and the RE Camryn book
APPEND NOBL2  // Manor nobleman
	IF WEIGHT #-99 ~Global("#L_GRxRENashkel","GLOBAL",1) Global("#L_GRxRENashkelManor","GLOBAL",0)~ THEN BEGIN LOOKING_FOR_BOOK
		SAY #%SAY_RIFFRAFF% /* ~My dear! Common riffraff ... */
		IF ~~ THEN REPLY @2033 /* ~Excuse me.  I was told you may have a book on romance in your library.~ */ GOTO TALK_TO_THE_WIFE
		IF ~~ THEN REPLY @2028 /* ~Ok, I'll be off then.~ */ EXIT
	END
	
	IF ~~ THEN BEGIN TALK_TO_THE_WIFE
		SAY @2034 /* ~Talk to the misses about books of that sort.~ */
		IF ~Contains("TITOME09","Container7")~ THEN DO ~EscapeArea()~ EXTERN NOBW2 I_HAVE_BOOK
		IF ~!Contains("TITOME09","Container7")~ THEN DO ~EscapeArea()~ EXTERN NOBW2 BOOK_STOLEN
	END
END
APPEND NOBW2 // Manor noblewoman
	IF WEIGHT #-99 ~Global("#L_GRxRENashkel","GLOBAL",1) Global("#L_GRxRENashkelManor","GLOBAL",0)~ THEN BEGIN LOOKING_FOR_BOOK
		SAY #%SAY_7HEAVENS% // ~Who in the Seven Heavens are all of you?! ...
		IF ~Contains("TITOME09","Container7")~ THEN REPLY @2033 /* ~Excuse me.  I was told you may have a book on romance in your library.~ */ GOTO I_HAVE_BOOK
		IF ~!Contains("TITOME09","Container7")~ THEN REPLY @2033 /* ~Excuse me.  I was told you may have a book on romance in your library.~ */ GOTO BOOK_STOLEN
		IF ~~ THEN REPLY @2028 /* ~Ok, I'll be off then.~ */ EXIT
	END

	IF ~~ THEN BEGIN I_HAVE_BOOK
		SAY @2035 // ~Indeed, I do have one.  The illustrations are lovely.  Why?~
		++ @2036 /* ~I might be in the market to buy it if the price is right.~ */ GOTO THE_PRICE_OF_THE_BOOK
	END
	
	IF ~~ THEN BEGIN BOOK_STOLEN
		SAY @2023 // ~I should have one, but it seems it's been stolen. You wouldn't know anything about that would you?!~
		++ @2024 /* ~No, of course not.  I'd not come here to look for it if I already had it~ */ DO ~SetGlobal("#L_GRxRENashkelManor","GLOBAL",1)~ GOTO BE_OFF_WITH_YOU
	END
	
	IF ~~ THEN BEGIN BE_OFF_WITH_YOU
		SAY @2025 // ~Ok.  Well, be off with you!~
		IF ~~ THEN EXIT
	END
	
	IF ~~ THEN BEGIN THE_PRICE_OF_THE_BOOK
		SAY @2037 // ~I'd be amenable to parting with it for, say, 150gp. It is, after all, one of my favorites and I've never seen the like again anywhere.~
		++ @2021 EXIT // ~That's a little more than I had hoped to pay.  Perhaps I'll come back later.~
		IF ~GlobalGT("TITamah","GLOBAL",0)~ THEN REPLY @2026 /* ~I just need the letter inside the binding.  It's for a woman who has been petrified by a basilisk for many years.~ */ GOTO HERE_YA_GO
		++ @2038 /* ~Alright.  150gp it is.~ */ DO ~SetGlobal("#L_GRxRENashkelManor","GLOBAL",1) TakePartyGold(150) ActionOverride("Container7",DestroyItem("TITOME09")) GiveItemCreate("TITOME09",Player1,0,0,0)~ EXIT
	END
		
	IF ~~ THEN BEGIN HERE_YA_GO
		SAY @2027 // ~Letter...oh well, what do you know.  Sure, you can have the letter.  Here.~
		IF ~~ THEN DO ~SetGlobal("#L_GRxRENashkelManor","GLOBAL",1) ActionOverride("Container7",DestroyItem("TITOME09")) GiveItemCreate("TIC9SCRL",Player1,0,0,0)~ EXIT
	END
END

// Cloakwood hunters
REPLACE_ACTION_TEXT ALDETH ~SetGlobal("AldethMove","GLOBAL",1)~ ~SetGlobal("AldethMove","GLOBAL",1) GiveItemCreate("TITOME11",LastTalkedToBy,0,0,0) SetGlobal("#L_GRxRETome11","GLOBAL",1)~

// Ogre mage in S Baldur's Gate
REPLACE_ACTION_TEXT OGRELEAD ~Enemy()~ ~SetGlobal("#L_GROgreMages","GLOBAL",1) Enemy()~
