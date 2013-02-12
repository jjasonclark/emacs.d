;; Marks your files if they have merge conflicts

(autoload 'smerge-mode "smerge-mode" nil t)

;; turn on automatically
(defun sm-try-smerge ()
  (save-excursion
    (goto-char (point-min))
    (when (re-search-forward "^<<<<<<< " nil t)
      (smerge-mode 1))))
(add-hook 'find-file-hook 'sm-try-smerge t)

(provide 'init-smerge)
