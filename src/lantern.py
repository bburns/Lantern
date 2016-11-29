
"""
Lantern
Parse and convert Zork Muddle source code to different data structures.
Uses mud.py, the Muddle parser/compiler.
"""


# input file
mudfile = 'data/mdl/dung.mud'

# output files
outfiles = {
    'lisp': 'data/lisp/zork.lisp',
    'json': 'data/json/zork.json',
    'graphviz': 'data/graphviz/zork.gv',
    }

import mud # the MDL parser/compiler


# can add global variables here, though might be overwritten by
# setg and psetg commands in dung.mud.
# mud.global_env[',FOO'] = 123


# define special form functions, which will be added to the mudpy parser.
# in lisp these would be defined as macros.
# there might be a better way to define these as functions, but this works for now.

def form_room(x, env):
    """
    ROOM special form handler.
    This is a special form so can pass current room key down to EXIT.
    """
    key, desc, name, exits = x[1:5] # unpack arguments
    # evaluate values
    name = mud.eval(name, env) # need this in case name is a global variable reference
    desc = mud.eval(desc, env) # ditto
    # create a new environment with ROOM-KEY, to pass to the EXIT special form
    parms = ['ROOM-KEY']
    args = [key]
    newenv = mud.Env(parms, args, env)
    exits = mud.eval(exits, newenv) # parse EXIT special form
    # return a simple room object
    room = {'key': key, 'name': name, 'desc': desc, 'exits': exits}
    return room


def form_exit(x, env):
    """
    EXIT special form handler.
    Transform any special exit forms and return as an unconditional exit list,
    e.g.
    <EXIT "N" "NHOUSE" "W" (CEXIT ,WH "WHOUS" <>)> => ["N","NHOUS","W","WHOUS"].
    """
    if mud.debug: print 'exit',x
    exits = []
    tokens = x[1:]
    while tokens:
        token = tokens.pop(0) # pop from start of list
        if isinstance(token, str) and token.startswith(','):
            val = mud.eval(token)
            if val is None:
                if mud.debug: print 'unknown/unparsed gvar',token
                val = token # leave the value as the plain comma-prefixed token
            token = val
        if isinstance(token, mud.List):
            if token[0] == 'CEXIT': # handle conditional exit form
                token = mud.eval(token) # replace CEXIT struct with a room key
            elif token[0] == 'DOOR': # handle door exit form
                # this will be token 2 or 3 - want the one other than the current room
                roomkey = env.findvalue('ROOM-KEY') # passed down from ROOM special form
                if mud.debug: print 'roomkey', roomkey
                if token[2] == roomkey:
                    token = token[3] # replace DOOR struct with a room key
                else:
                    token = token[2]
            elif token[0] == 'SETG':
                token = mud.eval(token) # replace SETG form with room key
        exits.append(token)
    return exits


def form_cexit(x, env):
    """
    CEXIT special form handler.
    <CEXIT cond tform fform unk fn> => (eval tform)
    """
    if mud.debug: print 'cexit',x
    # (_, cond, tform, fform, unk, fn) = x
    # we just want to eval the tform
    tform = x[2]
    value = mud.eval(tform, env)
    return value


# def form_door(x, env):
#     "DOOR special form handler"
#     if mud.debug: print 'door',x
#     # this will be token 2 or 3 - want the one other than the current room
#     if token[2] == roomkey:
#         token = token[3] # replace DOOR struct with a room key
#     else:
#         token = token[2]
#     value = mud.eval(tform, env)
#     return value


def form_setg(x, env):
    """
    SETG special form handler.
    Set a global variable value to an evaluated form value and return that value.
    eg <SETG foo 32>
    Note that this is different from the set! special form, which sets a
    local variable.
    """
    if mud.debug: print 'setg',x
    var = x[1]
    form = x[2]
    value = mud.eval(form, env)
    mud.global_env[',' + var] = value # set global variable value (adding comma is a cheat)
    return value

# assign the special form functions to a dictionary in mudpy
mud.forms['room'] = form_room
mud.forms['exit'] = form_exit
mud.forms['cexit'] = form_cexit
mud.forms['setg'] = form_setg
mud.forms['psetg'] = form_setg # psetg calls setg and adds to a 'pure' list - not needed


def get_rooms(muddle):
    "Parse the given Muddle code and return a list of ROOM objects."
    program = "(list " + muddle + ")"
    objs = mud.eval(mud.parse(program)) # parse the program and get objects
    rooms = [obj for obj in objs if isinstance(obj, dict)] # filter down to room objects
    return rooms


def get_lisp(rooms):
    "Convert the given list of ROOMs to simpler Lisp objects"
    lines = []
    for room in rooms:
        key = room['key']
        name = room['name']
        desc = room['desc']
        exits = room['exits']
        exits = ' '.join(room['exits'])
        s = """(room %s
    (name %s)
    (desc %s)
    (exit %s))""" % (key, name, desc, exits)
        # print s
        # print
        lines.append(s)
    s = '\n\n'.join(lines)
    return s


def get_graph(rooms):
    "Convert the given list of ROOMs to a graph structure of rooms and exits"

    roomlist = []
    exitlist = []

    for room in rooms:

        key = room['key']
        name = room['name']
        desc = room['desc']
        exits = room['exits']

        # remove surrounding double quotes
        tostr = lambda s: s[1:-1]
        key = tostr(key)
        name = tostr(name)
        desc = tostr(desc)

        # add room
        obj = {'key': key, 'name': name, 'desc': desc}
        roomlist.append(obj)

        # add exits
        while exits:
            dir = exits.pop(0)
            target = exits.pop(0)
            dir = tostr(dir)
            target = tostr(target)
            obj = {'source': key, 'dir': dir, 'target': target}
            exitlist.append(obj)

    graph = {'rooms': roomlist, 'exits': exitlist}
    return graph


def get_json(rooms):
    "Convert the given list of ROOMs to JSON data"
    graph = get_graph(rooms)
    import json
    s = json.dumps(graph, indent=2)
    return s


def get_graphviz(rooms):
    "Convert the given list of ROOMs to GraphViz"
    graph = get_graph(rooms)
    roomlist = graph['rooms']
    exitlist = graph['exits']
    lines = []
    lines.append("digraph zork {")
    for room in roomlist:
        lines.append("%s [label=\"%s\"];" % (room['key'], room['name']))
    for exit in exitlist:
        if exit['target'] != 'NEXI':
            lines.append("\"%s\" -> \"%s\";" % (exit['source'], exit['target']))
    lines.append("}")
    s = '\n'.join(lines)
    return s


def get_muddle(filename):
    "Return contents of given Muddle file"
    f = open(filename)
    muddle = f.read()
    f.close()
    return muddle


def get_muddle_test():
    muddle = """
    <ROOM "WHOUS"
    "This is an open field west of a white house, with a boarded front door."
           "West of House"
           <EXIT "NORTH" "NHOUS" "SOUTH" "SHOUS" "WEST" "FORE1"
                  "EAST" #NEXIT "The door is locked, and there is evidently no key.">
           (<GET-OBJ "FDOOR"> <GET-OBJ "MAILB"> <GET-OBJ "MAT">)
           <>
           <+ ,RLANDBIT ,RLIGHTBIT ,RNWALLBIT ,RSACREDBIT>
           (RGLOBAL ,HOUSEBIT)>
    <SETG KITCHEN-WINDOW <DOOR "WINDO" "KITCH" "EHOUS">>
    <ROOM "EHOUS"
           ""
           "Behind House"
           <EXIT "NORTH" "NHOUS" "SOUTH" "SHOUS" "EAST" "CLEAR"
                  "WEST" ,KITCHEN-WINDOW
                  "ENTER" ,KITCHEN-WINDOW>
           (<GET-OBJ "WINDO">)
           EAST-HOUSE
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
    <PSETG STFORE "This is a forest, with trees in all directions around you.">
    <PSETG FOREST "Forest">
    <PSETG FORDES
    "This is a dimly lit forest, with large trees all around.  To the
east, there appears to be sunlight.">
    <PSETG FORTREE
    "This is a dimly lit forest, with large trees all around.  One
particularly large tree with some low branches stands here.">
    <PSETG NOTREE #NEXIT "There is no tree here suitable for climbing.">
    <ROOM "FORE1"
           ,STFORE
           ,FOREST
           <EXIT "UP" ,NOTREE
                 "NORTH" "FORE1" "EAST" "FORE3" "SOUTH" "FORE2" "WEST" "FORE1">
           ()
           FOREST-ROOM
           <+ ,RLANDBIT ,RLIGHTBIT ,RNWALLBIT ,RSACREDBIT>
           (RGLOBAL <+ ,TREEBIT ,BIRDBIT ,HOUSEBIT>)>
    """

    # muddle = "<COND ((if 0 1 0) 3) (1 5)>"

    # muddle = """
    # <PSETG FOO "pokpok">
    # ,FOO
    # """

    # muddle = """
    # <PSETG FOO ["pokpok"]>
    # ,FOO
    # """
    # print mud.parse(s)

    return muddle



if __name__=='__main__':

    import sys

    # check cmdline arguments
    args = sys.argv[1:]
    dotest = '-test' in args
    dosave = '-save' in args
    debug = '-debug' in args
    output = 'lisp'
    if '-json' in args:
        output = 'json'
    if '-graphviz' in args:
        output = 'graphviz'

    # set flags
    mud.debug = debug
    mud.compile = True

    # get muddle code
    if dotest:
        muddle = get_muddle_test()
    else:
        muddle = get_muddle(mudfile)

    # get room objects
    rooms = get_rooms(muddle)

    # convert to different forms
    if output=='lisp':
        s = get_lisp(rooms)
    elif output=='json':
        s = get_json(rooms)
    elif output=='graphviz':
        s = get_graphviz(rooms)

    if dosave:
        outfile = outfiles[output]
        print >>outfile, s
    else:
        print s

