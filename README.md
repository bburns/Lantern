
# Lantern

Lantern is an exploration of **[Zork: The Great Underground Empire][zork]**, or
at least as it existed in the original Muddle code from 1979.

[zork]: http://en.wikipedia.org/wiki/Zork/


## The Game

Here's the game intro from 1983 -

----

```
ZORK I: The Great Underground Empire
Copyright (c) 1981, 1982, 1983 Infocom, Inc. All rights reserved.
ZORK is a registered trademark of Infocom, Inc.
Revision 88 / Serial number 840726

West of House
You are standing in an open field west of a white house, with a boarded front door.
There is a small mailbox here.

> open mailbox
Opening the small mailbox reveals a leaflet.

> read leaflet
(Taken)

"WELCOME TO ZORK!
ZORK is a game of adventure, danger, and low cunning. In it you will explore
some of the most amazing territory ever seen by mortals. No computer should be
without one!"
```

----


## Exploring the Map

We can parse the original source code to JSON and use [d3][d3] to
[visualize and wander around the map](http://bburns.github.io/Lantern) - click
on a room to add its neighboring rooms, and zoom in/out with the mouse wheel.

<a href="http://bburns.github.io/Lantern"><img src="images/lantern2016-11-22_800.png" /></a>

[d3]: https://d3js.org/


## Muddle Source Code

Zork was written in [MDL (MIT Design Language) (aka Muddle)][muddle], a dialect of
Lisp from the 1970's. The original code looks like this -

```lisp
<ROOM "WHOUS"
"This is an open field west of a white house, with a boarded front door."
       "West of House"
       <EXIT "NORTH" "NHOUS" "SOUTH" "SHOUS" "WEST" "FORE1"
	      "EAST" #NEXIT "The door is locked, and there is evidently no key.">
       (<GET-OBJ "FDOOR"> <GET-OBJ "MAILB"> <GET-OBJ "MAT">)
       <>
       <+ ,RLANDBIT ,RLIGHTBIT ,RNWALLBIT ,RSACREDBIT>
       (RGLOBAL ,HOUSEBIT)>

<ROOM "LROOM"
       ""
       "Living Room"
       <EXIT "EAST" "KITCH"
	      "WEST" <CEXIT "MAGIC-FLAG" "BLROO" "The door is nailed shut.">
	      "DOWN" <DOOR "DOOR" "LROOM" "CELLA">>
       (<GET-OBJ "WDOOR"> <GET-OBJ "DOOR"> <GET-OBJ "TCASE">
	<GET-OBJ "LAMP"> <GET-OBJ "RUG"> <GET-OBJ "PAPER">
	<GET-OBJ "SWORD">)
       LIVING-ROOM
       <+ ,RLANDBIT ,RLIGHTBIT ,RHOUSEBIT ,RSACREDBIT>>

<DEFINE CLEARING ("AUX" (GRATE <SFIND-OBJ "GRATE">) (LEAVES <SFIND-OBJ "LEAVE">))
  #DECL ((LEAVES GRATE) OBJECT)
  <COND (<VERB? "LOOK">
    <TELL
"You are in a clearing, with a forest surrounding you on the west
and south.">
    <COND (<TRNN .GRATE ,OPENBIT>
     <TELL "There is an open grating, descending into darkness." 1>)
          (,GRATE-REVEALED!-FLAG
     <TELL "There is a grating securely fastened into the ground." 1>)>)>>
```

The room definitions are stored in the `dung.mud` file starting at line 1582 -
you can browse through them [here][rooms].

[muddle]: http://en.wikipedia.org/wiki/MDL_programming_language
[rooms]: https://github.com/bburns/Lantern/blob/master/data/mdl/dung.mud#L1582


## ZIL Source Code

Later the MDL code was cleaned up and rewritten in ZIL (Zork Implementation
Language), a domain-specific language in MDL -

```lisp
<ROOM LIVING-ROOM
    (LOC ROOMS)
    (DESC "Living Room")
    (EAST TO KITCHEN)
    (WEST TO STRANGE-PASSAGE IF CYCLOPS-FLED ELSE
        "The wooden door is nailed shut.")
    (DOWN PER TRAP-DOOR-EXIT)
    (ACTION LIVING ROOM-F)
    (FLAGS RLANDBIT ONBIT SACREDBIT)
    (GLOBAL STAIRS)
    (THINGS <> NAILS NAILS-PSEUDO)>
```

I'd love to see the more organized ZIL code, but Activision holds the rights,
and the full source code has never been released - this and other snippets were
released in the [ZIL manual][zil]. So, we'll have to make do with the MDL code.

[zil]: http://www.xlisp.org/zil.pdf


## Goals

The goals for Lantern are:

- Explore the map interactively with d3
- Make a static map with Graphviz
- View the room structures with a cleaner Lisp syntax

so the main tasks are:

- Make a Muddle compiler/interpreter in Python to parse the ROOM objects
- Parse the original source code to output JSON, Lisp, Graphviz
- Make a web page to interact with the JSON data using JavaScript and d3


## Muddle Compiler/Interpreter

A Muddle compiler, extending Peter Norvig's simple [Lispy interpreter][lispy],
parses the `dung.mud` file and handles conditional exits and doors.

The Muddle compiler is in [mud.py][mudpy] - the lexer breaks the text into
tokens, and is extended from lispy to handle strings - the parser assembles the
tokens into an abstract syntax tree, and the `eval` function evalutes the tree
and returns Lisp objects.

<!-- Handling special forms like ROOM, CEXIT, DOOR requires -->

[lispy]: http://norvig.com/lispy.html
[mudpy]: src/mud.py
[lanternpy]: src/lantern.py


## Compiler Output

The compiler can output simpler Lisp data structures, like so -

```lisp
(room "WHOUS"
    (name "West of House")
    (desc "This is an open field west of a white house, with a boarded front door.")
    (exit "NORTH" "NHOUS" "SOUTH" "SHOUS" "WEST" "FORE1" "EAST" #NEXIT))

(room "LROOM"
    (name "Living Room")
    (desc "")
    (exit "EAST" "KITCH" "WEST" "BLROO" "DOWN" "CELLA"))
```

It can also output JSON data structures, like so -

```json
{
  "rooms": [
    {
      "name": "West of House",
      "key": "WHOUS",
      "desc": "This is an open field west of a white house, with a boarded front door."
    },

  ],
  "exits": [
    {
      "source": "WHOUS",
      "target": "NHOUS",
      "dir": "NORTH"
    },
    {
      "source": "WHOUS",
      "target": "SHOUS",
      "dir": "SOUTH"
    },
  ]
}
```

or a Graphviz dot file -

```graphviz
digraph zork {
WHOUS [label="West of House"];
NHOUS [label="North of House"];
SHOUS [label="South of House"];
...
"WHOUS" -> "NHOUS";
"WHOUS" -> "SHOUS";
"WHOUS" -> "FORE1";
"NHOUS" -> "WHOUS";
"NHOUS" -> "EHOUS";
"NHOUS" -> "FORE3";
}
```


## A Graphviz Map

We can use [Graphviz][graphviz] to get a look at the whole thing - there are 149
rooms. Note that the locations of the exit arrows do not correspond to the
actual exit directions.

<img src="images/zork3000_crop560.png" />

The overview, using the default Graphviz dot layout engine:

<img src="images/zork2200_scale700.png" />

The full map is located [here](images/zork2200.png).

[graphviz]: http://www.graphviz.org/


## Status

This is a low-priority project that I'll work on from time to time.

I've been interested in Zork since I was 12 - I read through the assembly code
but didn't understand that what I was looking at was a byte-code interpreter and
machine language compiled down from Lisp, though I was able to decipher the
text, which was encoded with 3 characters in 2 bytes to save space.


## Contributing

Want to work on this project? Feel free to pitch in on any part you find interesting!


## The Source of the Source

The original Muddle Zork source code is available at an archive of old programs,
located [here][source].

[source]: http://simh.trailing-edge.com/software.html


## License

GPL

