
//--------------------------------------------------------------------------------
// Library
//--------------------------------------------------------------------------------

// define some useful functions

function assert(condition, message) {
    if (!condition)
        throw message || "Assertion failed";
    else
        console.log("Assertion passed");
}

// convert object to JSON string
function j(o) {
    if (o==undefined)
        return 'undefined'; // otherwise would be blank
    else
        return JSON.stringify(o, null, 2);
}

// shortcuts for debugging
function a(o) {alert(o);}
function aj(o) {alert(j(o));}
function p(o) {console.log(o);}
function pj(o) {console.log(j(o));}
function h(o) {d3.select("body").append("p").text(o);}
function hj(o) {d3.select("body").append("p").text(j(o));}

// define a Set class
function Set() {
    var o = {};
    this.add = function(key) {o[key] = true;};
    this.has = function(key) {return o[key] !== undefined;};
}

// define a Hash class
function Hash() {
    var o = {};
    this.set = function(key, value) {o[key]=value;};
    this.get = function(key) {return o[key];};
    this.has = function(key) {return o[key] !== undefined;};
}

// convenience functions
function findElement(array, fn) { return array.filter(fn)[0]; } // first match
function findObject(objs, prop, value) { return findElement(objs, function(o){ return o[prop]===value;}); }


function getWindowSize() {
    // cross browser function to get dimensions of window, ie the area usable on the page
    // in firefox, all 3 methods work and give same result
    var w = window, d = document, e = d.documentElement, g = d.getElementsByTagName('body')[0];
    var width = w.innerWidth || e.clientWidth || g.clientWidth;
    var height = w.innerHeight|| e.clientHeight|| g.clientHeight;
    var size = [width,height];
    return size;
}
