;;; packages.el -*- lexical-binding: t; -*-

(package! svelte-mode)
(package! vue-mode)

(package! lsp-mode) ;; reinforces LSP for Vue/Svelte
(package! lsp-ui)
(package! lsp-treemacs)

;; Optional prettier formatting
(package! prettier-js)
(package! modus-themes)

;; GitHub Copilot AI assistance
(package! copilot :recipe (:host github :repo "zerolfx/copilot.el" :files ("*.el" "dist")))
