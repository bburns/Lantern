
"""
Lantern
Parse and convert Zork Muddle source code to different data structures.

"""

import mud


# add global variables
mud.global_env[',NULEXIT'] = []




# add special forms to parser, keyed on first symbol in form

def form_room(x, env):
    "ROOM special form handler"
    # python 3 has syntax for this - unpacking optional values
    (_, key, desc, name, exits, objects, unk, bits, bits2) = (x + [None,None,None,None])[:9]
    # create a new environment with ROOM-KEY, to pass to the EXIT special form
    parms = ['ROOM-KEY']
    args = [key]
    newenv = mud.Env(parms, args, env)
    # parse EXIT special form and its subforms
    exits = mud.eval(exits, newenv)
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

mud.forms['room'] = form_room


def form_exit(x, env):
    "EXIT special form handler"
    # transform the special exits and return as an unconditional exit list
    # print 'exit',x
    # if isinstance(x, mud.String) and x == ',NULEXIT':
        # return []
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
                # token = token[2] # replace CEXIT struct with a room key
                token = mud.eval(token) # replace CEXIT struct with a room key
            elif token[0] == 'DOOR': # handle door exit form
                # this will be 2 or 3 - want the one other than the current room
                if token[2] == roomkey:
                    token = token[3] # replace DOOR struct with a room key
                else:
                    token = token[2]
            elif token[0] == 'SETG':
                token = mud.eval(token) # replace SETG form with room key
                print token
        elif token == '#NEXIT': # no exit
            # remove following token, which is a no-exit string
            tokens.pop(0)
        exits.append(token)
    return exits

mud.forms['exit'] = form_exit


def form_cexit(x, env):
    "CEXIT special form handler"
    # (_, cond, tform, fform, unk, fn) = x
    # we usually want the tform
    if mud.debug: print 'cexit',x
    tform = x[2]
    value = mud.eval(tform, env)
    return value

mud.forms['cexit'] = form_cexit


def form_setg(x, env):
    "SETG special form handler"
    # set a global variable value to an evaluated form value and return that value.
    # can skip the setting part and just return the value for now.
    if mud.debug: print 'setg',x
    # (_, var, form) = x  # crashes if form is '#NEXIT'
    form = x[2]
    value = mud.eval(form, env)
    #> set global variable
    return value

mud.forms['setg'] = form_setg





if __name__=='__main__':

#     s = """
# <COND (<G? ,MUDDLE 104>
#        <PSETG MSG-STRING "Muddle 105 Version/Please report strange occurances.">)>
# "Device definitions for save and restore"
# <COND (<L? ,MUDDLE 100>
#        <PSETG DEVICE-TABLE '["A" "AI" "D" "DM" "C" "ML" "H" "AI" "L" "AI"
# 			    "M" "ML" "N" "MC" "P" "ML" "U" "MC" "Z" "ML"]>)>
# ; "SUBTITLE POBLIST DEFINITIONS AND PARSER STRUCTURES"
# <MPOBLIST ACTIONS-POBL 17>
# <PSETG ACTIONS-POBL ,ACTIONS-POBL>

#     <ROOM "WHOUS"
#     "This is an open field west of a white house, with a boarded front door."
#            "West of House"
#            <EXIT "NORTH" "NHOUS" "SOUTH" "SHOUS" "WEST" "FORE1"
#                   "EAST" #NEXIT "The door is locked, and there is evidently no key.">
#            (<GET-OBJ "FDOOR"> <GET-OBJ "MAILB"> <GET-OBJ "MAT">)
#            <>
#            <+ ,RLANDBIT ,RLIGHTBIT ,RNWALLBIT ,RSACREDBIT>
#            (RGLOBAL ,HOUSEBIT)>

#     <ROOM "LROOM"
#            ""
#            "Living Room"
#            <EXIT "EAST" "KITCH"
#                   "WEST" <CEXIT "MAGIC-FLAG" "BLROO" "The door is nailed shut.">
#                   "DOWN" <DOOR "DOOR" "LROOM" "CELLA">>
#            (<GET-OBJ "WDOOR"> <GET-OBJ "DOOR"> <GET-OBJ "TCASE">
#             <GET-OBJ "LAMP"> <GET-OBJ "RUG"> <GET-OBJ "PAPER">
#             <GET-OBJ "SWORD">)
#            LIVING-ROOM
#            <+ ,RLANDBIT ,RLIGHTBIT ,RHOUSEBIT ,RSACREDBIT>>
#     """

    # s = "<COND ((if 0 1 0) 3) (1 5)>"

    f = open('data/mdl/dung.mud')
    s = f.read()

    mud.debug = False
    # mud.debug = True
    mud.compile = True

    program = "(begin " + s + ")"
    mud.eval(mud.parse(program))



