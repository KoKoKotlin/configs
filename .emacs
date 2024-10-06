
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

; load the theme without prompting the safety message
(load-theme 'afternoon 1)

(require 'smex)
(smex-initialize)

(use-package smex
  :bind (("M-x" . smex))
  :config (smex-initialize)) 

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("1711947b59ea934e396f616b81f8be8ab98e7d57ecab649a97632339db3a3d19" "603a831e0f2e466480cdc633ba37a0b1ae3c3e9a4e90183833bc4def3421a961" "e13beeb34b932f309fb2c360a04a460821ca99fe58f69e65557d6c1b10ba18c7" default))
 '(package-selected-packages
   '(rust-mode magit afternoon-theme dracula-theme gruber-darker-theme)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
