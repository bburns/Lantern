(room "WHOUS"
    (name "West of House")
    (desc "This is an open field west of a white house, with a boarded front door.")
    (exit "NORTH" "NHOUS" "SOUTH" "SHOUS" "WEST" "FORE1" "EAST" "The door is locked, and there is evidently no key."))

(room "NHOUS"
    (name "North of House")
    (desc "You are facing the north side of a white house.  There is no door here,
and all the windows are barred.")
    (exit "WEST" "WHOUS" "EAST" "EHOUS" "NORTH" "FORE3" "SOUTH" "The windows are all barred."))

(room "SHOUS"
    (name "South of House")
    (desc "You are facing the south side of a white house. There is no door here,
and all the windows are barred.")
    (exit "WEST" "WHOUS" "EAST" "EHOUS" "SOUTH" "FORE2" "NORTH" "The windows are all barred."))

(room "EHOUS"
    (name "Behind House")
    (desc "")
    (exit "NORTH" "NHOUS" "SOUTH" "SHOUS" "EAST" "CLEAR" "WEST" ,KITCHEN-WINDOW "ENTER" ,KITCHEN-WINDOW))

(room "KITCH"
    (name "Kitchen")
    (desc "")
    (exit "EAST" ,KITCHEN-WINDOW "WEST" "LROOM" "EXIT" ,KITCHEN-WINDOW "UP" "ATTIC" "DOWN" "Only Santa Claus climbs down chimneys."))

(room "ATTIC"
    (name "Attic")
    (desc "This is the attic.  The only exit is stairs that lead down.")
    (exit "DOWN" "KITCH"))

(room "LROOM"
    (name "Living Room")
    (desc "")
    (exit "EAST" "KITCH" "WEST" "BLROO" "DOWN" "CELLA"))

(room "FORE1"
    (name "Forest")
    (desc "This is a forest, with trees in all directions around you.")
    (exit "UP" "There is no tree here suitable for climbing." "NORTH" "FORE1" "EAST" "FORE3" "SOUTH" "FORE2" "WEST" "FORE1"))

(room "FORE2"
    (name "Forest")
    (desc "This is a dimly lit forest, with large trees all around.  To the
east, there appears to be sunlight.")
    (exit "UP" "There is no tree here suitable for climbing." "NORTH" "SHOUS" "EAST" "CLEAR" "SOUTH" "FORE4" "WEST" "FORE1"))

(room "FORE3"
    (name "Forest")
    (desc "This is a dimly lit forest, with large trees all around.  One
particularly large tree with some low branches stands here.")
    (exit "UP" "TREE" "NORTH" "FORE2" "EAST" "CLEAR" "SOUTH" "CLEAR" "WEST" "NHOUS"))

(room "TREE"
    (name "Up a Tree")
    (desc "")
    (exit "DOWN" "FORE3" "UP" "You cannot climb any higher."))

(room "FORE4"
    (name "Forest")
    (desc "This is a large forest, with trees obstructing all views except
to the east, where a small clearing may be seen through the trees.")
    (exit "UP" "There is no tree here suitable for climbing." "EAST" "CLTOP" "NORTH" "FORE5" "SOUTH" "FORE4" "WEST" "FORE2"))

(room "FORE5"
    (name "Forest")
    (desc "This is a forest, with trees in all directions around you.")
    (exit "UP" "There is no tree here suitable for climbing." "NORTH" "FORE5" "SE" "CLTOP" "SOUTH" "FORE4" "WEST" "FORE2"))

(room "CLEAR"
    (name "Clearing")
    (desc "")
    (exit "SW" "EHOUS" "SE" "FORE5" "NORTH" "CLEAR" "EAST" "CLEAR" "WEST" "FORE3" "SOUTH" "FORE2" "DOWN" "MGRAT"))

(room "CELLA"
    (name "Cellar")
    (desc "")
    (exit "EAST" "MTROL" "SOUTH" "CHAS2" "UP" "LROOM" "WEST" "You try to ascend the ramp, but it is impossible, and you slide back down."))

(room "MTROL"
    (name "The Troll Room")
    (desc "This is a small room with passages off in all directions. 
Bloodstains and deep scratches (perhaps made by an axe) mar the
walls.")
    (exit "WEST" "CELLA" "EAST" "CRAW4" "NORTH" "PASS1" "SOUTH" "MAZE1"))

(room "STUDI"
    (name "Studio")
    (desc "This is what appears to have been an artist's studio.  The walls
and floors are splattered with paints of 69 different colors. 
Strangely enough, nothing of value is hanging here.  At the north and
northwest of the room are open doors (also covered with paint).  An
extremely dark and narrow chimney leads up from a fireplace; although
you might be able to get up it, it seems unlikely you could get back
down.")
    (exit "NORTH" "CRAW4" "NW" "GALLE" "UP" "KITCH"))

(room "GALLE"
    (name "Gallery")
    (desc "This is an art gallery.  Most of the paintings which were here
have been stolen by vandals with exceptional taste.  The vandals
left through either the north, south, or west exits.")
    (exit "NORTH" "CHAS2" "SOUTH" "STUDI" "WEST" "BKENT"))

(room "MAZE1"
    (name "Maze")
    (desc "This is part of a maze of twisty little passages, all alike.")
    (exit "WEST" "MTROL" "NORTH" "MAZE1" "SOUTH" "MAZE2" "EAST" "MAZE4"))

(room "MAZE2"
    (name "Maze")
    (desc "This is part of a maze of twisty little passages, all alike.")
    (exit "SOUTH" "MAZE1" "NORTH" "MAZE4" "EAST" "MAZE3"))

(room "MAZE3"
    (name "Maze")
    (desc "This is part of a maze of twisty little passages, all alike.")
    (exit "WEST" "MAZE2" "NORTH" "MAZE4" "UP" "MAZE5"))

(room "MAZE4"
    (name "Maze")
    (desc "This is part of a maze of twisty little passages, all alike.")
    (exit "WEST" "MAZE3" "NORTH" "MAZE1" "EAST" "DEAD1"))

(room "DEAD1"
    (name "You have come to a dead end in the maze.")
    (desc "Dead End")
    (exit "SOUTH" "MAZE4"))

(room "MAZE5"
    (name "Maze")
    (desc "This is part of a maze of twisty little passages, all alike.")
    (exit "EAST" "DEAD2" "NORTH" "MAZE3" "SW" "MAZE6"))

(room "DEAD2"
    (name "You have come to a dead end in the maze.")
    (desc "Dead End")
    (exit "WEST" "MAZE5"))

(room "MAZE6"
    (name "Maze")
    (desc "This is part of a maze of twisty little passages, all alike.")
    (exit "DOWN" "MAZE5" "EAST" "MAZE7" "WEST" "MAZE6" "UP" "MAZE9"))

(room "MAZE7"
    (name "Maze")
    (desc "This is part of a maze of twisty little passages, all alike.")
    (exit "UP" "MAZ14" "WEST" "MAZE6" "NE" "DEAD1" "EAST" "MAZE8" "SOUTH" "MAZ15"))

(room "MAZE8"
    (name "Maze")
    (desc "This is part of a maze of twisty little passages, all alike.")
    (exit "NE" "MAZE7" "WEST" "MAZE8" "SE" "DEAD3"))

(room "DEAD3"
    (name "Dead End")
    (desc "Dead End")
    (exit "NORTH" "MAZE8"))

(room "MAZE9"
    (name "Maze")
    (desc "This is part of a maze of twisty little passages, all alike.")
    (exit "NORTH" "MAZE6" "EAST" "MAZ11" "DOWN" "MAZ10" "SOUTH" "MAZ13" "WEST" "MAZ12" "NW" "MAZE9"))

(room "MAZ10"
    (name "Maze")
    (desc "This is part of a maze of twisty little passages, all alike.")
    (exit "EAST" "MAZE9" "WEST" "MAZ13" "UP" "MAZ11"))

(room "MAZ11"
    (name "Maze")
    (desc "This is part of a maze of twisty little passages, all alike.")
    (exit "NE" "MGRAT" "DOWN" "MAZ10" "NW" "MAZ13" "SW" "MAZ12"))

(room "MGRAT"
    (name "Grating Room")
    (desc "")
    (exit "SW" "MAZ11" "UP" "CLEAR"))

(room "MAZ12"
    (name "Maze")
    (desc "This is part of a maze of twisty little passages, all alike.")
    (exit "WEST" "MAZE5" "SW" "MAZ11" "EAST" "MAZ13" "UP" "MAZE9" "NORTH" "DEAD4"))

(room "DEAD4"
    (name "Dead End")
    (desc "Dead End")
    (exit "SOUTH" "MAZ12"))

(room "MAZ13"
    (name "Maze")
    (desc "This is part of a maze of twisty little passages, all alike.")
    (exit "EAST" "MAZE9" "DOWN" "MAZ12" "SOUTH" "MAZ10" "WEST" "MAZ11"))

(room "MAZ14"
    (name "Maze")
    (desc "This is part of a maze of twisty little passages, all alike.")
    (exit "WEST" "MAZ15" "NW" "MAZ14" "NE" "MAZE7" "SOUTH" "MAZE7"))

(room "MAZ15"
    (name "Maze")
    (desc "This is part of a maze of twisty little passages, all alike.")
    (exit "WEST" "MAZ14" "SOUTH" "MAZE7" "NE" "CYCLO"))

(room "CYCLO"
    (name "Cyclops Room")
    (desc "")
    (exit "WEST" "MAZ15" "NORTH" "BLROO" "UP" "TREAS"))

(room "BLROO"
    (name "Strange Passage")
    (desc "This is a long passage.  To the south is one entrance.  On the
east there is an old wooden door, with a large hole in it (about
cyclops sized).")
    (exit "SOUTH" "CYCLO" "EAST" "LROOM"))

(room "TREAS"
    (name "Treasure Room")
    (desc "This is a large room, whose north wall is solid granite.  A number
of discarded bags, which crumble at your touch, are scattered about
on the floor.  There is an exit down and what appears to be a newly
created passage to the east.")
    (exit "DOWN" "CYCLO" "EAST" "CPANT"))

(room "RAVI1"
    (name "Deep Ravine")
    (desc "This is a deep ravine at a crossing with an east-west crawlway. 
Some stone steps are at the south of the ravine and a steep staircase
descends.")
    (exit "SOUTH" "PASS1" "DOWN" "RESES" "EAST" "CHAS1" "WEST" "CRAW1"))

(room "CRAW1"
    (name "Rocky Crawl")
    (desc "This is a crawlway with a three-foot high ceiling.  Your footing
is very unsure here due to the assortment of rocks underfoot. 
Passages can be seen in the east, west, and northwest corners of the
passage.")
    (exit "WEST" "RAVI1" "EAST" "DOME" "NW" "EGYPT"))

(room "RESES"
    (name "Reservoir South")
    (desc "")
    (exit "SOUTH" "RAVI1" "WEST" "STREA" "CROSS" "RESER" "NORTH" "RESER" "LAUNC" "RESER" "UP" "CANY1"))

(room "RESER"
    (name "Reservoir")
    (desc "")
    (exit "NORTH" "RESEN" "SOUTH" "RESES" "UP" "INSTR" "DOWN" "The dam blocks your way." "LAND" "You must specify direction."))

(room "RESEN"
    (name "Reservoir North")
    (desc "")
    (exit "NORTH" "ATLAN" "LAUNC" "RESER" "CROSS" "RESER" "SOUTH" "RESER"))

(room "STREA"
    (name "Stream View")
    (desc "You are standing on a path beside a gently flowing stream.  The path
travels to the north and the east.")
    (exit "LAUNC" "INSTR" "EAST" "RESES" "NORTH" "ICY"))

(room "INSTR"
    (name "Stream")
    (desc "You are on the gently flowing stream.  The upstream route is too narrow
to  navigate and the downstream route is invisible due to twisting
walls.  There is a narrow beach to land on.")
    (exit "UP" "The way is too narrow." "LAND" "STREA" "DOWN" "RESER"))

(room "EGYPT"
    (name "Egyptian Room")
    (desc "This is a room which looks like an Egyptian tomb.  There is an
ascending staircase in the room as well as doors, east and south.")
    (exit "UP" "ICY" "SOUTH" "LEDG3" "EAST" "CRAW1"))

(room "ICY"
    (name "Glacier Room")
    (desc "")
    (exit "NORTH" "STREA" "EAST" "EGYPT" "WEST" "RUBYR"))

(room "RUBYR"
    (name "Ruby Room")
    (desc "This is a small chamber behind the remains of the Great Glacier.
To the south and west are small passageways.")
    (exit "WEST" "LAVA" "SOUTH" "ICY"))

(room "ATLAN"
    (name "Atlantis Room")
    (desc "This is an ancient room, long under water.  There are exits here
to the southeast and upward.")
    (exit "SE" "RESEN" "UP" "CAVE1"))

(room "CANY1"
    (name "Deep Canyon")
    (desc "You are on the south edge of a deep canyon.  Passages lead off
to the east, south, and northwest.  You can hear the sound of
flowing water below.")
    (exit "NW" "RESES" "EAST" "DAM" "SOUTH" "CAROU"))

(room "ECHO"
    (name "Loud Room")
    (desc "This is a large room with a ceiling which cannot be detected from
the ground. There is a narrow passage from east to west and a stone
stairway leading upward.  The room is extremely noisy.  In fact, it is
difficult to hear yourself think.")
    (exit "EAST" "CHAS3" "WEST" "PASS5" "UP" "CAVE3"))

(room "MIRR1"
    (name "Mirror Room")
    (desc "")
    (exit "WEST" "PASS3" "NORTH" "CRAW2" "EAST" "CAVE1"))

(room "MIRR2"
    (name "Mirror Room")
    (desc "")
    (exit "WEST" "PASS4" "NORTH" "CRAW3" "EAST" "CAVE2"))

(room "CAVE1"
    (name "Cave")
    (desc "This is a small cave with an entrance to the north and a stairway
leading down.")
    (exit "NORTH" "MIRR1" "DOWN" "ATLAN"))

(room "CAVE2"
    (name "Cave")
    (desc "This is a tiny cave with entrances west and north, and a dark,
forbidding staircase leading down.")
    (exit "NORTH" "CRAW3" "WEST" "MIRR2" "DOWN" "LLD1"))

(room "CRAW2"
    (name "Steep Crawlway")
    (desc "This is a steep and narrow crawlway.  There are two exits nearby to
the south and southwest.")
    (exit "SOUTH" "MIRR1" "SW" "PASS3"))

(room "CRAW3"
    (name "Narrow Crawlway")
    (desc "This is a narrow crawlway.  The crawlway leads from north to south.
However the south passage divides to the south and southwest.")
    (exit "SOUTH" "CAVE2" "SW" "MIRR2" "NORTH" "MGRAI"))

(room "PASS3"
    (name "Cold Passage")
    (desc "This is a cold and damp corridor where a long east-west passageway
intersects with a northward path.")
    (exit "EAST" "MIRR1" "WEST" "SLIDE" "NORTH" "CRAW2"))

(room "PASS4"
    (name "Winding Passage")
    (desc "This is a winding passage.  It seems that there is only an exit
on the east end although the whirring from the round room can be
heard faintly to the north.")
    (exit "EAST" "MIRR2" "NORTH" "You hear the whir from the round room but can find no entrance."))

(room "ENTRA"
    (name "Mine Entrance")
    (desc "You are standing at the entrance of what might have been a coal
mine. To the northeast and the northwest are entrances to the mine,
and there is another exit on the south end of the room.")
    (exit "SOUTH" "SLIDE" "NW" "SQUEE" "NE" "TSHAF"))

(room "SQUEE"
    (name "Squeaky Room")
    (desc "You are a small room.  Strange squeaky sounds may be heard coming from
the passage at the west end.  You may also escape to the south.")
    (exit "WEST" "BATS" "SOUTH" "ENTRA"))

(room "TSHAF"
    (name "Shaft Room")
    (desc "This is a large room, in the middle of which is a small shaft
descending through the floor into darkness below.  To the west and
the north are exits from this room.  Constructed over the top of the
shaft is a metal framework to which a heavy iron chain is attached.")
    (exit "DOWN" "You wouldn't fit and would die if you could." "WEST" "ENTRA" "NORTH" "TUNNE"))

(room "TUNNE"
    (name "Wooden Tunnel")
    (desc "This is a narrow tunnel with large wooden beams running across
the ceiling and around the walls.  A path from the south splits into
paths running west and northeast.")
    (exit "SOUTH" "TSHAF" "WEST" "SMELL" "NE" "MINE1"))

(room "SMELL"
    (name "Smelly Room")
    (desc "This is a small non-descript room.  However, from the direction
of a small descending staircase a foul odor can be detected.  To the
east is a narrow path.")
    (exit "DOWN" "BOOM" "EAST" "TUNNE"))

(room "BOOM"
    (name "Gas Room")
    (desc "This is a small room which smells strongly of coal gas.")
    (exit "UP" "SMELL"))

(room "TLADD"
    (name "Ladder Top")
    (desc "This is a very small room.  In the corner is a rickety wooden
ladder, leading downward.  It might be safe to descend.  There is
also a staircase leading upward.")
    (exit "DOWN" "BLADD" "UP" "MINE7"))

(room "BLADD"
    (name "Ladder Bottom")
    (desc "This is a rather wide room.  On one side is the bottom of a
narrow wooden ladder.  To the northeast and the south are passages
leaving the room.")
    (exit "NE" "DEAD7" "SOUTH" "TIMBE" "UP" "TLADD"))

(room "DEAD7"
    (name "Dead End")
    (desc "Dead End")
    (exit "SOUTH" "BLADD"))

(room "TIMBE"
    (name "Timber Room")
    (desc "This is a long and narrow passage, which is cluttered with broken
timbers.  A wide passage comes from the north and turns at the 
southwest corner of the room into a very narrow passageway.")
    (exit "NORTH" "BLADD" "SW" "BSHAF"))

(room "BSHAF"
    (name "Lower Shaft")
    (desc "This is a small square room which is at the bottom of a long
shaft. To the east is a passageway and to the northeast a very narrow
passage. In the shaft can be seen a heavy iron chain.")
    (exit "EAST" "MACHI" "OUT" "TIMBE" "NE" "TIMBE" "UP" "The chain is not climbable."))

(room "MACHI"
    (name "Machine Room")
    (desc "")
    (exit "NW" "BSHAF"))

(room "BATS"
    (name "Bat Room")
    (desc "")
    (exit "EAST" "SQUEE"))

(room "MINE1"
    (name "Coal mine")
    (desc "This is a non-descript part of a coal mine.")
    (exit "NORTH" "MINE4" "SW" "MINE2" "EAST" "TUNNE"))

(room "MINE2"
    (name "Coal mine")
    (desc "This is a non-descript part of a coal mine.")
    (exit "SOUTH" "MINE1" "WEST" "MINE5" "UP" "MINE3" "NE" "MINE4"))

(room "MINE3"
    (name "Coal mine")
    (desc "This is a non-descript part of a coal mine.")
    (exit "WEST" "MINE2" "NE" "MINE5" "EAST" "MINE5"))

(room "MINE4"
    (name "Coal mine")
    (desc "This is a non-descript part of a coal mine.")
    (exit "UP" "MINE5" "NE" "MINE6" "SOUTH" "MINE1" "WEST" "MINE2"))

(room "MINE5"
    (name "Coal mine")
    (desc "This is a non-descript part of a coal mine.")
    (exit "DOWN" "MINE6" "NORTH" "MINE7" "WEST" "MINE2" "SOUTH" "MINE3" "UP" "MINE3" "EAST" "MINE4"))

(room "MINE6"
    (name "Coal mine")
    (desc "This is a non-descript part of a coal mine.")
    (exit "SE" "MINE4" "UP" "MINE5" "NW" "MINE7"))

(room "MINE7"
    (name "Coal mine")
    (desc "This is a non-descript part of a coal mine.")
    (exit "EAST" "MINE1" "WEST" "MINE5" "DOWN" "TLADD" "SOUTH" "MINE6"))

(room "DOME"
    (name "Dome Room")
    (desc "")
    (exit "EAST" "CRAW1" "DOWN" "MTORC"))

(room "MTORC"
    (name "Torch Room")
    (desc "")
    (exit "UP" "You cannot reach the rope." "WEST" "PRM" "DOWN" "CRAW4"))

(room "CRAW4"
    (name "North-South Crawlway")
    (desc "This is a north-south crawlway; a passage goes to the east also.
There is a hole above, but it provides no opportunities for climbing.")
    (exit "NORTH" "CHAS2" "SOUTH" "STUDI" "EAST" "MTROL" "UP" "Not even a human fly could get up it."))

(room "CHAS2"
    (name "West of Chasm")
    (desc "You are on the west edge of a chasm, the bottom of which cannot be
seen. The east side is sheer rock, providing no exits.  A narrow
passage goes west, and the path you are on continues to the north and
south.")
    (exit "WEST" "CELLA" "NORTH" "CRAW4" "SOUTH" "GALLE" "DOWN" "The chasm probably leads straight to the infernal regions."))

(room "PASS1"
    (name "East-West Passage")
    (desc "This is a narrow east-west passageway.  There is a narrow stairway
leading down at the north end of the room.")
    (exit "EAST" "CAROU" "WEST" "MTROL" "DOWN" "RAVI1" "NORTH" "RAVI1"))

(room "CAROU"
    (name "Round room")
    (desc "")
    (exit "NORTH" "CAVE4" "SOUTH" "CAVE4" "EAST" "MGRAI" "WEST" "PASS1" "NW" "CANY1" "NE" "PASS5" "SE" "PASS4" "SW" "MAZE1" "EXIT" "PASS3"))

(room "PASS5"
    (name "North-South Passage")
    (desc "This is a high north-south passage, which forks to the northeast.")
    (exit "NORTH" "CHAS1" "NE" "ECHO" "SOUTH" "CAROU"))

(room "CHAS1"
    (name "Chasm")
    (desc "A chasm runs southwest to northeast.  You are on the south edge; the
path exits to the south and to the east.")
    (exit "SOUTH" "RAVI1" "EAST" "PASS5" "DOWN" "Are you out of your mind?"))

(room "CAVE3"
    (name "Damp Cave")
    (desc "This is a cave.  Passages exit to the south and to the east, but
the cave narrows to a crack to the west.  The earth is particularly
damp here.")
    (exit "SOUTH" "ECHO" "EAST" "DAM" "WEST" "It is too narrow for most insects."))

(room "CHAS3"
    (name "Ancient Chasm")
    (desc "A chasm, evidently produced by an ancient river, runs through the
cave here.  Passages lead off in all directions.")
    (exit "SOUTH" "ECHO" "EAST" "TCAVE" "NORTH" "DEAD5" "WEST" "DEAD6"))

(room "DEAD5"
    (name "Dead End")
    (desc "Dead End")
    (exit "SW" "CHAS3"))

(room "DEAD6"
    (name "Dead End")
    (desc "Dead End")
    (exit "EAST" "CHAS3"))

(room "CAVE4"
    (name "Engravings Cave")
    (desc "You have entered a cave with passages leading north and southeast.")
    (exit "NORTH" "CAROU" "SE" "RIDDL"))

(room "RIDDL"
    (name "Riddle Room")
    (desc "This is a room which is bare on all sides.  There is an exit down. 
To the east is a great door made of stone.  Above the stone, the
following words are written: 'No man shall enter this room without
solving this riddle:

  What is tall as a house,
	  round as a cup, 
	  and all the king's horses can't draw it up?'

(Reply via 'ANSWER 'answer'')")
    (exit "DOWN" "CAVE4" "EAST" "MPEAR"))

(room "MPEAR"
    (name "Pearl Room")
    (desc "This is a former broom closet.  The exits are to the east and west.")
    (exit "EAST" "BWELL" "WEST" "RIDDL"))

(room "LLD1"
    (name "Entrance to Hades")
    (desc "")
    (exit "EAST" "LLD2" "UP" "CAVE2" "ENTER" "LLD2"))

(room "LLD2"
    (name "Land of the Living Dead")
    (desc "")
    (exit "EAST" "TOMB" "EXIT" "LLD1" "WEST" "LLD1"))

(room "MGRAI"
    (name "Grail Room")
    (desc "You are standing in a small circular room with a pedestal.  A set of
stairs leads up, and passages leave to the east and west.")
    (exit "WEST" "CAROU" "EAST" "CRAW3" "UP" "TEMP1"))

(room "TEMP1"
    (name "Temple")
    (desc "This is the west end of a large temple.  On the south wall is an 
ancient inscription, probably a prayer in a long-forgotten language. 
The north wall is solid granite.  The entrance at the west end of the
room is through huge marble pillars.")
    (exit "WEST" "MGRAI" "EAST" "TEMP2"))

(room "TEMP2"
    (name "Altar")
    (desc "This is the east end of a large temple.  In front of you is what
appears to be an altar.")
    (exit "WEST" "TEMP1"))

(room "DAM"
    (name "Dam")
    (desc "")
    (exit "SOUTH" "CANY1" "DOWN" "DOCK" "EAST" "CAVE3" "NORTH" "LOBBY"))

(room "LOBBY"
    (name "Dam Lobby")
    (desc "This room appears to have been the waiting room for groups touring
the dam.  There are exits here to the north and east marked
'Private', though the doors are open, and an exit to the south.")
    (exit "SOUTH" "DAM" "NORTH" "MAINT" "EAST" "MAINT"))

(room "MAINT"
    (name "Maintenance Room")
    (desc "This is what appears to have been the maintenance room for Flood
Control Dam #3, judging by the assortment of tool chests around the
room.  Apparently, this room has been ransacked recently, for most of
the valuable equipment is gone. On the wall in front of you is a
group of buttons, which are labelled in EBCDIC. However, they are of
different colors:  Blue, Yellow, Brown, and Red. The doors to this
room are in the west and south ends.")
    (exit "SOUTH" "LOBBY" "WEST" "LOBBY"))

(room "DOCK"
    (name "Dam Base")
    (desc "You are at the base of Flood Control Dam #3, which looms above you
and to the north.  The river Frigid is flowing by here.  Across the
river are the White Cliffs which seem to form a giant wall stretching
from north to south along the east shore of the river as it winds its
way downstream.")
    (exit "NORTH" "DAM" "UP" "DAM" "LAUNC" "RIVR1"))

(room "RIVR1"
    (name "Frigid River")
    (desc "You are on the River Frigid in the vicinity of the Dam.  The river
flows quietly here.  There is a landing on the west shore.")
    (exit "UP" "You cannot go upstream due to strong currents." "WEST" "DOCK" "LAND" "DOCK" "DOWN" "RIVR2" "EAST" "The White Cliffs prevent your landing here."))

(room "RIVR2"
    (name "Frigid River")
    (desc "The River turns a corner here making it impossible to see the
Dam.  The White Cliffs loom on the east bank and large rocks prevent
landing on the west.")
    (exit "UP" "You cannot go upstream due to strong currents." "DOWN" "RIVR3" "EAST" "The White Cliffs prevent your landing here."))

(room "RIVR3"
    (name "Frigid River")
    (desc "The river descends here into a valley.  There is a narrow beach on
the east below the cliffs and there is some shore on the west which
may be suitable.  In the distance a faint rumbling can be heard.")
    (exit "UP" "You cannot go upstream due to strong currents." "DOWN" "RIVR4" "EAST" "WCLF1" "WEST" "RCAVE" "LAND" "You must specify which direction here."))

(room "WCLF1"
    (name "White Cliffs Beach")
    (desc "You are on a narrow strip of beach which runs along the base of the
White Cliffs. The only path here is a narrow one, heading south
along the Cliffs.")
    (exit "SOUTH" "WCLF2" "LAUNC" "RIVR3"))

(room "WCLF2"
    (name "White Cliffs Beach")
    (desc "You are on a rocky, narrow strip of beach beside the Cliffs.  A
narrow path leads north along the shore.")
    (exit "NORTH" "WCLF1" "LAUNC" "RIVR4"))

(room "RIVR4"
    (name "Frigid River")
    (desc "The river is running faster here and the sound ahead appears to be
that of rushing water.  On the west shore is a sandy beach.  A small
area of beach can also be seen below the Cliffs.")
    (exit "UP" "You cannot go upstream due to strong currents." "DOWN" "RIVR5" "EAST" "WCLF2" "WEST" "BEACH" "LAND" "Specify the direction to land."))

(room "RIVR5"
    (name "Frigid River")
    (desc "The sound of rushing water is nearly unbearable here.  On the west
shore is a large landing area.")
    (exit "UP" "You cannot go upstream due to strong currents." "DOWN" "FCHMP" "LAND" "FANTE"))

(room "FCHMP"
    (name "Moby lossage")
    (desc "")
    (exit "NORTH" ""))

(room "FANTE"
    (name "Shore")
    (desc "You are on the shore of the River.  The river here seems somewhat
treacherous.  A path travels from north to south here, the south end
quickly turning around a sharp corner.")
    (exit "LAUNC" "RIVR5" "NORTH" "BEACH" "SOUTH" "FALLS"))

(room "BEACH"
    (name "Sandy Beach")
    (desc "You are on a large sandy beach at the shore of the river, which is
flowing quickly by.  A path runs beside the river to the south here.")
    (exit "LAUNC" "RIVR4" "SOUTH" "FANTE"))

(room "RCAVE"
    (name "Rocky Shore")
    (desc "You are on the west shore of the river.  An entrance to a cave is
to the northwest.  The shore is very rocky here.")
    (exit "LAUNC" "RIVR3" "NW" "TCAVE"))

(room "TCAVE"
    (name "Small Cave")
    (desc "This is a small cave whose exits are on the south and northwest.")
    (exit "SOUTH" "RCAVE" "NW" "CHAS3"))

(room "FALLS"
    (name "Aragain Falls")
    (desc "")
    (exit "EAST" "RAINB" "DOWN" "It's a long way..." "NORTH" "FANTE" "UP" "RAINB"))

(room "RAINB"
    (name "Rainbow Room")
    (desc "You are on top of a rainbow (I bet you never thought you would walk
on a rainbow), with a magnificent view of the Falls.  The rainbow
travels east-west here.  There is an NBC Commissary here.")
    (exit "EAST" "POG" "WEST" "FALLS"))

(room "POG"
    (name "End of Rainbow")
    (desc "You are on a small, rocky beach on the continuation of the Frigid
River past the Falls.  The beach is narrow due to the presence of the
White Cliffs.  The river canyon opens here and sunlight shines in
from above. A rainbow crosses over the falls to the west and a narrow
path continues to the southeast.")
    (exit "UP" "RAINB" "NW" "RAINB" "WEST" "RAINB" "SE" "CLBOT" "LAUNC" "The sharp rocks endanger your boat."))

(room "CLBOT"
    (name "Canyon Bottom")
    (desc "You are beneath the walls of the river canyon which may be climbable
here.  There is a small stream here, which is the lesser part of the
runoff of Aragain Falls. To the north is a narrow path.")
    (exit "UP" "CLMID" "NORTH" "POG"))

(room "CLMID"
    (name "Rocky Ledge")
    (desc "You are on a ledge about halfway up the wall of the river canyon.
You can see from here that the main flow from Aragain Falls twists
along a passage which it is impossible to enter.  Below you is the
canyon bottom.  Above you is more cliff, which still appears
climbable.")
    (exit "UP" "CLTOP" "DOWN" "CLBOT"))

(room "CLTOP"
    (name "Canyon View")
    (desc "You are at the top of the Great Canyon on its south wall.  From here
there is a marvelous view of the Canyon and parts of the Frigid River
upstream.  Across the canyon, the walls of the White Cliffs still
appear to loom far above.  Following the Canyon upstream (north and
northwest), Aragain Falls may be seen, complete with rainbow. 
Fortunately, my vision is better than average and I can discern the
top of the Flood Control Dam #3 far to the distant north.  To the
west and south can be seen an immense forest, stretching for miles
around.  It is possible to climb down into the canyon from here.")
    (exit "DOWN" "CLMID" "SOUTH" "FORE4" "WEST" "FORE5"))

(room "VLBOT"
    (name "Volcano Bottom")
    (desc "You are at the bottom of a large dormant volcano.  High above you
light may be seen entering from the cone of the volcano.  The only
exit here is to the north.")
    (exit "NORTH" "LAVA"))

(room "VAIR1"
    (name "Volcano Core")
    (desc "You are about one hundred feet above the bottom of the volcano.  The
top of the volcano is clearly visible here.")
    (exit "#!#!#" "!"))

(room "VAIR2"
    (name "Volcano near small ledge")
    (desc "You are about two hundred feet above the volcano floor.  Looming
above is the rim of the volcano.  There is a small ledge on the west
side.")
    (exit "WEST" "LEDG2" "LAND" "LEDG2"))

(room "VAIR3"
    (name "Volcano near viewing ledge")
    (desc "You are high above the floor of the volcano.  From here the rim of
the volcano looks very narrow and you are very near it.  To the 
east is what appears to be a viewing ledge, too thin to land on.")
    (exit "#!#!#" "!"))

(room "VAIR4"
    (name "Volcano near wide ledge")
    (desc "You are near the rim of the volcano which is only about 15 feet
across.  To the west, there is a place to land on a wide ledge.")
    (exit "LAND" "LEDG4" "EAST" "LEDG4"))

(room "LEDG2"
    (name "Narrow Ledge")
    (desc "You are on a narrow ledge overlooking the inside of an old dormant
volcano.  This ledge appears to be about in the middle between the
floor below and the rim above. There is an exit here to the south.")
    (exit "DOWN" "I wouldn't jump from here." "LAUNC" "VAIR2" "WEST" "VLBOT" "SOUTH" "LIBRA"))

(room "LIBRA"
    (name "Library")
    (desc "This is a room which must have been a large library, probably
for the royal family.  All of the shelves appear to have been gnawed
to pieces by unfriendly gnomes.  To the north is an exit.")
    (exit "NORTH" "LEDG2" "OUT" "LEDG2"))

(room "LEDG3"
    (name "Volcano View")
    (desc "You are on a ledge in the middle of a large volcano.  Below you
the volcano bottom can be seen and above is the rim of the volcano.
A couple of ledges can be seen on the other side of the volcano;
it appears that this ledge is intermediate in elevation between
those on the other side.  The exit from this room is to the east.")
    (exit "DOWN" "I wouldn't try that." "CROSS" "It is impossible to cross this distance." "EAST" "EGYPT"))

(room "LEDG4"
    (name "Wide Ledge")
    (desc "")
    (exit "DOWN" "It's a long way down." "LAUNC" "VAIR4" "WEST" "VLBOT" "SOUTH" "SAFE"))

(room "SAFE"
    (name "Dusty Room")
    (desc "")
    (exit "NORTH" "LEDG4"))

(room "LAVA"
    (name "Lava Room")
    (desc "This is a small room, whose walls are formed by an old lava flow.
There are exits here to the west and the south.")
    (exit "SOUTH" "VLBOT" "WEST" "RUBYR"))

(room "MAGNE"
    (name "Low Room")
    (desc "")
    (exit "NORTH" "CMACH" "SOUTH" "CMACH" "WEST" "CMACH" "NE" "CMACH" "NW" "ALICE" "SW" "ALICE" "SE" "ALICE" "EAST" "CMACH" "OUT" "ALICE"))

(room "CMACH"
    (name "Machine Room")
    (desc "")
    (exit "WEST" "MAGNE" "SOUTH" "CAGER"))

(room "CAGER"
    (name "Dingy Closet")
    (desc "This is a dingy closet adjacent to the machine room.  On one wall
is a small sticker which says
		Protected by
		  FROBOZZ
	     Magic Alarm Company
	      (Hello, footpad!)
")
    (exit "NORTH" "CMACH"))

(room "CAGED"
    (name "Cage")
    (desc "You are trapped inside a steel cage.")
    (exit "NORTH" ""))

(room "TWELL"
    (name "Top of Well")
    (desc "You are at the top of the well.  Well done.  There are etchings on
the side of the well. There is a small crack across the floor at the
entrance to a room on the east, but it can be crossed easily.")
    (exit "EAST" "ALICE" "DOWN" "It's a long way down!"))

(room "BWELL"
    (name "Circular Room")
    (desc "This is a damp circular room, whose walls are made of brick and
mortar.  The roof of this room is not visible, but there appear to be
some etchings on the walls.  There is a passageway to the west.")
    (exit "WEST" "MPEAR" "UP" "The walls cannot be climbed."))

(room "ALICE"
    (name "Tea Room")
    (desc "This is a small square room, in the center of which is a large
oblong table, no doubt set for afternoon tea.  It is clear from the
objects on the table that the users were indeed mad.  In the eastern
corner of the room is a small hole (no more than four inches high). 
There are passageways leading away to the west and the northwest.")
    (exit "EAST" "Only a mouse could get in there." "WEST" "TWELL" "NW" "MAGNE"))

(room "ALISM"
    (name "Posts Room")
    (desc "This is an enormous room, in the center of which are four wooden
posts delineating a rectangular area, above which is what appears to
be a wooden roof.  In fact, all objects in this room appear to be
abnormally large. To the east is a passageway.  There is a large
chasm on the west and the northwest.")
    (exit "NW" "There is a chasm too large to jump across." "EAST" "ALITR" "WEST" "There is a chasm too large to jump across." "DOWN" "There is a chasm too large to jump across."))

(room "ALITR"
    (name "Pool Room")
    (desc "This is a large room, one half of which is depressed.  There is a
large leak in the ceiling through which brown colored goop is
falling.  The only exit to this room is to the west.")
    (exit "EXIT" "ALISM" "WEST" "ALISM"))

(room "BKENT"
    (name "Bank Entrance")
    (desc "This is the large entrance hall of the Bank of Zork, the largest
banking institution of the Great Underground Empire. A partial
account of its history is in 'The Lives of the Twelve Flatheads' with
the chapter on J. Pierpont Flathead.  A more detailed history (albeit
less objective) may be found in Flathead's outrageous autobiography
'I'm Rich and You Aren't - So There!'.
Most of the furniture has been ravaged by passing scavengers.  All
that remains are two signs at the Northwest and Northeast corners of
the room, which say
  
      <--  WEST VIEWING ROOM        EAST VIEWING ROOM  -->  
")
    (exit "NW" "BKTW" "NE" "BKTE" "SOUTH" "GALLE"))

(room "BKTW"
    (name "West Teller's Room")
    (desc "")
    (exit "NORTH" "BKVW" "SOUTH" "BKENT" "WEST" "BKBOX"))

(room "BKTE"
    (name "East Teller's Room")
    (desc "")
    (exit "NORTH" "BKVE" "SOUTH" "BKENT" "EAST" "BKBOX"))

(room "BKVW"
    (name "Viewing Room")
    (desc "This is a room used by holders of safety deposit boxes to view
their contents.  On the north side of the room is a sign which says 
	
   REMAIN HERE WHILE THE BANK OFFICER RETRIEVES YOUR DEPOSIT BOX
    WHEN YOU ARE FINISHED, LEAVE THE BOX, AND EXIT TO THE SOUTH  
     AN ADVANCED PROTECTIVE DEVICE PREVENTS ALL CUSTOMERS FROM
      REMOVING ANY SAFETY DEPOSIT BOX FROM THIS VIEWING AREA!
               Thank You for banking at the Zork!
")
    (exit "SOUTH" "BKENT"))

(room "BKVE"
    (name "Viewing Room")
    (desc "This is a room used by holders of safety deposit boxes to view
their contents.  On the north side of the room is a sign which says 
	
   REMAIN HERE WHILE THE BANK OFFICER RETRIEVES YOUR DEPOSIT BOX
    WHEN YOU ARE FINISHED, LEAVE THE BOX, AND EXIT TO THE SOUTH  
     AN ADVANCED PROTECTIVE DEVICE PREVENTS ALL CUSTOMERS FROM
      REMOVING ANY SAFETY DEPOSIT BOX FROM THIS VIEWING AREA!
               Thank You for banking at the Zork!
")
    (exit "SOUTH" "BKENT"))

(room "BKTWI"
    (name "Small Room")
    (desc "This is a small, bare room with no distinguishing features. There
are no exits from this room.")
    (exit "#!#!#" "!"))

(room "BKVAU"
    (name "Vault")
    (desc "This is the Vault of the Bank of Zork, in which there are no doors.")
    (exit "#!#!#" "!"))

(room "BKBOX"
    (name "Safety Depository")
    (desc "This is a large rectangular room.  The east and west walls here
were used for storing safety deposit boxes.  As might be expected,
all have been carefully removed by evil persons.  To the east, west,
and south of the room are large doorways. The northern 'wall'
of the room is a shimmering curtain of light.  In the center of the
room is a large stone cube, about 10 feet on a side.  Engraved on 
the side of the cube is some lettering.")
    (exit "NORTH" "There is a curtain of light there." "WEST" "BKTW" "EAST" "BKTE" "SOUTH" "BKEXE"))

(room "BKEXE"
    (name "Chairman's Office")
    (desc "This room was the office of the Chairman of the Bank of Zork.
Like the other rooms here, it has been extensively vandalized.
The lone exit is to the north.")
    (exit "NORTH" "BKBOX"))

(room "CPANT"
    (name "Small Square Room")
    (desc "This is a small square room, in the middle of which is a recently 
created hole through which you can barely discern the floor some ten
feet below.  It doesn't seem likely you could climb back up.  There
are exits to the west and south.")
    (exit "SOUTH" "CPOUT" "WEST" "TREAS" "DOWN" "FCHMP"))

(room "CPOUT"
    (name "Side Room")
    (desc "")
    (exit "NORTH" "CPANT" "EAST" "CP"))

(room "CP"
    (name "Room in a Puzzle")
    (desc "")
    (exit "NORTH" "FCHMP" "SOUTH" "FCHMP" "EAST" "FCHMP" "WEST" "FCHMP" "NE" "FCHMP" "NW" "FCHMP" "SE" "FCHMP" "UP" "FCHMP" "SW" "FCHMP"))

(room "PALAN"
    (name "Dreary Room")
    (desc "")
    (exit "SOUTH" ,PALANDOOR "EXIT" ,PALANDOOR "#!#!#" ,PALANWIND))

(room "PRM"
    (name "Tiny Room")
    (desc "")
    (exit "NORTH" ,PALANDOOR "ENTER" ,PALANDOOR "#!#!#" ,PALANWIND "EAST" "MTORC"))

(room "SLIDE"
    (name "Slide Room")
    (desc "")
    (exit "EAST" "PASS3" "NORTH" "ENTRA" "DOWN" "CAVE4"))

(room "SLID1"
    (name "Slide")
    (desc "This is an uncomfortable spot within the coal chute.  The rope to
which you are clinging can be seen rising into the darkness above.
There is more rope dangling below you.")
    (exit "DOWN" "SLID2" "UP" "SLIDE"))

(room "SLID2"
    (name "Slide")
    (desc "This is another spot within the coal chute.  Above you the rope
climbs into darkness and the end of the rope is dangling five feet
beneath you.")
    (exit "DOWN" "SLID3" "UP" "SLID1"))

(room "SLID3"
    (name "Slide")
    (desc "You have reached the end of your rope.  Below you is darkness as
the chute makes a sharp turn.  On the east here is a small ledge
which you might be able to stand on.")
    (exit "DOWN" "CELLA" "UP" "SLID2" "EAST" "SLEDG"))

(room "SLEDG"
    (name "Slide Ledge")
    (desc "This is a narrow ledge abutting the coal chute, in which a rope can
be seen passing downward.  Behind you, to the south, is a small room.")
    (exit "DOWN" "CELLA" "UP" "SLID2" "SOUTH" "SPAL"))

(room "SPAL"
    (name "Sooty Room")
    (desc "This is a small room with rough walls, and a ceiling which is steeply
sloping from north to south. There is coal dust covering almost
everything, and little bits of coal are scattered around the only exit
(which is a narrow passage to the north). In one corner of the room is
an old coal stove which lights the room with a cheery red glow.  There
is a very narrow crack in the north wall.")
    (exit "NORTH" "SLEDG"))

(room "MRD"
    (name "Hallway")
    (desc "")
    (exit "NORTH" "FDOOR" "NE" "FDOOR" "NW" "FDOOR" "SOUTH" "MRG" "SE" "MRG" "SW" "MRG"))

(room "MRG"
    (name "Hallway")
    (desc "")
    (exit "NORTH" "MRD" "SOUTH" "MRC"))

(room "MRC"
    (name "Hallway")
    (desc "")
    (exit "NORTH" "MRG" "NW" "MRG" "NE" "MRG" "ENTER" "INMIR" "SOUTH" "MRB" "SW" "MRB" "SE" "MRB"))

(room "MRB"
    (name "Hallway")
    (desc "")
    (exit "NORTH" "MRC" "NW" "MRC" "NE" "MRC" "ENTER" "INMIR" "SOUTH" "MRA" "SW" "MRA" "SE" "MRA"))

(room "MRA"
    (name "Hallway")
    (desc "")
    (exit "NORTH" "MRB" "NW" "MRB" "NE" "MRB" "ENTER" "INMIR" "SOUTH" "MREYE"))

(room "MRDE"
    (name "Narrow Room")
    (desc "")
    (exit "#!#!#" "!"))

(room "MRDW"
    (name "Narrow Room")
    (desc "")
    (exit "#!#!#" "!"))

(room "MRGE"
    (name "Narrow Room")
    (desc "")
    (exit "#!#!#" "!"))

(room "MRGW"
    (name "Narrow Room")
    (desc "")
    (exit "#!#!#" "!"))

(room "MRCE"
    (name "Narrow Room")
    (desc "")
    (exit "ENTER" "INMIR" "WEST" "INMIR" "NORTH" "MRG" "SOUTH" "MRB"))

(room "MRCW"
    (name "Narrow Room")
    (desc "")
    (exit "ENTER" "INMIR" "EAST" "INMIR" "NORTH" "MRG" "SOUTH" "MRB"))

(room "MRBE"
    (name "Narrow Room")
    (desc "")
    (exit "ENTER" "INMIR" "WEST" "INMIR" "NORTH" "MRC" "SOUTH" "MRA"))

(room "MRBW"
    (name "Narrow Room")
    (desc "")
    (exit "ENTER" "INMIR" "EAST" "INMIR" "NORTH" "MRC" "SOUTH" "MRA"))

(room "MRAE"
    (name "Narrow Room")
    (desc "")
    (exit "ENTER" "INMIR" "WEST" "INMIR" "NORTH" "MRB" "SOUTH" "MREYE"))

(room "MRAW"
    (name "Narrow Room")
    (desc "")
    (exit "ENTER" "INMIR" "EAST" "INMIR" "NORTH" "MRB" "SOUTH" "MREYE"))

(room "INMIR"
    (name "Inside Mirror")
    (desc "")
    (exit "NORTH" "MRA" "SOUTH" "MRA" "EAST" "MRA" "WEST" "MRA" "NE" "MRA" "NW" "MRA" "SE" "MRA" "SW" "MRA" "EXIT" "MRA"))

(room "MRANT"
    (name "Stone Room")
    (desc "You are standing near one end of a long, dimly lit hall.  At the
south stone stairs ascend.  To the north the corridor is illuminated
by torches set high in the walls, out of reach.  On one wall is a red
button.")
    (exit "SOUTH" "TSTRS" "UP" "TSTRS" "NORTH" "MREYE"))

(room "MREYE"
    (name "Small Room")
    (desc "")
    (exit "NORTH" "MRA" "NW" "MRA" "NE" "MRA" "SOUTH" "MRANT"))

(room "TOMB"
    (name "Tomb of the Unknown Implementer")
    (desc "")
    (exit "WEST" "LLD2" "NORTH" ,CD "ENTER" ,CD))

(room "CRYPT"
    (name "Crypt")
    (desc "")
    (exit "SOUTH" ,CD "LEAVE" ,CD))

(room "TSTRS"
    (name "Top of Stairs")
    (desc "You are standing at the top of a flight of stairs that lead down to
a passage below.  Dim light, as from torches, can be seen in the
passage.  Behind you the stairs lead into untouched rock.")
    (exit "NORTH" "MRANT" "DOWN" "MRANT" "SOUTH" "The wall is solid rock."))

(room "ECORR"
    (name "East Corridor")
    (desc "This is a corridor with polished marble walls.  The corridor
widens into larger areas as it turns west at its northern and
southern ends.")
    (exit "NORTH" "NCORR" "SOUTH" "SCORR"))

(room "WCORR"
    (name "West Corridor")
    (desc "This is a corridor with polished marble walls.  The corridor
widens into larger areas as it turns east at its northern and
southern ends.")
    (exit "NORTH" "NCORR" "SOUTH" "SCORR"))

(room "SCORR"
    (name "South Corridor")
    (desc "")
    (exit "WEST" "WCORR" "EAST" "ECORR" "NORTH" ,OD "SOUTH" "BDOOR"))

(room "BDOOR"
    (name "Narrow Corridor")
    (desc "")
    (exit "NORTH" "SCORR" "SOUTH" ,WD))

(room "FDOOR"
    (name "Dungeon Entrance")
    (desc "")
    (exit "NORTH" ,WD "ENTER" ,WD "SOUTH" "MRD" "SE" "MRD" "SW" "MRD"))

(room "NCORR"
    (name "North Corridor")
    (desc "")
    (exit "EAST" "ECORR" "WEST" "WCORR" "NORTH" "PARAP" "SOUTH" ,CD "ENTER" ,CD))

(room "PARAP"
    (name "Parapet")
    (desc "")
    (exit "SOUTH" "NCORR" "NORTH" "You would be burned to a crisp in no time."))

(room "CELL"
    (name "Prison Cell")
    (desc "")
    (exit "EXIT" ,CD "NORTH" ,CD "SOUTH" ,OD))

(room "PCELL"
    (name "Prison Cell")
    (desc "")
    (exit "EXIT" "The door is securely fastened."))

(room "NCELL"
    (name "Prison Cell")
    (desc "")
    (exit "SOUTH" "The door is securely fastened." "EXIT" ,ND "NORTH" ,ND))

(room "NIRVA"
    (name "Treasury of Zork")
    (desc "     This is a room of large size, richly appointed and decorated
in a style that bespeaks exquisite taste.  To judge from its
contents, it is the ultimate storehouse of the treasures of Zork.
     There are chests here containing precious jewels, mountains of
zorkmids, rare paintings, ancient statuary, and beguiling curios.
     In one corner of the room is a bookcase boasting such volumes as
'The History of the Great Underground Empire,' 'The Lives of the
Twelve Flatheads,' 'The Wisdom of the Implementors,' and other
informative and inspiring works.
     On one wall is a completely annotated map of the Great Underground
Empire, showing points of interest, various troves of treasure, and
indicating the locations of several superior scenic views.
     On a desk at the far end of the room may be found stock
certificates representing a controlling interest in FrobozzCo
International, the multinational conglomerate and parent company of
the Frobozz Magic Boat Co., etc.")
    (exit "#!#!#" "!"))
