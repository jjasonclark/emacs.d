
;; Set my linux box's default font to Monospace
(set-default-font "Monospace-14")

;; Make sure new frames also open up in Monospace
(set-face-attribute 'default nil :font "Monospace-14")

(if (<= (length (frame-list)) 1)
    (make-frame))

(defun insert-xsel ()
  "Insert what ever is in the x-windows selection"
   (interactive)
   (insert (shell-command-to-string "xsel -o")))

;; Try to remove this function because elpa vs ubuntu are fighting
;; and every magit change is showing me a message about it
(defun inf-ruby-keys ())
