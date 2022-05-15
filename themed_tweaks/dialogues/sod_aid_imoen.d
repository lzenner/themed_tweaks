/////////////////////////////////////////
// INITIAL CONVERSATION WITH DUKE LIIA //
// ON THE THIRD FLOOR OF THE PALACE    //
/////////////////////////////////////////

INTERJECT_COPY_TRANS BDLIIA 0 ~#L_GAVE_AID~
	== BDLIIA IF ~OR(2) Global("#L_AICastHeal","GLOBAL",1) Global("#L_AICastSlowPoison","GLOBAL",1)~ THEN @2000 /* ~I can tell you've already administered aid.  Your quick reactions may have just saved her life.~ */
END

