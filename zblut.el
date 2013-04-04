
;; Set my linux box's default font to Monospace
(set-default-font "Monospace-14")

;; Make sure new frames also open up in Monospace
(set-face-attribute 'default nil :font "Monospace-14")

(if (<= (length (frame-list)) 1)
    (make-frame))
