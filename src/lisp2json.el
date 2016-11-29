
; lisp2json
;--------------------------------------------------------------------------------
; parse zork muddle code, get list of rooms and connections.
; save as json graph and/or graphviz file. 

; this file will be deleted!


; run this file to parse a room mdl/lisp file, then go to the end
; and run a fn to output to json or graphviz. 

;.. add mdl2lisp.el

;. use prefix for namespace? 'simple namespace
;. also handle n for north etc

; (require 'modern-lib) ; for ? 

(setq zork-filename nil) ; for small infile dataset
; (setq zork-filename "zork.lisp")
; (setq zork-filename "zork_small.lisp")


;;; library

;. obsolete
; print to buffer instead of console
; is this just insert?
(defun pr (s) (println s (current-buffer)))


;;; rooms

; get list of rooms


(if zork-filename
    
  ; this sets zork-rooms
  ;. better way? eg (setq zork-rooms (readfile foo))?
  (load zork-filename)

  ; else a small test set
  (setq zork-rooms '(
              
    (room "WHOUS" "This is an open field west of a white house, with a boarded front door."
       "West of House"
       (exit "NORTH" "NHOUS" "SOUTH" "SHOUS" "WEST" "FORE1" "EAST" "The door is locked, and there is no key.")
       ((get-obj "FDOOR") (get-obj "MAILB") (get-obj "MAT"))
       () (+ ,rlandbit ,rlightbit ,rnwallbit ,rsacredbit) (rglobal ,housebit))
  
    (room "NHOUS" "You are facing the north side of a white house.  There is no door here, and barred windows."
       "North of House"
       (exit "WEST" "WHOUS" "EAST" "EHOUS" "NORTH" "FORE3" "SOUTH" "The windows are all barred.")
       () () (+ ,rlandbit ,rlightbit ,rnwallbit ,rsacredbit) (rglobal (+ ,dwindow ,housebit)))
    )))


; (length rooms)
;=> 149


;;; room functions

(defun zork-room-key (room) (nth 1 room))
(defun zork-room-desc (room) (nth 2 room))
; (defun zork-room-name (room) (nth 3 room))
(defun zork-room-name (room) (let ((name (nth 3 room))) (if (consp name) (symbol-name (nth 1 name)) name))) ; handle names like ,forest
(defun zork-room-exits (room) (rest (nth 4 room)))

; for testing
(setq zork-room (first zork-rooms))

; (zork-room-key zork-room)
; (zork-room-name zork-room)
; (zork-room-desc zork-room)
; (zork-room-exits zork-room)

(setq zork-exits (zork-room-exits zork-room))

; (plist-keys zork-exits)
; (lax-plist-get zork-exits "NORTH")
; (plist-get-equal zork-exits "NORTH")
; (setq zork-exitdirs (plist-keys zork-exits))
; (setq zork-exitdirs (mapcar 'downcase zork-exitdirs))


(defun zork-get-room (key rooms)
  "Find a room in a list of rooms, given its key."
  (first (filter (lambda (room) (equal (zork-room-key room) key)) rooms)))

; (zork-get-room "foo" zork-rooms)
; (zork-get-room "whous" zork-rooms)
; (zork-get-room "WHOUS" zork-rooms)
; (zork-get-room "KITCH" zork-rooms)

; (setq zork-bad-room (zork-get-room "FORE1" zork-rooms))
; zork-bad-room
; these are ,forest etc in the mdl code
; (room "FORE1" (\, stfore) (\, forest) (exit "NORTH" "FORE1" "EAST" "FORE3" "SOUTH" "FORE2" "WEST" "FORE1") nil forest-room (+ (\, rlandbit) (\, rlightbit) (\, rnwallbit) (\, rsacredbit)) (rglobal (+ (\, treebit) (\, birdbit) (\, housebit))))

; (zork-room-name zork-room)
; (zork-room-name zork-bad-room)




;;; filter rooms


; remove non-room forms, eg (psetg forest "Forest")
; just checks if it has an exit keyvalue
(setq zork-rooms (filter (lambda (room) (assq 'exit room)) zork-rooms))



; remove/fix non-room links, eg
; (exit "NORTH" "NHOUS"
; "EAST" "The door is locked, and there is evidently no key."
; "UP" (door "DOOR" "LROOM" "CELLA")
; "SOUTH" (cexit "CYCLOPS-FLAG" "TREAS" "The cyclops doesn't look like he'll let you past."))

;. awful lot of work. should have some data manipulation fns. like update queries
; eg setting an element in place instead of building a new list. though this is more fnal. 


; if consp
;   if car cexit
;   if car door
; if !consp and len5
;   add it

;. maybe put these into small fns, to make it easier to read
; doors
; (let ((dest '(door "DOOR" "LROOM" "CELLA")) (room-name "CELLA"))
; (when (and (consp dest) (eq (car dest) 'door))
  ; (setq dest (cddr dest))
  ; (setq dest (if (equal (car dest) room-name) (cadr dest) (car dest)))))

(defun filter-exits (exits room-name)
  (let ((newexits ()))
    (plist-foreach (dir dest exits)
                   ; cexits - conditional exits, eg
                   ; (cexit "CYCLOPS-FLAG" "TREAS" "The cyclops doesn't look like he'll let you past.")
                   (if (and (consp dest) (eq (car dest) 'cexit))
                       (setq dest (nth 2 dest))) ; TREAS
                   ; doors, eg
                   ; (door "DOOR" "LROOM" "CELLA")
                   ; order is same on either side of door, so have to check room name
                   (when (and (consp dest) (eq (car dest) 'door))
                     (setq dest (cddr dest))
                     (setq dest (if (equal (car dest) room-name) (cadr dest) (car dest))))
                   ; remove long strings (ie not room keys)
                   (if (and (not (consp dest)) (<= (length dest) 5))
                       (setq newexits (cons dest (cons dir newexits)))))
    (nreverse newexits)))


; (setq zork-test-exits
;       '("NORTH" "NHOUS"
;        "EAST" "The door is locked, and there is no key."
;        "WEST" (cexit "MAGIC-FLAG" "BLROO" "The door is nailed shut.")
;        "DOWN" (door "DOOR" "LROOM" "CELLA")))

; (filter-exits zork-test-exits "LROOM")
; ("NORTH" "NHOUS" "DOWN" "CELLA" "WEST" "BLROO")

; (filter-exits zork-test-exits "CELLAR")
; ("NORTH" "NHOUS" "DOWN" "LROOM" "WEST" "BLROO")


;. also do this from zork-room-json
    ; (if (consp name) (setq name (nth 1 name))) ; avoid things like (\, "forest")
    ; (if (consp desc) (setq desc (nth 1 desc))) ; avoid things like (\, "forest")
; (psetg notree "There is no tree here suitable for climbing.")
; (exit "UP" ,notreeo



(defun filter-rooms (rooms)
  (let (newrooms room-name)
    (foreach (room rooms)
      (setq room-name (zork-room-name room))
      (setq room (mapcar
                  (lambda (elem)
                    (if (and (consp elem) (eq (car elem) 'exit))
                        (cons 'exit (filter-exits (rest elem) room-name))
                      elem))
                  room))
      (setq newrooms (cons room newrooms)))
    (nreverse newrooms)))

(setq zork-rooms (filter-rooms zork-rooms))

; zork-rooms


;;; links / exits

(defun zork-get-links (rooms)
  "For a list of rooms, get a list of triples of the form (room direction destination)"
  (let ((links ()))
    (foreach (room rooms)
      (let ((exits (zork-room-exits room)) ; ("EAST" "EHOUS"...)
            (source (zork-room-key room))) ; "SHOUS"
        (plist-foreach (direction target exits) ; dir "EAST" target "EHOUS"
                       (if (consp target) (setq target "closet")) ; avoid weird targets like (\, kitchen)
                       (setq links (cons (list source direction target) links))))) ; ("SHOUS" "EAST" "EHOUS")
    (reverse links)))

(setq zork-links (zork-get-links zork-rooms)) ; (("WHOUS" "WEST" "FORE1") ("NHOUS" "WEST" "WHOUS")... )
(setq zork-link (first zork-links)) ; ("WHOUS" "NORTH" "NHOUS")


; (describe-variable 'links "links")

; ("KITCH" "WEST" "LROOM")
; ("KITCH" "EAST" (\, kitchen-window))
; ("KITCH" "DOWN" "Only Santa Claus climbs down chimneys.")
; ("LROOM" "WEST" (cexit "MAGIC-FLAG" "BLROO" "The door is nailed shut."))

; {"source":"KITCH", "dir":"WEST", "target":"LROOM"}, 
; {"source":"KITCH", "dir":"EAST", "target":[",", "kitchen-window"]}, 
; {"source":"KITCH", "dir":"DOWN", "target":"Only Santa Claus climbs down chimneys."}, 
; {"source":"LROOM", "dir":"WEST", "target":["cexit", "MAGIC-FLAG", "BLROO", "The door is nailed shut."]}, 


;;; repl

; repl to explore the graph

(defun zork-repl () (interactive)
  (switch-to-buffer-other-window (get-buffer-create "zork repl"))
  (pr "")
  (pr "")
  (pr "Welcome to Zork...")
  (pr "----------------------------------")
  (let (key newkey done room name desc exits input)
    ; (setq key "whous")
    (setq key "WHOUS")
    (setq done nil)
    (while (not done)

      ; get room properties
      (setq room (zork-get-room key rooms))
      (setq name (zork-room-name room))
      (setq desc (zork-room-desc room))
      (setq exits (zork-room-exits room))
      
      (setq exitdirs (plist-keys exits))
      (setq exitdirs (mapcar 'downcase exitdirs))

      ; print room
      (cursor-file-end t)
      (pr "")
      (if room (progn
                 (pr name)
                 (pr desc)
                 (pr exitdirs)
                 )
        (pr "Off the map..."))

      ; get input
      (setq input (read-string "> "))
      
      ; (setq newkey (lax-plist-get exits input))
      (setq newkey (lax-plist-get exits (upcase input)))
      (if newkey (setq key newkey))
      (if (equal input "q") (setq done t)))))

; (zork-repl)

; (setq zork-exitdirs (plist-keys exits))
; (plist-get-equal exits "SOUTH")


;;; json
;;;; plan

; what we need
; var nodes = [{key:'whous',name:'West of House',desc:'lijlij',exits:{'south':'shous'...}]

; json.el:
; (json-encode-plist '(hi there bye here))
; (json-encode-string "hi\n")


; get list of triples from rooms and convert to json or graphviz

; (room (exit "NORTH" "NHOUS" "SOUTH" "SHOUS" "WEST" "FORE1" "EAST" "The door is locked, and there is evidently no key."))

; (("NHOUS" "EAST" "PORCH")
; ("NHOUS" "SOUTH" "SHOUS")
; ("WHOUS" "WEST" "FORE1")
; ("WHOUS" "NORTH" "NHOUS"))

; [{"source":"NHOUS", "dir":"EAST", "target":"PORCH"}
; ...]


; (exit "EAST" ,kitchen-window "WEST" "LROOM" "EXIT" ,kitchen-window "UP" "ATTIC" "DOWN" "Only Santa Claus climbs down chimneys.")
; (("KITCH" "EAST" ,kitchen-window)
; ("KITCH" "WEST" "LROOM")
; ("KITCH" "DOWN" "Only Santa Claus climbs down chimneys."))

;;;; nodes / rooms

(defun zork-room-json (room)
  "Convert room object to json."
  ; eg (room "WHOUS" "This is an open field..." "West of House" (exits "NORTH" "NHOUS"...)) =>
  ; {"key":"WHOUS", "name":"West of House", "desc":"This is an open field...", "exits":{"NORTH":"NHOUS",...}}
  (let ((cr "\n") (indent "  ")
        (key (zork-room-key room))
        (name (zork-room-name room))
        (desc (zork-room-desc room)))
    (if (consp name) (setq name (nth 1 name))) ; avoid things like (\, "forest")
    (if (consp desc) (setq desc (nth 1 desc))) ; avoid things like (\, "forest")
    (concat "{" cr
      indent (json-encode "key") ": " (json-encode key) ", " cr
      indent (json-encode "name") ": " (json-encode name) ", " cr
      indent (json-encode "desc") ": " (json-encode desc) cr
      ; indent (json-encode "desc") ": " (json-encode (room-desc room)) ", " cr
      ; indent (json-encode "exits") ": " (json-encode-plist (room-exits room)) cr
      "}")))


; (key 'whous' name 'west of house' desc 'lijlij' exits (north 'nouse'...)) 
; ((key 'whouse') (name 'west of house') (desc 'lilij') (exits (north 'lijlij' east 'oioij'...)))

; (zork-room-json room)
; (mapconcat 'zork-room-json rooms ",")
; (concat "[" (mapconcat 'zork-room-json rooms ", \n") "]")



;;;; convert a link to json

(defun zork-link-json (link)
  (let ((cr "") (indent ""))
    (concat "{" cr
          indent "\"source\":" (json-encode (nth 0 link)) ", " cr
          indent "\"dir\":" (json-encode (nth 1 link)) ", " cr
          indent "\"target\":" (json-encode (nth 2 link)) cr
          "}")))

; link ; ("WHOUS" "NORTH" "NHOUS")
; (zork-link-json link) ; "{\"source\":\"WHOUS\", \"dir\":\"NORTH\"\"target\":\"NHOUS\", }"


;;;; print rooms to a new buffer as json

(defun zork-json (rooms links) 
  (output-to "zork-json"
             (println "{")
             (println "\"rooms\": [")
             (println (mapconcat 'zork-room-json rooms ", \n"))
             (println "],")
             (println "\"exits\": [")
             (println (mapconcat 'zork-link-json links ", \n"))
             (println "]")
             (println "}")
             ))

; (zork-json zork-rooms zork-links)
; save as zork_rooms.json


;;; graphviz

; what we need

; digraph zork {
;   whous -> nhous;
;   whous -> shous;
;   whous -> fore1;
;   # whous -> "the door is locked";
;   nhous -> whous;
;   nhous -> ehous;
;   nhous -> fore3;
;   # nhous -> "the windows"
; }


; convert a link to graphviz
(defun zork-link-graphviz (link)
  (let ((cr "") (indent ""))
    (concat indent (json-encode (nth 0 link)) " -> " (json-encode (nth 2 link)))))
; link ; ("WHOUS" "NORTH" "NHOUS")
; (zork-link-graphviz zork-link)


; WHOUS [label="West of House"];
(let ((rooms zork-rooms))
  (mapconcat (lambda (room) (concat (zork-room-key room) " [label=\"" (zork-room-name room) "\"];")) rooms "\n"))

; print map as graphviz
; doesn't need zork-rooms
(defun zork-graphviz (rooms links) 
  (output-to "zork-graphviz"
             (println "digraph zork {")
             (println (mapconcat (lambda (room) (concat (zork-room-key room) " [label=\"" (zork-room-name room) "\"];")) rooms "\n"))
             (println (mapconcat 'zork-link-graphviz links "; \n"))
             (println "}")
             ))


;;; final output

; can output to json or graphviz here


; (capture (println zork-rooms))
(capture (println zork-rooms))
; (capture (princ zork-rooms))

; (output-to "zorkmap" (princ zork-rooms))
; (output-to "zorkmap" (princ zork-links))


; (zork-json zork-rooms zork-links)
; save as zork.json


; add
; maclisp [label="MacLisp"];

; (zork-graphviz zork-rooms zork-links)
; save as zork.gv

