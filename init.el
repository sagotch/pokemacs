;;; init.el --- -*- lexical-binding: t -*-

;; Copyright (c) 2020-2020 Mattias and contributors.

;; Author: Mattias
;; Maintainer: Mattias <mattias@ocamlpro.com>
;; Vesrion: 0.1
;; Licence: GPL2+
;; Keywords: convenience, configuration

;;; License:

;; This file is not part of GNU Emacs.

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 2 of the License, or
;; (at your option) any later version.
;;
;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.
;;
;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

;;; Commentary:

;; In case of variable/face customization, try not to put it here and instead
;; use M-x customize-variable/face <ret> name_of_the_variable/face
;;
;; This file mainly focuses on setting modes and some options that
;; can't be set through customize-variable/face

;;; Code:

;;;; A BIG BUNCH OF CUSTOM OPTIONS

;; These options can't be customized from M-x customize

;;;;; From MatthewZMD

;; See https://github.com/MatthewZMD/.emacs.d for the following options
;; CheckVer
(cond ((version< emacs-version "26.1")
       (warn "M-EMACS requires Emacs 26.1 and above!"))
      ((let* ((early-init-f (expand-file-name "early-init.el" user-emacs-directory))
              (early-init-do-not-edit-d (expand-file-name "early-init-do-not-edit/" user-emacs-directory))
              (early-init-do-not-edit-f (expand-file-name "early-init.el" early-init-do-not-edit-d)))
         (and (version< emacs-version "27")
              (or (not (file-exists-p early-init-do-not-edit-f))
                  (file-newer-than-file-p early-init-f early-init-do-not-edit-f)))
         (make-directory early-init-do-not-edit-d t)
         (copy-file early-init-f early-init-do-not-edit-f t t t t)
         (add-to-list 'load-path early-init-do-not-edit-d)
         (require 'early-init))))
;; -CheckVer

;; BetterGC
(defvar better-gc-cons-threshold 67108864 ; 64mb
  "The default value to use for `gc-cons-threshold'.
If you experience freezing, decrease this.  If you experience stuttering, increase this.")

(add-hook 'emacs-startup-hook
          (lambda ()
            (setq gc-cons-threshold better-gc-cons-threshold)
            (setq file-name-handler-alist file-name-handler-alist-original)
            (makunbound 'file-name-handler-alist-original)))
;; -BetterGC
;; END MATTHEWZMD

;;;;; Custom
;; Start the window on the upper right corner with a fixed size
;; Loading custom-file containing all the custom variables and faces
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(load custom-file)

(set-fontset-font t '(#xe3d0 . #xe3d4) "Material Icons")

(when window-system
  (setq frame-resize-pixelwise t
        x-frame-normalize-before-maximize t)
  (add-to-list 'default-frame-alist '(fullscreen . maximized)))

(setq max-specpdl-size 10000
      max-lisp-eval-depth 5000)

(set-selection-coding-system 'utf-8)
(prefer-coding-system 'utf-8)
(set-language-environment "UTF-8")
(set-default-coding-systems 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(setq locale-coding-system 'utf-8)

;; Treat clipboard input as UTF-8 string first; compound text next, etc.
(setq x-select-request-type '(UTF8_STRING COMPOUND_TEXT TEXT STRING))


;;;;; Unbind unneeded keys

(global-set-key (kbd "C-z") nil)
(global-set-key (kbd "M-z") nil)
(global-set-key (kbd "C-x C-z") nil)
(global-set-key (kbd "M-/") nil)

;;;;; Hooks:

;; Delete trailing whitespaces when saving:
(add-hook 'before-save-hook 'delete-trailing-whitespace)

;; Wraps automatically too long lines:
;; (add-hook 'text-mode-hook 'turn-on-auto-fill)

(setq frame-title-format '(buffer-file-name "%b (%f)" "%b"))

;; Asks y/n instead of yes/no (faster):
(fset 'yes-or-no-p 'y-or-n-p)

;; Adapting the compilation directory matcher for french:
;; (setq compilation-directory-matcher '("\\(?:Entering\\|Leavin\\(g\\)\\|\\) directory [`']\\(.+\\)'$" (2 . 1)))
(setq compilation-directory-matcher '("\\(?:on entre dans le\\|on quitte l\\(e\\)\\|\\) répertoire « \\(.+\\) »$" (2 . 1)))
(setq compilation-page-delimiter "\\(?:on entre dans le\\|on quitte l\\(e\\)\\|\\) répertoire « \\(.+\\) »$")

;; Custom comment function a bit more clever
;; https://www.emacswiki.org/emacs/CommentingCode
(defun comment-eclipse (&optional arg)
  "Replacement for the `comment-dwim' command.
If no region is selected and current line is not blank and we are not at the
end of the line, then comment current line.
Replaces default behaviour of `comment-dwim', when it inserts comment at the
end of the line. Provides the optional ARG used by `comment-dwim'"
  (interactive "*P")
  (comment-normalize-vars)
  (if (and (not (region-active-p)) (not (looking-at "[ \t]*$")))
      (comment-or-uncomment-region (line-beginning-position) (line-end-position))
    (comment-dwim arg)))

;;;; PACKAGE SOURCES AND USE-PACKAGE:

(require 'package)
(add-to-list 'package-archives
             '("melpa" . "http://melpa.org/packages/") t)
(add-to-list 'package-archives
             '("org" . "http://orgmode.org/elpa/") t)
(package-initialize)

;; ConfigurePackageManager
(unless (bound-and-true-p package--initialized)
  (setq package-enable-at-startup nil)          ; To prevent initializing twice
  (package-initialize))

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(eval-and-compile
  (setq use-package-expand-minimally t)
  (setq use-package-compute-statistics t)
  (setq use-package-enable-imenu-support t))

(eval-when-compile
  (require 'use-package)
  (require 'bind-key)
  )

;; (require 'use-package-ensure)
;; (setq use-package-always-ensure t)
;; -ConfigureUsePackage

;; Will be used to download non-emacs packages needed by emacs packages
(use-package use-package-ensure-system-package
  :ensure t)

;;;; GLOBAL MINOR MODES:

;; Some minor packages have the following line:
;;   `:init (*-mode 1) ; globally at startup'
;; This allows to load the mode for all buffers
;; Other minor modes will be loaded when needed
;;
;; Important thing!
;; Most of the configs were made through M-x customize-variable
;; and are thus found in custom.el. It may seem nicer to configure them
;; here through :config but it makes it hard to follow how each package
;; is configures and it's actually simpler to just M-x customize <package>
;; instead of editing this file. Avoid, then, using :config here for variables
;; that can be customized directly.

;;;;; Crux

(use-package crux
  :bind-keymap ("M-m" . crux-map)
  :bind (:map crux-map
              ("w" . crux-view-url)                ; Open a new buffer containing the contents of URL.
              ("o" . crux-open-with)               ; Open visited file in default external program.
              ("e" . crux-sudo-edit)               ; Edit currently visited file as root.
              ("i" . crux-insert-date)             ; Insert a timestamp according to locale's date and time format.
              ("t" . crux-transpose-windows)       ; Transpose the buffers shown in two windows.
              ("j" . crux-top-join-line)           ; Join the current line with the line beneath it.
              ("u" . crux-upcase-region)           ; `upcase-region' when `transient-mark-mode' is on and region is active.
              ("d" . crux-downcase-region)         ; `downcase-region' when `transient-mark-mode' is on and region is active.
              ("c" . crux-capitalize-region)       ; `capitalize-region' when `transient-mark-mode' is on and region is active.
              ("r" . crux-recompile-init)          ; Byte-compile all your dotfiles again.
              ("k" . crux-smart-kill-line)         ; Kill to the end of the line and kill whole line on the next call.
              ("M-k" . crux-kill-line-backwards)   ; Kill line backwards and adjust the indentation.
              ("a" . crux-move-beginning-of-line)  ; Move point back to indentation/beginning (toggle) of line.
              ("s" . crux-ispell-word-then-abbrev) ; Call `ispell-word', then create an abbrev for it.
              )
  (("C-a" . crux-move-beginning-of-line)
   ("C-x 4 t" . crux-transpose-windows)
   ("C-x K" . crux-kill-other-buffers)
   ("C-k" . crux-smart-kill-line)
   ("M-u" . crux-upcase-region)
   ("M-d" . crux-downcase-region)
   ("M-c" . crux-capitalize-region)
   )
  :config
  (define-prefix-command 'crux-map nil "Crux-")
  (crux-with-region-or-buffer indent-region)
  (crux-with-region-or-buffer untabify)
  (crux-with-region-or-point-to-eol kill-ring-save)
  (defalias 'rename-file-and-buffer #'crux-rename-file-and-buffer))

;;;;; Outline, outshines and friends:

(use-package outline
  :hook (prog-mode . outline-minor-mode) ; globally at startup
  :config
  (define-prefix-command 'cm-map nil "Outline-")
  (set-display-table-slot standard-display-table
                          'selective-display
                          (string-to-vector "+++"))
  ;; Outline-minor-mode key map
  :bind-keymap ("C-o" . cm-map)
  :bind (:map cm-map
              ;; HIDE
              ("q" . outline-hide-sublevels)    ; Hide everything but the top-level headings
              ("t" . outline-hide-body)         ; Hide everything but headings (all body lines)
              ("o" . outline-hide-other)        ; Hide other branches
              ("c" . outline-hide-entry)        ; Hide this entry's body
              ("l" . outline-hide-leaves)       ; Hide body lines in this entry and sub-entries
              ("d" . outline-hide-subtree)      ; Hide everything in this entry and sub-entries
              ;; SHOW
              ("a" . outline-show-all)          ; Show (expand) everything
              ("e" . outline-show-entry)        ; Show this heading's body
              ("i" . outline-show-children)     ; Show this heading's immediate child sub-headings
              ("k" . outline-show-branches)     ; Show all sub-headings under this heading
              ("s" . outline-show-subtree)      ; Show (expand) everything in this heading & below
              ;; MOVE
              ("u" . outline-up-heading)                ; Up
              ("n" . outline-next-visible-heading)      ; Next
              ("p" . outline-previous-visible-heading)  ; Previous
              ("f" . outline-forward-same-level)        ; Forward - same level
              ("b" . outline-backward-same-level)       ; Backward - same level
              )
  )

(use-package outshine
  :hook (outline-minor-mode . outshine-mode)
  )

(use-package outline-ivy
  :load-path "custom/"
  :after (outline ivy)
  :bind (:map outline-minor-mode-map
              ("C-j" . oi-jump)
              )
  )

(use-package pretty-outlines
  :defer t
  :load-path "custom/"
  :hook ((outline-mode . pretty-outlines-set-display-table)
         (outline-minor-mode . pretty-outlines-set-display-table)
         (emacs-lisp-mode . pretty-outlines-add-bullets)
         (tuareg-mode . pretty-outlines-add-bullets)
         (rust-mode . pretty-outlines-add-bullets)
         )
  )

;; ;; Working on fixing a bug for this one:
;; (use-package outline-minor-faces
;;   :after outline
;;   :config (add-hook 'outline-minor-mode-hook
;;                     'outline-minor-faces-add-font-lock-keywords))

;;;;; Colors and other small things:

;; rainbow mode:
;;
;; Display colors with a background corresponding to the color
(use-package rainbow-mode
  :init (rainbow-mode 1) ; globally at startup
  :delight)

;; Abbrev mode:
;;
;; Expand defined abbrevs
;; To define an abbrev just type the corresponding letters then
;; C-x a i g (mnemonic: add inverse global) and the expansion for it
;; The file with all the user defined abbrevs should be in .emacs.d/abbrev_defs
;; https://www.emacswiki.org/emacs/AbbrevMode
(use-package abbrev
  :init (abbrev-mode 1) ; globally at startup
  :config
  (if (file-exists-p abbrev-file-name)
      (quietly-read-abbrev-file)))

;; ANSI colors in compilation buffer:
;;
(use-package ansi-color
  :ensure nil
  :hook (compilation-filter . colorize-compilation-buffer)
  :preface
  (autoload 'ansi-color-apply-on-region "ansi-color")
  (defun colorize-compilation-buffer ()
    (let ((inhibit-read-only t))
      (ansi-color-apply-on-region (point-min) (point-max)))))

;; Nice theme:
;;
(use-package apropospriate-theme
  :if window-system
  :init
  (add-to-list 'custom-theme-load-path
               (file-name-directory
                (locate-library "apropospriate-theme")))
  (load-theme 'apropospriate-dark t))

;; All the icons:
;;
;; M-x all-the-icons-insert-* will allow to directly insert a unicode symbol
(use-package all-the-icons)

;;;;; Counsel, Ivy and friends:

(use-package ivy
  :init
  (use-package amx
    :defer t)
  (use-package counsel
    :config (counsel-mode 1))
  (use-package swiper
    :defer t)
  (ivy-mode 1) ; globally at startup
  :config
  (defun ivy-yank-action (x)
    (kill-new x))

  (defun ivy-copy-to-buffer-action (x)
    (with-ivy-window
      (insert x)))
  (ivy-set-actions
   t
   '(("i" ivy-copy-to-buffer-action "insert")
     ("y" ivy-yank-action "yank")))
  :bind (:map ivy-minibuffer-map
              ("<return>" . ivy-alt-done))
  ;;The * means that these bindings will override all minor mode binding
  :bind*
  (("M-x"     . counsel-M-x)
   ;; Not happy with the behaviour of swiper or swiper-isearch
   ;; ("C-s"     . swiper-isearch)
   ("C-x C-f" . counsel-find-file)
   ("C-x C-r" . counsel-recentf)  ; search for recently edited
   ("C-c g"   . counsel-git)      ; search for files in git repo
   ("C-c j"   . counsel-git-grep) ; search for regexp in git repo
   ;; ("C-c /"   . counsel-ag)       ; Use ag for regexp
   ("C-x l"   . counsel-locate)
   ("C-x C-f" . counsel-find-file)
   ("<f1> f"  . counsel-describe-function)
   ("<f1> v"  . counsel-describe-variable)
   ("<f1> l"  . counsel-find-library)
   ("<f2> i"  . counsel-info-lookup-symbol)
   ("<f2> u"  . counsel-unicode-char)
   ("C-c C-r" . ivy-resume))     ; Resume last Ivy-based completion
  )

;; All the icons for Ivy:
;;
;; Uses all-the-icons to display ivy results in a nicer way
(use-package all-the-icons-ivy
  :requires all-the-icons
  :init (all-the-icons-ivy-setup)
  )

;;;;; Windows management
(use-package winner
  :ensure nil
  :custom
  (winner-boring-buffers
   '("*Completions*"
     "*Compile-Log*"
     "*inferior-lisp*"
     "*Fuzzy Completions*"
     "*Apropos*"
     "*Help*"
     "*cvs*"
     "*Buffer List*"
     "*Ibuffer*"
     "*esh command on file*"))
  :config
  (winner-mode 1))

;; Resizes the window width based on the input
(defun resize-window-width (w)
  "Resizes the window width based on W."
  (interactive (list (if (> (count-windows) 1)
                         (read-number "Set the current window width in [1~9]x10%: ")
                       (error "You need more than 1 window to execute this function!"))))
  (message "%s" w)
  (window-resize nil (- (truncate (* (/ w 10.0) (frame-width))) (window-total-width)) t))

;; Resizes the window height based on the input
(defun resize-window-height (h)
  "Resizes the window height based on H."
  (interactive (list (if (> (count-windows) 1)
                         (read-number "Set the current window height in [1~9]x10%: ")
                       (error "You need more than 1 window to execute this function!"))))
  (message "%s" h)
  (window-resize nil (- (truncate (* (/ h 10.0) (frame-height))) (window-total-height)) nil))

;; Setup shorcuts for window resize width and height
(global-set-key (kbd "C-z w") #'resize-window-width)
(global-set-key (kbd "C-z h") #'resize-window-height)

(defun resize-window (width delta)
  "Resize the current window's size.  If WIDTH is non-nil, resize width by some DELTA."
  (if (> (count-windows) 1)
      (window-resize nil delta width)
    (error "You need more than 1 window to execute this function!")))

;; Setup shorcuts for window resize width and height
(global-set-key (kbd "M-J") (lambda () (interactive) (resize-window t 5)))
(global-set-key (kbd "M-L") (lambda () (interactive) (resize-window t -5)))

(global-set-key (kbd "M-I") (lambda () (interactive) (resize-window nil 5)))
(global-set-key (kbd "M-K") (lambda () (interactive) (resize-window nil -5)))

;;;;; Minions

(use-package minions
  :config (minions-mode 1)
  )

;;;;; Discover Major modes

(use-package discover-my-major
  :bind ("C-h C-m" . discover-my-major))

;;;; ORG MODE:

;; This one is actually a big mess, some things are commented because I'm
;; still working on how they fit my style or not

(use-package org
  :ensure org-plus-contrib
  :hook (
         (org-mode . (lambda ()
                       (add-hook 'completion-at-point-functions
                                 'pcomplete-completions-at-point nil t)))
         (message-mode . turn-on-orgtbl)
         (org-mode . (lambda ()
                       (autoload 'org-eldoc-documentation-function "org-eldoc")
                       (setq-local eldoc-documentation-function
                                   'org-eldoc-documentation-function)))
         (org-mode . (lambda ()
                       (push '("[ ]" . "🞎") prettify-symbols-alist)
                       (push '("[X]" . "🗹" ) prettify-symbols-alist)
                       (push '("[-]" . "❍" ) prettify-symbols-alist)
                       (prettify-symbols-mode)
                       ))
         )
  :bind* (
          ("C-c c" . org-capture)
          ("C-c a" . org-agenda)
          ("C-c l" . org-store-link)
          ("C-c b" . org-iswitchb)
          (:map org-mode-map
                ([backtab] . company-complete)
                ("C-j" . org-goto)
                )
          )
  :config
  ;; The following lines define faces for the org checkboxes that strangely
  ;; don't have face as of now
  (defface org-checkbox-todo-text
    '((t (:inherit org-todo)))
    "Face for the text part of an unchecked org-mode checkbox."
    :group 'org-faces)
  (font-lock-add-keywords
   'org-mode
   `(("^[ \t]*\\(?:[-+*]\\|[0-9]+[).]\\)[ \t]+\\(\\(?:\\[@\\(?:start:\\)?[0-9]+\\][ \t]*\\)?\\[\\(?: \\|\\([0-9]+\\)/\\2\\)\\][^\n]*\n\\)" 1 'org-checkbox-todo-text prepend))
   'append)

  (defface org-checkbox-done-text
    '((t (:inherit org-done)))
    "Face for the text part of a checked org-mode checkbox."
    :group 'org-faces)
  (font-lock-add-keywords
   'org-mode
   `(("^[ \t]*\\(?:[-+*]\\|[0-9]+[).]\\)[ \t]+\\(\\(?:\\[@\\(?:start:\\)?[0-9]+\\][ \t]*\\)?\\[\\(?:X\\|\\([0-9]+\\)/\\2\\)\\][^\n]*\n\\)" 1 'org-checkbox-done-text prepend))
   'append)

  (defface org-checkbox-intermediate-text
    '((t (:inherit org-todo)))
    "Face for the text part of an intermediate org-mode checkbox."
    :group 'org-faces)
  (font-lock-add-keywords
   'org-mode
   `(("^[ \t]*\\(?:[-+*]\\|[0-9]+[).]\\)[ \t]+\\(\\(?:\\[@\\(?:start:\\)?[0-9]+\\][ \t]*\\)?\\[\\(?:-\\|\\([0-9]+\\)/\\2\\)\\][^\n]*\n\\)" 1 'org-checkbox-intermediate-text prepend))
   'append)

  ;; ispell should not check code blocks in org mode
  (add-to-list 'ispell-skip-region-alist '(":\\(PROPERTIES\\|LOGBOOK\\):" . ":END:"))
  (add-to-list 'ispell-skip-region-alist '("#\\+BEGIN_SRC" . "#\\+END_SRC"))
  (add-to-list 'ispell-skip-region-alist '("#\\+begin_src" . "#\\+end_src"))
  (add-to-list 'ispell-skip-region-alist '("^#\\+begin_example " . "#\\+end_example$"))
  (add-to-list 'ispell-skip-region-alist '("^#\\+BEGIN_EXAMPLE " . "#\\+END_EXAMPLE$"))

  (use-package ob-dot
    :ensure nil
    :demand)
  (use-package ox-latex
    :ensure nil
    :demand)
  (use-package ox-beamer
    :ensure nil
    :demand)
  (use-package ox-md
    :ensure nil
    :demand)
  )

(use-package org-bullets
  :config
  (add-hook 'org-mode-hook (lambda () (org-bullets-mode 1))))

(use-package org-present
  :commands org-present
  )

;;;; META PROGRAMMING:

;;;;;; Separedit:

;; https://github.com/twlz0ne/separedit.le
(use-package separedit
  :ensure t
  :bind (("C-c C-e" . separedit))
  :config
  (setq separedit-default-mode 'markdown-mode)
  )

;;;;;; Conf mode:

(use-package conf-mode
  :ensure nil
  :mode (
         ("/\\.merlin\\'" . conf-mode)
         ("_oasis\\'" . conf-mode)
         ("_tags\\'" . conf-mode)
         ("_log\\'" . conf-mode)))

;;;;;; Flycheck:

;; Enabled when in prog mode
(use-package flycheck
  :hook ((prog-mode markdown-mode) . flycheck-mode)
  )

;; Quick-peek:

;; Will be used to allow seeing the inline flycheck in a stylised way
(use-package quick-peek
  :ensure t
  )

;; Flycheck inline mode:

;; Enabled when Flycheck is enabled
(use-package flycheck-inline
  :hook (flycheck-mode . flycheck-inline-mode)
  :config (setq flycheck-inline-display-function
        	(lambda (msg pos err)
                  (let* ((ov (quick-peek-overlay-ensure-at pos))
                         (contents (quick-peek-overlay-contents ov)))
                    (setf (quick-peek-overlay-contents ov)
                          (concat contents (when contents "\n") msg))
                    (quick-peek-update ov)))
                flycheck-inline-clear-function #'quick-peek-hide)
  )

;;;;;; Company mode:

;; Enabled when in prog mode
(use-package company
  :hook ((prog-mode . company-mode)
         (org-mode . company-mode))
  :bind
  ;; Autocomplete (calling company) when shift-tab
  ([backtab] . company-complete)
  )

;; (use-package company-tabnine
;;   :defer 1
;;   :custom
;;   (company-tabnine-max-num-results 9)
;;   :bind
;;   (("M-q" . company-other-backend)
;;    ("C-z t" . company-tabnine))
;;   :hook (kill-emacs . company-tabnine-kill-process)
;;   :config
;;   ;; Enable TabNine on default
;;   (add-to-list 'company-backends #'company-tabnine)
;;   )

(use-package company-math
  :preface
  (autoload 'company-math-symbols-latex "company-math")
  (autoload 'company-latex-commands "company-math")
  :hook
  (TeX-mode . (lambda ()
                (setq-local company-backends '((company-math-symbols-latex
                                                company-latex-commands
                                                company-capf)))))
  (TeX-mode . my/latex-mode-setup)
  :config
  (defun my/latex-mode-setup ()
    (setq-local company-backends
                (append '((company-math-symbols-latex company-latex-commands))
                        company-backends)))
  )

(use-package company-web
  :preface
  (autoload 'company-web-html "company-web-html")
  (autoload 'company-web-jade "company-web-jade")
  (autoload 'company-web-slim "company-web-slim")
  :hook ((web-mode . (lambda ()
                       (setq-local company-backends '(company-web-html
                                                      company-web-jade
                                                      company-web-slim
                                                      company-capf))))))
;;;;;; nlinum;

;; Configuration of the width of the line number displayed on the left
(use-package nlinum
  :config
  (setq nlinum--width (length (number-to-string (count-lines (point-min) (point-max)))))
  (global-nlinum-mode)
  )

;; smart paren;
;;
;; I'm really not confortable with electric parentheses
;;
;; (use-package smartparens
;;   :ensure t
;;   :hook (prog-mode . smartparens-mode)
;;   )

;;;;;; Aggressive indentation;

;; Should indent as you type
(use-package aggressive-indent
  :hook (prog-mode . aggressive-indent-mode)
  )

;;;;;; Bug reference;

;; Is supposed to provide links to bugs listed in source code
(use-package bug-reference
  :ensure nil
  :hook ((prog-mode . bug-reference-prog-mode)
         (text-mode . bug-reference-mode)))

;;;;;; Projectile

(use-package projectile
  :bind
  ("M-p" . projectile-command-map)
  :custom
  (projectile-completion-system 'ivy)
  :init
  (projectile-mode 1)
  ;; :config
  ;; (add-to-list 'projectile-globally-ignored-directories "node_modules")
  )

;;;;;; Jump to definition

(use-package dumb-jump
  :bind
  (:map prog-mode-map
        (("C-c C-o" . dumb-jump-go-other-window)
         ("C-c C-j" . dumb-jump-go)
         ("C-c C-i" . dumb-jump-go-prompt)))
  :custom (dumb-jump-selector 'ivy))

;;;;;; Code folding

(use-package hideshow
  :commands (hs-minor-mode
             hs-toggle-hiding)
  :init
  (add-hook 'prog-mode-hook #'hs-minor-mode)
  :diminish hs-minor-mode
  :config
  (setq hs-isearch-open t)
  :bind (("M-+" . hs-toggle-hiding)
         ("M-*" . hs-show-all))
  )

;;;; EDITING ENHANCEMENTS:

;;;;;; Multiple cursors

(use-package multiple-cursors
  :bind
  (("C-c n" . mc/mark-next-like-this)
   ("C-c p" . mc/mark-previous-like-this)
   ("C-c a" . mc/mark-all-like-this)
   )
  )

;;;;;; Delete block

(use-package delete-block
  :load-path (lambda () (expand-file-name "site-elisp/delete-block" user-emacs-directory))
  :bind
  (("M-d" . delete-block-forward)
   ("C-<backspace>" . delete-block-backward)
   ("M-<backspace>" . delete-block-backward)
   ("M-DEL" . delete-block-backward)))

;;;; SPELL CHECKING:

;; (setq ispell-dictionary "french")

(defun my-english-dict ()
  "Change dictionary to english."
  (interactive)
  (setq ispell-local-dictionary "english")
  (flyspell-mode 1)
  (flyspell-buffer))

(defun my-french-dict ()
  "Change dictionary to french."
  (interactive)
  (setq ispell-local-dictionary "french")
  (flyspell-mode 1)
  (flyspell-buffer))

(defalias 'ir #'ispell-region)
;; (add-hook 'text-mode-hook 'my-french-dict)

;; Dictionaries
(global-set-key (kbd "C-c d") 'dictionary-search)
(global-set-key (kbd "C-c D") 'dictionary-match-words)

;;;; GIT:

(use-package magit
  :bind (("C-x g" . magit-status)
         ("C-x M-g" . magit-dispatch)))

(use-package git-commit
  :hook (git-commit-mode . my-english-dict))

(use-package git-messenger
  :bind ("C-x G" . git-messenger:popup-message)
  :config
  (setq git-messenger:show-detail t
        git-messenger:use-magit-popup t))

(use-package gitignore-mode
  :mode (("/\\.gitignore\\'"      . gitignore-mode)
         ("/info/exclude\\'"      . gitignore-mode)
         ("/git/ignore\\'"        . gitignore-mode)))

;;;; LANGUAGE SPECIFIC PACKAGES:

;;;;; LaTeX:

(use-package tex-site
  :mode "\\.tex\\'"
  :hook (tex-site . turn-on-auto-fill)
  )

(use-package LaTeX-math-mode
  :hook tex-site
  )

;;;;; Cubicle:

(use-package cubicle-mode
  :mode "\\.cub$"
  )

;;;;; Why3:

(use-package why3-mode
  :load-path "custom/"
  :mode "\\.\\(\\(mlw\\)\\|\\(why\\)\\)$"
  )

;;;;; Dune:

(use-package dune-mode
  :mode ("dune" "dune-project")
  )

;;;;; Rust:

(use-package rust-mode
  :mode "\\.rs'"
  :bind ("C-M-;" . rust-doc-comment-dwim-following)
  :bind ("C-M-," . rust-doc-comment-dwim-enclosing)
  ;; :hook (rust-mode . my/rust-mode-outline-regexp-setup)
  :config
  (setq rust-format-on-save t)
  ;; (defun my/rust-mode-outline-regexp-setup ()
  ;;   (setq-local outline-regexp "///[;]\\{1,8\\}[^ \t]"))
  (defun rust-doc-comment-dwim (c)
    "Comment or uncomment the current line or text selection."
    (interactive)

    ;; If there's no text selection, comment or uncomment the line
    ;; depending whether the WHOLE line is a comment. If there is a text
    ;; selection, using the first line to determine whether to
    ;; comment/uncomment.
    (let (p1 p2)
      (if (use-region-p)
          (save-excursion
            (setq p1 (region-beginning) p2 (region-end))
            (goto-char p1)
            (if (wholeLineIsCmt-p c)
                (my-uncomment-region p1 p2 c)
              (my-comment-region p1 p2 c)
              ))
        (progn
          (if (wholeLineIsCmt-p c)
              (my-uncomment-current-line c)
            (my-comment-current-line c)
            )) )))

  (defun wholeLineIsCmt-p (c)
    (save-excursion
      (beginning-of-line 1)
      (looking-at (concat "[ \t]*//" c))
      ))

  (defun my-comment-current-line (c)
    (interactive)
    (beginning-of-line 1)
    (insert (concat "//" c))
    )

  (defun my-uncomment-current-line (c)
    "Remove “//c” (if any) in the beginning of current line."
    (interactive)
    (when (wholeLineIsCmt-p c)
      (beginning-of-line 1)
      (search-forward (concat "//" c))
      (delete-backward-char 4)
      ))

  (defun my-comment-region (p1 p2 c)
    "Add “//c” to the beginning of each line of selected text."
    (interactive "r")
    (let ((deactivate-mark nil))
      (save-excursion
        (goto-char p2)
        (while (>= (point) p1)
          (my-comment-current-line c)
          (previous-line)
          ))))

  (defun my-uncomment-region (p1 p2 c)
    "Remove “//c” (if any) in the beginning of each line of selected text."
    (interactive "r")
    (let ((deactivate-mark nil))
      (save-excursion
        (goto-char p2)
        (while (>= (point) p1)
          (my-uncomment-current-line c)
          (previous-line) )) ))

  (defun rust-doc-comment-dwim-following ()
    (interactive)
    (rust-doc-comment-dwim "/ "))
  (defun rust-doc-comment-dwim-enclosing ()
    (interactive)
    (rust-doc-comment-dwim "! "))
  )

(use-package cargo
  :hook (rust-mode . cargo-minor-mode))

(use-package racer
  :hook (rust-mode . racer-mode)
  :bind ("C-c C-t" . 'racer-find-definition))

(use-package eldoc
  :hook (racer-mode . eldoc-mode))

(use-package toml-mode
  :hook cargo)

(use-package flycheck-rust
  :hook (rust-mode . flycheck-rust-setup))

;;;;; OCaml:

(use-package opam-user-setup
  :after tuareg
  :load-path "custom/"
  :config (ignore "Loaded 'flycheck-popup")
  )

(use-package tuareg
  ;; :hook (
  ;;        (tuareg-mode . my/set-ocaml-error-regexp)
  ;;        ;; The following line will be added again when all the
  ;;        ;; small errors it's provoking will be fixed (by me)
  ;;        ;; (tuareg-mode . my/tuareg-mode-outline-regexp-setup)
  ;;        )
  ;; :config
  ;; (defun my/tuareg-mode-outline-regexp-setup ()
  ;;   (setq-local outline-regexp "(\\*[;]\\{0,8\\}[^ \t]"))
  ;; (defun my/set-ocaml-error-regexp ()
  ;;   (set
  ;;    'compilation-error-regexp-alist
  ;;    (list '("[Ff]ile \\(\"\\(.*?\\)\", line \\(-?[0-9]+\\)\\(, characters \\(-?[0-9]+\\)-\\([0-9]+\\)\\)?\\)\\(:\n\\(\\(Warning .*?\\)\\|\\(Error\\)\\):\\)?"
  ;;            2 3 (5 . 6) (9 . 11) 1 (8 compilation-message-face)))))
  )

(use-package merlin-mode
  :hook tuareg-mode
  :config (setq merlin-error-after-save nil)
  )

(use-package flycheck-ocaml
  :hook (tuareg-mode . flycheck-ocaml-setup))

(with-eval-after-load 'merlin
  ;; Disable Merlin's own error checking
  (setq merlin-error-after-save nil)

  ;; Enable Flycheck checker
  (flycheck-ocaml-setup))

(add-hook 'tuareg-mode-hook #'merlin-mode)

;;;;; Markdown:

(use-package markdown-mode
  :mode (("README\\.md\\'" . gfm-mode)
         ("\\.md\\'"       . markdown-mode)
         ("\\.markdown\\'" . gfm-mode)))

(use-package pandoc-mode
  :hook ((markdown-mode . pandoc-mode)
         (pandoc-mode . pandoc-load-default-settings)))

;;;;; Web:

(use-package web-mode
  :init
  (add-to-list 'auto-mode-alist '("\\.php\\'" . web-mode))
  :bind (:map web-mode-map
              ([backtab] . company-complete))
  )

;;;;; CSS:

(use-package css-mode
  :ensure nil
  :mode "\\.css\\'")

;;;;; JSON:

(use-package json-mode
  :mode (("\\.bowerrc$"     . json-mode)
         ("\\.jshintrc$"    . json-mode)
         ("\\.json_schema$" . json-mode)
         ("\\.json\\'" . json-mode))
  :bind (:package json-mode-map
                  :map json-mode-map
                  ("C-c <tab>" . json-mode-beautify))
  :config
  (make-local-variable 'js-indent-level))

;;;; KEY BINDINDS:


;;;;; Adjust font size like web browsers
(global-set-key (kbd "C-=") #'text-scale-increase)
(global-set-key (kbd "C-+") #'text-scale-increase)
(global-set-key (kbd "C--") #'text-scale-decrease)

;;;;; Which key:

(use-package which-key
  :init (which-key-mode)
  :config
  (which-key-add-major-mode-key-based-replacements 'markdown-mode
    "C-c TAB" "markdown/images"
    "C-c C-a" "markdown/links"
    "C-c C-c" "markdown/process"
    "C-c C-s" "markdown/style"
    "C-c C-t" "markdown/header"
    "C-c C-x" "markdown/structure"
    "C-c m" "markdown/personal")
  (which-key-add-major-mode-key-based-replacements 'web-mode
    "C-c C-a" "web/attributes"
    "C-c C-b" "web/blocks"
    "C-c C-d" "web/dom"
    "C-c C-e" "web/element"
    "C-c C-t" "web/tags")
  (which-key-setup-side-window-right-bottom)
  (setq which-key-sort-order 'which-key-key-order-alpha
        which-key-side-window-max-width 0.33
        which-key-idle-delay 0.5)
  :custom
  (which-key-separator " ")
  (which-key-prefix-prefix "+")
  )


;;;;; Global utility keys:

(global-set-key (kbd "C-c h b") 'describe-personal-keybindings)

;; Custom comment overwriting comment-dwim key binding
(global-set-key (kbd "M-;") 'comment-eclipse)
;; Create new line contextualised by the previous one
;; (will add a comment if in comment mode for example)
(global-set-key (kbd "C-<return>") 'default-indent-new-line)
;; emacs autocompletion (not like company)
(global-set-key (kbd "C-<tab>") 'dabbrev-expand)
;; emacs autocompletion in the minibuffer (search, search file, M-x etc)
(define-key minibuffer-local-map (kbd "C-<tab>") 'dabbrev-expand)

;; Shortcuts used for compilation and other bound to function keys
(global-set-key [f3] 'next-match)
(defun prev-match () (interactive nil) (next-match -1))
(global-set-key [(shift f3)] 'prev-match)
(global-set-key [f4]   'goto-line)
(global-set-key [f5]   'compile)
(global-set-key [f6]   'recompile)
(global-set-key [f7]   'next-error)
(global-set-key [f8]   'normal-mode)

(global-set-key (kbd "C-n") 'next-error)
(global-set-key (kbd "C-p") 'previous-error)

(global-set-key (kbd "M-<f1>") 'kill-this-buffer)
(global-set-key (kbd "M-g") 'goto-line)

;; Rewriting scroll up and down
(defun up-slightly () (interactive) (scroll-up 5))
(defun down-slightly () (interactive) (scroll-down 5))

(global-set-key [mouse-4]   'down-slightly)
(global-set-key [mouse-5]   'up-slightly)

;; enable toggling paragraph un-fill
(define-key global-map (kbd "M-Q") 'unfill-paragraph)
;; *****************************************************************************

;;;;; Window management (move):

;; windmove
(global-set-key (kbd "C-x <left>") 'windmove-left)
(global-set-key (kbd "C-x <right>") 'windmove-right)
(global-set-key (kbd "C-x <up>") 'windmove-up)
(global-set-key (kbd "C-x <down>") 'windmove-down)

;; Store and recall window layouts (views!)
(global-set-key (kbd "C-c v") 'ivy-push-view)
(global-set-key (kbd "C-c V") 'ivy-switch-view)

;; use ace-window for navigating windows
(global-set-key (kbd "C-x C-o") 'ace-window)
(with-eval-after-load "ace-window"
  (setq aw-dispatch-always t)
  (set-face-attribute 'aw-leading-char-face nil :height 2.5))

;; rotate buffers and window arrangements
(global-set-key (kbd "C-c r w") 'rotate-window)
(global-set-key (kbd "C-c r l") 'rotate-layout)
;; *****************************************************************************

;;;; Footer

;; End:
(provide 'init)

;;; init.el ends here
