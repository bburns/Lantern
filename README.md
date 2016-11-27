
# Lantern

Lantern is an exploration of **[Zork: The Great Underground Empire][zork]**, or
at least as it existed in the original Muddle code from 1979.


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

## Muddle Source Code

It was written in [MDL (aka Muddle)](muddle), a dialect of Lisp from the 1970's.
The original code looks like this -

```lisp
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

<ROOM "WHOUS"
"This is an open field west of a white house, with a boarded front door."
       "West of House"
       <EXIT "NORTH" "NHOUS" "SOUTH" "SHOUS" "WEST" "FORE1"
	      "EAST" #NEXIT "The door is locked, and there is evidently no key.">
       (<GET-OBJ "FDOOR"> <GET-OBJ "MAILB"> <GET-OBJ "MAT">)
       <>
       <+ ,RLANDBIT ,RLIGHTBIT ,RNWALLBIT ,RSACREDBIT>
       (RGLOBAL ,HOUSEBIT)>
```


## ZIL Source Code

Later the MDL was rewritten in ZIL (Zork Implementation Language), a domain-specific language within MDL, with a much cleaner syntax -

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

but... the full source code has never been released in this form. So, we'll have to make do with the MDL code.


## Goals

- Convert the original Muddle code to Lisp data structures using text transformations
- Convert the Lisp data to JSON to explore the map interactively with d3
- Convert the Lisp data to a Graphviz file to make a static map

To handle more complex exits, instead of using text transformations -

- Write a simple Muddle compiler/interpreter in Python to parse room objects


## Lisp Data

With a little text manipulation the original Muddle code can be converted to a
more parsable Lisp - I'm using Emacs Lisp to do this at the moment.

There are some constructs like `#NEXIT` and the `#DECL` type
declarations which would need special handling, but we can filter them out for
now.

There are also conditional exits, which look like
`("SOUTH" (cexit "CYCLOPS-FLAG" "TREAS" "The cyclops doesn't look like he'll let you past."))`,
and doorways, which look like `("UP" (door "DOOR" "LROOM" "CELLA"))`, from which
we can extract the destination.

So we get some room structures like so -

```lisp
(room "WHOUS"
    "This is an open field west of a white house, with a boarded front door."
    "West of House"
    (exit "NORTH" "NHOUS" "SOUTH" "SHOUS" "WEST" "FORE1"))
```


## Exploring the Map

Then we can convert this Lisp to JSON and use [d3][d3] to
[wander around the map](http://bburns.github.io/Lantern) - click on a room to
add its neighboring rooms. Note though that you're stuck with a limited number
of rooms for now.

<img src="images/lantern2016-11-22_800.png" />


## A Graphviz Map

We can also convert them to a [Graphviz][graphviz] file to get a look at the
whole thing - there are 149 rooms. Note that the locations of the exit arrows do
not correspond to the actual exit directions.

<!-- <img src="images/zork2200_crop700.png" /> -->
<img src="images/zork3000_crop560.png" />

The overview, using the default Graphviz layout engine:

<img src="images/zork2200_scale700.png" />

The full map is located [here](images/zork2200.png).

This is just one of an infinite number of layouts - I haven't experimented much
with the different settings.


## Muddle Compiler/Interpreter

We'll follow Peter Norvig's [Lispy interpreter][lispy] to write a simple Muddle
interpreter, which will handle conditional exits and doors and output the Lisp
data structures.


[lispy]: http://norvig.com/lispy.html


## Issues

The code needs to be organized to transform the MDL code to Lisp and then JSON
and Graphviz step-by-step - it was done a bit interactively so the code is not
really in place yet.

Some things to do for the d3 map:

- handle special doorways (eg a locked door) - need so can explore house, rest of map
- fix height of svg - currently arbitrarily set to 85% - need to read size of parent element
- indicate if a room is unexplored - eg gray text
- explain that the forest is a bit of a maze, so can tangle up the map
- for rooms like 'forest' w/o proper names, wrap in parens, or get proper names somehow, or use key
- handle page resize event
- allow zoom in/out - ie catch zoom event, redraw svg etc
- show objects in current room
- show exits from current room
- labels should be clearer - clear a background rectangle first http://stackoverflow.com/questions/15500894/background-color-of-text-in-svg
- add button to automatically explore the map, depth first, slowly
- draw white outline around nodes, as here http://jsfiddle.net/4sq4F/
- and more...

This is a kind of low-priority project that I'll work on from time to time. I've
been interested in Zork since I was 12 - I hacked into the code but didn't
understand that what I was looking at was a byte-code interpreter and machine
language compiled down from Lisp, though I *was* able to decipher the text,
which was encoded with 3 characters in 2 bytes to save space.


## Contributing

Want to work on this project? Feel free to pitch in on any part you find interesting!


## The Source of the Source

The original Muddle Zork source code is available at an archive of old programs,
located [here][source].


## License

GPL



[zork]: http://en.wikipedia.org/wiki/Zork/
[muddle]: http://en.wikipedia.org/wiki/MDL_programming_language
[graphviz]: http://www.graphviz.org/
[d3]: https://d3js.org/
[source]: http://simh.trailing-edge.com/software.html


