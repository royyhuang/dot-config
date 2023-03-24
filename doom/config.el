;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
(setq user-full-name "Roy Huang"
      user-mail-address "roy.y.huang@gmail.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-unicode-font' -- for unicode glyphs
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
;;
(setq doom-font (font-spec
                 :family "JetBrainsMono Nerd Font Mono"
                 :size 12
                 :weight 'medium)
      doom-unicode-font (font-spec
                         :family "JetBrainsMono Nerd Font Mono"
                         :size 12
                         :weight 'medium))

;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;;
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-material)
(setq doom-themes-treemacs-enable-variable-pitch nil)

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type 'relative)

;; set fill-column and display fill column with character
(setq-default fill-column 80
              display-fill-column-indicator-column t)
(add-hook! (text-mode prog-mode) 'display-fill-column-indicator-mode)

;; default frame size
(add-to-list 'default-frame-alist '(height . 50))
(add-to-list 'default-frame-alist '(width . 160))

;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `after!' block, otherwise Doom's defaults may override your settings. E.g.
;;
;;   (after! PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look up their documentation).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;)
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;; Alternatively, use `C-h o' to look up a symbol (functions, variables, faces,
;; etc)
;;

(use-package! tramp
  :config
  (add-to-list 'tramp-remote-path 'tramp-own-remote-path )
  (add-to-list 'tramp-remote-path "/home/yuyangh/.local/bin")
  (add-to-list 'tramp-remote-path "/home/cc/.local/bin")
  (add-to-list 'tramp-connection-properties
               (list (regexp-quote "/ssh:yuyangh@[a-zA-z0-9]*[.]cs[.]uchicago[.]edu:")
                     "remote-shell" "/bin/bash"))
  )

(use-package! lsp
  :config
  (add-hook! lsp-mode 'lsp-headerline-breadcrumb-mode)
  (add-hook! lsp-mode 'lsp-lens-mode)
  (setq lsp-ui-sideline-enable nil))

;; lsp-ltex config
(use-package! lsp-ltex
  :init
  (setenv "JAVA_HOME" "/Library/Java/JavaVirtualMachines/temurin-19.jdk/Contents/Home")
  (setq! lsp-ltex-version "16.0.0")
  :hook
  (text-mode . (lambda () (require 'lsp-ltex) (lsp)))
  :config
  (setq lsp-ltex-check-frequency "edit"))

;; AucTeX
(use-package! latex
  :init
  (setenv "PATH" (concat "/Library/TeX/texbin" ":" (getenv "PATH")))
  (add-hook! LaTeX-mode 'LaTeX-math-mode
                        'auto-fill-mode)
  :config
  (setq TeX-auto-save t
        TeX-parse-self t
        TeX-PDF-mode t
        reftex-plug-into-AUCTeX t
        reftex-default-bibliography "referece.bib")
  (setq-default TeX-master "main"))

(use-package! eshell
  :config
  (setq +eshell-kill-window-on-exit t))

;; Keymap
(use-package! general
  :config
  (general-define-key
   :states '(motion normal)
   :keymaps 'override
   "C-h" 'evil-window-left
   "C-j" 'evil-window-down
   "C-k" 'evil-window-up
   "C-l" 'evil-window-right
   "C-t" '+vterm/toggle)
  (general-define-key
   :states '(insert)
   :keymaps 'override
   "C-t" '+vterm/toggle))

(use-package! evil
  :config
  (define-key evil-normal-state-map "j" 'evil-next-visual-line)
  (define-key evil-normal-state-map "k" 'evil-previous-visual-line)
  (setq evil-ex-substitute-global t)
  )

(use-package! key-chord
  :config
  (key-chord-define evil-insert-state-map "jj" 'evil-normal-state)
  (key-chord-mode 1))

;; org
(defun display-ansi-colors ()
  (ansi-color-apply-on-region (point-min) (point-max)))
(use-package! org
  :init
  (add-hook! org-mode #'auto-fill-mode)
  (add-hook! 'org-babel-after-execute-hook #'display-ansi-colors)
  :config
  (setq prettify-symbols-alist '(("#+end_quote" . "”")
                                 ("#+END_QUOTE" . "”")
                                 ("#+begin_quote" . "“")
                                 ("#+BEGIN_QUOTE" . "“")
                                 ("#+end_src" . "«")
                                 ("#+END_SRC" . "«")
                                 ("#+begin_src" . "»")
                                 ("#+BEGIN_SRC" . "»")
                                 ("#+name:" . "»")
                                 ("#+NAME:" . "»"))
        org-directory "~/org/"
        org-refile-targets '((org-agenda-files :maxlevel . 3))
        org-image-actual-width (list 500)
        org-hide-emphasis-markers t
        org-fontify-done-headline nil
        org-pretty-entities t)
  (org-babel-do-load-languages
   'org-babel-load-languages
   '((emacs-lisp . t)
     (shell . t)
     (python . t)
     (jupyter . t)))
  (setq org-babel-default-header-args:jupyter-python '((:async . "yes")
                                                       (:session . "py")
                                                       (:kernel . "python3")
                                                       (:results . "scalar"))
        org-babel-default-header-args:bash '((:async . "yes"))
        org-babel-default-header-args:sh '((:async . "yes"))
        org-babel-default-header-args:shell '((:async . "yes"))
        jupyter-eval-short-result-max-lines 10
        ob-async-no-async-languages-alist '("jupyter-python" "jupyter-julia" "python"))

)

(use-package! olivetti
  :init
  (add-hook 'olivetti-mode-on-hook
            (lambda ()
              (set-face-attribute 'olivetti-fringe nil :background "#1E262A")
              (display-line-numbers-mode -1)
              (vi-tilde-fringe-mode -1)
              (display-fill-column-indicator-mode -1)))

  (add-hook 'olivetti-mode-off-hook
            (lambda ()
              (set-face-attribute 'olivetti-fringe nil :background nil)
              (display-line-numbers-mode t)
              (vi-tilde-fringe-mode t)
              (display-fill-column-indicator-mode t)))
  :config
  (setq-default olivetti-margin-width 15)
  (setq-default olivetti-style 'fancy)
  (setq-default olivetti-body-width 86)
  )

(use-package! tree-sitter
  :init
  (add-hook! python-mode #'tree-sitter-hl-mode)
  (add-hook! c-mode #'tree-sitter-hl-mode)
  (add-hook! c++-mode #'tree-sitter-hl-mode))

(use-package! flycheck-pos-tip
  :after flycheck
  :config (add-hook 'flycheck-mode-hook #'flycheck-pos-tip-mode))

(use-package! treemacs
  :config
  (treemacs-project-follow-mode 1))

(use-package! company
  :config
  (setq +company-backend-alist (assq-delete-all 'text-mode +company-backend-alist))
  (add-to-list '+company-backend-alist '(text-mode (:separate company-dabbrev company-yasnippet))))
