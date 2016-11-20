
// Lantern
// Explore Zork map interactively with d3
// --------------------------------------------------------------------------------

// For reference, see
// http://bl.ocks.org/mbostock/3750558


// The data structures read in look like this - 
// var rooms = [
//     {"key": "WHOUS", "name": "West of House", "desc": "This is an open field west of a white house, with a boarded front door."},
//     {"key": "ATTIC", "name": "Attic", "desc": "This is the attic.  The only exit is stairs that lead down."}];
// var exits = [
//     {"source": "WHOUS", "dir": "NORTH", "target": "NHOUS"},
//     {"source": "WHOUS", "dir": "EAST", "target": "The door is locked, and there is evidently no key."}];


// this code needs major cleanup - very hard to read/understand
// several undefined globals


// globals from other files
var d3;
var p, pj;
var Hash, Set, getWindowSize, findObject;
var g;


//--------------------------------------------------------------------------------
// * Graph
//--------------------------------------------------------------------------------

//> this module defines a Graph g which...

(function () {
    
    // initialize the graph object

    var distance = 90; // fixed distance between nodes
    var charge = -5000; // attractive/repulsive force
    var gravity = 0.5; // force drawing nodes to the center

    var shape = "circle";
    // var shape = "rect";
    var radius = 20;
    var rect_width = 60, rect_height = 50;
    var labelx = 8, labely = 18;

    var nodeData, nodeGroup;
    var nodeCircle, nodeRect;
    var linkData, linkLine;

    // we need to store a hash to added objects, so we can avoid duplicates.
    // this could just be a set, but we also need the objects in adding links -
    // which we could let the user take care of, but let's just try doing it here
    var nodehash = new Hash();

    // similarly we could store a set of link keys, to avoid duplicates.
    // for at the moment that would be more wasteful than useful,
    // since we won't be duplicating links very much
    // var linkkeys = new Set();

    
    // create svg canvas
    var svg = d3.select("#map").append("svg");
    
    // note that the size of the svg rectangle is INDEPENDENT of the svg size -
    // just want it to match it somehow

    // set size of svg
    var size = getWindowSize();
    size[1]-=100; //> arbitrary
    svg.append("rect").attr("width", size[0]).attr("height", size[1]);

    //> can you read the width and height of the map div instead of whole window?
    // nowork
    // var map = document.getElementById('map');
    // var size = [map.offsetWidth, map.offsetHeight];
    // pj(size);

    // // set force size to svg size
    // // var width2 = svg.offsetWidth;
    // var height2 = svg.offsetHeight;
    // var width2 = svg.style.pixelHeight;
    // var width2 = svg.style.height;
    // // var width2 = svg.width;
    // // p('wh ' + width2 + ' ' + height2);
    // p(d3);
    // p(svg);
    // p(svg[0]);
    // p(document);
    // // svg = document.getElementsByClassName('svg')[0];
    // var e = document.getElementsByTagName('svg')[0];
    // p(e.clientWidth);
    // // svg.load(function() {
    // // p(svg.localName);
    // // p(svg.border);
    // // p(svg.width);
    // // p(svg.offsetWidth);
    // // p(svg.style.width);
    // // p(svg.style.pixelHeight);
    // // p(svg.getBBox); //().width);
    // // p(svg.getBoundingClientRect);
    // // });

    // scale contents with browser window resizing.
    // svg.attr("viewBox", "0 0 " + width + " " + height ).attr("preserveAspectRatio", "xMidYMid meet");
    // svg.call(d3.behavior.zoom().on("zoom", redraw));


    var force = d3.layout.force()
        .size(size)
        .distance(distance)
        .charge(charge)
        .gravity(gravity)
        .on("tick", tick);
    

    // this function is called on each time tick to animate the graph
    function tick() {
        nodeData
            .attr("transform", function(d) {return "translate(" + d.x + "," + d.y + ")";});
            // .attr("cx", function(d) { return d.x; })
            // .attr("cy", function(d) { return d.y; });
        linkData
            .attr("x1", function(d) { return d.source.x; })
            .attr("y1", function(d) { return d.source.y; })
            .attr("x2", function(d) { return d.target.x; })
            .attr("y2", function(d) { return d.target.y; });
    };

    
    // add/update/delete svg elements for current nodes and links
    function updateSvg() {
        
        // links
        
        // select all line elements with class 'link'
        linkData = svg.selectAll("line.link")
            .data(force.links(), function(d) { return d.source.key + "-" + d.target.key; }); // eg "whous-shous"
        linkLine = linkData.enter()
            .append("line")
            .attr("class", "link"); // add new elements
        linkData.exit()
            .remove(); // remove old elements

        
        // nodes
        
        // groups with circles or rectangles and labels
        // select all g elements with class 'node'
        nodeData = svg.selectAll("g.node")
            .data(force.nodes(), function(d) { return d.key;});
        nodeGroup = nodeData.enter()
            .append("g")
            .attr("class", "node"); // add new elements
        nodeGroup.call(force.drag); // make nodes draggable
        nodeGroup.on("click", onclick); // callback fn for user to set
        nodeGroup.append("svg:title")
            .text(function(d) { return d.desc || "(No description)"; }); // tooltips
        nodeData.exit()
            .remove(); // remove old elements

        if (shape=="circle")
            nodeCircle = nodeGroup.append("circle")
            .attr("r", radius);
        
        if (shape=="rect")
            nodeRect = nodeGroup.append("rect")
            .attr("width", rect_width)
            .attr("height", rect_height);

        var nodeLabel = nodeGroup.append("text")
            .attr("class", "nodetext")
            .attr("x", labelx)
            .attr("y", labely)
            // .attr("dx", radius + 3)
            // .attr("dy", ".35em")
            .text(function(d) {return d.name;});

        // restart the force layout
        force.start();
    };

    
    // export a global variable/module/namespace
    g = {

        // add a node to the graph. a node is just an object with a .key property.
        addnode: function (node) {
            if (node && !nodehash.has(node.key)) {
                force.nodes().push(node);
                nodehash.set(node.key, node);
                updateSvg();
            }
        },

        // add a link to the graph. the source and target keys refer to node keys
        //. dir is a direction. should just be extra info?
        addlink: function (sourcekey, targetkey, dir) {
            // don't add if already there
            // var linkkey = sourcekey + '-' + targetkey;
            // if (! linkkeys.has(linkkey)) {
                // linkkeys.add(linkkey)
            var nodeSource = nodehash.get(sourcekey);
            var nodeTarget = nodehash.get(targetkey);
            if (nodeSource && nodeTarget) {
                // d3 expects links to have source and target properties linking to the full node objects. dir is extra.
                var link = {"source": nodeSource, "target": nodeTarget, "dir": dir};
                force.links().push(link);
                updateSvg();
            }
            // }
        }
    };

})();



//--------------------------------------------------------------------------------
// * Data
//--------------------------------------------------------------------------------

//> what is this?

var data = {
    init: function(filename, fn) {
        d3.json(filename, function(error, json) {
            if (error) return console.warn(error);
            rooms = json['rooms'];
            exits = json['exits'];
            return fn();
        });
    },
    // find the given room object.
    // linear search in lieu of a hash for now
    // getroom: function(roomkey) {
    //     var room = findObject(rooms, 'key', roomkey);
    //     return room;
    // },
    get: function(roomkey, fn) {
        var room = findObject(rooms, 'key', roomkey);
        fn(room);
    },
    // find all of the exits from the given room - each exit object looks like this
    // {source:'whous', target:'shous', dir:'east'}
    // return in a list
    getexits: function(roomkey) {
        return exits.filter(function (exit) {return exit.source===roomkey;});
    }
};



//--------------------------------------------------------------------------------
// * UI
//--------------------------------------------------------------------------------

// click on room callback
function onclick(d,i) { addRoomExits(d); }

// given a room, find all its exits.
// then add those rooms and the links to them called by onclick handler.
function addRoomExits(room) {

    // find all exits from this room
    var sourcekey = room.key;
    var roomexits = data.getexits(sourcekey);

    // add (possibly) new rooms and links
    roomexits.map(function (exit) {
        var dir = exit.dir;
        var targetkey = exit.target;

        //. get objs all at once
        // var target = d.getroom(targetkey);
        // g.addnode(target);
        // g.addlink(sourcekey, targetkey, dir);

        data.get(targetkey, function (target) {
            if (target) {
                g.addnode(target);
                g.addlink(sourcekey, targetkey, dir);
            }
        });
    });
}


//--------------------------------------------------------------------------------
// * Start
//--------------------------------------------------------------------------------

// nowork - why? can only do child dirs?
//// var filename = '../../data/json/zork_rooms.json';
//var filename = '../../data/json/zork_rooms_small.json';

// var filename = 'zork_rooms.json';
var filename = 'data/json/zork_rooms_small.json';
var startkey = 'WHOUS';


// arrays
data.init(filename, function() {
    data.get(startkey, function(room) {
        g.addnode(room);
    });
});


// var whous = data.getroom(startkey);
// g.addnode(whous);

// g.addnode(rooms[0]);
// g.addnode(rooms[1]);
// g.addlink(rooms[0].key, rooms[1].key, 'north');
// g.addnode(rooms[1]); // re-add room, and note we still have only 2 circles

// addRoomExits(whous);



