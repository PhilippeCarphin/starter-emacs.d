(use-package evil
  :ensure t
  :init (setq evil-want-C-i-jump nil)
	(setq evil-want-integration t)
	(setq evil-want-C-u-scroll t)
  :config (evil-mode 1)
	(define-key evil-normal-state-map (kbd "SPC") 'leader-key)
	  (define-key evil-insert-state-map (kbd "C-g") 'evil-normal-state)
	  (evil-global-set-key 'motion "j" 'evil-next-visual-line)
	  (evil-global-set-key 'motion "k" 'evil-previous-visual-line)
	  (define-key evil-insert-state-map (kbd "C-w") evil-window-map)
	  (define-key evil-insert-state-map (kbd "C-w /") 'split-window-right)
	  (define-key evil-insert-state-map (kbd "C-w -") 'split-window-below)
	  (define-key evil-normal-state-map (kbd "C-r") 'undo-tree-redo)
	  (define-key evil-normal-state-map (kbd "u") 'undo-tree-undo)
	  (global-set-key (kbd "M-u") 'universal-argument)
	  (setq evil-default-state 'emacs)
	  (setq evil-insert-state-modes nil)
	  (setq evil-motion-state-modes nil)
	  (setq evil-normal-state-modes '(fundamental-mode
					  conf-mode
					  prog-mode
					  text-mode
					  dired))
	  (setq evil-insert-state-cursor '((bar . 2) "lime green")
	      evil-normal-state-cursor '(box "yellow"))
	  (add-hook 'with-editor-mode-hook 'evil-insert-state))

(add-hook 'evil-insert-state-exit-hook (lambda () (blink-cursor-mode 0)))
(add-hook 'evil-insert-state-entry-hook (lambda () (blink-cursor-mode 1)))

(blink-cursor-mode 0)
