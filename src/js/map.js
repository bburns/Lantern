
//--------------------------------------------------------------------------------
// * Map
//--------------------------------------------------------------------------------

// This makes a map object that encapsulates the room and exit arrays,
// and provides some access functions.

// The data structures read in look like this -
// var rooms = [
//     {"key": "WHOUS", "name": "West of House", "desc": "This is an open field west of a white house...."},
//     {"key": "ATTIC", "name": "Attic", "desc": "This is the attic. The only exit is stairs that lead down."}];
// var exits = [
//     {"source": "WHOUS", "dir": "NORTH", "target": "NHOUS"},
//     {"source": "WHOUS", "dir": "EAST", "target": "The door is locked, and there is evidently no key."}];

// Usage:
// var graph = new Graph('#map');
// var map = new Map('map.json', 'ROOM1', graph);

// --------------------------------------------------------------------------------


// globals defined elsewhere - basically 'imported' in index.html
var d3; // index.html
var findObject; // library.js


var Map = function (filename, startKey) {

    var rooms, exits; // arrays of all rooms and exits

    // file i/o is asynchronous, so have to do things in callbacks.
    // this just opens the file, finds the room with the given startkey,
    // and adds it to the graph.
    // d3 provides a convenience fn 'json' to read from a json file
    d3.json(filename, function(error, json) {
        rooms = json['rooms'];
        exits = json['exits'];
        var room = map.getRoom(startKey);
        graph.addNode(room);
    });

    return {

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

};


//> add to map class

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


