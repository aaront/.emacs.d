;;; init.el -- Aaron's very minimal init.el

;; Generally nice stuff to have

;; Cut-copy-paste
(cua-mode t)
(setq cua-auto-tabify-rectangles nil) ;; Don't tabify after rectangle commands
(transient-mark-mode 1) ;; No region when it is not highlighted
(setq cua-keep-region-after-copy t) ;; Standard Windows behaviour

;; Don't use messages that you don't read
(setq initial-scratch-message "")
(setq inhibit-startup-message t)

;; Don't let Emacs hurt your ears or eyes
(setq ring-bell-function 'ignore)
(setq redisplay-dont-pause t)

;; No blinkin' cursor
(blink-cursor-mode -1)

;; No toolbar
(tool-bar-mode -1)

;; No scrollbars
(scroll-bar-mode -1)

;; Line numbering
(global-linum-mode t)
(setq linum-format " %4d ")

;; Delay updates to give Emacs a chance for other changes
(setq linum-delay t)

;; scrolling to always be a line at a time
(setq scroll-conservatively 10000)

;; line spacing
(setq-default line-spacing 2)

;; Move backups to a common folder
(setq backup-directory-alist '(("." . "~/.emacs.d/backup"))
  backup-by-copying t ; Don't delink hardlinks
  version-control t ; Use version numbers on backups
  delete-old-versions t ; Automatically delete excess backups
  kept-new-versions 20 ; how many of the newest versions to keep
  kept-old-versions 5 ; and how many of the old
  )

;; packages
(require 'package)
(setq package-user-dir "~/.emacs.d/elpa/")
(add-to-list 'package-archives
             '("melpa" . "http://melpa.milkbox.net/packages/") t)
(package-initialize)

;; Install packages
(defun at-install-packages ()
  "Install mah packages."
  (interactive)
  (package-refresh-contents)
  (mapc #'(lambda (package)
	    (unless (package-installed-p package)
	      (package-install package)))
        '(;;ample-theme
	  auto-complete
          autopair
          csharp-mode
	  exec-path-from-shell
	  flycheck
          flx-ido
	  go-mode
	  god-mode
          ido
          ido-ubiquitous
          ido-vertical-mode
          jedi
          json-mode
          json-reformat
          powershell
	  projectile
	  smex
	  solarized-theme
	  sr-speedbar)))

;; theme
;;(require 'solarized-theme)
;;(setq solarized-distinct-fringe-background -1)
(setq solarized-high-contrast-mode-line t)
(setq solarized-use-more-italic t)
(require 'solarized-dark-theme)

;; autopair
(require 'autopair)
(autopair-global-mode)

;; recentf
(require 'recentf)
(recentf-mode 1)
(setq recentf-max-menu-items 25)
(global-set-key "\C-x\ \C-r" 'recentf-open-files)

;; ido
(require 'ido)
(ido-mode t)

(require 'flx-ido)
(ido-everywhere 1)
(flx-ido-mode 1)
(setq ido-use-faces nil)

(require 'ido-vertical-mode)
(ido-vertical-mode 1)

(require 'ido-ubiquitous)
(ido-ubiquitous-mode 1)

;; Fix ido-ubiquitous for newer packages
(defmacro ido-ubiquitous-use-new-completing-read (cmd package)
  `(eval-after-load ,package
     '(defadvice ,cmd (around ido-ubiquitous-new activate)
        (let ((ido-ubiquitous-enable-compatibility nil))
          ad-do-it))))

(ido-ubiquitous-use-new-completing-read webjump 'webjump)
(ido-ubiquitous-use-new-completing-read yas/expand 'yasnippet)
(ido-ubiquitous-use-new-completing-read yas/visit-snippet-file 'yasnippet)

;; God mode
(require 'god-mode)
(global-set-key (kbd "<escape>") 'god-local-mode)
(add-to-list 'god-exempt-major-modes 'dired-mode)

;; jedi.el
(add-hook 'python-mode-hook 'jedi:setup)
(setq jedi:complete-on-dot t)

;; smex
(require 'smex)
(defun smex-update-after-load (unused)
  (when (boundp 'smex-cache)
    (smex-update)))
(add-hook 'after-load-functions 'smex-update-after-load)

;; Flycheck
(add-hook 'after-init-hook #'global-flycheck-mode)

;; Auto-complete
(require 'auto-complete-config)
(ac-config-default)
(setq ac-auto-show-menu 0.8)
(auto-complete-mode t)

;; exec-path-from-shell.el
(when (memq window-system '(mac ns))
  (require 'exec-path-from-shell)
  (exec-path-from-shell-initialize))

;; projectile
(require 'projectile)

;; Load custom.el
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(when (file-exists-p custom-file)
  (load custom-file))

(provide 'init)
;;; init.el ends here
