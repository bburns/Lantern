
"""
mud.py
MDL (Muddle) compiler/interpreter, following Peter Norvig's Lispy [1].

[1]: http://norvig.com/lispy.html
"""


# Lexer
# Parsing is traditionally separated into two parts: lexical analysis, in which
# the input character string is broken up into a sequence of tokens, and
# syntactic analysis, in which the tokens are assembled into an abstract syntax
# tree. The Lispy tokens are parentheses, symbols, and numbers. We'll use split
# for a tokenizer.
def tokenize(chars):
    "Convert a string of characters into a list of tokens."
    # s = s.replace('<','(').replace('>',')')
    # return s.replace('(', ' ( ').replace(')', ' ) ').split()
    brackets = list("()<>")
    whitespace = list(" \n\r\t\f") # \f is ^L?
    tokens = []
    token = ''
    s = ''
    for char in chars:
        if '"' == char:
            if s:
                s += char
                tokens.append(s)
                s = ''
            else:
                s += char
        elif s:
            s += char
        elif char in brackets:
            char = char.replace('<','(').replace('>',')')
            if token:
                tokens.append(token)
                token = ''
            tokens.append(char)
        elif char in whitespace:
            if token:
                tokens.append(token)
                token = ''
        else:
            token += char
    if token:
        tokens.append(token) # add leftover token
    return tokens

# print tokenize('(a (lambda b c) "cat dog")')
# stop

# Parser
# Our function parse will take a string representation of a program as input,
# call tokenize to get a list of tokens, and then call read_from_tokens to
# assemble an abstract syntax tree. read_from_tokens looks at the first token;
# if it is a ')' that's a syntax error. If it is a '(', then we start building
# up a list of sub-expressions until we hit a matching ')'. Any non-parenthesis
# token must be a symbol or number. We'll let Python make the distinction
# between them: for each non-paren token, first try to interpret it as an int,
# then as a float, and finally as a symbol. Here is the parser:
def parse(program):
    "Read a Scheme expression from a string."
    return read_from_tokens(tokenize(program))

def read_from_tokens(tokens):
    "Read an expression from a sequence of tokens."
    if len(tokens) == 0:
        raise SyntaxError('unexpected EOF while reading')
    token = tokens.pop(0)
    if '(' == token:
        L = []
        while tokens[0] != ')':
            L.append(read_from_tokens(tokens))
        tokens.pop(0) # pop off ')'
        return L
    elif ')' == token:
        raise SyntaxError('unexpected )')
    else:
        return atom(token)

Symbol = str
String = str

def isstr(token):
    "Is the given token a constant string?"
    if isinstance(token, String):
        return token.startswith('"') and token.endswith('"')
    else:
        return False

def atom(token):
    "Numbers become numbers; every other token is a symbol."
    try: return int(token)
    except ValueError:
        try: return float(token)
        except ValueError:
            if isstr(token):
                return String(token)
            else:
                return Symbol(token)

List = list

# REPL: Read-Eval-Print Loop
def repl(prompt='mud.py> '):
    "A prompt-read-eval-print loop."
    while True:
        val = eval(parse(raw_input(prompt)))
        if val is not None:
            print(schemestr(val))

def schemestr(exp):
    "Convert a Python object back into a Scheme-readable string."
    if isinstance(exp, List):
        return '(' + ' '.join(map(schemestr, exp)) + ')'
    else:
        return str(exp)


# We will now extend our language with three new special forms, giving us a much
# more nearly-complete Scheme subset.

# We will create a new kind of environment, one which allows for both local and
# global variables. When we look up a variable in such a nested environment, we
# look first at the innermost level, but if we don't find the variable name
# there, we move to the next outer level.

# We see that every procedure has three components: a list of parameter names, a
# body expression, and an environment that tells us what non-local variables are
# accessible from the body.
class Procedure(object):
    "A user-defined Scheme procedure."
    def __init__(self, parms, body, env):
        self.parms, self.body, self.env = parms, body, env
    def __call__(self, *args):
        return eval(self.body, Env(self.parms, args, self.env))

# Environments
# The function eval takes two arguments: an expression, x, that we want to
# evaluate, and an environment, env, in which to evaluate it. An environment is
# a mapping from variable names to their values. By default, eval will use a
# global environent that includes the names for a bunch of standard functions
# (like sqrt and max, and also operators like *). This environment can be
# augmented with user-defined variables, using the expression (define variable
# value). For now, we can implement an environment as a Python dict of
# {variable: value} pairs.
# An environment is a subclass of dict, so it has all the methods that dict has.
# In addition there are two methods: the constructor __init__ builds a new
# environment by taking a list of parameter names and a corresponding list of
# argument values, and creating a new environment that has those {variable:
# value} pairs as the inner part, and also refers to the given outer environment.
# The method find is used to find the right environment for a variable:
# either the inner one or an outer one.
class Env(dict):
    "An environment: a dict of {'var':val} pairs, with an outer Env."
    def __init__(self, parms=(), args=(), outer=None):
        self.update(zip(parms, args))
        self.outer = outer
    def find(self, var):
        "Find the innermost Env where var appears."
        print 'find',var
        return self if (var in self) else self.outer.find(var)
    
# Note: it is customary in Scheme for begin to be a special form that takes a
# sequence of arguments, evaluares each one, and returns the last one
# (discarding the other values, and using them only for their side effects, such
# as printing something). To make things easier for now, we implement begin as a
# function, not a special form.
import math
import operator as op


def standard_env():
    "An environment with some Scheme standard procedures."
    env = Env()
    env.update(vars(math)) # sin, cos, sqrt, pi, ...
    env.update({
        '+':op.add, '-':op.sub, '*':op.mul, '/':op.div,
        # '>':op.gt, '<':op.lt,
        '>=':op.ge, '<=':op.le, '=':op.eq,
        'abs':     abs,
        'append':  op.add,
        'apply':   apply,
        'begin':   lambda *x: x[-1],
        'car':     lambda x: x[0],
        'cdr':     lambda x: x[1:],
        'cons':    lambda x,y: [x] + y,
        'eq?':     op.is_,
        'equal?':  op.eq,
        'length':  len,
        'list':    lambda *x: list(x),
        'list?':   lambda x: isinstance(x,list),
        'map':     map,
        'max':     max,
        'min':     min,
        'not':     op.not_,
        'null?':   lambda x: x == [],
        'number?': lambda x: isinstance(x, Number),
        'procedure?': callable,
        'round':   round,
        'symbol?': lambda x: isinstance(x, Symbol),
    })
    return env

global_env = standard_env()


# To see how these all go together, here is the new definition of eval. Note
# that the clause for variable reference has changed: we now have to call
# env.find(x) to find at what level the variable x exists; then we can fetch the
# value of x from that level. (The clause for define has not changed, because a
# define always adds a new variable to the innermost environment.) There are two
# new clauses: for set!, we find the environment level where the variable exists
# and set it to a new value. With lambda, we create a new procedure object with
# the given parameter list, body, and environment.
#> make this extensible, add ROOM at end

def eval(x, env=global_env):
    "Evaluate an expression in an environment."
    # print x
    if isstr(x):                   # constant string
        # print x,'is a String'
        return x
    elif isinstance(x, Symbol):      # variable reference
        return env.find(x)[x]
    elif not isinstance(x, List):  # constant literal
        return x
    elif x[0] == 'quote':          # quotation
        (_, exp) = x
        return exp
    elif x[0] == 'if':             # conditional
        (_, test, conseq, alt) = x
        exp = (conseq if eval(test, env) else alt)
        return eval(exp, env)
    elif x[0] == 'define':         # definition
        (_, var, exp) = x
        env[var] = eval(exp, env)
    elif x[0] == 'set!':           # assignment
        (_, var, exp) = x
        env.find(var)[var] = eval(exp, env)
    elif x[0] == 'lambda':         # procedure
        (_, parms, body) = x
        return Procedure(parms, body, env)
    elif x[0] in forms:            # other special forms
        form = forms[x[0]]
        return form(x)
    else:                          # procedure call
        proc = eval(x[0], env)
        args = [eval(arg, env) for arg in x[1:]]
        return proc(*args)


# other special forms, keyed on first symbol in form

def form_room(x):
    "ROOM special form handler"
    # python 3 has syntax for this - unpacking optional values
    (_, key, desc, name, exits, objects, unk, bits, bits2) = (x + [None])[:9]
    exits = eval(exits) # parse exits
    s = "(room (key %s) (name %s) (desc %s) (exits %s))" % (key, name, desc, exits)
    print s
    return s

def form_exit(x):
    "EXIT special form handler"
    exits = []
    for token in x[1:]:
        if isinstance(token, List):
            if token[0] == 'CEXIT': # handle CEXIT form
                token = token[2]
        exits.append(token)
    return exits

forms = {
    'EXIT': form_exit,
    'ROOM': form_room,
}




    
# We now have a language with procedures, variables, conditionals (if), and
# sequential execution (the begin procedure). If you are familiar with other
# languages, you might think that a while or for loop would be needed, but
# Scheme manages to do without these just fine. The Scheme report says "Scheme
# demonstrates that a very small number of rules for forming expressions, with
# no restrictions on how they are composed, suffice to form a practical and
# efficient programming language." In Scheme you iterate by defining recursive
# functions.

# Lispy is not very complete compared to the Scheme standard. Some major
# shortcomings:
#     Syntax: Missing comments, quote and quasiquote notation, # literals,
#         the derived expression types (such as cond, derived from if, or let,
#         derived from lambda), and dotted list notation.
#     Semantics: Missing call/cc and tail recursion.
#     Data Types: Missing strings, characters, booleans, ports, vectors,
#         exact/inexact numbers. Python lists are actually closer to Scheme
#         vectors than to the Scheme pairs and lists that we implement with them.
#     Procedures: Missing over 100 primitive procedures: all the ones for the
#         missing data types, plus some others like set-car! and set-cdr!,
#         because we can't implement set-cdr! completely using Python lists.
#     Error recovery: Lispy does not attempt to detect, reasonably report, or
#         recover from errors. Lispy expects the programmer to be perfect.

# --------------------------------------------------------------------------------



if __name__=='__main__':

    # program = "<begin (define r 10) (* pi (* r r))>"
    # program = "(begin (define r 10) (* pi (* r r)))"
    # program = "(begin (define circle-area (lambda (r) (* pi (* r r)))) (circle-area 10))"
    # print tokenize(program)
    # print parse(program)
    # print eval(parse(program))


    # repl()


    # ROOM should be a special form - a macro - don't evaluate its subexpressions
    # lib = """
    # (define ROOM (lambda (key desc name exits objects unk bits unk2) name))
    # (define EXIT (lambda (pairs) pairs))
    # """

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
    """

    program = "(begin " + s + ")"
    print eval(parse(program))
    
