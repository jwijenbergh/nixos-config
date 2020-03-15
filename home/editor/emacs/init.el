;; Initialize packaging, required for how we use `Nix'.
(require 'package)
(setq load-prefer-newer t            ;; Always load the newest file between `.el' and `.elc'
      package--init-file-ensured t   ;; We do initialize our packages, yes
      package-archives nil           ;; But we do not use `package.el' for installation, so disable it
      package-enable-at-startup nil) ;; Don't enable installed packages on boot
(package-initialize)

(add-to-list 'load-path "~/.emacs.d/lisp/")

(use-package company
  :demand t
  :init
  (global-company-mode)
  (add-to-list 'company-backends 'company-nixos-options)
  :config
  (company-mode 1))

(use-package counsel
  :demand t
  :config
  (counsel-mode 1))

(use-package dracula-theme
  :demand t)

(use-package evil
  :demand t
  :init
  (setq evil-want-keybinding nil)
  (setq evil-want-minibuffer t)
  :config
  (evil-mode))

(use-package evil-collection
  :after evil
  :demand t
  :config
  (evil-collection-init))

(use-package evil-magit
  :after evil
  :demand t)
					; Much faster than counsel-fzf
(use-package fzf
  :demand t
  :init
  (setenv "FZF_DEFAULT_COMMAND" "rg --files --hidden"))

(use-package magit
  :demand t
  :config
					; automatically refresh magit buffer
  (add-hook 'after-save-hook 'magit-after-save-refresh-status t))

(use-package nix-mode
  :demand t
  :init
  (add-to-list 'auto-mode-alist '("\\.nix\\'" . nix-mode)))

(use-package org
  :mode (("\\.org$" . org-mode))
  :demand t
  :init
  (add-hook 'org-mode-hook (lambda ()
			     (visual-line-mode 1)))
  :config
  (setq org-startup-indented t))

(use-package org-bullets
  :demand t
  :init
  (add-hook 'org-mode-hook (lambda ()
			     (org-bullets-mode 1))))

(use-package rust-mode
  :demand t
  :init
  (add-to-list 'auto-mode-alist '("\\.rs\\'" . rust-mode)))

(use-package telephone-line
  :demand t
  :init
  (setq telephone-line-primary-left-separator 'telephone-line-gradient
	telephone-line-secondary-left-separator 'telephone-line-nil
	telephone-line-primary-right-separator 'telephone-line-gradient
	telephone-line-secondary-right-separator 'telephone-line-nil)
  (setq telephone-line-height 24
	telephone-line-evil-use-short-tag t)
  :config
  (telephone-line-mode 1))

(use-package which-key
  :demand t
  :config
  (which-key-mode 1))

(global-display-line-numbers-mode)
(global-hl-line-mode 1)

(tool-bar-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)

(set-frame-font "Hack 12" nil t)

(setq-default c-basic-offset 4)

;; Put backup files neatly away                                                 
(let ((backup-dir "~/.emacs-bu/")
      (auto-saves-dir "~/.emacs-sv/"))
  (dolist (dir (list backup-dir auto-saves-dir))
    (when (not (file-directory-p dir))
      (make-directory dir t)))
  (setq backup-directory-alist `(("." . ,backup-dir))
	auto-save-file-name-transforms `((".*" ,auto-saves-dir t))
	auto-save-list-file-prefix (concat auto-saves-dir ".saves-")
	tramp-backup-directory-alist `((".*" . ,backup-dir))
	tramp-auto-save-directory auto-saves-dir))

(setq backup-by-copying t    ; Don't delink hardlinks                           
      delete-old-versions t  ; Clean up the backups                             
      version-control t      ; Use version numbers on backups,                  
      kept-new-versions 5    ; keep some new versions                           
      kept-old-versions 2)   ; and some old ones, too


(setq auto-mode-alist
      (cons '("\\.horn$" . proverif-horn-mode) 
	    (cons '("\\.horntype$" . proverif-horntype-mode) 
		  (cons '("\\.pv$" . proverif-pv-mode) 
			(cons '("\\.pi$" . proverif-pi-mode) auto-mode-alist)))))
(autoload 'proverif-pv-mode "proverif" "Major mode for editing ProVerif code." t)
(autoload 'proverif-pi-mode "proverif" "Major mode for editing ProVerif code." t)
(autoload 'proverif-horn-mode "proverif" "Major mode for editing ProVerif code." t)
(autoload 'proverif-horntype-mode "proverif" "Major mode for editing ProVerif code." t)
