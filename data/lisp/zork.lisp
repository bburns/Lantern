
; zork_rooms.mud
; rooms extracted from dungeon.mud
;--------------------------------------------------------------------------------


(setq zork-rooms '(
                   
                   
;;; "SUBTITLE HOUSE AND VICINITY"


(room "WHOUS"
"This is an open field west of a white house, with a boarded front door."
       "West of House"
       (exit "NORTH" "NHOUS" "SOUTH" "SHOUS" "WEST" "FORE1"
	      "EAST" "The door is locked, and there is evidently no key.")
       ((get-obj "FDOOR") (get-obj "MAILB") (get-obj "MAT"))
       ()
       (+ ,rlandbit ,rlightbit ,rnwallbit ,rsacredbit)
       (rglobal ,housebit))

(room "NHOUS"
       "You are facing the north side of a white house.  There is no door here,
and all the windows are barred."
       "North of House"
       (exit "WEST" "WHOUS" "EAST" "EHOUS" "NORTH" "FORE3"
	      "SOUTH" "The windows are all barred.")
       ()
       ()
       (+ ,rlandbit ,rlightbit ,rnwallbit ,rsacredbit)
       (rglobal (+ ,dwindow ,housebit)))

(room "SHOUS"
"You are facing the south side of a white house. There is no door here,
and all the windows are barred."
       "South of House"
       (exit "WEST" "WHOUS" "EAST" "EHOUS" "SOUTH" "FORE2"
	      "NORTH" "The windows are all barred.")
       ()
       ()
       (+ ,rlandbit ,rlightbit ,rnwallbit ,rsacredbit)
       (rglobal (+ ,dwindow ,housebit)))

(setg kitchen-window (door "WINDO" "KITCH" "EHOUS"))

(room "EHOUS"
       ""
       "Behind House"
       (exit "NORTH" "NHOUS" "SOUTH" "SHOUS" "EAST" "CLEAR"
	      "WEST" ,kitchen-window
	      "ENTER" ,kitchen-window)
       ((get-obj "WINDO"))
       east-house
       (+ ,rlandbit ,rlightbit ,rnwallbit ,rsacredbit)
       (rglobal ,housebit))

(room "KITCH"
       ""
       "Kitchen"
       (exit "EAST" ,kitchen-window "WEST" "LROOM"
	      "EXIT" ,kitchen-window "UP" "ATTIC"
	      "DOWN" "Only Santa Claus climbs down chimneys.")
       ((get-obj "WINDO") (get-obj "SBAG") (get-obj "BOTTL"))
       kitchen
       (+ ,rlandbit ,rlightbit ,rhousebit ,rsacredbit)
       (rval 10))

(room "ATTIC"
"This is the attic.  The only exit is stairs that lead down."
	"Attic"
	(exit "DOWN" "KITCH")
	((get-obj "BRICK") (get-obj "ROPE") (get-obj "KNIFE"))
	()
	(+ ,rlandbit ,rhousebit))

(room "LROOM"
       ""
       "Living Room"
       (exit "EAST" "KITCH"
	      "WEST" (cexit "MAGIC-FLAG" "BLROO" "The door is nailed shut.")
	      "DOWN" (door "DOOR" "LROOM" "CELLA"))
       ((get-obj "WDOOR") (get-obj "DOOR") (get-obj "TCASE") 
	(get-obj "LAMP") (get-obj "RUG") (get-obj "PAPER")
	(get-obj "SWORD"))
       living-room
       (+ ,rlandbit ,rlightbit ,rhousebit ,rsacredbit))



;;; "SUBTITLE FOREST"

(psetg stfore "This is a forest, with trees in all directions around you.")

(psetg forest "Forest")

(psetg fordes
"This is a dimly lit forest, with large trees all around.  To the
east, there appears to be sunlight.")

(psetg fortree
"This is a dimly lit forest, with large trees all around.  One
particularly large tree with some low branches stands here.")

(psetg notree "There is no tree here suitable for climbing.")

(room "FORE1"
       ,stfore
       ,forest
       (exit "UP" ,notree
	     "NORTH" "FORE1" "EAST" "FORE3" "SOUTH" "FORE2" "WEST" "FORE1")
       ()
       forest-room
       (+ ,rlandbit ,rlightbit ,rnwallbit ,rsacredbit)
       (rglobal (+ ,treebit ,birdbit ,housebit)))

(room "FORE2"
       ,fordes
       ,forest
       (exit "UP" ,notree
	     "NORTH" "SHOUS" "EAST" "CLEAR" "SOUTH" "FORE4" "WEST" "FORE1")
       ()
       forest-room
       (+ ,rlandbit ,rlightbit ,rnwallbit ,rsacredbit)
       (rglobal (+ ,treebit ,birdbit ,housebit)))

(room "FORE3"
       ,fortree
       ,forest
       (exit "UP" "TREE"  
	     "NORTH" "FORE2" "EAST" "CLEAR" "SOUTH" "CLEAR" "WEST" "NHOUS")
       ((get-obj "FTREE"))
       forest-room
       (+ ,rlandbit ,rlightbit ,rnwallbit ,rsacredbit)
       (rglobal (+ ,birdbit ,housebit)))

(room "TREE"
      ""
      "Up a Tree"
      (exit "DOWN" "FORE3"
	    "UP" "You cannot climb any higher.")
      ((get-obj "NEST") (get-obj "TTREE"))
      tree-room
      (+ ,rlandbit ,rlightbit ,rnwallbit)
      (rglobal (+ ,birdbit ,housebit)))

(room "FORE4"
       "This is a large forest, with trees obstructing all views except
to the east, where a small clearing may be seen through the trees."
       ,forest
       (exit "UP" ,notree
	     "EAST" "CLTOP" "NORTH" "FORE5" "SOUTH" "FORE4" "WEST" "FORE2")
       ()
       forest-room
       (+ ,rlandbit ,rlightbit ,rnwallbit ,rsacredbit)
       (rglobal (+ ,treebit ,birdbit ,housebit)))

(room "FORE5"
       ,stfore
       ,forest
       (exit "UP" ,notree
	     "NORTH" "FORE5" "SE" "CLTOP" "SOUTH" "FORE4" "WEST" "FORE2")
       ()
       forest-room
       (+ ,rlandbit ,rlightbit ,rnwallbit ,rsacredbit)
       (rglobal (+ ,treebit ,birdbit ,housebit)))

(room "CLEAR"
       ""
       "Clearing"
       (exit "SW" "EHOUS" "SE" "FORE5" "NORTH" "CLEAR" "EAST" "CLEAR"
	      "WEST" "FORE3" "SOUTH" "FORE2"
	      "DOWN" (door "GRATE" "MGRAT" "CLEAR" "You can't go through the closed grating."))
       ((get-obj "GRATE") (get-obj "LEAVE"))
       clearing
       (+ ,rlandbit ,rlightbit ,rnwallbit ,rsacredbit)
       (rglobal ,housebit))



;;; "SUBTITLE CELLAR AND VICINITY"

(room "CELLA"
       ""
       "Cellar"
       (exit "EAST" "MTROL" "SOUTH" "CHAS2"
	      "UP"
	      (door "DOOR" "LROOM" "CELLA")
	      "WEST"
	      "You try to ascend the ramp, but it is impossible, and you slide back down.")
       ((get-obj "DOOR"))
       cellar
       ,rlandbit
       (rval 25))

(psetg tchomp "The troll fends you off with a menacing gesture.")

(room "MTROL"

"This is a small room with passages off in all directions. 
Bloodstains and deep scratches (perhaps made by an axe) mar the
walls."
       "The Troll Room"
       (exit "WEST" "CELLA"
		  "EAST" (cexit "TROLL-FLAG" "CRAW4" ,tchomp)
		  "NORTH" (cexit "TROLL-FLAG" "PASS1" ,tchomp)
		  "SOUTH" (cexit "TROLL-FLAG" "MAZE1" ,tchomp))
       ((get-obj "TROLL")))

(room "STUDI" 

"This is what appears to have been an artist's studio.  The walls
and floors are splattered with paints of 69 different colors. 
Strangely enough, nothing of value is hanging here.  At the north and
northwest of the room are open doors (also covered with paint).  An
extremely dark and narrow chimney leads up from a fireplace; although
you might be able to get up it, it seems unlikely you could get back
down."
       "Studio"
       (exit "NORTH" "CRAW4"
		  "NW" "GALLE"
		  "UP"
		  (cexit "LIGHT-LOAD"
			  "KITCH"
			  "The chimney is too narrow for you and all of your baggage."
			  () chimney-function)))

(room "GALLE"
"This is an art gallery.  Most of the paintings which were here
have been stolen by vandals with exceptional taste.  The vandals
left through either the north, south, or west exits."
       "Gallery"
       (exit "NORTH" "CHAS2" "SOUTH" "STUDI" "WEST" "BKENT")
       ((get-obj "PAINT"))
       ()
       (+ ,rlandbit ,rlightbit))



;;; "SUBTITLE MAZE"

(psetg mazedesc "This is part of a maze of twisty little passages, all alike.")
(psetg smazedesc "Maze")

(room "MAZE1"
       ,mazedesc ,smazedesc
       (exit "WEST" "MTROL"
	      "NORTH" "MAZE1"
	      "SOUTH" "MAZE2"
	      "EAST" "MAZE4"))

(room "MAZE2"
       ,mazedesc ,smazedesc
       (exit "SOUTH" "MAZE1"
	      "NORTH" "MAZE4"
	      "EAST" "MAZE3"))

(room "MAZE3"
       ,mazedesc ,smazedesc
       (exit "WEST" "MAZE2" "NORTH" "MAZE4" "UP" "MAZE5"))

(room "MAZE4"
       ,mazedesc ,smazedesc
       (exit "WEST" "MAZE3" "NORTH" "MAZE1" "EAST" "DEAD1"))

(room "DEAD1"
       ,deadend ,sdeadend
       (exit "SOUTH" "MAZE4"))

(room "MAZE5"
       ,mazedesc ,smazedesc
       (exit "EAST" "DEAD2" "NORTH" "MAZE3" "SW" "MAZE6")
       ((get-obj "BONES") (get-obj "BAGCO") (get-obj "KEYS")
	(get-obj "BLANT") (get-obj "RKNIF")))

(room "DEAD2"
       ,deadend ,sdeadend
       (exit "WEST" "MAZE5"))

(room "MAZE6"
       ,mazedesc ,smazedesc
       (exit "DOWN" "MAZE5" "EAST" "MAZE7" "WEST" "MAZE6" "UP" "MAZE9"))

(room "MAZE7"
       ,mazedesc ,smazedesc
       (exit "UP" "MAZ14" "WEST" "MAZE6" "NE" "DEAD1" "EAST" "MAZE8" "SOUTH" "MAZ15"))

(room "MAZE8"
       ,mazedesc ,smazedesc
       (exit "NE" "MAZE7" "WEST" "MAZE8" "SE" "DEAD3"))

(room "DEAD3"
       ,deadend ,deadend
       (exit "NORTH" "MAZE8"))

(room "MAZE9"
       ,mazedesc ,smazedesc
       (exit "NORTH" "MAZE6" "EAST" "MAZ11" "DOWN" "MAZ10" "SOUTH" "MAZ13"
	      "WEST" "MAZ12" "NW" "MAZE9"))

(room "MAZ10"
       ,mazedesc ,smazedesc
       (exit "EAST" "MAZE9" "WEST" "MAZ13" "UP" "MAZ11"))

(room "MAZ11"
       ,mazedesc
       ,smazedesc
       (exit "NE" "MGRAT" "DOWN" "MAZ10" "NW" "MAZ13" "SW" "MAZ12"))
	      
(room "MGRAT"
       ""
       "Grating Room"
       (exit "SW" "MAZ11" "UP" (door "GRATE" "MGRAT" "CLEAR" "The grating is locked."))
       ((get-obj "GRATE"))
       maze-11)

(room "MAZ12"
       ,mazedesc ,smazedesc
       (exit "WEST" "MAZE5" "SW" "MAZ11" "EAST" "MAZ13" "UP" "MAZE9" "NORTH" "DEAD4"))

(room "DEAD4"
       ,deadend ,deadend
       (exit "SOUTH" "MAZ12"))

(room "MAZ13"
       ,mazedesc ,smazedesc
       (exit "EAST" "MAZE9" "DOWN" "MAZ12" "SOUTH" "MAZ10" "WEST" "MAZ11"))

(room "MAZ14"
       ,mazedesc ,smazedesc
       (exit "WEST" "MAZ15" "NW" "MAZ14" "NE" "MAZE7" "SOUTH" "MAZE7"))

(room "MAZ15"
       ,mazedesc ,smazedesc
       (exit "WEST" "MAZ14" "SOUTH" "MAZE7" "NE" "CYCLO"))



;;; "SUBTITLE CYCLOPS AND HIDEAWAY"

(room "CYCLO"
       "" "Cyclops Room"
       (exit "WEST" "MAZ15" "NORTH" (cexit "MAGIC-FLAG" "BLROO" "The north wall is solid rock.")
		  "UP" (cexit "CYCLOPS-FLAG" "TREAS" "The cyclops doesn't look like he'll let you past."))
       ((get-obj "CYCLO"))
       cyclops-room)

(room "BLROO"
"This is a long passage.  To the south is one entrance.  On the
east there is an old wooden door, with a large hole in it (about
cyclops sized)."
       "Strange Passage"
       (exit "SOUTH" "CYCLO" "EAST" "LROOM")
       ()
       time
       ,rlandbit
       (rval 10))

(room "TREAS"

"This is a large room, whose north wall is solid granite.  A number
of discarded bags, which crumble at your touch, are scattered about
on the floor.  There is an exit down and what appears to be a newly
created passage to the east."
	"Treasure Room"
	(exit "DOWN" "CYCLO" "EAST" "CPANT")
	((get-obj "CHALI"))
	treasure-room
	,rlandbit
	(rval 25))



;;; "SUBTITLE RESERVOIR AREA"

(room "RAVI1"

"This is a deep ravine at a crossing with an east-west crawlway. 
Some stone steps are at the south of the ravine and a steep staircase
descends."
       "Deep Ravine"
       (exit "SOUTH" "PASS1" "DOWN"
	     (cexit "EGYPT-FLAG"
		    "RESES"
		    "The stairs are to steep for you with your burden."
		    t
		    coffin-cure) "EAST" "CHAS1" "WEST" "CRAW1"))

(room "CRAW1"

"This is a crawlway with a three-foot high ceiling.  Your footing
is very unsure here due to the assortment of rocks underfoot. 
Passages can be seen in the east, west, and northwest corners of the
passage."
       "Rocky Crawl"
       (exit "WEST" "RAVI1" "EAST" "DOME" "NW"
	     (cexit "EGYPT-FLAG" "EGYPT"
		    "The passage is too narrow to accomodate coffins."
		    t coffin-cure)))

(room "RESES"
       ""
       "Reservoir South"
       (exit "SOUTH" (cexit "EGYPT-FLAG"
			      "RAVI1"
			      "The coffin will not fit through this passage."
			      t
			      coffin-cure)
	      "WEST" "STREA"
	      "CROSS" (cexit "LOW-TIDE" "RESER" "You are not equipped for swimming.")
	      "NORTH" (cexit "LOW-TIDE" "RESER" "You are not equipped for swimming.")
	      "LAUNC" "RESER"
	      "UP" (cexit "EGYPT-FLAG"
			   "CANY1"
			   "The stairs are too steep for carrying the coffin."
			   t
			   coffin-cure))
       ()
       reservoir-south
       ,rlandbit
       (rglobal ,rgwater))

(room "RESER"
       ""
       "Reservoir"
       (exit "NORTH" "RESEN" "SOUTH" "RESES"
	      "UP" "INSTR" "DOWN" "The dam blocks your way."
	      "LAND" "You must specify direction.")
       ((get-obj "TRUNK"))
       reservoir
       (+ ,rwaterbit ,rnwallbit)
       (rglobal ,rgwater))

(room "RESEN"
       ""
       "Reservoir North"
       (exit "NORTH" "ATLAN" "LAUNC" "RESER"
	      "CROSS" (cexit "LOW-TIDE" "RESER" "You are not equipped for swimming.")
	      "SOUTH" (cexit "LOW-TIDE" "RESER" "You are not equipped for swimming."))
       ((get-obj "PUMP"))
       reservoir-north
       ,rlandbit
       (rglobal ,rgwater))

(room "STREA"
"You are standing on a path beside a gently flowing stream.  The path
travels to the north and the east."
       "Stream View"
       (exit "LAUNC" "INSTR" "EAST" "RESES" "NORTH" "ICY")
       ((get-obj "FUSE"))
       ()
       ,rlandbit
       (rglobal ,rgwater))

(room "INSTR"
"You are on the gently flowing stream.  The upstream route is too narrow
to  navigate and the downstream route is invisible due to twisting
walls.  There is a narrow beach to land on."
       "Stream"
       (exit "UP" "The way is too narrow."
	      "LAND" "STREA"
	      "DOWN" "RESER")
       ()
       ()
       (+ ,rwaterbit ,rnwallbit)
       (rglobal ,rgwater))

(room "EGYPT"
"This is a room which looks like an Egyptian tomb.  There is an
ascending staircase in the room as well as doors, east and south."
       "Egyptian Room"
       (exit "UP" "ICY" "SOUTH" "LEDG3"
	      "EAST" (cexit "EGYPT-FLAG" "CRAW1"
			     "The passage is too narrow to accomodate coffins." t
			     coffin-cure))
       ((get-obj "COFFI")))

(room "ICY"
       ""
       "Glacier Room"
       (exit "NORTH" "STREA" "EAST" "EGYPT" "WEST" (cexit "GLACIER-FLAG" "RUBYR"))
       ((get-obj "ICE"))
       glacier-room)

(room "RUBYR"
"This is a small chamber behind the remains of the Great Glacier.
To the south and west are small passageways."
       "Ruby Room"
       (exit "WEST" "LAVA" "SOUTH" "ICY")
       ((get-obj "RUBY")))

(room "ATLAN"
      "This is an ancient room, long under water.  There are exits here
to the southeast and upward."
       "Atlantis Room"
       (exit "SE" "RESEN" "UP" "CAVE1")
       ((get-obj "TRIDE")))

(room "CANY1"
"You are on the south edge of a deep canyon.  Passages lead off
to the east, south, and northwest.  You can hear the sound of
flowing water below."
       "Deep Canyon"
       (exit "NW" (cexit "EGYPT-FLAG"
			 "RESES"
			 "The passage is too steep for carrying the coffin."
			 t
			 coffin-cure) "EAST" "DAM" "SOUTH" "CAROU"))



;;; "SUBTITLE ECHO ROOM"

(room "ECHO"
"This is a large room with a ceiling which cannot be detected from
the ground. There is a narrow passage from east to west and a stone
stairway leading upward.  The room is extremely noisy.  In fact, it is
difficult to hear yourself think."
       "Loud Room"
       (exit "EAST" "CHAS3" "WEST" "PASS5" "UP" "CAVE3")
       ((get-obj "BAR"))
       echo-room)

(room "MIRR1"
       ""
       "Mirror Room"
       (exit "WEST" "PASS3" "NORTH" "CRAW2" "EAST" "CAVE1")
       ((get-obj "REFL1"))
       mirror-room)

(room "MIRR2"
       ""
       "Mirror Room"
       (exit "WEST" "PASS4" "NORTH" "CRAW3" "EAST" "CAVE2")
       ((get-obj "REFL2"))
       mirror-room
       (+ ,rlandbit ,rlightbit))

(room "CAVE1"
"This is a small cave with an entrance to the north and a stairway
leading down."
       "Cave"
       (exit "NORTH" "MIRR1" "DOWN" "ATLAN"))

(room "CAVE2"
"This is a tiny cave with entrances west and north, and a dark,
forbidding staircase leading down."
       "Cave"
       (exit "NORTH" "CRAW3" "WEST" "MIRR2" "DOWN" "LLD1")
       ()
       cave2-room)

(room "CRAW2"
"This is a steep and narrow crawlway.  There are two exits nearby to
the south and southwest."
       "Steep Crawlway"
       (exit "SOUTH" "MIRR1" "SW" "PASS3"))

(room "CRAW3"
"This is a narrow crawlway.  The crawlway leads from north to south.
However the south passage divides to the south and southwest."
      "Narrow Crawlway"
       (exit "SOUTH" "CAVE2" "SW" "MIRR2" "NORTH" "MGRAI"))

(room "PASS3"
"This is a cold and damp corridor where a long east-west passageway
intersects with a northward path."
       "Cold Passage"
       (exit "EAST" "MIRR1" "WEST" "SLIDE" "NORTH" "CRAW2"))

(room "PASS4"

"This is a winding passage.  It seems that there is only an exit
on the east end although the whirring from the round room can be
heard faintly to the north."
       "Winding Passage"
       (exit "EAST" "MIRR2" "NORTH"
 "You hear the whir from the round room but can find no entrance."))



;;; "SUBTITLE COAL MINE AREA"

(room "ENTRA"

"You are standing at the entrance of what might have been a coal
mine. To the northeast and the northwest are entrances to the mine,
and there is another exit on the south end of the room."
       "Mine Entrance"
       (exit "SOUTH" "SLIDE" "NW" "SQUEE" "NE" "TSHAF"))

(room "SQUEE"
"You are a small room.  Strange squeaky sounds may be heard coming from
the passage at the west end.  You may also escape to the south."
       "Squeaky Room"
       (exit "WEST" "BATS" "SOUTH" "ENTRA"))

(room "TSHAF"
       "This is a large room, in the middle of which is a small shaft
descending through the floor into darkness below.  To the west and
the north are exits from this room.  Constructed over the top of the
shaft is a metal framework to which a heavy iron chain is attached."
       "Shaft Room"
       (exit "DOWN" "You wouldn't fit and would die if you could."
	      "WEST" "ENTRA" "NORTH" "TUNNE")
       ((get-obj "TBASK")))

(room "TUNNE"

"This is a narrow tunnel with large wooden beams running across
the ceiling and around the walls.  A path from the south splits into
paths running west and northeast."
       "Wooden Tunnel"
       (exit "SOUTH" "TSHAF" "WEST" "SMELL" "NE" "MINE1"))

(room "SMELL"

"This is a small non-descript room.  However, from the direction
of a small descending staircase a foul odor can be detected.  To the
east is a narrow path."
       "Smelly Room"
       (exit "DOWN" "BOOM" "EAST" "TUNNE"))

(room "BOOM"
       "This is a small room which smells strongly of coal gas."
       "Gas Room"
       (exit "UP" "SMELL")
       ((get-obj "BRACE"))
       boom-room
       (+ ,rlandbit ,rsacredbit))

(room "TLADD"

"This is a very small room.  In the corner is a rickety wooden
ladder, leading downward.  It might be safe to descend.  There is
also a staircase leading upward."
       "Ladder Top"
       (exit "DOWN" "BLADD" "UP" "MINE7"))

(room "BLADD"

"This is a rather wide room.  On one side is the bottom of a
narrow wooden ladder.  To the northeast and the south are passages
leaving the room."
       "Ladder Bottom"
       (exit "NE" "DEAD7" "SOUTH" "TIMBE" "UP" "TLADD"))

(room "DEAD7"
       ,deadend
       ,deadend
       (exit "SOUTH" "BLADD")
       ((get-obj "COAL")))

(psetg nofit "You cannot fit through this passage with that load.")

(room "TIMBE"
"This is a long and narrow passage, which is cluttered with broken
timbers.  A wide passage comes from the north and turns at the 
southwest corner of the room into a very narrow passageway."
       "Timber Room"
       (exit "NORTH" "BLADD"
	      "SW" (setg dark-room (cexit "EMPTY-HANDED" "BSHAF" ,nofit)))
       ((get-obj "OTIMB"))
       no-objs
       (+ ,rlandbit ,rsacredbit))

(room "BSHAF" 

"This is a small square room which is at the bottom of a long
shaft. To the east is a passageway and to the northeast a very narrow
passage. In the shaft can be seen a heavy iron chain."
       "Lower Shaft"
       (exit "EAST" "MACHI"
	      "OUT" (cexit "EMPTY-HANDED" "TIMBE" ,nofit)
	      "NE" (cexit "EMPTY-HANDED" "TIMBE" ,nofit)
	      "UP" "The chain is not climbable.")
       ((get-obj "FBASK"))
       no-objs
       (+ ,rlandbit ,rsacredbit))

(room "MACHI"
       ""
       "Machine Room"
       (exit "NW" "BSHAF")
       ((get-obj "MSWIT") (get-obj "MACHI"))
       machine-room)

(room "BATS"
      ""
      "Bat Room"
      (exit "EAST" "SQUEE") 
      ((get-obj "JADE") (get-obj "BAT"))
      bats-room
      (+ ,rlandbit ,rsacredbit))



;;; "SUBTITLE COAL MINE"

(psetg mindesc "This is a non-descript part of a coal mine.")
(psetg smindesc "Coal mine")

(room "MINE1"
       ,mindesc
       ,smindesc
       (exit "NORTH" "MINE4" "SW" "MINE2" "EAST" "TUNNE"))

(room "MINE2"
       ,mindesc
       ,smindesc
       (exit "SOUTH" "MINE1" "WEST" "MINE5" "UP" "MINE3" "NE" "MINE4"))

(room "MINE3"
       ,mindesc
       ,smindesc
       (exit "WEST" "MINE2" "NE" "MINE5" "EAST" "MINE5"))

(room "MINE4"
       ,mindesc
       ,smindesc
       (exit "UP" "MINE5" "NE" "MINE6" "SOUTH" "MINE1" "WEST" "MINE2"))

(room "MINE5"
       ,mindesc
       ,smindesc
       (exit "DOWN" "MINE6" "NORTH" "MINE7" "WEST" "MINE2" "SOUTH" "MINE3"
              "UP" "MINE3" "EAST" "MINE4"))

(room "MINE6"
       ,mindesc
       ,smindesc
       (exit "SE" "MINE4" "UP" "MINE5" "NW" "MINE7"))

(room "MINE7"
       ,mindesc
       ,smindesc
       (exit "EAST" "MINE1" "WEST" "MINE5" "DOWN" "TLADD" "SOUTH" "MINE6"))



;;; "SUBTITLE DOME/TORCH AREA"

(room "DOME"
       ""
       "Dome Room"
       (exit "EAST" "CRAW1"
	      "DOWN" (cexit "DOME-FLAG"
			     "MTORC"
			     "You cannot go down without fracturing many bones."))
       ((get-obj "RAILI"))
       dome-room)

(room "MTORC"
       ""
       "Torch Room"
       (exit "UP" "You cannot reach the rope." "WEST" "PRM" "DOWN" "CRAW4")
       ((get-obj "TORCH"))
       torch-room)

(room "CRAW4"
"This is a north-south crawlway; a passage goes to the east also.
There is a hole above, but it provides no opportunities for climbing."
       "North-South Crawlway"
       (exit "NORTH" "CHAS2" "SOUTH" "STUDI" "EAST" "MTROL"
	      "UP" "Not even a human fly could get up it."))

(room "CHAS2"

"You are on the west edge of a chasm, the bottom of which cannot be
seen. The east side is sheer rock, providing no exits.  A narrow
passage goes west, and the path you are on continues to the north and
south."
       "West of Chasm"
       (exit "WEST" "CELLA" "NORTH" "CRAW4" "SOUTH" "GALLE"
		  "DOWN" "The chasm probably leads straight to the infernal regions."))

(room "PASS1"
"This is a narrow east-west passageway.  There is a narrow stairway
leading down at the north end of the room."
       "East-West Passage"
       (exit "EAST" "CAROU" "WEST" "MTROL" "DOWN" "RAVI1" "NORTH" "RAVI1") 
       ()
       ()
       ,rlandbit
       (rval 5))

(room "CAROU"
       ""
       "Round room"
       (exit "NORTH" (cexit "CAROUSEL-FLIP" "CAVE4" "" () carousel-exit)
	      "SOUTH" (cexit "CAROUSEL-FLIP" "CAVE4" "" () carousel-exit)
	      "EAST" (cexit "CAROUSEL-FLIP" "MGRAI" "" () carousel-exit)
	      "WEST" (cexit "CAROUSEL-FLIP" "PASS1" "" () carousel-exit)
	      "NW" (cexit "CAROUSEL-FLIP" "CANY1" "" () carousel-exit)
	      "NE" (cexit "CAROUSEL-FLIP" "PASS5" "" () carousel-exit)
	      "SE" (cexit "CAROUSEL-FLIP" "PASS4" "" () carousel-exit)
	      "SW" (cexit "CAROUSEL-FLIP" "MAZE1" "" () carousel-exit)
	      "EXIT" (cexit "CAROUSEL-FLIP" "PASS3" "" () carousel-out))
       ((get-obj "IRBOX"))
       carousel-room)

(room "PASS5"
       "This is a high north-south passage, which forks to the northeast."
       "North-South Passage"
       (exit "NORTH" "CHAS1" "NE" "ECHO" "SOUTH" "CAROU"))

(room "CHAS1"
"A chasm runs southwest to northeast.  You are on the south edge; the
path exits to the south and to the east."
       "Chasm"
       (exit "SOUTH" "RAVI1" "EAST" "PASS5"
		  "DOWN" "Are you out of your mind?"))

(room "CAVE3"

"This is a cave.  Passages exit to the south and to the east, but
the cave narrows to a crack to the west.  The earth is particularly
damp here."
       "Damp Cave"
       (exit "SOUTH" "ECHO" "EAST" "DAM"
		  "WEST" "It is too narrow for most insects."))

(room "CHAS3"
"A chasm, evidently produced by an ancient river, runs through the
cave here.  Passages lead off in all directions."
       "Ancient Chasm"
       (exit "SOUTH" "ECHO" "EAST" "TCAVE" "NORTH" "DEAD5" "WEST" "DEAD6"))

(room "DEAD5"
       ,deadend
       ,deadend
       (exit "SW" "CHAS3"))

(room "DEAD6"
       ,deadend
       ,deadend
       (exit "EAST" "CHAS3"))

(room "CAVE4"
"You have entered a cave with passages leading north and southeast."
       "Engravings Cave"
       (exit "NORTH" "CAROU" "SE" "RIDDL")
       ((get-obj "ENGRA")))

(room "RIDDL"

"This is a room which is bare on all sides.  There is an exit down. 
To the east is a great door made of stone.  Above the stone, the
following words are written: 'No man shall enter this room without
solving this riddle:

  What is tall as a house,
	  round as a cup, 
	  and all the king's horses can't draw it up?'

(Reply via 'ANSWER \"answer\"')"
       "Riddle Room"
       (exit "DOWN" "CAVE4"
	      "EAST" (cexit "RIDDLE-FLAG" "MPEAR"
			     "Your way is blocked by an invisible force."))
       ((get-obj "SDOOR")))

(room "MPEAR"
"This is a former broom closet.  The exits are to the east and west."
       "Pearl Room"
       (exit "EAST" "BWELL" "WEST" "RIDDL")
       ((get-obj "PEARL")))

(room "LLD1"
       ""
       "Entrance to Hades"
       (exit "EAST"
		(cexit "LLD-FLAG"
			"LLD2"
			"Some invisible force prevents you from passing through the gate.")
		"UP" "CAVE2"
		"ENTER"
		(cexit "LLD-FLAG"
			"LLD2"
			"Some invisible force prevents you from passing through the gate."))
       ((get-obj "CORPS") (get-obj "GATES") (get-obj "GHOST"))
       lld-room
       (+ ,rlandbit ,rlightbit))

(room "LLD2"
       ""
       "Land of the Living Dead"
       (exit "EAST" "TOMB"
		"EXIT" "LLD1" "WEST" "LLD1")
       ((get-obj "BODIE"))
       lld2-room
       (+ ,rlandbit ,rlightbit)
       (rval 30))

(room "MGRAI"
"You are standing in a small circular room with a pedestal.  A set of
stairs leads up, and passages leave to the east and west."
       "Grail Room"
       (exit "WEST" "CAROU" "EAST" "CRAW3" "UP" "TEMP1")
       ((get-obj "GRAIL")))

(room "TEMP1"

"This is the west end of a large temple.  On the south wall is an 
ancient inscription, probably a prayer in a long-forgotten language. 
The north wall is solid granite.  The entrance at the west end of the
room is through huge marble pillars."
       "Temple"
       (exit "WEST" "MGRAI" "EAST" "TEMP2")
       ((get-obj "PRAYE") (get-obj "BELL"))
       ()
       (+ ,rlandbit ,rlightbit ,rsacredbit))

(room "TEMP2"
"This is the east end of a large temple.  In front of you is what
appears to be an altar."
       "Altar"
       (exit "WEST" "TEMP1")
       ((get-obj "BOOK") (get-obj "CANDL"))
       ()
       (+ ,rlandbit ,rlightbit ,rsacredbit))



;;; "SUBTITLE FLOOD CONTROL DAM #3"

(room "DAM"
       ""
       "Dam"
       (exit "SOUTH" "CANY1" "DOWN" "DOCK" "EAST" "CAVE3" "NORTH" "LOBBY")
       ((get-obj "BOLT") (get-obj "DAM") (get-obj "BUBBL") (get-obj "CPANL"))
       dam-room
       (+ ,rlandbit ,rlightbit)
       (rglobal ,rgwater))

(room "LOBBY"
"This room appears to have been the waiting room for groups touring
the dam.  There are exits here to the north and east marked
'Private', though the doors are open, and an exit to the south."
       "Dam Lobby"
       (exit "SOUTH" "DAM"
	      "NORTH" "MAINT"
	      "EAST" "MAINT")
       ((get-obj "MATCH") (get-obj "GUIDE"))
       ()
       (+ ,rlandbit ,rlightbit))

(room "MAINT"

"This is what appears to have been the maintenance room for Flood
Control Dam #3, judging by the assortment of tool chests around the
room.  Apparently, this room has been ransacked recently, for most of
the valuable equipment is gone. On the wall in front of you is a
group of buttons, which are labelled in EBCDIC. However, they are of
different colors:  Blue, Yellow, Brown, and Red. The doors to this
room are in the west and south ends."
       "Maintenance Room"
       (exit "SOUTH" "LOBBY" "WEST" "LOBBY")
       ((get-obj "LEAK") (get-obj "TUBE") (get-obj "WRENC")
	(get-obj "BLBUT") (get-obj "RBUTT") (get-obj "BRBUT")
	(get-obj "YBUTT") (get-obj "SCREW") (get-obj "TCHST"))
       maint-room
       ,rlandbit)



;;; "SUBTITLE RIVER AREA"

(psetg cliffs "The White Cliffs prevent your landing here.")

(psetg riverdesc "Frigid River")

(psetg current "You cannot go upstream due to strong currents.")

(psetg narrow "The path is too narrow.")

(room "DOCK"
"You are at the base of Flood Control Dam #3, which looms above you
and to the north.  The river Frigid is flowing by here.  Across the
river are the White Cliffs which seem to form a giant wall stretching
from north to south along the east shore of the river as it winds its
way downstream."
       "Dam Base"
       (exit "NORTH" "DAM" "UP" "DAM" "LAUNC" "RIVR1")
       ((get-obj "IBOAT") (get-obj "STICK"))
       ()
       (+ ,rlandbit ,rlightbit ,rnwallbit ,rsacredbit)
       (rglobal ,rgwater))

(room "RIVR1"
"You are on the River Frigid in the vicinity of the Dam.  The river
flows quietly here.  There is a landing on the west shore."
       ,riverdesc
       (exit "UP" ,current "WEST" "DOCK" "LAND" "DOCK" "DOWN" "RIVR2"
	      "EAST" ,cliffs)
       ()
       ()
       (+ ,rwaterbit ,rnwallbit ,rsacredbit)
       (rglobal ,rgwater))

(room "RIVR2"
"The River turns a corner here making it impossible to see the
Dam.  The White Cliffs loom on the east bank and large rocks prevent
landing on the west."
       ,riverdesc
       (exit "UP" ,current "DOWN" "RIVR3" "EAST" ,cliffs) () ()
       (+ ,rwaterbit ,rnwallbit ,rsacredbit)
       (rglobal ,rgwater))

(room "RIVR3"
"The river descends here into a valley.  There is a narrow beach on
the east below the cliffs and there is some shore on the west which
may be suitable.  In the distance a faint rumbling can be heard."
       ,riverdesc
       (exit "UP" ,current "DOWN" "RIVR4" "EAST" "WCLF1" "WEST" "RCAVE"
	      "LAND" "You must specify which direction here.")
       () () (+ ,rwaterbit ,rnwallbit ,rsacredbit)
       (rglobal ,rgwater))

(room "WCLF1"
"You are on a narrow strip of beach which runs along the base of the
White Cliffs. The only path here is a narrow one, heading south
along the Cliffs."
       "White Cliffs Beach"
       (exit "SOUTH" (cexit "DEFLATE" "WCLF2" ,narrow) "LAUNC" "RIVR3")
       ((get-obj "WCLIF")) cliff-function (+ ,rlandbit ,rsacredbit ,rnwallbit)
       (rglobal ,rgwater))

(room "WCLF2"

"You are on a rocky, narrow strip of beach beside the Cliffs.  A
narrow path leads north along the shore."
       "White Cliffs Beach"
       (exit "NORTH" (cexit "DEFLATE" "WCLF1" ,narrow) "LAUNC" "RIVR4")
       ((get-obj "WCLIF")) cliff-function (+ ,rnwallbit ,rlandbit ,rsacredbit)
       (rglobal ,rgwater))

(room "RIVR4"

"The river is running faster here and the sound ahead appears to be
that of rushing water.  On the west shore is a sandy beach.  A small
area of beach can also be seen below the Cliffs."
       ,riverdesc
       (exit "UP" ,current "DOWN" "RIVR5" "EAST" "WCLF2" "WEST" "BEACH"
	      "LAND" "Specify the direction to land.")
       ((get-obj "BUOY"))
       rivr4-room
       (+ ,rwaterbit ,rnwallbit ,rsacredbit)
       (rglobal ,rgwater))

(room "RIVR5"
"The sound of rushing water is nearly unbearable here.  On the west
shore is a large landing area."
       ,riverdesc
       (exit "UP" ,current "DOWN" "FCHMP" "LAND" "FANTE")
       () ()
       (+ ,rwaterbit ,rnwallbit ,rsacredbit)
       (rglobal ,rgwater))

(room "FCHMP"
       ""
       "Moby lossage" (exit "NORTH" "") () over-falls)

(room "FANTE"
"You are on the shore of the River.  The river here seems somewhat
treacherous.  A path travels from north to south here, the south end
quickly turning around a sharp corner."
       "Shore"
       (exit "LAUNC" "RIVR5" "NORTH" "BEACH"
	      "SOUTH" "FALLS")
       ()
       ()
       (+ ,rnwallbit ,rlandbit ,rsacredbit)
       (rglobal ,rgwater))

(room "BEACH"
"You are on a large sandy beach at the shore of the river, which is
flowing quickly by.  A path runs beside the river to the south here."
       "Sandy Beach"
       (exit "LAUNC" "RIVR4" "SOUTH" "FANTE")
       ((get-obj "STATU") (get-obj "SAND"))
       ()
       (+ ,rnwallbit ,rlandbit ,rsacredbit)
       (rglobal ,rgwater))

(room "RCAVE"
"You are on the west shore of the river.  An entrance to a cave is
to the northwest.  The shore is very rocky here."
       "Rocky Shore"
       (exit "LAUNC" "RIVR3" "NW" "TCAVE")
       () () (+ ,rnwallbit ,rlandbit ,rsacredbit)
       (rglobal ,rgwater))

(room "TCAVE"
"This is a small cave whose exits are on the south and northwest."
       "Small Cave"
       (exit "SOUTH" "RCAVE" "NW" "CHAS3")
       ((get-obj "GUANO") (get-obj "SHOVE")))

(room "FALLS"
       ""
       "Aragain Falls"
       (exit "EAST" (cexit "RAINBOW" "RAINB") 
	     "DOWN" "It's a long way..." "NORTH" "FANTE"
	       "UP" (cexit "RAINBOW" "RAINB"))
       ((get-obj "RAINB") (get-obj "BARRE"))
       falls-room
       (+ ,rnwallbit ,rlandbit ,rsacredbit)
       (rglobal ,rgwater))

(room "RAINB"
"You are on top of a rainbow (I bet you never thought you would walk
on a rainbow), with a magnificent view of the Falls.  The rainbow
travels east-west here.  There is an NBC Commissary here."
       "Rainbow Room"
       (exit "EAST" "POG" "WEST" "FALLS")
       ()
       ()
       (+ ,rlandbit ,rlightbit ,rnwallbit ,rsacredbit))

(setg crain (cexit "RAINBOW" "RAINB"))

(room "POG"
"You are on a small, rocky beach on the continuation of the Frigid
River past the Falls.  The beach is narrow due to the presence of the
White Cliffs.  The river canyon opens here and sunlight shines in
from above. A rainbow crosses over the falls to the west and a narrow
path continues to the southeast."
       "End of Rainbow"
       (exit "UP" ,crain "NW" ,crain "WEST" ,crain "SE" "CLBOT"
	     "LAUNC" "The sharp rocks endanger your boat.")
       ((get-obj "RAINB") (get-obj "POT"))
       ()
       (+ ,rlandbit ,rlightbit ,rnwallbit)
       (rglobal ,rgwater))

(room "CLBOT"
"You are beneath the walls of the river canyon which may be climbable
here.  There is a small stream here, which is the lesser part of the
runoff of Aragain Falls. To the north is a narrow path."
       "Canyon Bottom"
       (exit "UP" "CLMID" "NORTH" "POG")
       ((get-obj "CCLIF"))
       ()
       (+ ,rlandbit ,rlightbit ,rnwallbit ,rsacredbit)
       (rglobal ,rgwater))

(room "CLMID"

"You are on a ledge about halfway up the wall of the river canyon.
You can see from here that the main flow from Aragain Falls twists
along a passage which it is impossible to enter.  Below you is the
canyon bottom.  Above you is more cliff, which still appears
climbable."
       "Rocky Ledge"
       (exit "UP" "CLTOP" "DOWN" "CLBOT")
       ((get-obj "CCLIF"))
       ()
       (+ ,rlandbit ,rlightbit ,rnwallbit ,rsacredbit))

(room "CLTOP"

"You are at the top of the Great Canyon on its south wall.  From here
there is a marvelous view of the Canyon and parts of the Frigid River
upstream.  Across the canyon, the walls of the White Cliffs still
appear to loom far above.  Following the Canyon upstream (north and
northwest), Aragain Falls may be seen, complete with rainbow. 
Fortunately, my vision is better than average and I can discern the
top of the Flood Control Dam #3 far to the distant north.  To the
west and south can be seen an immense forest, stretching for miles
around.  It is possible to climb down into the canyon from here."
       "Canyon View"
       (exit "DOWN" "CLMID" "SOUTH" "FORE4" "WEST" "FORE5")
       ((get-obj "CCLIF"))
       ()
       (+ ,rlandbit ,rlightbit ,rnwallbit ,rsacredbit))



;;; "SUBTITLE VOLCANO AREA"

(room "VLBOT"
"You are at the bottom of a large dormant volcano.  High above you
light may be seen entering from the cone of the volcano.  The only
exit here is to the north."
       "Volcano Bottom"
       (exit "NORTH" "LAVA")
       ((get-obj "BALLO")))

(room "VAIR1"
"You are about one hundred feet above the bottom of the volcano.  The
top of the volcano is clearly visible here."
       "Volcano Core"
       ,nulexit
       ()
       ()
       (+ ,rairbit ,rnwallbit ,rsacredbit))

(room "VAIR2"
"You are about two hundred feet above the volcano floor.  Looming
above is the rim of the volcano.  There is a small ledge on the west
side."
       "Volcano near small ledge"
       (exit "WEST" "LEDG2" "LAND" "LEDG2")
       ()
       ()
       (+ ,rairbit ,rnwallbit ,rsacredbit))

(room "VAIR3"
"You are high above the floor of the volcano.  From here the rim of
the volcano looks very narrow and you are very near it.  To the 
east is what appears to be a viewing ledge, too thin to land on."
       "Volcano near viewing ledge"
       ,nulexit
       ()
       ()
       (+ ,rairbit ,rnwallbit ,rsacredbit))

(room "VAIR4"
"You are near the rim of the volcano which is only about 15 feet
across.  To the west, there is a place to land on a wide ledge."
       "Volcano near wide ledge"
       (exit "LAND" "LEDG4" "EAST" "LEDG4")
       ()
       ()
       (+ ,rairbit ,rnwallbit ,rsacredbit))

(setg cxgnome (cexit "GNOME-DOOR" "VLBOT"))

(room "LEDG2"
"You are on a narrow ledge overlooking the inside of an old dormant
volcano.  This ledge appears to be about in the middle between the
floor below and the rim above. There is an exit here to the south."
       "Narrow Ledge"
       (exit "DOWN" "I wouldn't jump from here."
	      "LAUNC" "VAIR2" "WEST" ,cxgnome "SOUTH" "LIBRA")
       ((get-obj "HOOK1") (get-obj "COIN")))

(room "LIBRA"
"This is a room which must have been a large library, probably
for the royal family.  All of the shelves appear to have been gnawed
to pieces by unfriendly gnomes.  To the north is an exit."
       "Library"
       (exit "NORTH" "LEDG2" "OUT" "LEDG2")
       ((get-obj "BLBK") (get-obj "GRBK") (get-obj "PUBK")
	(get-obj "WHBK")))

(room "LEDG3"
"You are on a ledge in the middle of a large volcano.  Below you
the volcano bottom can be seen and above is the rim of the volcano.
A couple of ledges can be seen on the other side of the volcano;
it appears that this ledge is intermediate in elevation between
those on the other side.  The exit from this room is to the east."
       "Volcano View"
       (exit "DOWN" "I wouldn't try that."
	      "CROSS" "It is impossible to cross this distance."
	      "EAST" "EGYPT"))

(room "LEDG4"
       ""
       "Wide Ledge"
       (exit "DOWN" "It's a long way down."
	      "LAUNC" "VAIR4" "WEST" ,cxgnome "SOUTH" "SAFE")
       ((get-obj "HOOK2"))
       ledge-function)

(room "SAFE"
       ""
       "Dusty Room"
       (exit "NORTH" "LEDG4")
       ((get-obj "SSLOT") (get-obj "SAFE"))
       safe-room
       (+ ,rlandbit ,rlightbit))

(room "LAVA"
"This is a small room, whose walls are formed by an old lava flow.
There are exits here to the west and the south."
       "Lava Room"
       (exit "SOUTH" "VLBOT" "WEST" "RUBYR"))

(setg bloc (get-room "VLBOT"))



;;; "SUBTITLE ALICE IN WONDERLAND"

(setg bucket-top!-flag ())

(setg magcmach (cexit "FROBOZZ" "CMACH" "" () magnet-room-exit))

(setg magalice (cexit "FROBOZZ" "ALICE" "" () magnet-room-exit))

(room "MAGNE"
       ""
       "Low Room"
       (exit "NORTH" ,magcmach "SOUTH" ,magcmach "WEST" ,magcmach "NE" ,magcmach
	      "NW" ,magalice "SW" ,magalice "SE" ,magalice "EAST" ,magcmach
	      "OUT" ,magalice)
       ((get-obj "RBTLB") (get-obj "ROBOT"))
       magnet-room)

(room "CMACH"
       ""
       "Machine Room"
       (exit "WEST" "MAGNE" "SOUTH" "CAGER")
       ((get-obj "SQBUT") (get-obj "RNBUT") (get-obj "TRBUT"))
       cmach-room)

(room "CAGER"
"This is a dingy closet adjacent to the machine room.  On one wall
is a small sticker which says
		Protected by
		  FROBOZZ
	     Magic Alarm Company
	      (Hello, footpad!)
"
       "Dingy Closet"
       (exit "NORTH" "CMACH")
       ((get-obj "SPHER"))
       ()
       (+ ,rlightbit ,rlandbit))

(room "CAGED"
"You are trapped inside a steel cage."
       "Cage"
       (exit "NORTH" "")
       ((get-obj "CAGE")) caged-room (+ ,rlandbit ,rnwallbit))

(room "TWELL"

"You are at the top of the well.  Well done.  There are etchings on
the side of the well. There is a small crack across the floor at the
entrance to a room on the east, but it can be crossed easily."
       "Top of Well"
       (exit "EAST" "ALICE" "DOWN" "It's a long way down!")
       ((get-obj "ETCH2"))
       ()
       (+ ,rlandbit ,rbuckbit)
       (rval 10
	rglobal ,wellbit))

(room "BWELL"
       
"This is a damp circular room, whose walls are made of brick and
mortar.  The roof of this room is not visible, but there appear to be
some etchings on the walls.  There is a passageway to the west."
       "Circular Room"
       (exit "WEST" "MPEAR" "UP" "The walls cannot be climbed.")
       ((get-obj "BUCKE") (get-obj "ETCH1"))
       ()
       (+ ,rlandbit ,rbuckbit)
       (rglobal ,wellbit))

(room "ALICE"

"This is a small square room, in the center of which is a large
oblong table, no doubt set for afternoon tea.  It is clear from the
objects on the table that the users were indeed mad.  In the eastern
corner of the room is a small hole (no more than four inches high). 
There are passageways leading away to the west and the northwest."
       "Tea Room"
       (exit "EAST" "Only a mouse could get in there."
	      "WEST" "TWELL" "NW" "MAGNE")
       ((get-obj "ATABL") (get-obj "ECAKE") (get-obj "ORICE")
	(get-obj "RDICE") (get-obj "BLICE")))

(psetg smdrop "There is a chasm too large to jump across.")

(room "ALISM"

"This is an enormous room, in the center of which are four wooden
posts delineating a rectangular area, above which is what appears to
be a wooden roof.  In fact, all objects in this room appear to be
abnormally large. To the east is a passageway.  There is a large
chasm on the west and the northwest."
       "Posts Room"
       (exit "NW" ,smdrop "EAST" "ALITR" "WEST" ,smdrop "DOWN" ,smdrop)
       ((get-obj "POSTS")))

(room "ALITR"

"This is a large room, one half of which is depressed.  There is a
large leak in the ceiling through which brown colored goop is
falling.  The only exit to this room is to the west."
       "Pool Room"
       (exit "EXIT" "ALISM" "WEST" "ALISM")
       ((get-obj "FLASK") (get-obj "POOL") (get-obj "PLEAK") (get-obj "SAFFR")))



;;; "SUBTITLE BANK OF ZORK"

(room "BKENT"
      
"This is the large entrance hall of the Bank of Zork, the largest
banking institution of the Great Underground Empire. A partial
account of its history is in 'The Lives of the Twelve Flatheads' with
the chapter on J. Pierpont Flathead.  A more detailed history (albeit
less objective) may be found in Flathead's outrageous autobiography
'I'm Rich and You Aren't - So There!'.
Most of the furniture has been ravaged by passing scavengers.  All
that remains are two signs at the Northwest and Northeast corners of
the room, which say
  
      (--  WEST VIEWING ROOM        EAST VIEWING ROOM  --)  
"
      "Bank Entrance"
      (exit "NW" "BKTW" "NE" "BKTE" "SOUTH" "GALLE"))

(room "BKTW"
      ""
      "West Teller's Room"
      (exit "NORTH" "BKVW" "SOUTH" "BKENT" "WEST" "BKBOX")
      ()
      teller-room)

(room "BKTE"
      ""
      "East Teller's Room"
      (exit "NORTH" "BKVE" "SOUTH" "BKENT" "EAST" "BKBOX")
      ()
      teller-room)

(setg view-room
      
"This is a room used by holders of safety deposit boxes to view
their contents.  On the north side of the room is a sign which says 
	
   REMAIN HERE WHILE THE BANK OFFICER RETRIEVES YOUR DEPOSIT BOX
    WHEN YOU ARE FINISHED, LEAVE THE BOX, AND EXIT TO THE SOUTH  
     AN ADVANCED PROTECTIVE DEVICE PREVENTS ALL CUSTOMERS FROM
      REMOVING ANY SAFETY DEPOSIT BOX FROM THIS VIEWING AREA!
               Thank You for banking at the Zork!
")

(setg scolexit (cexit "FROBOZZ" "BKENT" "" () scolgo))

(setg scol-active (find-room "FCHMP"))

(room "BKVW"
      ,view-room
      "Viewing Room"
      (exit "SOUTH" "BKENT")
      ()
      ()
      ,rlandbit
      (rglobal (+ ,wall-eswbit ,wall-nbit)))

(room "BKVE"
      ,view-room
      "Viewing Room"
      (exit "SOUTH" "BKENT")
      ()
      ()
      ,rlandbit
      (rglobal (+ ,wall-eswbit ,wall-nbit)))

(room "BKTWI"
      
"This is a small, bare room with no distinguishing features. There
are no exits from this room."
      "Small Room"
      ,nulexit
      ()
      ()
      (+ ,rlandbit ,rsacredbit)
      (rglobal (+ ,wall-eswbit ,wall-nbit)))

(room "BKVAU"
      "This is the Vault of the Bank of Zork, in which there are no doors."
      "Vault"
      ,nulexit
      ((get-obj "BILLS"))
      ()
      (+ ,rsacredbit ,rlandbit)
      (rglobal (+ ,wall-eswbit ,wall-nbit)))

(setg bkalarm 
"An alarm rings briefly and an invisible force prevents your leaving.")

(room "BKBOX"
"This is a large rectangular room.  The east and west walls here
were used for storing safety deposit boxes.  As might be expected,
all have been carefully removed by evil persons.  To the east, west,
and south of the room are large doorways. The northern 'wall'
of the room is a shimmering curtain of light.  In the center of the
room is a large stone cube, about 10 feet on a side.  Engraved on 
the side of the cube is some lettering."
      "Safety Depository"
      (exit "NORTH"
	    "There is a curtain of light there."
	    "WEST"
	    (cexit "FROBOZZ" "BKTW" ,bkalarm () bkleavew)
	    "EAST"
	    (cexit "FROBOZZ" "BKTE" ,bkalarm () bkleavee)
	    "SOUTH"
	    "BKEXE")
      ((get-obj "VAULT") (get-obj "SCOL"))
      bkbox-room
      (+ ,rlandbit ,rlightbit)
      (rglobal ,wall-nbit))

(room "BKEXE"
"This room was the office of the Chairman of the Bank of Zork.
Like the other rooms here, it has been extensively vandalized.
The lone exit is to the north."
      "Chairman's Office"
      (exit "NORTH" "BKBOX")
      ((get-obj "PORTR")))

      
))

