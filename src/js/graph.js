
// --------------------------------------------------------------------------------
// Graph
// Define a generic d3 graph object.
// --------------------------------------------------------------------------------

// This makes a generic graph object that encapsulates a d3 force layout object,
// and provides some access functions.

// Nodes can be any javascript object with 'key', 'name', and optional 'desc' properties.
// Links are just pairs of node keys.

// Usage:
// var graph = new Graph('#map', {charge: -5000, gravity: 0.5, distance: 90, nodeRadius: 20});
// var room = {key:'foo', name:'Foo', desc:'A dusty room'};
// graph.addNode(room);

// For reference, see
// https://bl.ocks.org/mbostock/3750558 - force layout
// https://bl.ocks.org/mbostock/6123708 - pan and zoom
// http://stackoverflow.com/questions/9539294/adding-new-nodes-to-force-directed-layout

// --------------------------------------------------------------------------------

// globals defined elsewhere - basically 'imported' by index.html
var d3; // index.html
var Hash; //, getWindowSize; // library.js


//> get rid of global 'onClickNode' and 'onMouseOver' references


var Graph = function (parentElementId, options={}) {

    // set graph options
    var charge     = options.charge     || -5000; // attractive/repulsive force
    var gravity    = options.gravity    || 0.5; // force drawing nodes to the center
    var distance   = options.distance   || 90; // fixed distance between nodes
    var nodeRadius = options.nodeRadius || 20; // pixels

    // set label positions
    var labelx = nodeRadius + 4; // pixels
    var labely = nodeRadius / 4; // pixels

    // need to store a hash of added objects, so can avoid duplicate rooms.
    // could just use a Set, but also need to be able to find the room objects.
    var nodeHash = new Hash();

    //> could store a set of link keys to avoid duplicate links also,
    // but we won't be duplicating them very often.
    // var linkkeys = new Set();

    // create svg canvas as child of parent element and return a d3 svg object
    var svg = d3.select('#'+parentElementId).append("svg");

    //> make a getElementSize() fn
    var el = document.getElementById(parentElementId);
    var width = el.clientWidth,
        height = el.clientHeight;

    // handle zoom with mouse wheel
    var zoom = d3.behavior.zoom()
        .scaleExtent([0.1, 10])
        .on("zoom", zoomed);
    svg.call(zoom);
    svg = svg.append("g");

    // create a d3 force layout object and set some properties
    var force = d3.layout.force()
        .size([width, height])
        .distance(distance)
        .charge(charge)
        .gravity(gravity)
        // .linkStrength(0.1) // default 1.0
        .on("tick", tick);

    // create some groups where we'll add the elements
    svg.append("g").attr("class","lines");
    svg.append("g").attr("class","circles");
    svg.append("g").attr("class","labels");

    // add arrow marker definition
    // see http://www.coppelia.io/2014/07/an-a-to-z-of-extra-features-for-the-d3-force-layout/
    svg.append("defs").selectAll("marker")
        .data(["arrow"]) //>?
      .enter().append("marker")
        .attr("id", "arrow")
        .attr("viewBox", "0 -5 10 10") //>?
        .attr("refX", 20) // how far back from end of the line to start arrow
        .attr("refY", 0)
        .attr("markerWidth", 10) //>?
        .attr("markerHeight", 10)
        .attr("orient", "auto")
      .append("path")
        .attr("d", "M0,-2 L5,0 L0,2 L0,-2")
        .style("stroke", "#444")
        .style("fill", "#444");
        // .style("opacity", "0.6");

    // arrays of objects
    var lines, circles, labels;

    // update svg elements for current nodes and links,
    // and restart the d3 force layout object.
    function updateSvg() {

        // add lines
        lines = svg.select("g.lines").selectAll("line")
            .data(force.links());
        lines
            .enter().append("line")
            .attr("class", "link")
            .style("marker-end",  "url(#arrow)");

        // add circles
        circles = svg.select("g.circles").selectAll("circle")
            .data(force.nodes());
        circles
            .enter().append("circle")
            .attr("class", "node")
            .attr("r", nodeRadius);
        circles
            .call(force.drag) // make nodes draggable
            .on("mouseover", onMouseOver) // callback fn
            .on("click", onClickNode); // callback fn

        // add labels
        labels = svg.select("g.labels").selectAll("text")
            .data(force.nodes());
        labels
            .enter().append("text")
            .attr("x", labelx)
            .attr("y", labely)
            .text(function(d) { return d.name; });

        // restart the d3 force layout object
        force.start();
    };

    // this function is called on each time tick to animate the graph.
    //> why is this needed if it's assigning fns to these attributes?
    // couldn't you just do that once?
    function tick() {
        lines
            .attr("x1", function(d) { return d.source.x; })
            .attr("y1", function(d) { return d.source.y; })
            .attr("x2", function(d) { return d.target.x; })
            .attr("y2", function(d) { return d.target.y; });
        circles
            .attr("transform", function(d) { return "translate(" + d.x + "," + d.y + ")"; });
        labels
            .attr("transform", function(d) { return "translate(" + d.x + "," + d.y + ")"; });
    };

    function zoomed() {
        // container.attr("transform", "translate(" + d3.event.translate +
        svg.attr("transform", "translate(" + d3.event.translate +
                       ") scale(" + d3.event.scale + ")");
    }

    function dragstarted(d) {
        d3.event.sourceEvent.stopPropagation();
        d3.select(this).classed("dragging", true);
    }

    function dragged(d) {
        d3.select(this).attr("cx", d.x = d3.event.x).attr("cy", d.y = d3.event.y);
    }

    function dragended(d) {
        d3.select(this).classed("dragging", false);
    }

    // return access functions
    return {

        // add a node to the graph, update the svg elements, and restart the layout.
        // a node can be any javascript object with a .key property.
        addNode: function (node) {
            if (node && !nodeHash.has(node.key)) {
                force.nodes().push(node);
                nodeHash.set(node.key, node);
                updateSvg();
            }
        },

        // add a link to the graph, update the svg elements, and restart the layout.
        // a link is just a pair of node keys.
        //> dir is a direction - not used yet.
        addLink: function (sourceKey, targetKey, dir) {
            //> don't add if already there
            // var linkKey = sourceKey + '-' + targetKey;
            // if (! linkKeys.has(linkKey)) {
                // linkKeys.add(linkKey) etc
            var sourceNode = nodeHash.get(sourceKey);
            var targetNode = nodeHash.get(targetKey);
            if (sourceNode && targetNode) {
                // d3 expects links to have 'source' and 'target' properties linking
                // to the full node objects. dir is extra.
                var link = {"source": sourceNode, "target": targetNode, "dir": dir};
                force.links().push(link);
                updateSvg();
            }
        },

        update: function() {
            // updateSvg();
        }
    };
};


