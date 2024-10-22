
(require 'package)
(add-to-list 'package-archives
             '("melpa-stable" . "https://stable.melpa.org/packages/"))
(package-initialize)

(setq indent-tabs-mode 'only)
(setq tab-width 4)
(defvaralias 'c-basic-offset 'tab-width)
(setq display-line-numbers-type 'relative)
(setq inhibit-splash-screen t)

(add-to-list 'default-frame-alist '(fullscreen . maximized))

(global-display-line-numbers-mode 1)
(ido-mode 1)
(ido-everywhere 1)
(menu-bar-mode 0)
(scroll-bar-mode 0)
(tool-bar-mode 0)
(electric-pair-mode 1)

(set-frame-font "JetbrainsMono 13" nil t)

;; load path from shell env even when started from gui
(when (memq window-system '(mac ns x))
  (exec-path-from-shell-initialize))

;; load the theme without prompting the safety message
(load-theme 'afternoon 1)

;; smex
(require 'smex)
(smex-initialize)

(use-package smex
  :bind (("M-x" . smex))
  :config (smex-initialize))

;; Company mode
(use-package company
  :ensure t
  :init
  (add-hook 'after-init-hook 'global-company-mode))

;; Rust mode
(setq rust-format-on-save t)
(add-hook 'rust-mode-hook
          (lambda () (prettify-symbols-mode)))
(add-hook 'rust-mode-hook 'cargo-minor-mode)
(setq compilation-scroll-output t)
(use-package cargo-mode
  :custom
  (cargo-mode-use-comint nil))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("1711947b59ea934e396f616b81f8be8ab98e7d57ecab649a97632339db3a3d19" "603a831e0f2e466480cdc633ba37a0b1ae3c3e9a4e90183833bc4def3421a961" "e13beeb34b932f309fb2c360a04a460821ca99fe58f69e65557d6c1b10ba18c7" default))
 '(package-selected-packages
   '(exec-path-from-shell cargo-mode company auto-complete markdown-mode rust-mode magit afternoon-theme)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
