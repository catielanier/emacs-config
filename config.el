;;; config.el -*- lexical-binding: t; -*-

;; -----------------------------
;; Identity
;; -----------------------------
(setq user-full-name "Catie Lanier"
      user-mail-address "hello@catielanier.ca")

;; -----------------------------
;; Theme & UI
;; -----------------------------
;; Using Rose Pine Moon (make sure (package! rose-pine-theme) is in packages.el)
(setq doom-theme 'modus-operandi)

;; Relative line numbers like vim
(setq display-line-numbers-type 'relative)

;; Fonts – tweak sizes if needed
(setq doom-font (font-spec :family "JetBrains Mono" :size 13)
      doom-variable-pitch-font (font-spec :family "Inter" :size 13)
      doom-big-font (font-spec :family "JetBrains Mono" :size 18))

;; Smoother scrolling
(pixel-scroll-precision-mode 1)

;; Highlight current line and show column number
(global-hl-line-mode 1)
(column-number-mode 1)

;; -----------------------------
;; Treemacs
;; -----------------------------
(after! treemacs
  (setq treemacs-position 'left
        treemacs-width 32))

;; -----------------------------
;; Window navigation: Alt + h/j/k/l
;; -----------------------------
(map! :n "M-h" #'windmove-left
      :n "M-j" #'windmove-down
      :n "M-k" #'windmove-up
      :n "M-l" #'windmove-right
      :i "M-h" #'windmove-left
      :i "M-j" #'windmove-down
      :i "M-k" #'windmove-up
      :i "M-l" #'windmove-right
      :v "M-h" #'windmove-left
      :v "M-j" #'windmove-down
      :v "M-k" #'windmove-up
      :v "M-l" #'windmove-right)

;; -----------------------------
;; Editing defaults
;; -----------------------------
(setq confirm-kill-emacs nil      ; no dramatic “really quit?” prompt
      tab-width 4
      indent-tabs-mode nil)       ; spaces over tabs

;; -----------------------------
;; Org pretties
;; -----------------------------
(after! org
  (setq org-hide-emphasis-markers t
        org-ellipsis "…"
        org-startup-indented t))

;; -----------------------------
;; Projectile / projects
;; -----------------------------
(after! projectile
  (setq projectile-project-search-path '("~/projects" "~/code" "~/src")))

;; -----------------------------
;; Quick leader bindings
;; -----------------------------
(map! :leader
      :desc "Open vterm" "o t" #'vterm
      :desc "Magit status" "g g" #'magit-status)

;; -----------------------------
;; LSP setup – shared behavior
;; -----------------------------
(after! lsp-mode
  (setq lsp-headerline-breadcrumb-enable t
        lsp-enable-on-type-formatting t
        lsp-signature-auto-activate t
        lsp-ui-doc-delay 0.1
        lsp-idle-delay 0.2
        lsp-log-io nil))

;; Enable LSP for all your languages
(dolist (hook '(js-mode-hook
                js-ts-mode-hook
                typescript-ts-mode-hook
                tsx-ts-mode-hook
                web-mode-hook
                html-mode-hook
                css-mode-hook
                json-mode-hook
                go-mode-hook
                python-mode-hook
                csharp-mode-hook
                rust-mode-hook
                php-mode-hook
                php-ts-mode-hook
                ruby-mode-hook
                kotlin-mode-hook
                java-mode-hook
                svelte-mode-hook
                vue-mode-hook
                sh-mode-hook
                yaml-mode-hook))
  (add-hook hook #'lsp-deferred))

;; -----------------------------
;; Svelte & Vue modes
;; (packages.el must have: (package! svelte-mode) (package! vue-mode))
;; -----------------------------
(use-package! svelte-mode
  :mode "\\.svelte\\'"
  :hook (svelte-mode . lsp-deferred))

(use-package! vue-mode
  :mode "\\.vue\\'"
  :hook (vue-mode . lsp-deferred))

;; -----------------------------
;; Copilot configuration (GitHub Copilot)
;; -----------------------------
;; packages.el must contain:
;; (package! copilot :recipe (:host github :repo "zerolfx/copilot.el" :files ("*.el" "dist")))
(use-package! copilot
  :hook (prog-mode . copilot-mode)   ;; enable in all programming modes
  :config
  ;; Don't show minor mode in modeline list
  (delq 'copilot-mode minor-mode-list)

  ;; Accept suggestions with C-<tab> or M-\
  (define-key copilot-mode-map (kbd "C-<tab>") #'copilot-accept-completion)
  (define-key copilot-mode-map (kbd "M-\\")    #'copilot-accept-completion)

  ;; Cycle through suggestions
  (define-key copilot-mode-map (kbd "C-]") #'copilot-next-completion)
  (define-key copilot-mode-map (kbd "C-[") #'copilot-previous-completion)

  ;; Dismiss suggestion
  (define-key copilot-mode-map (kbd "C-;") #'copilot-clear-overlay))

;; Leader-key prefix for AI things: SPC a …
(map! :leader
      (:prefix-map ("a" . "AI")
       :desc "Copilot accept"   "a" #'copilot-accept-completion
       :desc "Copilot next"     "n" #'copilot-next-completion
       :desc "Copilot previous" "p" #'copilot-previous-completion
       :desc "Copilot clear"    "c" #'copilot-clear-overlay))
