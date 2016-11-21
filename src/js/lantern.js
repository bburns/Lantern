
// --------------------------------------------------------------------------------
// Lantern
// Explore Zork map interactively with d3
// --------------------------------------------------------------------------------

// For reference, see
// http://bl.ocks.org/mbostock/3750558

// The data structures read in look like this - 
// var rooms = [
//     {"key": "WHOUS", "name": "West of House", "desc": "This is an open field west of a white house...."},
//     {"key": "ATTIC", "name": "Attic", "desc": "This is the attic. The only exit is stairs that lead down."}];
// var exits = [
//     {"source": "WHOUS", "dir": "NORTH", "target": "NHOUS"},
//     {"source": "WHOUS", "dir": "EAST", "target": "The door is locked, and there is evidently no key."}];

// globals from other files
var d3;
var p, pj;
var Hash, Set, getWindowSize, findObject;


//--------------------------------------------------------------------------------
// * Graph
//--------------------------------------------------------------------------------

// make a graph object that encapsulates a d3 force layout object,
// and provides access functions addNode and addLink.
// nodes are any javascript object with a 'key' property,
// and links are just pairs of node keys. 

//> make a class, pass in html element to add svg to, and graph properties 

var graph = (function () {
    
    var charge = -5000; // attractive/repulsive force
    var gravity = 0.5; // force drawing nodes to the center
    var distance = 90; // fixed distance between nodes

    var nodeRadius = 20; // pixels
    var labelx = nodeRadius + 4; // pixels
    var labely = nodeRadius / 4; // pixels

    var nodes, links; // arrays of nodes (rooms) and links

    // need to store a hash of added objects, so can avoid duplicate rooms.
    // could just use a Set, but also need to be able to find the room objects.
    var nodehash = new Hash();

    //> could store a set of link keys to avoid duplicate links also,
    // but we won't be duplicating them very often.
    // var linkkeys = new Set();

    // create svg canvas
    var svg = d3.select("#map").append("svg");
    
    // add a rectangle filling the canvas
    //> get size of svg, if possible 
    var size = getWindowSize();
    size[1] -= 100; //> arbitrary
    svg.append("rect").attr("width", size[0]).attr("height", size[1]);

    // create a d3 force layout object and set some properties
    var force = d3.layout.force()
        .size(size)
        .distance(distance)
        .charge(charge)
        .gravity(gravity)
        .on("tick", tick);
    
    // this function is called on each time tick to animate the graph.
    //> why is this needed if it's assigning fns to these attributes?
    // couldn't you just do that once?
    function tick() {
        nodes
            .attr("transform", function(d) { return "translate(" + d.x + "," + d.y + ")"; });
            // .attr("cx", function(d) { return d.x; })
            // .attr("cy", function(d) { return d.y; });
        links
            .attr("x1", function(d) { return d.source.x; })
            .attr("y1", function(d) { return d.source.y; })
            .attr("x2", function(d) { return d.target.x; })
            .attr("y2", function(d) { return d.target.y; });
    };
    
    
    // update svg elements for current nodes and links,
    // and restart the d3 force layout object.
    function updateSvg() {
        
        // update nodes
        // nodes are svg group objects with circle and text children
        
        // select all svg group elements with class 'node'
        nodes = svg.selectAll("g.node") 
            .data(force.nodes(), function(d) { return d.key;}); //> ?
        
        // add new group elements
        nodes.enter()
            .append("g") // g is an svg group element
            .attr("class", "node"); // set class to 'node'
        
        // add some properties for the group element
        nodes.call(force.drag) // make nodes draggable
            .on("click", onClickNode) // callback fn to handle clicks
            .append("svg:title") // add a tooltip for each node showing the value of .desc
            .text(function(d) { return d.desc || "(No description)"; });
        
        // remove any old elements
        nodes.exit()
            .remove(); 
        
        // add circle elements to groups
        nodes.append("circle")
            .attr("r", nodeRadius);
        
        // add text elements to groups
        nodes.append("text")
            .attr("class", "nodetext")
            .attr("x", labelx)
            .attr("y", labely)
            .text(function(d) {return d.name;});

        
        // update links
        // links are just lines between nodes
        
        // select all svg line elements with class 'link'
        links = svg.selectAll("line.link") 
            .data(force.links(), function(d) { return d.source.key + "-" + d.target.key; }); // eg "whous-shous"
        
        // add new link elements
        links.enter()
            .append("line")
            .attr("class", "link");
        
        // remove old elements
        links.exit()
            .remove(); 

        
        // restart the d3 force layout object
        force.start();
    };

    
    // return access functions
    return {

        // add a node to the graph, update the svg elements, and restart the layout.
        // a node can be any javascript object with a .key property.
        addNode: function (node) {
            if (node && !nodehash.has(node.key)) {
                force.nodes().push(node);
                nodehash.set(node.key, node);
                updateSvg();
            }
        },

        // add a link to the graph, update the svg elements, and restart the layout.
        // a link is just a pair of node keys.
        // dir is a direction - not used yet.
        addLink: function (sourceKey, targetKey, dir) {
            //> don't add if already there
            // var linkKey = sourceKey + '-' + targetKey;
            // if (! linkKeys.has(linkKey)) {
                // linkKeys.add(linkKey) etc
            var sourceNode = nodehash.get(sourceKey);
            var targetNode = nodehash.get(targetKey);
            if (sourceNode && targetNode) {
                // d3 expects links to have 'source' and 'target' properties linking
                // to the full node objects. dir is extra.
                var link = {"source": sourceNode, "target": targetNode, "dir": dir};
                force.links().push(link);
                updateSvg();
            }
        }
    };

})();



//--------------------------------------------------------------------------------
// * Map
//--------------------------------------------------------------------------------

// make a map object that encapsulates the room and exit arrays,
// and provides the access functions init, getRoom, and getExits.

var map = (function () {
    
    var rooms, exits; // arrays of all rooms and exits

    return {
        
        // open the given file and read into room and exit variables
        init: function(filename, fn) {
            // d3 provides a convenience fn to read from a json file
            d3.json(filename, function(error, json) {
                if (error) return console.warn(error);
                rooms = json['rooms'];
                exits = json['exits'];
                return fn();
            });
        },
        
        // find the given room object
        getRoom: function(roomKey) {
            // linear search in lieu of a hash for now
            var room = findObject(rooms, 'key', roomKey);
            return room;
        },
        
        // find all exits from the given room and return in a list.
        // each exit object looks like this -
        //   {source:'whous', target:'shous', dir:'east'}
        getExits: function(roomKey) {
            return exits.filter(function (exit) {return exit.source===roomKey;});
        }
    };

})();


//--------------------------------------------------------------------------------
// * Click Handler
//--------------------------------------------------------------------------------

// onclick handler for nodes - adds room exits
function onClickNode(d,i) { addRoomExits(d); }

// given a room, find all its exits, then add those rooms
// and the links to them.
function addRoomExits(room) {

    // find all exits from this room
    var sourceKey = room.key;
    var roomExits = map.getExits(sourceKey);

    // for each exit, add the room it points to and a link between them
    roomExits.map(function (exit) {
        var dir = exit.dir;
        var targetKey = exit.target;
        var targetRoom = map.getRoom(targetKey);
        if (targetRoom) {
            graph.addNode(targetRoom);
            graph.addLink(sourceKey, targetKey, dir);
        }
    });
}


//--------------------------------------------------------------------------------
// * Start
//--------------------------------------------------------------------------------

var startKey = 'WHOUS'; // map starting point - west of the house

// var filename = 'data/json/zork_rooms.json';
var filename = 'data/json/zork_rooms_small.json';

// file i/o is asynchronous, so have to do things in callbacks.
// this just opens the file, finds the room with the given startkey,
// and adds it to the graph.
map.init(filename, function() {
    var room = map.getRoom(startKey);
    graph.addNode(room);
});



