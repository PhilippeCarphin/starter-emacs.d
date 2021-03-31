(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/") t)
(add-to-list 'package-archives '("org"   . "http://orgmode.org/elpa/") t)
(add-to-list 'package-archives '("gnu"   . "http://elpa.gnu.org/packages/") t)
(package-initialize)

(unless (package-installed-p 'use-package)
    (package-refresh-contents)
    (package-install 'use-package))
(eval-when-compile (require 'use-package))

;; (tool-bar-mode -1)
(scroll-bar-mode -1)

(setq scroll-step 1)
(setq-default scroll-margin 10)

(setq-default cursor-type '(bar . 3))
(set-cursor-color "light grey")
(custom-set-faces '(cursor ((t (:background "SlateGray3")))))

(blink-cursor-mode)

(global-visual-line-mode 1)

(setq visual-line-fringe-indicators '(left-curly-arrow right-curly-arrow))

(load-theme 'misterioso)

(custom-set-variables '(vc-follow-symlinks t))

(global-set-key (kbd "C-x C-c") 'save-buffers-kill-emacs)

(use-package undo-tree
  :ensure t
  :config (global-undo-tree-mode))

(use-package helm :ensure t
  :config
  (require 'helm-config)
  (helm-mode)
  :bind (("M-x" . helm-M-x)
	 ("C-x C-f" . helm-find-files)
	 ("C-x C-r" . helm-recentf)
	 ("C-h C-i" . helm-info)
	 ("C-x C-b" . helm-buffers-list)
	 ("C-c g" . helm-grep-do-git-grep)))

(use-package which-key
  :ensure t
  :delight
  :init
  (setq which-key-separator " ")
  (setq which-key-prefix-prefix "+")
  (setq which-key-idle-delay 0.3)
  :config
  (which-key-mode))

(defun configure-ellipsis () (set-display-table-slot standard-display-table
  'selective-display (string-to-vector " ⤵")))

(add-hook 'org-mode-hook 'configure-ellipsis)

(setq org-link-descriptive nil)
;; Note (org-mode-restart) is required for this to take effect

(use-package org-bullets
  :ensure t
  :hook (org-mode . org-bullets-mode))

(setq org-startup-with-inline-images t)
(setq org-image-actual-width 100)

(custom-set-variables '(org-startup-folded t))

(use-package ox-gfm :ensure t)
(use-package ox-rst :ensure t)
(use-package ox-twbs :ensure t)
(use-package ox-reveal :ensure t
  :config (setq org-reveal-root "https://cdn.jsdelivr.net/npm/reveal.js"))
(use-package htmlize :ensure t)

(defun org-insert-subheading-respect-content (arg)
  "Insert a new subheading and demote it.
Works for outline headings and for plain lists alike."
  (interactive "P")
  (org-insert-heading-respect-content arg)
  (cond ((org-at-heading-p) (org-do-demote))
        ((org-at-item-p) (org-indent-item))))

(define-key org-mode-map (kbd "C-S-<return>") 'org-insert-subheading-respect-content)
(define-key org-mode-map (kbd "M-S-<return>") 'org-insert-subheading)

(cond ((string-equal system-type "windows-nt")
       (progn (setq org-agenda-dir "c:\\Users\\phil1\\Documents\\gtd")))
      ((string-equal system-type "darwin")
       (progn (setq org-agenda-dir "~/Documents/gtd/")))
      ((string-equal system-type "gnu/linux")
       (progn (setq org-agenda-dir "~/Documents/gtd/"))))

(setq org-agenda-files (list org-agenda-dir))

(setq org-refile-targets '((nil :maxlevel . 3) (org-agenda-files :maxlevel . 3)))
(setq org-outline-path-complete-in-steps nil)
(setq org-refile-use-outline-path 'file)

(setq org-agenda-prefix-format  '((agenda . "%-12t%-12s")))

(org-babel-do-load-languages 'org-babel-load-languages
			     '((shell . t)
			       (python . t)))

(setq org-confirm-babel-evaluate nil)

(defun ek/babel-ansi ()
  (when-let ((beg (org-babel-where-is-src-block-result nil nil)))
    (save-excursion
      (goto-char beg)
      (when (looking-at org-babel-result-regexp)
        (let ((end (org-babel-result-end))
              (ansi-color-context-region nil))
          (ansi-color-apply-on-region beg end))))))
(add-hook 'org-babel-after-execute-hook 'ek/babel-ansi)

(define-prefix-command 'leader-key)

(global-set-key (kbd "M-m") 'leader-key)

(define-key leader-key (kbd "SPC") 'helm-M-x)
(define-key leader-key (kbd "M-m") 'helm-M-x)

(defun about-this-keymap () (interactive)
(org-open-link-from-string "[[file:~/.emacs.d/config.org::Leader Keymap]]"))

(define-prefix-command 'emacs-movement)
(define-key leader-key (kbd "m") 'emacs-movement)
(define-key emacs-movement (kbd "C-f") 'forward-char)
(define-key emacs-movement (kbd "C-b") 'backward-char)
(define-key emacs-movement (kbd "C-p") 'previous-line)
(define-key emacs-movement (kbd "C-n") 'next-line)
(define-key emacs-movement (kbd "C-v") 'scroll-up-command)
(define-key emacs-movement (kbd "M-v") 'scroll-down-command)
(define-key emacs-movement (kbd "C-s") 'isearch-forward)
(define-key emacs-movement (kbd "C-r") 'isearch-backward)

(defun open-emacs-config-file () (interactive) (find-file "~/.emacs.d/config.org"))
(define-prefix-command 'files)
(define-key leader-key (kbd "f") 'files)

(define-key files (kbd "c") 'open-emacs-config-file)
(define-key files (kbd "f") 'helm-find-files)
(define-key files (kbd "r") 'helm-recentf)
(define-key files (kbd "s") 'save-buffer)

(define-prefix-command 'buffers)
(define-key leader-key (kbd "b") 'buffers)
(define-key buffers (kbd "b") 'helm-buffers-list)
(define-key buffers (kbd "k") 'kill-buffer)
(define-key buffers (kbd "K") 'maybe-kill-all-buffers)

(define-key leader-key (kbd "q") 'save-buffers-kill-emacs)

(define-prefix-command 'help)
(define-key leader-key (kbd "h") 'help)
(define-key help (kbd "a") 'about-this-keymap)
(define-key help (kbd "C-i") 'helm-info)
(define-key help (kbd "o") 'describe-symbol)
(define-key help (kbd "f") 'describe-function)
(define-key help (kbd "k") 'describe-key)

(define-prefix-command 'orgmode)

(define-prefix-command '__orgmode__C-c__)
(define-key orgmode (kbd "C-c") '__orgmode__C-c__)
(define-key __orgmode__C-c__ (kbd "C-,") 'org-insert-structure-template)
(define-key __orgmode__C-c__ (kbd "C-c") 'org-ctrl-c-ctrl-c)
(define-key __orgmode__C-c__ (kbd "C-w") 'org-refile)
(define-key __orgmode__C-c__ (kbd "C-x C-c") 'org-columns)
(define-key __orgmode__C-c__ (kbd "'") 'org-edit-special)
(define-key __orgmode__C-c__ (kbd ".") 'org-time-stamp)
(define-key __orgmode__C-c__ (kbd "C-s") 'org-schedule)
(define-key __orgmode__C-c__ (kbd "C-d") 'org-deadline)

(define-key leader-key (kbd "o") 'orgmode)
(define-key orgmode (kbd "a") 'org-agenda)
(define-key orgmode (kbd "v") 'org-tags-view)
(define-key orgmode (kbd "C-c /") 'org-match-sparse-tree)
(define-key orgmode (kbd "<M-S-left>") 'org-promote-subtree)
(define-key orgmode (kbd "<M-S-right>") 'org-demote-subtree)
(define-key orgmode (kbd "<M-up>") 'org-demote-subtree)
(define-key orgmode (kbd "n") 'org-narrow-to-subtree)
(define-key orgmode (kbd "c") 'org-columns)

(define-prefix-command 'org-insert)
(define-key orgmode (kbd "i") 'org-insert)
(define-key 'org-insert (kbd "C-<return>") 'org-insert-heading)
(define-key 'org-insert (kbd "M-<return>") 'org-insert-heading-respect-content)
(define-key 'org-insert (kbd "C-S-<return>") 'org-insert-subheading)
(define-key 'org-insert (kbd "M-S-<return>") 'org-insert-subheading-respect-content)

(define-prefix-command 'org-subtree)
(define-key orgmode (kbd "s") 'org-subtree)
(define-key 'org-subtree (kbd "h") 'org-promote-subtree)
(define-key 'org-subtree (kbd "l") 'org-demote-subtree)
(define-key 'org-subtree (kbd "k") 'org-move-subtree-up)
(define-key 'org-subtree (kbd "j") 'org-move-subtree-down)

(define-prefix-command 'org-present-map)
(define-key leader-key (kbd "p") 'org-present-map)
(define-key org-present-map (kbd "P") 'org-present)
(define-key org-present-map (kbd "n") 'org-present-next)
(define-key org-present-map (kbd "p") 'org-present-prev)
(define-key org-present-map (kbd "b") 'org-present-big)
(define-key org-present-map (kbd "s") 'org-present-small)
(define-key org-present-map (kbd "q") 'org-present-quit)

(define-prefix-command 'gtd)
(define-key leader-key (kbd "g") 'gtd)
(define-key gtd (kbd "c") 'org-capture)
(define-key gtd (kbd "i") 'gtd-open-in-tray)
(define-key gtd (kbd "p") 'gtd-open-project-list)
(define-key gtd (kbd "w p") 'gtd-open-work-project-list)
(define-key gtd (kbd "r") 'gtd-open-reference)
(define-key gtd (kbd "w r") 'gtd-open-work-project-list)
(define-key gtd (kbd "n") 'gtd-open-next-actions)

(define-prefix-command 'org-agenda-keys)
(define-key leader-key (kbd "a") 'org-agenda-keys)
(define-key org-agenda-keys (kbd "a") 'org-agenda)
(define-key org-agenda-keys (kbd "g") 'gtd-agenda-view)
(define-key org-agenda-keys (kbd "c") 'gtd-review-view)
(define-key org-agenda-keys (kbd "n") 'gtd-next-action-sparse-tree)
(define-key org-agenda-keys (kbd "w v") 'work-agenda-view)
(define-key org-agenda-keys (kbd "w f") 'for000-agenda-view)
(define-key org-agenda-keys (kbd "w p") 'publish-work-agenda-views)
(define-key org-agenda-keys (kbd "w p") 'phc001-agenda-view)

(defun ox-reveal () (interactive) (org-reveal-export-to-html-and-browse nil t))
(defun ox-twbs () (interactive) (browse-url (org-twbs-export-to-html nil t)))
(defun ox-twbs-all () (interactive) (browse-url (org-twbs-export-to-html nil nil)))
(defun ox-html () (interactive) (browse-url (org-html-export-to-html nil t)))
(defun ox-html-all () (interactive) (browse-url (org-html-export-to-html nil nil)))
(defun ox-rst () (interactive) (org-open-file (org-rst-export-to-rst nil t)))
(defun ox-rst-all () (interactive) (org-open-file (org-rst-export-to-rst nil nil)))
(easy-menu-define present-menu org-mode-map
  "Menu for word navigation commands."
  '("Present"
    ["Present Right Now (C-c C-e R B)" org-reveal-export-to-html-and-browse]
    ["Present Subtree Right Now (C-c C-e C-s R B)" ox-reveal]
    ["View Twitter Bootstrap HTML Right now (C-c C-e C-s w o)" ox-twbs]
    ["View Twitter Bootstrap HTML all Right now (C-c C-e w o)" ox-twbs-all]
    ["View RST Right Now (C-c C-e C-s r R)" ox-rst]
    ["View RST All Right Now (C-c C-e r R)" ox-rst-all]
    ["View straight-pipe HTML Right Now (C-c C-e C-s h o)" ox-html]
    ["View straight-pipe HTML All Right Now (C-c C-e h o)" ox-html-all]))
