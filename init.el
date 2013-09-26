;;; Aaron's Emacs Config

;; Turn off mouse interface early in startup to avoid momentary display
;;(when (fboundp 'menu-bar-mode) (menu-bar-mode -1))
(when (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(when (fboundp 'show-paren-mode) (show-paren-mode 1))
(when (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))

;; No splash screen
(setq inhibit-startup-screen t)

;; Some defaults
(setq default-tab-width 4)
(setq tab-width 4)
(setq ring-bell-function 'ignore)
(setq line-spacing 4)
(setq frame-title-format '(buffer-file-name "%f" ("%b")))
(global-hl-line-mode t)
(column-number-mode t)
(size-indication-mode t)

;; CUA-mode
(cua-mode t)

;; Move backups to a common folder
(setq backup-directory-alist '(("." . "~/.emacs.d/backup"))
  backup-by-copying t    ; Don't delink hardlinks
  version-control t      ; Use version numbers on backups
  delete-old-versions t  ; Automatically delete excess backups
  kept-new-versions 20   ; how many of the newest versions to keep
  kept-old-versions 5    ; and how many of the old
  )

;; package.el
(require 'package)
(setq package-user-dir "~/.emacs.d/elpa/")
(add-to-list 'package-archives
             '("melpa" . "http://melpa.milkbox.net/packages/") t)
(package-initialize)

;; Install packages
(defun at-install-packages ()
  "Install only the sweetest of packages."
  (interactive)
  (package-refresh-contents)
  (mapc #'(lambda (package)
           (unless (package-installed-p package)
             (package-install package)))
                '(emmet-mode
	          flycheck
	          ido-ubiquitous
	          ido-vertical-mode
                  magit
	          monokai-theme
			  multi-web-mode
		  org
                  paredit
		  powerline
                  smex
		  soothe-theme
		  sr-speedbar
		  tern
		  tern-auto-complete
                  undo-tree
		  ;;web-mode
				  )))

;; Load theme
(load-theme 'soothe t)

;; linum.el
(require 'linum)
(global-linum-mode t)

;; recentf.el
(require 'recentf)
(recentf-mode 1)

;; ido.el
(require 'ido)
(ido-mode t)
(ido-ubiquitous-mode t)
(ido-vertical-mode t)

;; powerline.el
(require 'powerline)
(powerline-reset)
(powerline-default-theme)

;; sr-speedbar.el
(require 'sr-speedbar)

;; smex.el
(require 'smex)
(smex-initialize)

;; web-mode.el
;;(require 'web-mode)
;;(add-to-list 'auto-mode-alist '("\\.phtml\\'" . web-mode))
;;(add-to-list 'auto-mode-alist '("\\.tpl\\.php\\'" . web-mode))
;;(add-to-list 'auto-mode-alist '("\\.jsp\\'" . web-mode))
;;(add-to-list 'auto-mode-alist '("\\.as[cp]x\\'" . web-mode))
;;(add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode))
;;(add-to-list 'auto-mode-alist '("\\.mustache\\'" . web-mode))
;;(add-to-list 'auto-mode-alist '("\\.djhtml\\'" . web-mode))

;; tern-auto-complete.el
;;(eval-after-load 'tern
;;   '(progn
;;      (require 'tern-auto-complete)
;;      (tern-ac-setup)))

(require 'multi-web-mode)
(setq mweb-default-major-mode 'html-mode)
(setq mweb-tags 
  '((php-mode "<\\?php\\|<\\? \\|<\\?=" "\\?>")
    (js-mode  "<script +\\(type=\"text/javascript\"\\|language=\"javascript\"\\)[^>]*>" "</script>")
    (css-mode "<style +type=\"text/css\"[^>]*>" "</style>")))
(setq mweb-filename-extensions '("php" "htm" "html" "ctp" "phtml" "php4" "php5"))
(multi-web-global-mode 1)

;; Hooks
(add-hook 'js-mode-hook (lambda () (tern-mode t)))
(add-hook 'after-init-hook #'global-flycheck-mode)

;; Load custom.el
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(when (file-exists-p custom-file)
  (load custom-file))

(provide 'init)
;;; init.el ends here