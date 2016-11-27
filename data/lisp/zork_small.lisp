
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
      
))







