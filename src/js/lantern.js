
// --------------------------------------------------------------------------------
// Lantern
// Explore Zork map interactively with d3
// --------------------------------------------------------------------------------

//> this still needs some work to make Graph and Map independent,
// eg the onclicknode callback


// globals defined elsewhere - basically 'imported' by index.html
var $; // index.html
var Graph; // graph.js
var Map; // map.js


//> can't wrap like this yet because code depends on the global variables!
// (function() {

var parentElementId = 'map';
var nodeRadius = 20; // pixels
var mapfile = 'data/json/zork.json';

// var startRoom = 'WHOUS'; // west of house
var startRoom = 'KITCH'; // kitchen
// var startRoom = 'CELLA'; // cellar


// create a new generic d3 graph object
var graph = new Graph( parentElementId, {nodeRadius:nodeRadius} );

// create a Zork map object.
// read rooms and exits from file, and add initial room.
var map = new Map( mapfile, startRoom, graph );


// click handler for graph
function onClickNode(d,i) {
    map.addRoomExits(d);
}

function onMouseOver(d) {
    $('#room-name').text(d.name);
    $('#room-description').text(d.desc || '(No description)');
}


// })();

