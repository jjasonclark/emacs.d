(add-to-list 'load-path
             "/home/zblut/emacs_scripts/nagios-mode/")

(autoload 'nagios-mode "nagios-mode" nil t)

(setq auto-mode-alist
      (append (list '("\\.cfg$" . nagios-mode))
              auto-mode-alist))

(provide 'init-nagios)
