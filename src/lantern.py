
"""
Lantern
Parse and convert Zork Muddle source code to different data structures.
"""

import mud


# add global variables

# mud.global_env[',FOO'] = 321


# add special forms to parser, keyed on first symbol in form

def form_room(x, env):
    "ROOM special form handler"
    # python 3 has syntax for this - unpacking optional values
    (_, key, desc, name, exits, objects, unk, bits, bits2) = (x + [None,None,None,None])[:9]
    # create a new environment with ROOM-KEY, to pass to the EXIT special form
    parms = ['ROOM-KEY']
    args = [key]
    newenv = mud.Env(parms, args, env)
    # evaluate values
    name = mud.eval(name, newenv)
    desc = mud.eval(desc, newenv)
    exits = mud.eval(exits, newenv) # parse EXIT special form
    # create the compiler output
    # s = "(room (key %s) (name %s) (desc %s) (exits %s))" % (key, name, desc, exits)
    s = """(room %s
    (name %s)
    (desc %s)
    (exit %s))""" % (key, name, desc, ' '.join(exits))
    if mud.compile: # print the compiler output
        print s
        print
    return s


def form_exit(x, env):
    "EXIT special form handler"
    # transform the special exits and return as an unconditional exit list
    if mud.debug: print 'exit',x
    exits = []
    tokens = x[1:]
    envfound = env.find('ROOM-KEY')
    if envfound:
        roomkey = envfound['ROOM-KEY']
    else:
        roomkey = None
    if mud.debug: print 'roomkey', roomkey
    while tokens:
        token = tokens.pop(0) # pop from start of list
        if isinstance(token, mud.List):
            if token[0] == 'CEXIT': # handle conditional exit form
                token = mud.eval(token) # replace CEXIT struct with a room key
            elif token[0] == 'DOOR': # handle door exit form
                # this will be token 2 or 3 - want the one other than the current room
                if token[2] == roomkey:
                    token = token[3] # replace DOOR struct with a room key
                else:
                    token = token[2]
            elif token[0] == 'SETG':
                token = mud.eval(token) # replace SETG form with room key
        elif token == '#NEXIT': # no exit
            # remove following token, which is a no-exit string
            tokens.pop(0)
        elif token.startswith(','): #> eval should handle these
            val = mud.eval(token)
            if val is None:
                if mud.debug: print 'unknown/unparsed gvar',token
                val = token
            token = val
        exits.append(token)
    return exits


def form_cexit(x, env):
    "CEXIT special form handler"
    if mud.debug: print 'cexit',x
    # (_, cond, tform, fform, unk, fn) = x
    # we just want the tform
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
    "SETG special form handler"
    # set a global variable value to an evaluated form value and return that value.
    # can skip the setting part and just return the value for now.
    if mud.debug: print 'setg',x
    # (_, var, form) = x  # crashes if form is '#NEXIT'
    var = x[1]
    form = x[2]
    value = mud.eval(form, env)
    mud.global_env[',' + var] = value # set global variable value
    return value


mud.forms['room'] = form_room
mud.forms['exit'] = form_exit
mud.forms['cexit'] = form_cexit
mud.forms['setg'] = form_setg
mud.forms['psetg'] = form_setg # psetg calls setg and adds to a 'pure' list - not needed


if __name__=='__main__':

    s = """
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

    # s = "<COND ((if 0 1 0) 3) (1 5)>"

    # s = """
    # <PSETG FOO "pokpok">
    # ,FOO
    # """

    # s = """
    # <PSETG FOO ["pokpok"]>
    # ,FOO
    # """
    # print mud.parse(s)

    mud.debug = False
    # mud.debug = True
    mud.compile = True


    f = open('data/mdl/dung.mud')
    s = f.read()
    f.close()

    program = "(begin " + s + ")"
    # program = "(list " + s + ")"
    rooms = mud.eval(mud.parse(program))
    # print rooms





