;;; package --- Customization for emacs
;;; Commentary:
;;; Global customization should be made with M-x customize-variable/face
;;; so everything can be found in this file
;;;
;;; If there is any question about what these variables/faces do just
;;; M-x customize-variable/face <ret> name_of_the_variable/face and see the doc
;;; Code:
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ac-use-fuzzy nil)
 '(ansi-color-names-vector
   ["#424242" "#EF9A9A" "#C5E1A5" "#FFEE58" "#64B5F6" "#E1BEE7" "#80DEEA" "#E0E0E0"])
 '(backup-directory-alist (quote (("." . "~/.local/share/emacs/backups"))))
 '(beacon-color "#ed0547ad8099")
 '(blink-matching-paren t)
 '(blink-matching-paren-dont-ignore-comments t)
 '(blink-matching-paren-on-screen t)
 '(column-number-mode t)
 '(comment-style (quote indent))
 ;; '(company-idle-delay nil)
 '(company-minimum-prefix-length 1)
 '(company-show-numbers (quote (quote left)))
 '(company-tooltip-align-annotations t)
 '(compilation-always-kill t)
 '(compilation-ask-about-save nil)
 '(compilation-context-lines 2)
 '(compilation-error-screen-columns nil)
 '(compilation-scroll-output nil)
 '(compilation-search-path (quote (nil "src")))
 '(compilation-window-height 12)
 '(delete-selection-mode t)
 '(electric-indent-mode nil)
 '(enable-recursive-minibuffers t)
 '(evil-emacs-state-cursor (quote ("#E57373" hbar)))
 '(evil-insert-state-cursor (quote ("#E57373" bar)))
 '(evil-normal-state-cursor (quote ("#FFEE58" box)))
 '(evil-visual-state-cursor (quote ("#C5E1A5" box)))
 '(font-lock-global-modes t)
 '(global-auto-revert-mode t)
 '(global-nlinum-mode t)
 '(global-prettify-symbols-mode t)
 '(highlight-indent-guides-auto-enabled nil)
 '(highlight-symbol-colors
   (quote
    ("#FFEE58" "#C5E1A5" "#80DEEA" "#64B5F6" "#E1BEE7" "#FFCC80")))
 '(highlight-symbol-foreground-color "#E0E0E0")
 '(highlight-tail-colors (quote (("#ed0547ad8099" . 0) ("#424242" . 100))))
 '(indent-tabs-mode nil)
 '(inhibit-startup-screen t)
 '(initial-major-mode (quote text-mode))
 '(ivy-count-format "%d/%d ")
 '(ivy-height 10)
 '(ivy-use-selectable-prompt t)
 '(ivy-use-virtual-buffers t)
 '(ivy-wrap t)
 '(line-move-visual t)
 '(minions-mode t)
 '(minions-mode-line-lighter "☰")
 '(next-error-highlight t)
 '(next-error-highlight-no-select t)
 '(next-line-add-newlines nil)
 '(org-startup-truncated nil)
 '(org-support-shift-select (quote always))
 '(outshine-preserve-delimiter-whitespace nil)
 '(package-selected-packages
   (quote
    (merlin-mode tuareg dumb-jump flycheck discover-my-major amx abbrev rust-mode use-package-ensure-system-package crux outline-minor-faces pretty-outlines dash-functional outshine json-mode run-ocaml dune-mode why3-mode LaTeX-math-mode tex-site gitignore-mode org-present diminish delight org-bullets rainbow-mode aggressive-indent all-the-icons all-the-icons-ivy apropospriate-theme auctex auto-complete caml-debug caml-mode cargo company-math company-racer company-web counsel cubicle-mode dictionary dune flycheck-inline flycheck-ocaml flycheck-rust git-messenger magit merlin-eldoc minions multiple-cursors nlinum org-plus-contrib pandoc-mode php-mode quick-peek racer rotate separedit smartparens smex sort-words toml-mode undo-tree unfill use-package vlf web-mode which-key)))
 '(pos-tip-background-color "#3a933a933a93")
 '(pos-tip-foreground-color "#9E9E9E")
 '(prettify-symbols-unprettify-at-point nil)
 '(require-final-newline t)
 '(save-abbrevs (quote silently))
 '(save-interprogram-paste-before-kill t)
 '(save-place-mode t)
 '(scroll-bar-mode nil)
 '(sentence-end-double-space nil)
 '(show-paren-delay 0)
 '(show-paren-mode t)
 '(show-paren-style (quote expression))
 '(show-trailing-whitespace t)
 '(tabbar-background-color "#357535753575")
 '(tool-bar-mode nil)
 '(truncate-lines nil)
 '(tuareg-electric-indent t)
 '(tuareg-prettify-symbols-full t)
 '(use-package-verbose t)
 '(visible-bell t))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:inherit nil :extend nil :stipple nil :background "#2e3436" :foreground "#eeeeec" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 136 :width normal :foundry "CTDB" :family "Fira Code"))))
 '(ivy-current-match ((t (:extend t :background "dark olive green"))))
 '(outshine-level-1 ((t (:inherit outline-1 :foreground "sienna" :underline t))))
 '(show-paren-match ((t (:background "indian red" :underline nil))))
 '(variable-pitch ((t (:family "ETBembo" :height 180 :weight thin)))))
(provide 'custom)
;;; custom.el ends here
