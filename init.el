;; Load general features files
(setq config_files "/usr/share/emacs/site-lisp/")
(setq load-path (append (list nil config_files) load-path))
(load "list.el")
(load "string.el")
(load "comments.el")
(load "header.el")
(autoload 'php-mode "php-mode" "Major mode for editing PHP code" t)
(add-to-list 'auto-mode-alist '("\\.php[34]?\\'\\|\\.phtml\\'" . php-mode))

;; 42 config

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

(use-package auto-complete
  :ensure t
  :init
  (global-auto-complete-mode t))

(setq-default tab-stop-list '(4 8 12 16 20 24 28 32 36 40 44 48 52 56 60
	  		  				 64 68 72 76 80 84 88 92 96 100 104 108 112 116 120))

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
  ("M-s" . avy-goto-char)
  ("C-c g" . avy-goto-line))

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
  )

;; sudo edit
(use-package sudo-edit
  :ensure t
  :bind ("C-c s e" . sudo-edit))

;; rainbow delimiters
 (use-package rainbow-delimiters
  :ensure t
  :init (rainbow-delimiters-mode 1))

;; dashboard
(use-package dashboard
  :ensure t
  :config
  (dashboard-setup-startup-hook)
  (setq dashboard-items '((recents . 10))))

(use-package expand-region
  :ensure t)

(use-package change-inner
  :ensure t
  :bind)

(global-set-key (kbd "C-c w i") 'change-inner)
(global-set-key (kbd "C-c w o") 'change-outer)

(global-set-key (kbd "M-*") 'er/expand-region)
(global-set-key (kbd "C-c w p") 'er/mark-inside-pairs)
(global-set-key (kbd "C-c w P") 'er/mark-outside-pairs)


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
;; (scroll-bar-mode -1)

;; save cursor position
(save-place-mode 1)

(setq inhibit-startup-message t)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(gud-gdb-command-name "gdb --annotate=1")
 '(large-file-warning-threshold nil)
 '(package-selected-packages
   (quote
	(highlight-indent-guides ggtags auto-complete change-inner evil which-key use-package solarized-theme smex nlinum linum-relative ido-vertical-mode beacon))))


;; cool C-Tab autocompletion from buffer
(global-set-key (kbd "C-<tab>") 'dabbrev-expand)
(define-key minibuffer-local-map (kbd "C-<tab>") 'dabbrev-expand)

(global-set-key (kbd "TAB") 'self-insert-command)
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
(set-face-foreground 'linum "#586e75")

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



;; TAGS
(use-package ggtags
  :ensure t)

(add-hook 'c-mode-common-hook
          (lambda ()
            (when (derived-mode-p 'c-mode 'c++-mode 'java-mode)
              (ggtags-mode 1))))



;; abbreviations
;; (clear-abbrev-table global-abbrev-table)

(define-abbrev-table 'global-abbrev-table
  '(

	("imv" "int		main(void)")
	("imar" "int		main(int ac, char **av)")
	("libfth" "#include <libft.h>")

	))

;; key sets
(global-set-key (kbd "C-c M-t") 'ansi-term) ;; C-c M-t to run ansi-term


(set-background-color "#002833")


;;(require 'evil)
;;  (evil-mode 1)

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
 '(default ((t (:inherit nil :stipple nil :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight light :height 1 :width normal :foundry "default" :family "default"))))
 '(my-tab-face ((((class color)) (:foreground "black" :weight bold :underline t))) t))
