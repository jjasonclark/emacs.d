;; GUI only settings
(when (display-graphic-p)
  ;; change command to meta, and ignore option to use weird norwegian keyboard
  (setq mac-option-modifier 'none)
  (setq mac-command-modifier 'meta)
  ;; mac friendly font
  (set-face-attribute 'default nil :font "Monaco-16")
)

;; make sure path is correct when launched as application
(setenv "PATH" (concat "/usr/local/bin:" (getenv "PATH")))
(push "/usr/local/bin" exec-path)

;; keybinding to toggle full screen mode
(global-set-key (quote [M-f10]) (quote ns-toggle-fullscreen))

;; Move to trash when deleting stuff
(setq delete-by-moving-to-trash t
      trash-directory "~/.Trash/emacs")

;; Ignore .DS_Store files with ido mode
;; (add-to-list 'ido-ignore-files "\\.DS_Store")

;; Enable mouse support
(unless window-system
  (require 'mouse)
  (xterm-mouse-mode t)
  (global-set-key [mouse-4] '(lambda ()
                              (interactive)
                              (scroll-down 1)))
  (global-set-key [mouse-5] '(lambda ()
                              (interactive)
                              (scroll-up 1)))
  (defun track-mouse (e))
  (setq mouse-sel-mode t)
)

;; Prefer utf-8 encoding
(prefer-coding-system 'utf-8)

;; Do not use tabs for indentation
(setq-default indent-tabs-mode nil)

(provide 'init-mac)
