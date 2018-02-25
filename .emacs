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
	("8aebf25556399b58091e533e455dd50a6a9cba958cc4ebb0aab175863c25b9a4" default)))
 '(package-selected-packages
   (quote
	(linum-relative solarized-theme which-key use-package))))

;; set a default font
(when (member "Monaco" (font-family-list))
  (set-face-attribute 'default nil :font "Monaco-10:spacing=100"))

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

;; abbreviations
(clear-abbrev-table global-abbrev-table)

(define-abbrev-table 'global-abbrev-table
  '(

	("imv" "int		main(void)")
	("imar" "int		main(int ac, char **av)")

	))




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
