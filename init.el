;;; init.el -*- lexical-binding: t; -*-

(doom!
 :input

 :completion
 (company +childframe)
 (vertico +icons)

 :ui
 doom
 doom-dashboard
 doom-quit
 hl-todo
 indent-guides
 ligatures
 modeline
 nav-flash
 ophints
 (popup +defaults)
 tabs
 treemacs
 (vc-gutter +pretty)
 workspaces
 zen

 :editor
 (evil +everywhere)
 file-templates
 fold
 (format +onsave)
 multiple-cursors
 snippets
 word-wrap

 :emacs
 (dired +icons)
 electric
 (ibuffer +icons)
 undo
 vc

 :term
 vterm

 :checkers
 syntax
 (spell +flyspell +everywhere)
 grammar

 :tools
 (eval +overlay)
 (lookup +dictionary +offline)
 (lsp +peek)
 (magit +forge)
 pdf
 rgb
 tree-sitter
 docker

 :lang
 ;; Web stack
 (web +lsp)                ; HTML, CSS, JS/TS (React & Angular work here)
 (javascript +lsp)         ; TS/JS direct support
 (json +lsp)

 ;; Frameworks not covered by Doom defaults
 ;; Svelte & Vue are added in packages.el

 ;; Backend languages
 (go +lsp)
 (python +lsp +pyright)
 (csharp +lsp)             ; .NET / OmniSharp
 (rust +lsp)
 (php +lsp)
 (ruby +lsp)
 (kotlin +lsp)
 (java +lsp)

 ;; Docs
 (markdown +grip)

 yaml
 sh

 :config
 (default +bindings +smartparens))
