
;;; This will log all interactions.  Fun for tracking your usage style

(require 'interaction-log)
(interaction-log-mode +1)

;;;
;;; You probably will want to have a hotkey for showing the log
;;; buffer, so also add something like
;;;
(global-set-key [f9] (lambda () (interactive) (display-buffer
                                          ilog-buffer-name)))

(provide 'init-iteraction-log)
