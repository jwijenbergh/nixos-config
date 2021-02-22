;; A big contributor to startup times is garbage collection. We up the gc
;; threshold to temporarily prevent it from running, then reset it later using a
;; hook and controlling after that with `gcmh-mode'.
(setq gc-cons-threshold most-positive-fixnum
      gc-cons-percentage 0.6)

;; Keep a ref to the actual file-name-handler
(defvar default-file-name-handler-alist file-name-handler-alist)

;; Set the file-name-handler to nil (because regexing is cpu intensive)
(setq file-name-handler-alist nil)

;; Reset file-name-handler-alist after initialization
(add-hook 'emacs-startup-hook
	  (lambda ()
	    (setq gc-cons-threshold MY/GC-CONS-THRESHOLD
		  gc-cons-percentage 0.1
		  file-name-handler-alist default-file-name-handler-alist)))

;; Settings
(add-to-list 'default-frame-alist '(font . "Iosevka-15"))
(setq-default xterm-query-timeout nil)

;; Separate file for custom-set-variables
(setq custom-file "~/.emacs.d/custom.el")
(load custom-file 'noerror)

;; Put backup files neatly away
(let ((backup-dir "~/.emacs-bu/")
      (auto-saves-dir "~/.emacs-sv/"))
  (dolist (dir (list backup-dir auto-saves-dir))
    (when (not (file-directory-p dir))
      (make-directory dir t)))
  (setq backup-directory-alist `(("." . ,backup-dir))
	auto-save-file-name-transforms `((".*" ,auto-saves-dir t))
	auto-save-list-file-prefix (concat auto-saves-dir ".saves-")))

(setq backup-by-copying t    ; Don't delink hardlinks
      delete-old-versions t  ; Clean up the backups
      version-control t      ; Use version numbers on backups,
      kept-new-versions 5    ; keep some new versions
      kept-old-versions 2)   ; and some old ones, too

(use-package doom-themes
  :config
  ;; Global settings (defaults)
  (setq doom-themes-enable-bold t    ; if nil, bold is universally disabled
	doom-themes-enable-italic t) ; if nil, italics is universally disabled
  (load-theme 'doom-gruvbox t))

(use-package doom-modeline
  :config (doom-modeline-mode 1))

(use-package haskell-mode)

(use-package dashboard
  :config
  (dashboard-setup-startup-hook)
  (setq initial-buffer-choice (lambda () (get-buffer-create "*dashboard*"))))

(use-package general
  :demand t
  :config
  (general-evil-setup t)
  ; https://www.reddit.com/r/emacs/comments/des3cl/how_do_you_create_nested_menus_with_general/f2yw45k/?context=3
  (global-unset-key (kbd "C-SPC"))
  (general-create-definer global-definer
    :keymaps 'override
    :states '(insert emacs normal hybrid motion visual operator)
    :prefix "SPC"
    :non-normal-prefix "C-SPC")

  (defmacro general-global-menu-definer (def infix-key &rest body)
    "Create a definer named general-global-DEF wrapping global-definer.
The prefix map is named 'my-DEF-map'."
    `(progn
       (general-create-definer ,(intern (concat "general-global-" def))
	 :wrapping global-definer
	 :prefix-map (quote ,(intern (concat "my-" def "-map")))
	 :infix ,infix-key
	 :wk-full-keys nil
	 "" '(:ignore t :which-key ,def))
       (,(intern (concat "general-global-" def))
	,@body)))

  (general-global-menu-definer
   "buffers" "b"
   "k" 'kill-buffer
   "e" 'eval-buffer)

  (general-global-menu-definer
   "emacs" "e"
   "q" 'save-buffers-kill-terminal)

  (general-global-menu-definer
   "files" "f"
   "s" 'save-buffer
   "f" 'find-file)

  (general-global-menu-definer
   "git" "g"))

(use-package display-line-numbers
  :config
  (global-display-line-numbers-mode 1)
  (setq display-line-numbers-type 'relative)
  (global-hl-line-mode 1))

(use-package evil
  :init
  (setq evil-want-keybinding nil)
  :config
  (evil-mode))

(use-package evil-collection
  :after evil
  :config
  (evil-collection-init))

(use-package evil-easymotion
  :after evil)

(use-package evil-magit
  :after evil magit)

(use-package lua-mode)

(use-package magit
  :after general
  :config
  ;; automatically refresh magit buffer
  (add-hook 'after-save-hook 'magit-after-save-refresh-status t)
  :general
  (general-global-git "s" 'magit-status))

(use-package rg)
(use-package vterm)

(use-package vterm-wrappers
  :load-path "/home/jerry/Repos/emacs-vtermfloat-dev"
  :config
  (setq vterm-timer-delay 0.01)
  (setq vterm-wrappers-posframe-enable t)
  (setq vterm-wrappers-fzf-rg-phony nil)
  (setq vterm-wrappers-fzf-opt '("--reverse"))
  :general
  (general-global-menu-definer
   "vterm-wrappers" "w"
    "m" 'vterm-wrappers
    "f" (lambda() (interactive) (vterm-wrappers "fzf"))
    "r" (lambda() (interactive) (vterm-wrappers "fzf-rg"))
    "s" (lambda() (interactive) (vterm-wrappers "shell"))
    "n" (lambda() (interactive) (vterm-wrappers "nnn"))
    "h" 'vterm-wrappers-hide
    "u" 'vterm-wrappers-show))

(use-package org
  :mode (("\\.org$" . org-mode))
  :hook (org-mode . visual-line-mode)
  :config
  (setq org-startup-indented t))

(use-package org-bullets
  :after org
  :init
  :hook (org-mode . org-bullets-mode))

(use-package which-key
  :config
  (which-key-mode 1))

(use-package nix-mode
  :mode "\\.nix\\'")

(use-package with-editor)

(use-package deadgrep)

(use-package flycheck
  :ensure t
  :config (global-flycheck-mode))

(use-package fzf)

(use-package selectrum
  :load-path "/home/jerry/Repos/selectrum"
  :config
  (selectrum-mode +1))

(use-package selectrum-prescient
  :config
  (selectrum-prescient-mode +1))

(use-package prescient
  :after selectrum)

(use-package consult
  :load-path "/home/jerry/Repos/consult"
  :general
  (general-global-buffers "s" 'consult-buffer))

(use-package consult-selectrum
  :after selectrum
  :load-path "/home/jerry/Repos/consult")

;(use-package mini-frame
;  :init
;  (custom-set-variables
;   '(mini-frame-show-parameters
;     '((top . 0.35)
;       (width . 0.7)
;       (left . 0.5))))
;  :config
;  (mini-frame-mode 1))

(use-package bicycle
  :after outline
  :bind (:map outline-minor-mode-map
	      ([C-tab] . bicycle-cycle)
	      ([backtab] . bicycle-cycle-global)))

(use-package prog-mode
  :config
  (add-hook 'prog-mode-hook 'outline-minor-mode)
  (add-hook 'prog-mode-hook 'hs-minor-mode))
