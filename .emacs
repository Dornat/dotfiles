;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.

(require 'package)
(setq package-enable-at-startup nil)
(add-to-list 'package-archives
			 '("melpa" . "https://melpa.org/packages/"))
(package-initialize)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(unless (package-installed-p 'solarized-theme)
  (package-refresh-contents)
  (package-install 'solarized-theme))

(use-package which-key
  :ensure t
  :init
  (which-key-mode))

(use-package beacon
  :ensure t
  :init
  (beacon-mode 1))


;; IDO

;; enable ido mode
(setq ido-enable-flex-matching nil)
(setq ido-create-new-buffer 'always)
(setq ido-everywhere t)
(ido-mode 1)

;; ido-vertical
(use-package ido-vertical-mode
  :ensure t
  :init
  (ido-vertical-mode 1))
(setq ido-vertical-define-keys 'C-n-and-C-p-only)

;; smex
(use-package smex
  :ensure t
  :init (smex-initialize)
  :bind
  ("M-x" . smex))

;; avy
(use-package avy
  :ensure t
  :bind
  ("M-s" . avy-goto-char))

;; switch-window
(use-package switch-window
  :ensure t
  :config
  (setq switch-window-input-style 'minibuffer)
  (setq switch-window-increase 4)
  (setq switch-window-threshold 2)
  (setq switch-window-shortcut-style 'qwerty)
  (setq switch-window-qwerty-shortcuts
		'("a" "s" "d" "f" "g" "h" "j" "k" "l"))
  :bind
  ("C-x o" . switch-window))

;; hungry delete
(use-package hungry-delete
  :ensure t
  :config (global-hungry-delete-mode))

;; sudo edit
(use-package sudo-edit
  :ensure t
  :bind ("C-c s e" . sudo-edit))

;; rainbow delimiters
 (use-package rainbow-delimiters
  :ensure t
  :init (rainbow-delimiters-mode 1))


(use-package dashboard
  :ensure t
  :config
  (dashboard-setup-startup-hook)
  (setq dashboard-items '((recents . 10))))

(use-package auto-complete
  :ensure t
  :config
  (global-auto-complete-mode t))





;; modeline setup
(use-package smart-mode-line
  :ensure t)

(setq sml/no-confirm-load-theme t)
(sml/setup)
(setq column-number-mode t)

;; show time on modeline
(display-time-mode 1)



;; kill whole word
(defun kill-whole-word ()
  (interactive)
  (backward-word)
  (kill-word 1))
(global-set-key (kbd "C-c w w") 'kill-whole-word)


;; enable ibuffer
(global-set-key (kbd "C-x C-b") 'ibuffer)



(put 'upcase-region 'disabled nil)

;; (setq-default tab-width 4)

(tool-bar-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)

(setq inhibit-startup-message t)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes (quote (solarized-dark)))
 '(custom-safe-themes
   (quote
	("a27c00821ccfd5a78b01e4f35dc056706dd9ede09a8b90c6955ae6a390eb1c1e" "8aebf25556399b58091e533e455dd50a6a9cba958cc4ebb0aab175863c25b9a4" default)))
 '(package-selected-packages
   (quote
	(color-theme smart-mode-line-powerline-theme smart-mode-line spaceline auto-complete dashboard rainbow-delimiters sudo-edit hungry-delete switch-window avy smex ido-vertical-mode beacon linum-relative solarized-theme which-key use-package))))

;; set a default font
(when (member "Monaco" (font-family-list))
  (set-face-attribute 'default nil :font "Monaco-10:spacing=100"))

;; cool C-Tab autocompletion from buffer
(global-set-key (kbd "C-<tab>") 'dabbrev-expand)
(define-key minibuffer-local-map (kbd "C-<tab>") 'dabbrev-expand)

(local-set-key (kbd "TAB") 'self-insert-command)
(setq c-default-style "linux"
          c-basic-offset 4)
(setq-default c-basic-offset 4
			  tab-width 4
			  indent-tabs-mode t)

;; relative line number defined globally
(require 'linum-relative)
;;(global-linum-mode 1)
(linum-relative-global-mode 1)
(setq linum-relative-current-symbol "")
;; disable line numbers in shell and term
(add-hook 'term-mode-hook (lambda ()
							(setq-local linum-relative-global-mode
										nil)))


;; toggle soft wrap for lines
(global-visual-line-mode 1)

;; auto insert closing bracket
(electric-pair-mode 1)

;; turn on highlighting current line
;; (global-hl-line-mode 1)

;; turn on bracket match highlight
(show-paren-mode 1)

;; stop creating those #auto-save# files
(setq auto-save-default nil)

(defalias 'yes-or-no-p 'y-or-n-p)

;; ansi-term config
(defvar my-term-shell "/bin/bash")
(defadvice ansi-term (before force-bash)
  (interactive (list my-term-shell)))
(ad-activate 'ansi-term)


;; abbreviations
(clear-abbrev-table global-abbrev-table)

(define-abbrev-table 'global-abbrev-table
  '(

	("imv" "int		main(void)")
	("imar" "int		main(int ac, char **av)")

	))







;; key sets
(global-set-key (kbd "M-*") 'pop-tag-mark)
(global-set-key (kbd "C-c M-t") 'ansi-term) ;; C-c M-t to run ansi-term




 ;; (custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 ;; '(default ((t (:inherit nil :stipple nil :background "#002b36" :foreground "#839496" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight light :height 98 :width extra-condensed :foundry "PfEd" :family "Monaco")))))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:inherit nil :stipple nil :background "#002b36" :foreground "#839496" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight light :height 98 :width extra-condensed :foundry "PfEd" :family "Monaco")))))
