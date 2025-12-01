# Doom Emacs Setup (Void Linux + macOS)

A complete guide for configuring **Doom Emacs** with:

- GitHub Copilot integration  
- LSP support for: React, Vue, Angular, Svelte, TypeScript, JavaScript  
- Backend support: Go, Python, .NET, Rust, PHP, Ruby, Kotlin, Java  
- Rosé Pine theme  
- Modern AI keybindings (`SPC a`)  
- Multi-platform installation steps (Void Linux + macOS)

This setup is tuned for a full-stack workflow using Doom Emacs as a modern IDE.

---

## ⚡ Supported Languages

Doom modules and external language servers support:

- **Frontend:** React, Vue, Svelte, Angular, HTML, CSS  
- **JavaScript / TypeScript**  
- **Backend:** Go, Python, PHP, Ruby, Rust, C#, Kotlin, Java  
- **DevOps:** Bash, YAML, Docker  
- **Docs:** Markdown  

---

# 🚀 1. Install Dependencies

---

## 🟣 Void Linux

### Install core tools
```bash
sudo xbps-install -S \
  emacs-gtk3 git ripgrep fd fzf gnutls \
  nodejs npm python3 go rust cargo openjdk
```

### Install Node-based language servers
```bash
sudo npm install -g \
  typescript typescript-language-server \
  vscode-langservers-extracted \
  svelte-language-server \
  @vue/language-server \
  angular-language-server \
  pyright \
  bash-language-server \
  yaml-language-server \
  dockerfile-language-server-nodejs
```

### Additional LSP servers
```bash
sudo xbps-install -S gopls jdtls kotlin-language-server omnisharp-roslyn php
sudo gem install solargraph      # Ruby
cargo install rust-analyzer      # Rust
```

---

## 🍎 macOS

### Install Homebrew (if needed)
```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

### Core packages
```bash
brew install emacs-plus ripgrep fd fzf git \
             node npm python go rust gnutls \
             openjdk kotlin-language-server
```

### Node-based servers
```bash
npm install -g \
  typescript typescript-language-server \
  vscode-langservers-extracted \
  svelte-language-server \
  @vue/language-server \
  angular-language-server \
  pyright \
  yaml-language-server \
  bash-language-server \
  dockerfile-language-server-nodejs
```

### Additional
```bash
brew install gopls jdtls php
gem install solargraph
cargo install rust-analyzer
brew install omnisharp
```

---

# 🎯 2. Install Doom Emacs

```bash
git clone --depth 1 https://github.com/doomemacs/doomemacs ~/.emacs.d
~/.emacs.d/bin/doom install
```

Choose **Y** when asked to generate `env` files.

Create your config directory:

```bash
mkdir -p ~/.doom.d
```

---

# 💾 3. Required Configuration Files

Place the following files in:

```
~/.doom.d/
├── init.el
├── config.el
└── packages.el
```

---

## init.el

```elisp
(doom!
 :completion (company +childframe) (vertico +icons)

 :ui doom modeline hl-todo popup (vc-gutter +pretty) workspaces treemacs

 :editor (evil +everywhere) file-templates fold (format +onsave) snippets

 :emacs (dired +icons) electric undo vc

 :term vterm

 :checkers syntax (spell +everywhere) grammar

 :tools (eval +overlay) (lookup +dictionary +offline) (lsp +peek) magit rgb tree-sitter docker

 :lang
 (web +lsp)
 (javascript +lsp)
 (json +lsp)
 (go +lsp)
 (python +lsp +pyright)
 (csharp +lsp)
 (rust +lsp)
 (php +lsp)
 (ruby +lsp)
 (kotlin +lsp)
 (java +lsp)
 (markdown +grip)
 yaml sh

 :config (default +bindings +smartparens))
```

---

## packages.el

```elisp
(package! svelte-mode)
(package! vue-mode)
(package! rose-pine-theme)

(package! copilot
  :recipe (:host github :repo "zerolfx/copilot.el"
           :files ("*.el" "dist")))
```

---

## config.el

```elisp
;; Theme
(setq doom-theme 'rose-pine-moon)

;; Project directories
(after! projectile
  (setq projectile-project-search-path '("~/projects" "~/code" "~/src")))

;; --------------------
;; Copilot Integration
;; --------------------
(use-package! copilot
  :hook (prog-mode . copilot-mode)
  :config
  ;; Don’t clutter modeline
  (delq 'copilot-mode minor-mode-list)

  ;; Inline suggestion controls
  (define-key copilot-mode-map (kbd "C-<tab>") #'copilot-accept-completion)
  (define-key copilot-mode-map (kbd "M-\\")    #'copilot-accept-completion)
  (define-key copilot-mode-map (kbd "C-]")     #'copilot-next-completion)
  (define-key copilot-mode-map (kbd "C-[")     #'copilot-previous-completion)
  (define-key copilot-mode-map (kbd "C-;")     #'copilot-clear-overlay))

;; --------------------
;; AI Prefix: SPC a
;; --------------------
(map! :leader "a" nil)  ;; unbind SPC a

(map! :leader
      (:prefix-map ("a" . "AI")
       :desc "Accept completion"  "a" #'copilot-accept-completion
       :desc "Next suggestion"    "n" #'copilot-next-completion
       :desc "Previous suggestion" "p" #'copilot-previous-completion
       :desc "Clear suggestion"   "c" #'copilot-clear-overlay))
```

---

# 🌸 4. Theme Options (Rosé Pine)

Pick one:

```elisp
(setq doom-theme 'rose-pine)
(setq doom-theme 'rose-pine-moon)
(setq doom-theme 'rose-pine-dawn)
```

---

# 🤖 5. Activate GitHub Copilot

Inside any programming buffer:

```
M-x copilot-login
```

Follow the GitHub browser prompt.

Ghost text suggestions begin automatically.

---

# ⌨️ 6. Keybindings (AI)

| Key | Action |
|-----|--------|
| `SPC a a` | Accept Copilot suggestion |
| `SPC a n` | Next suggestion |
| `SPC a p` | Previous suggestion |
| `SPC a c` | Clear suggestion |
| `C-<tab>` | Accept |
| `M-\` | Accept |
| `C-]` | Next |
| `C-[` | Previous |
| `C-;` | Dismiss |

---

# 🔧 7. Sync Doom

Whenever you modify config:

```bash
~/.emacs.d/bin/doom sync
```

Restart Emacs:

```
SPC q r
```

---

# 🧪 8. Troubleshooting

### Regenerate environment
```bash
~/.emacs.d/bin/doom env
```

### Copilot debug
```bash
M-x copilot-diagnose
```

### Update all Doom packages
```bash
doom upgrade
```

---

# 🧡 Credits

Built with:

- Doom Emacs  
- Rosé Pine  
- GitHub Copilot  
- Tree-sitter + LSP  

Happy hacking! ✨
