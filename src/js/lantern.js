
// --------------------------------------------------------------------------------
// Lantern
// Explore Zork map interactively with d3
// --------------------------------------------------------------------------------

//> this still needs some work to make Graph and Map independent,
// eg the onclicknode callback

// --------------------------------------------------------------------------------


//> can't wrap like this yet because code depends on these leaky global variables!
// (function() {

    // globals defined elsewhere - basically 'imported' by index.html
    var Graph; // graph.js
    var Map; // map.js

    // create a new generic d3 graph object
    var graph = new Graph( '#map', {nodeRadius:20} );

    // create a Zork map object.
    // read rooms and exits from file, and add initial room.
    // WHOUS is west of house
    var map = new Map( 'data/json/zork_small.json', 'WHOUS', graph );

    // make click handler for graph
    function onClickNode(d,i) { map.addRoomExits(d); }

// })();
