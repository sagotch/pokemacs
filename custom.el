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
 '(auth-source-save-behavior nil)
 '(describe-char-unidata-list
   '(name old-name general-category decomposition decimal-digit-value digit-value numeric-value))
 '(electric-indent-mode t)
 '(org-export-backends '(ascii html icalendar latex md odt pandoc))
 '(package-selected-packages
   '(counsel-spotify cheatsheet keycast git-timemachine pulsar auto-package-update restart-emacs diff-hl magit-todos lsp-docker hide-mode-line async ghub anzu command-log-mode python-mode yapfify pyvenv lsp-pyright pyenv-mode dap-mode apheleia org-pdftools org-appear xr org-inline-pdf pandoc ox-gfm markdown-preview-mode dune-format abbrev ace-window all-the-icons all-the-icons-dired all-the-icons-ivy all-the-icons-ivy-rich amx auctex auctex-latexmk auto-complete auto-complete-auctex calfw calfw-org caml-debug caml-mode cargo cdlatex company-auctex company-box company-math company-prescient company-quickhelp company-racer company-web counsel counsel-projectile crux cubicle-mode dash dash-functional delight dictionary diminish discover-my-major doom-modeline doom-themes dumb-jump dune dune-mode elm-mode flycheck flycheck-inline flycheck-rust flyspell-correct flyspell-correct-ivy flyspell-correct-popup fsharp-mode general git-commit git-messenger gitignore-mode god-mode helpful highlight-indent-guides ivy-avy ivy-bibtex ivy-posframe ivy-prescient ivy-rich json-mode LaTeX-math-mode lsp-ivy lsp-mode lsp-treemacs lsp-ui magit merlin-mode minions multiple-cursors nlinum no-littering ob-rust org-bullets org-make-toc org-plus-contrib org-present org-protocol org-ref org-super-agenda outline-minor-faces outshine ox-pandoc pandoc-mode pdf-tools php-mode pretty-outlines projectile quick-peek racer rainbow-delimiters rainbow-mode ripgrep rotate run-ocaml rust-mode saveplace-pdf-view selected separedit smex sort-words tex-site toml-mode treemacs treemacs-all-the-icons treemacs-icons-dired treemacs-magit treemacs-projectile undo-tree unfill use-package use-package-ensure-system-package utop visual-fill-column vlf web-mode wgrep which-key why3-mode ws-butler yaml-mode yasnippet z3-mode zzz-to-char))

 ;; Doom modeline config
 '(doom-modeline-bar-width 4)
 '(doom-modeline-height 25)
 ;;- Doom modeline config

 ;; Choose between:
 ;;  - 'parenthesis:  show the matching paren
 ;;  - 'expression: show the entire expression enclosed by the paren
 ;;  - 'mixed: show the matching paren if it is visible, and the expression otherwise
 '(show-paren-style 'expression)

 ;; Enable or disable functionalities
 '(use-company t)
 '(use-fsharp t)
 '(use-god nil)
 '(use-latex nil)
 '(use-markdown t)
 '(use-ocaml t)
 '(use-org t)
 '(use-python t)
 '(use-rainbow t)
 '(use-reason nil)
 '(use-rust t)
 '(use-smt t)
 '(use-spotify nil)
 '(use-treemacs t)
 '(use-usuba nil)
 '(use-vertical-split nil)
 '(use-visual-fill t)
 '(use-web t)
 )

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "Fira Code" :slant normal :weight normal :height 136 :width normal :foundry "CTDB"))))
 '(fixed-pitch ((t (:family "Fira Code" :slant normal :weight normal :height 136 :width normal :foundry "CTDB"))))
 '(lsp-lens-face ((t (:family "Fira Code" :foundry "CTDB" :inherit lsp-details-face))))
 '(menu ((t (:inherit mode-line))))
 '(mode-line ((nil :family "Fira Code" :height 140)))
 '(mode-line-inactive ((nil :family "Fira Code" :height 140)))
 '(org-block ((t (:inherit fixed-pitch))))
 '(org-document-info-keyword ((t (:inherit (shadow fixed-pitch)))))
 '(org-document-title ((t (:inherit variable-pitch :height 1.4 :weight bold :foreground "#c678dd"))))
 '(org-level-1 ((t (:inherit variable-pitch :height 1.7 :weight bold :foreground "#51afef"))))
 '(org-level-2 ((t (:inherit variable-pitch :height 1.4 :weight bold :foreground "#c678dd"))))
 '(org-level-3 ((t (:inherit variable-pitch :height 1.2 :weight bold :foreground "#a9a1e1"))))
 '(org-level-4 ((t (:inherit variable-pitch :height 1.1 :weight bold :foreground "#7cc3f3"))))
 '(org-level-5 ((t (:inherit variable-pitch :height 1.0 :weight bold))))
 '(org-level-6 ((t (:inherit variable-pitch :height 1.0 :weight bold))))
 '(org-level-7 ((t (:inherit variable-pitch :height 1.0 :weight bold))))
 '(org-level-8 ((t (:inherit variable-pitch :height 1.0 :weight bold))))
 '(org-property-value ((t (:inherit fixed-pitch))) t)
 '(org-special-keyword ((t (:inherit (font-lock-comment-face fixed-pitch)))))
 '(org-tag ((t (:inherit (shadow fixed-pitch) :weight bold))))
 '(org-verbatim ((t (:inherit (shadow fixed-pitch)))))
 '(show-paren-match ((t (:background "sienna" :weight normal))))
 '(variable-pitch ((t (:family "Ubuntu" :height 136 :weight thin)))))

(provide 'custom)
;;; custom.el ends here
