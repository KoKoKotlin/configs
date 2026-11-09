;; -*- lexical-binding: t; -*-

;; ---------------------------------------------------------------------------
;; Packages (Emacs 27+ initialises package.el before this file is read)
;; ---------------------------------------------------------------------------
(require 'package)
(add-to-list 'package-archives
             '("melpa-stable" . "https://stable.melpa.org/packages/"))
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/") t)

;; ---------------------------------------------------------------------------
;; Basics
;; ---------------------------------------------------------------------------
(setq backup-directory-alist `(("." . "~/.emacs-backups")))
(setq make-backup-files t)  ;; ensure backups are still enabled

;; Tabs, 4 wide.  These are buffer-local, so they need setq-default.
(setq-default indent-tabs-mode t
              tab-width 4
              c-basic-offset 4)
(setq display-line-numbers-type 'relative)
(setq inhibit-splash-screen t)

(add-to-list 'default-frame-alist '(fullscreen . maximized))
(add-to-list 'default-frame-alist '(font . "JetBrainsMono NF 13")) ;; also for new frames

(global-display-line-numbers-mode 1)
(menu-bar-mode 0)
(scroll-bar-mode 0)
(tool-bar-mode 0)
(electric-pair-mode 1)

;; Built-in vertical completion for M-x, find-file, buffers, ...
;; (replaces ido + smex, which is unmaintained)
(fido-vertical-mode 1)

;; Load PATH from the shell even when started from the GUI.
;; Under Wayland, Emacs's window-system is `pgtk', not `x'.
(use-package exec-path-from-shell
  :ensure t
  :if (memq window-system '(mac ns x pgtk))
  :config (exec-path-from-shell-initialize))

;; Load the theme without prompting the safety message
(use-package afternoon-theme
  :ensure t
  :config (load-theme 'afternoon t))

;; ---------------------------------------------------------------------------
;; Evil
;; ---------------------------------------------------------------------------
(use-package evil
  :ensure t
  :init      ;; tweak evil's configuration before loading it
  (setq evil-want-keybinding nil)   ;; required by evil-collection
  (setq evil-vsplit-window-right t)
  (setq evil-split-window-below t)
  :config
  (evil-mode 1)
  (evil-set-initial-state 'compilation-mode 'emacs)
  (evil-set-initial-state 'dired-mode 'emacs))

(use-package evil-collection
  :ensure t
  :after evil
  :config
  (setq evil-collection-mode-list '(dashboard ibuffer))
  (evil-collection-init))

(use-package evil-mc
  :ensure t
  :after evil
  :config (global-evil-mc-mode 1))

;; ---------------------------------------------------------------------------
;; Tools
;; ---------------------------------------------------------------------------
(use-package elcord              ;; Discord rich presence
  :ensure t
  :config (elcord-mode 1))

(use-package company
  :ensure t
  :hook (after-init . global-company-mode))

(use-package magit :ensure t :defer t)

;; ---------------------------------------------------------------------------
;; Rust
;; ---------------------------------------------------------------------------
(setq compilation-scroll-output t)

(use-package rust-mode
  :ensure t
  :init (setq rust-format-on-save t)
  :hook (rust-mode . prettify-symbols-mode))

(use-package cargo-mode
  :ensure t
  :hook (rust-mode . cargo-minor-mode)
  :custom (cargo-mode-use-comint nil))

;; ---------------------------------------------------------------------------
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("1711947b59ea934e396f616b81f8be8ab98e7d57ecab649a97632339db3a3d19"
     "455aeeff00c55cac03e7cd9ee5f7545cd6b5656e1f2e6765e92f6ee897ef502b"
     "0a076beea7570c3047225baf40783d7ce1576b8b98cdcd3e5622808875ab8c00"
     "eead109a0c4c72e3926617c5eea8696eb3236ee885a92ee5ab875cec0142c9f2"
     default))
 '(package-selected-packages
   '(abyss-theme acme-theme afternoon-theme amber-glow-theme annalist
		 auctex cargo-mode comment-tags company elcord evil
		 evil-collection evil-mc exec-path-from-shell magit
		 rust-mode)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
