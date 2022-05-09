////////////////////////////////////////////////////////////
// Snarky dialogue to add to inane or stuffy SoD dialogue //
// Compiled via snark.tpa using snark.tra                 //
////////////////////////////////////////////////////////////

// Response to a dumb question from Corwin
EXTEND_BOTTOM BDSCHAEL 13  
	++ @8000 /*	= ~How the hells should I know?~ */ GOTO 14
END

// Response to Liia when she asks the pc to join the coalition
EXTEND_BOTTOM BDLIIA 11
	++ @8001 /* ~You want me to join the army?~ */ EXTERN ~BDELTAN~ ACCOMPANY_NOT_JOIN
END

// Duke Eltan's compelling response (well, I hope it's more compelling than 'Will you join them')
APPEND BDELTAN
	IF ~~ THEN BEGIN ACCOMPANY_NOT_JOIN
		SAY @8002 /* ~Accompany is more to the point.~ */
		+ ~Class(Player1,BARD_ALL)~ + @8003	/* ~What would you have me do?  Entertain your troops?  I'm just a bard!~ */ + MORE_THAN_A_BARD
		++ @8004 /* ~What could I possibly do that your trained army couldn't accomplish?  Well...besides...~ */ + BESIDES_EVERYTHING
	END

	IF ~~ THEN BEGIN MORE_THAN_A_BARD
		SAY @8005 /* ~A bard whose talents far exceed that of song.  A bard that solved the iron crisis, exposed Sarevok, and saved my life.~ */
		IF ~~ GOTO OKIE_DOKES
	END

	IF ~~ THEN BEGIN BESIDES_EVERYTHING
		SAY @8006 /* ~You mean besides solving the iron crisis?  Exposing Sarevok?  Saving my life?~ */
		IF ~~ GOTO OKIE_DOKES
	END

	IF ~~ THEN BEGIN OKIE_DOKES
		SAY @8007 /* ~Besides your obvious talent for tactics and getting to the root of the problem, you are a symbol of hope for the entire region.~ */
		= @8008	/* ~I know it is a heavy burden to lay upon one so young, but we don't always get to choose our destiny.~ */
		++ @8009 /* ~I can't promise anything, and I'm not joining any army ... just so we're clear.  But I'll go along and help where I'm able.~ */ EXTERN ~BDBELT~ 38
		++ @8010 /* ~So the reward for a dangerous job well done is more dangerous work. I have laid my own path, I will follow it.~ */ EXTERN ~BDBELT~ 38
		++ @8011 /* ~On the contrary, my coin is on the edge.  I choose my own destiny, and I choose to see this through.~ */ EXTERN ~BDBELT~ 38
	END
END

ALTER_TRANS BDENTAR
	BEGIN 18 END
	BEGIN 0 END
	BEGIN
		"TRIGGER" ~Global("#L_Snark","GLOBAL",0)~
	END
EXTEND_BOTTOM BDENTAR 18
	IF ~!Global("#L_Snark","GLOBAL",0)~ THEN REPLY @8025 /* ~With all due respect sir, I'm not a babysitter.  Neither is the Fist.  But if you insist upon this folly, her fate is upon your head, not mine.~ */ GOTO 44_intermediate
END
APPEND BDENTAR
	IF ~~ THEN BEGIN 44_intermediate
	SAY #%eet_2%64909 /* ~You'd better get moving. Unless there was something else?~ [BD64909] */
	COPY_TRANS BDENTAR 18
	END
END

// Snark about the sword and hooded man take place in reference to staying in room
ALTER_TRANS BDSCHAEL 
	BEGIN 20 21 23 END 
	BEGIN 0 END 
	BEGIN
		"EPILOGUE" ~EXTERN BDBELT BELT_HAVE_ROOM~
	END

%BELT_INSISTS_EXTEND_BOTTOM%

APPEND BDBELT
	IF ~~ THEN BELT_HAVE_ROOM
		SAY @8012 /* ~I want to make sure you rest here tonight, <CHARNAME>, when you're finished with your preparations.~ */
		%GOTO_LIIA_WONT_DISTURB_IMOEN%
//		++ @8013 /* ~Imoen and Fenster are up there, I'd not want to disturb them.~ */ EXTERN ~BDLIIA~ LIIA_IMOEN_ROOM_OK
	END

	%BELT_INSISTS_BLOCK%
//	IF ~~ THEN BELT_INSIST
//		SAY @8015 /* ~I rather insist upon this, <CHARNAME>.  It's for your safety.~ */
//		++ @8016 /* ~My safety?  That's a bit ironic.~ */ + BELT_NO_SNARK
//		+ ~OR(2) Dead("bdkorlas") Global("BD_KORLASZ_SURRENDER","GLOBAL",1) Global("#L_Snark","GLOBAL",1)~ + @8017 /* ~Like how you managed to keep Imoen safe?  Or that sword of Sarevok's?~ */ + BELT_SNARK
//	END

	IF ~~ THEN BELT_SNARK
		SAY @8018 /* ~err...I was going to mention that it went missing...~ */
		++ @8019 /* ~Do you know where it is?  I do.  It was stolen from you and sent to Athkatla at the request of some mysterious 'hooded man'.~ */ + BELT_SNARK_2
	END

	IF ~~ THEN BELT_SNARK_2
		SAY @8020 /* ~That I didn't know.~ */
		%GOTO_BELT_WRAP_IT_UP%
//		++ @8021 /* ~You should probably have someone look into that.  It could end up being important.~ */ + BELT_NO_SNARK
	END

	%BELT_WRAP_IT_UP%
//	IF ~~ THEN BELT_NO_SNARK
//		SAY @8022 /* ~Be that as it may, if tonight's attack would have happened when you were staying outside the palace, you'd not have had the Flaming Fist to help you fend them off.~ */
//		= @8023 /* ~You would not have been able to defend yourself from them all.~ */
//		++ @8024 /* ~Well, that is true.  You're right, I am safer here.~ */ + 41
//	END
END

%LIIA_WONT_DISTURB_IMOEN%
//APPEND BDLIIA
//	IF ~~ THEN LIIA_IMOEN_ROOM_OK
//		SAY @8014 /* ~Imoen will be moved to her quarters shortly.  You will not disturb her.~ */
//		%GOTO_BELT_INSISTS_BLOCK%
//	END
//END

// Response to ridiculaous statement from Corwin
ALTER_TRANS BDCORWIN
	BEGIN 7 END
	BEGIN 0 END
	BEGIN
		"REPLY" ~@8026~ // ~I'm your best chance?  Don't be absurd.~
	END
EXTEND_BOTTOM BDCORWIN 7
	IF ~BeenInParty("Xan")~ THEN REPLY @8027 /* ~I'm your best chance?  Xan was right.  We're doomed!~ */ GOTO 7_intermediate
	IF ~IsValidForPartyDialogue("Minsc")~ THEN REPLY @8028 /* ~I appreciate the fact that you'd take an arrow for me, Corwin, but it's hardly necessary.  That's what Minsc is for.~ */ EXTERN BDMINSCJ BUTT_KICKING_1
END

APPEND BDMINSCJ
	IF ~~ THEN BEGIN BUTT_KICKING_1
		SAY #%minsc_kick_butt%
		IF ~~ THEN EXTERN BDCORWIN 7_intermediate
	END
END

APPEND BDCORWIN
	IF ~~ THEN BEGIN 7_intermediate
		SAY #%eet_2%64654 /* ~They call you the hero of Baldur's Gate. Try to act the part.~ */
		COPY_TRANS BDCORWIN 7
	END
END

// Answer to inane statement by Caelar Argent at the Coastway Crossing
ALTER_TRANS BDCAELAR
	BEGIN 11 END
	BEGIN 0 END
	BEGIN 
		"REPLY" ~@8050~  // ~Are you seriously comparing my averting war to your starting one as being in way similar? Mind boggling!~
//		"ACTION" ~IncrementGlobal("bd_mdd420_good","global",1)~
	END
ADD_TRANS_ACTION BDCAELAR BEGIN 11 END BEGIN 0 END ~IncrementGlobal("bd_mdd420_good","global",1)~

ALTER_TRANS BDCAELAR
	BEGIN 15 END
	BEGIN 0 END
	BEGIN "REPLY" ~@8051~ END // ~You presume to know what my goals are?  You really are delusional!~

EXTEND_BOTTOM BDCAELAR 16
	IF ~~ THEN REPLY @8052 /* ~You're mad if you think they'd listen to me even if I had the slightest inclination of doing so.~ */ GOTO 18
END