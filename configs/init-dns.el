;; if I am in a bind dir then use dns mode
(add-to-list 'auto-mode-alist '("\\/cache\\/bind\\/.*\\.db$" . dns-mode))

(provide 'init-dns)
