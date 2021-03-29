;;; Load the config
(org-babel-load-file (concat user-emacs-directory "config.org"))
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes '(modus-vivendi))
 '(custom-safe-themes
   '("c7f364aeea0458b6368815558cbf1f54bbdcc1dde8a14b5260eb82b76c0ffc7b" default))
 '(indent-tabs-mode nil)
 '(magit-save-repository-buffers 'dontask)
 '(org-show-context-detail '((occur-tree . ancestors) (default . local)))
 '(org-startup-folded t)
 '(package-selected-packages
   '(vterm aggressive-indent highlight-defined paredit modus-themes command-log-mode keyfreq elfeed yasnippet-snippets org-present org-bullets undo-tree which-key use-package ox-twbs ox-rst ox-reveal ox-gfm magit htmlize helm evil company))
 '(vc-follow-symlinks nil)
 '(visual-line-fringe-indicators '(left-curly-arrow right-curly-arrow)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:height 200))))
 '(cursor ((t (:background "SlateGray3")))))
