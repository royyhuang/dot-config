# Neovim Configuration

## Project Overview

This directory contains a Neovim configuration tailored for a modern development workflow. It is managed by the `lazy.nvim` plugin manager and is written entirely in Lua.

The configuration is structured modularly, with general settings in the root `init.lua`, and plugin specifications located in the `lua/plugins/` directory. Key features include:

*   **Plugin Management**: Uses `lazy.nvim` for declarative plugin management.
*   **LSP Integration**: In-built support for Language Server Protocol (`pyright`, `ruff`, `lua_ls`) providing features like go-to-definition, code actions, and diagnostics.
*   **Enhanced Navigation**: Fuzzy finding with `telescope.nvim` and its extensions.
*   **Syntax Highlighting**: Advanced syntax highlighting and indentation provided by `nvim-treesitter`.
*   **Quality of Life**: Includes plugins for auto-pairing, commenting, and an integrated terminal.

## Usage

This is a Neovim configuration directory. To "run" it, simply start Neovim in your terminal:

```bash
nvim
```

The configuration will be loaded automatically.

## Development Conventions

The project follows conventions established by the `lazy.nvim` plugin manager.

*   **Plugin Configuration**: Each plugin or a related group of plugins is configured in its own file within the `lua/plugins/` directory. Each file returns a Lua table that follows the `lazy.nvim` specification.
*   **Adding a new plugin**:
    1.  Create a new `.lua` file in `lua/plugins/`.
    2.  Add the plugin specification to that file, for example:
        ```lua
        return {
            "user/repo",
            -- lazy.nvim options like `config`, `keys`, `dependencies` go here
        }
        ```
*   **Core Configuration**:
    *   `init.lua`: Main entry point. Contains general `vim` options and global keybindings.
    *   `lua/config/lazy.lua`: Bootstraps and configures `lazy.nvim`.
    *   `lua/config/lsp.lua`: Configures LSP servers and their keybindings.
