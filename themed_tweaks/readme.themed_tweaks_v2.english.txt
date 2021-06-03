-------------------------------------------------
---               Themed Tweaks               ---
---                 by Lauriel                ---
---        NEW COMPONENTS FOR VERSION 2       ---
---       for EET, BGEE, SoD, BG2EE, ToB      ---
-------------------------------------------------


------------------------------------------------------------------------
GENERAL
------------------------------------------------------------------------
This mod requires BGEE, SoD, BG2EE or EET.

This mod main purpose is to augment the role-playing environment throughout the game series.  To that end, it tweaks the storyline in various places.

------------------------------------------------------------------------
DESCRIPTION
------------------------------------------------------------------------

------------------------------------------------------------------------
BGEE/BG2EE - Give good-aligned reasons to go into peoples' homes
------------------------------------------------------------------------
This isn't for every house in the game.  A good aligned PC has no business ransacking every house in the realm.  But with this component, the PC will at least be prompted to enter the important ones. Inn and shop keepers will be a font of information concerning where to hand in certain quest items, for example.  If BG1RE is installed, this component will also allow for the Camryn/Tamah book collection quest to be completed without having to steal or break into homes.
PROGRESS: BG1 finished, BG2 yet to do

------------------------------------------------------------------------
BGEE/SoD/BG2EE - Fix cut scenes that rearrange the group
------------------------------------------------------------------------
Some cut scenes take on too much license with the arrangement of the group, especially before a fight.  This component will try to alleviate that.
PROGRESS: BG1 finished, SoD and BG2 yet to do

------------------------------------------------------------------------
BGEE/SoD/BG2EE - Make sure unique items stay unique
------------------------------------------------------------------------
Items that are made unique by a specific history are kept unique.  For example, if you return the Heart of the Golem to the revenant, you'll not find another anywhere in the game. There will, however, be multiple +2 daggers with a more generic background to be found throughout the realms that are almost as good. 
PROGRESS: BG1 in development, SoD and BG2 yet to do

------------------------------------------------------------------------
BGEE - Allow Rasaad's companion quest to be completed before chapter 5
------------------------------------------------------------------------
The encounter that is necessary to begin Rasaad's companion quest will happen at Beregost if the quest timer expires before chapter 5. If it expires in chapter 5, the quest will progress as usual.

------------------------------------------------------------------------
BGEE - Add Caelar recruitment attempts of PC after Nashkel mines and ToSC ending
------------------------------------------------------------------------
PROGRESS: Post-Nashkel encounter finished, post ToSC yet to do

------------------------------------------------------------------------
BGEE - Allow Dorn to join good group for the purpose of completing his revenge quest
------------------------------------------------------------------------
If a heroic group wants to help Dorn get his revenge, they may now do so.  At the start of Chapter 5, Dorn will rejoin your group no matter how shiny you are.

------------------------------------------------------------------------
BGEE/SoD - Remove errant references to PC being Bhaalspawn, like Entar
------------------------------------------------------------------------
PROGRESS: BG1 in development, SoD yet to do
If BG1NPC is to be installed, please do so before this component

------------------------------------------------------------------------
PLANNED FUTURE ENHANCEMENTS
------------------------------------------------------------------------
* SoD            - Add confrontation with Bence and Corwin over Bence bedding Skie
* SoD            - Speed up the elevator in hell
* SoD            - Speed up the prison/trial scenes
* BG2EE          - Distribute group's possessions from the beginning of BG2 to stores in Athkatla - might have to be EET only
* BG2EE          - Add comments from the group about Imoen's new innate ability to cast Magic Missile 
* BG2EE			 - Allow giving igi's potion of minor restoration to skinwalker's victim
* BG2EE/ToB      - Fix any outstanding issues with the Flail of Ages
* ToB            - Give viable reasons as to why the PC should attack its siblings in their own enclaves
* ToB            - Have Balthesar relent even if PC hasn't taken down any of the others yet
* ToB            - Add a "continue the adventure" ending with Bhaalspawn powers intact
* EET            - Allow Imoen to transition to dual-class mage during her training with Duke Liia
* EET            - Remove the recap of information the PC should know from the first BG2 dialogues

------------------------------------------------------------------------
COMPATABIITY NOTES
------------------------------------------------------------------------
There are no known compatibility issues at this time

------------------------------------------------------------------------
INSTALLATION
------------------------------------------------------------------------
If you're going to install Transitions, Endless BG1, or BG1NPC do so before Themed Tweaks.

Installation using Project Infinity (https://forums.beamdog.com/discussion/74335/project-infinity-mod-manager-for-baldurs-gate-icewind-dale-planescape-torment-and-eet) will ensure this and other mods are installed in the correct order.

NOTE: If you've previously installed the mod, remove it before extracting a new version. To do this, uninstall all previously installed components and delete the mod folder and executables. 

When installing or uninstalling, do not close the DOS window by clicking on the X button! Instead, press the Enter key when instructed to do so.

IMPORTANT FOR EET INSTALLATIONS: EET_End will need to be (re)installed after installing this mod.
 
General (Windows, Mac OS X, and Linux)

Extract the contents of the mod archive to your game's main directory. 

Windows
On successful extraction, there should be a themed_tweaks folder and a setup-themed_tweaks.exe file in your game folder. To install, simply double-click setup-themed_tweaks.exe and follow the instructions on screen.
Run setup-themed_tweaks.exe in your game folder to reinstall, uninstall or otherwise change components.

Mac OS X
The mod is packaged and installed with WeiDU. To install, extract the mod archive, then copy of the contents of the folder into your game folder (the folder which contains the CHITIN.KEY file). If properly extracted, you should have a "themed_tweaks" folder, setup-themed_tweaks, and setup-themed_tweaks.command in your game folder. To install, simply double-click setup-themed_tweaks.command and follow the instructions on screen.

Linux
Extract the contents of the mod to the folder of the game you wish to modify. Download the latest version of WeiDU for Linux from https://github.com/WeiDUorg/weidu/releases and copy WeiDU and WeInstall to /usr/bin. Following that, open a terminal and cd to your EET installation directory, run 'tolower' and answer Y to both queries. You can avoid running the second option (linux.ini) if you've already run it once in the same directory. If you're unsure, running tolower and choosing both options is the safest bet.
Run WeInstall themed_tweaks in your game folder to install the mod. Then run wine BGMain.exe and start playing. 

If you have installation problems or encounter any bugs, please post your bug report in the forum thread: https://www.gibberlings3.net/forums/topic/32346-themed-tweaks-for-bgee-sod-bg2ee-tob-eet.

------------------------------------------------------------------------
CREDITS
------------------------------------------------------------------------
* BeamDog / Overhaul Games: for the Infinity Engine and inspiring this mod
* K4thos: for EET - even though it's not required for this mod, I just really like EET
* DavidW: for the lovely macros included in alter_script.tpa as well as guidance on encapsulation and immutability
* Grammarsalad, subtledoctor, grodrigues, Mike1072, and jastey: for the ideas, guidance and help on the tool that provides proper and upper case player1 pronouns (cases.tpa)
* BGForge: for their IElib which I used as a jump-off point for my items lib
* Bubb and CamDawg - LOVE YOU FOREVER!!!  I mean it.  Forevah!
* jastey: for everything you've done and continue to do. :)
* igi: for permission to use the refreshment potion from his iiItems mod as the basis of Irenicus's revitalization potion
* igi: for permission to use the broken bottle from his IIitems mod
* BG1NPC Project: for permission to use their method of reading Gorion's letter (X#GorLet.CRE,DLG,BCS)
* The folks at The Gibberlings Three forums: for never failing to answer my many many questions

------------------------------------------------------------------------
USED TOOLS AND RESSOURCES
------------------------------------------------------------------------
The Themed Tweaks mod was created using the resources provided by the IESDP (https://gibberlings3.github.io/iesdp/index.htm) and with the following software:

* Near Infinity			https://github.com/Argent77/NearInfinity/releases/latest
* WeiDU					http://www.weidu.org

Modding communities, tutorials and technical assistance:

The Gibberlings Three	http://gibberlings3.net

------------------------------------------------------------------------
HISTORY
------------------------------------------------------------------------
still in development

------------------------------------------------------------------------
LEGAL INFORMATION
------------------------------------------------------------------------
Themed Tweaks is unofficial Fan Content permitted under the Fan Content Policy. Not approved/endorsed by Wizards. Portions of the materials used are property of Wizards of the Coast. ©Wizards of the Coast LLC.
This mod is also not developed, supported, or endorsed by BioWare, Black Isle Studios, Interplay Entertainment Corp., Overhaul Games or Beamdog. All other trademarks and copyrights are property of their respective owners.

