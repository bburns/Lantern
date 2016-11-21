
// --------------------------------------------------------------------------------
// Lantern
// Explore Zork map interactively with d3
// --------------------------------------------------------------------------------

// The data structures read in look like this -
// var rooms = [
//     {"key": "WHOUS", "name": "West of House", "desc": "This is an open field west of a white house...."},
//     {"key": "ATTIC", "name": "Attic", "desc": "This is the attic. The only exit is stairs that lead down."}];
// var exits = [
//     {"source": "WHOUS", "dir": "NORTH", "target": "NHOUS"},
//     {"source": "WHOUS", "dir": "EAST", "target": "The door is locked, and there is evidently no key."}];


// globals defined elsewhere - basically 'imported' by index.html
var findObject; // library.js
var Graph; // graph.js



// create a new generic d3 graph object
var graph = new Graph('#map', {nodeRadius:25});

// create a Zork map object -
// read rooms and exits from file, and add initial room.
// WHOUS is west of house
var map = new Map('data/json/zork_small.json', 'WHOUS');

