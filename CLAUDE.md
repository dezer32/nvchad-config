# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

This is a personal Neovim configuration repository built on top of NvChad v2.5. The main NvChad repo (NvChad/NvChad) is used as a plugin, and this config imports its modules and extends them with custom configurations.

## Architecture

### Entry Point
- `init.lua` - Bootstraps lazy.nvim plugin manager, loads NvChad base, imports custom plugins, and initializes the PHP namespace module

### Configuration Structure
```
lua/
├── chadrc.lua              # NvChad theme and UI configuration
├── options.lua             # Vim options and snippet loading
├── mappings.lua            # Custom keybindings (extends nvchad.mappings)
├── configs/                # Plugin-specific configurations
│   ├── conform.lua         # Code formatting setup
│   ├── lazy.lua            # Lazy.nvim configuration
│   ├── lspconfig.lua       # LSP server configurations
│   ├── nvim-lint.lua       # Linting configuration
│   └── snippets/           # Custom snippets
├── modules/                # Custom Lua modules
│   └── php_namespace/      # PHP namespace auto-generation
└── plugins/                # Plugin declarations
    ├── init.lua            # Core plugins (conform, lspconfig)
    └── [various].lua       # Individual plugin configs
```

### Key Design Patterns

**Plugin Management**: Uses lazy.nvim with lazy-loading enabled by default. NvChad is imported as a plugin with `import = "nvchad.plugins"`, and custom plugins are imported via `{ import = "plugins" }`.

**Configuration Override Pattern**: Custom configs extend NvChad defaults:
- `require "nvchad.options"` then override specific options
- `require "nvchad.mappings"` then add/override keybindings
- LSP `on_attach` is overridden to use FZF-lua for LSP navigation

**LSP Integration**: Uses the modern `vim.lsp.config` API (Neovim 0.11+) instead of the deprecated `require('lspconfig')` framework. All LSP navigation commands (definitions, references, implementations) are routed through FZF-lua for a unified fuzzy-finding experience.

## Language Server Setup

### Configured LSP Servers
- `lua_ls` - Lua with Neovim-specific configuration
- `html` - HTML
- `cssls` - CSS
- `ts_ls` - TypeScript/JavaScript with inlay hints
- `pyright` - Python with type checking
- `gopls` - Go with static check and gofumpt
- `jsonls` - JSON with schema store integration
- `yamlls` - YAML with Kubernetes schemas
- `dockerls` - Dockerfile
- `docker_compose_language_service` - Docker Compose
- `intelephense` - PHP (requires license key in `~/.intelephense`)

### LSP Keybindings (in lua/configs/lspconfig.lua)
All LSP navigation uses FZF-lua:
- `ga` - LSP finder (all references/definitions/implementations)
- `gi` - Implementations
- `gr` - References
- `gd` - Definitions
- `gD` - Declarations
- `gt` - Type definitions
- `<leader>ca` - Code actions
- `<leader>ds` - Document diagnostics

## Code Formatting

Format-on-save is enabled with 500ms timeout via conform.nvim:
- Lua: stylua (config in `.stylua.toml`)
- PHP: php_cs_fixer
- HTML/CSS: prettier
- JSON: fixjson

### Stylua Configuration
Column width: 120, Unix line endings, 2-space indentation, auto-prefer double quotes, no call parentheses.

## PHP Development Features

### PHP Namespace Auto-Generation
Custom module at `lua/modules/php_namespace/init.lua` provides PSR-4 compliant namespace generation.

**How it works**:
1. Finds project root by looking for `.git` or `composer.json`
2. Reads PSR-4 autoload configuration from `composer.json`
3. Generates namespace based on file path relative to PSR-4 base directory
4. Falls back to directory structure if PSR-4 config not found

**Command**: `:GenerateNamespace`

## Key Plugins

- **FZF-lua**: Primary fuzzy finder (replaces Telescope for most operations)
- **Spectre**: Find and replace across project
- **Leap/Easymotion**: Quick navigation
- **Copilot**: AI code completion
- **Lazygit**: Git integration
- **LSPSaga**: Enhanced LSP UI
- **nvim-lint**: Linting
- **Auto-save**: Automatic file saving
- **Surround**: Surround text objects

## Custom Keybindings (lua/mappings.lua)

### Buffer Navigation
- `[b` - Previous buffer
- `]b` - Next buffer

### File Operations
- `<C-s>` - Save (normal/insert/visual)
- `<leader>w` - Save (normal)
- `jk`, `jj` - Exit insert mode

### FZF-lua Fuzzy Finding
- `<leader>ff` - Find files (tracked)
- `<leader>fa` - Find all files (including ignored)
- `<leader>fb` - Find buffers
- `<leader>fw` - Live grep
- `<leader>gs` - Document symbols
- `<leader>fc` - Find classes (workspace symbols filtered)
- `<leader>gb` - Git blame
- `<leader>gc` - Git commits

### Spectre (Search/Replace)
- `<leader>rr` - Toggle Spectre
- `<leader>rw` - Search current word (normal/visual)
- `<leader>rp` - Search in current file

### Terminal
- `<leader>tt` - Toggle floating terminal

## Development Workflow

### Making Configuration Changes
1. Edit files in `lua/` directory
2. Format Lua files: Run `stylua .` (or rely on format-on-save)
3. Restart Neovim or use `:source` to reload config

### Adding New Plugins
Add to `lua/plugins/*.lua` following the lazy.nvim spec. Create a new file or add to `init.lua`.

### Adding LSP Servers

**Method 1: Simple servers (using defaults)**
Add server name to `servers` array in `lua/configs/lspconfig.lua`. The loop will automatically configure it with `vim.lsp.config()` and `vim.lsp.enable()`.

**Method 2: Servers requiring custom configuration**
Add a dedicated block after the loop using the modern API pattern:
```lua
vim.lsp.config("server_name", {
  on_attach = overridedOnAttach,
  on_init = nvlsp.on_init,
  capabilities = nvlsp.capabilities,
  settings = {
    -- server-specific settings
  },
})
vim.lsp.enable("server_name")
```

**Important**:
- Always use `vim.lsp.config()` instead of the deprecated `require('lspconfig')` pattern
- All servers must call `vim.lsp.enable()` after configuration
- Use `overridedOnAttach` to maintain FZF-lua integration and navic breadcrumbs

### Modifying Keybindings
Edit `lua/mappings.lua`. Use `vim.keymap.set` to add mappings, `vim.keymap.del` to remove NvChad defaults.

## Theme and UI

Current theme: `onedark` (configured in `lua/chadrc.lua`)

To change theme, modify `M.base46.theme` in `lua/chadrc.lua`. Available themes are from NvChad's base46.

## Notes

- NvDash (dashboard) is disabled by default
- Performance: Multiple Neovim plugins are disabled for faster startup (see `lua/configs/lazy.lua`)
- Tabufline: Uses NvChad's default configuration
- Cursor: Both line and column highlighting enabled with 20 line scroll offset
