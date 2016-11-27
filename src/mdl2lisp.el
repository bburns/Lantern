
; mdl2lisp
; --------------------------------------------------------------------------------
; convert muddle code to more readable lisp


; in a mdl/mud file, do
; (mdl-convert)
; (emacs-lisp-mode)


;>> also...

; remove \
; (occur "\\\\")
; (replace-regexp "\\\\" "")


;>> and for zork map...

; remove #nexit
; might mean something like (exit "north" "nhous" "east" (nexit "The door is locked, and there is evidently no key."))
; (occur "#nexit ")
; (replace-string "#nexit " "")



;;; lib

(defalias 'char-at 'char-after)

(defun find-not-after (str char)
  "Find the next occurrence of STR, if not preceeded by CHAR."
  (setq done nil)
  (while (and (< (point) (point-max)) (not done))
    (find-string str nil :end)
    (if (/= (char-at (- (point) 2)) char)
        (setq done t))))
;. expanded version in igor.el


(defun find-next-quote () (interactive)
  "Find next quote not preceded by a backslash"
  (find-not-after "\"" ?\\))

; (global-set-key (kbd "C-.") 'find-next-quote)

; "hello!"
; "then he said \"excuse me\"."
; ((tell ""))))
; <PRINC !\">
; <PRINTSTRING .A .OUTCHAN .AL "bye">


;;; mdl


(defun mdl-convert () (interactive)
  ; (emacs-lisp-mode)
  (mdl-convert-case)
  (mdl-convert-brackets)
  (mdl-convert-comments))


(defun mdl-convert-case () (interactive)
  "Convert all text not inside a string to lowercase."
  (save-excursion
    (goto-char (point-min))
    (while (< (point) (buffer-end 1))
     (setq start (point))
     (find-next-quote)
     (downcase-region start (point))
     (find-next-quote))))


(defun mdl-convert-brackets () (interactive)
  "Convert mdl brackets to parentheses."
  (save-excursion
    (goto-char (point-min)) (replace-string  "<"  "(")
    (goto-char (point-min)) (replace-string  ">"  ")")
    ))

;. also lines with a string on them starting at col 0 should get ;;; prefix
; but there are special cases to avoid
(defun mdl-convert-comments () (interactive)
  "Convert single comments to triple comments, for headers."
  (save-excursion
    (goto-char (point-min))  (replace-regexp  "^;\""  ";;; \"")
    (goto-char (point-min))  (replace-regexp  "^; \""  ";;; \"")
    (goto-char (point-min))  (replace-regexp  "^\""  ";;; \"")
    ))


