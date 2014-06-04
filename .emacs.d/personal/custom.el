;; === Custom requires
(require 'tabbar)
(require 'printing)
(pr-update-menus)

;;====== tabbar-mode keys
;; (global-set-key [(control f10)] 'tabbar-local-mode)

;; It is possible to navigate through tabs using commands (that is,
;; using the keyboard).  The main commands to cycle through tabs are:
;; - `tabbar-forward' select the next available tab.
;; - `tabbar-backward' select the previous available tab.

;; It is worth defining keys for them.  For example:
(global-set-key [(meta shift left)] 'tabbar-backward)
(global-set-key [(meta shift right)] 'tabbar-forward)


;; === Customizations
;; The variable redisplay-dont-pause, when set to t, will cause Emacs
;; to fully redraw the display before it processes queued input
;; events. This may have slight performance implications if you’re
;; aggressively mouse scrolling a document or rely on your keyboard’s
;; auto repeat feature.
;; Add this to your .emacs file to enable this functionality:
;; (setq redisplay-dont-pause t)
;;-------------------oo----------------------------------
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-names-vector ["#3F3F3F" "#CC9393" "#7F9F7F" "#F0DFAF" "#8CD0D3" "#DC8CC3" "#93E0E3" "#DCDCCC"])
 '(blink-cursor-mode nil)
 '(column-number-mode t)
 '(custom-enabled-themes (quote (adwaita)))
 '(desktop-menu-directory "~/.emacs.d/desktops")
 '(fci-rule-color "#383838")
 '(fringe-mode (quote (nil . 0)) nil (fringe))
 '(global-hl-line-mode nil)
 '(indicate-empty-lines t)
 '(prelude-global-mode t)
 '(prelude-guru nil)
 '(show-paren-mode t)
 '(size-indication-mode t)
 '(smtpmail-smtp-server "smtp.gmail.com")
 '(smtpmail-smtp-service "smtp")
 '(tabbar-mode t nil (tabbar))
 '(tool-bar-mode nil)
 '(menu-bar-mode t)
 '(vc-annotate-background "#2B2B2B")
 '(vc-annotate-color-map (quote ((20 . "#BC8383") (40 . "#CC9393") (60 . "#DFAF8F") (80 . "#D0BF8F") (100 . "#E0CF9F") (120 . "#F0DFAF") (140 . "#5F7F5F") (160 . "#7F9F7F") (180 . "#8FB28F") (200 . "#9FC59F") (220 . "#AFD8AF") (240 . "#BFEBBF") (260 . "#93E0E3") (280 . "#6CA0A3") (300 . "#7CB8BB") (320 . "#8CD0D3") (340 . "#94BFF3") (360 . "#DC8CC3"))))
 '(vc-annotate-very-old-color "#DC8CC3"))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(eshell-prompt ((t (:foreground "DodgerBlue4" :weight bold))) t)
 '(tabbar-button ((t (:inherit tabbar-default :box (:line-width 2 :color "white" :style released-button)))))
 '(tabbar-highlight ((t (:inverse-video t))))
 '(tabbar-selected ((t (:inherit tabbar-default :foreground "black" :box (:line-width 1 :color "dark gray" :style pressed-button)))))
 '(tabbar-unselected ((t (:inherit tabbar-default :box (:line-width 1 :color "light gray" :style released-button))))))
