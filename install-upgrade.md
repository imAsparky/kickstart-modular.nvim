# Complete Neovim Upgrade Guide - From 0.10 to 0.11+ with Kickstart.nvim

A comprehensive guide to upgrading Neovim and modernizing your development environment with the latest features, including the transition from nvim-cmp to blink.cmp.

## Table of Contents

1. [Prerequisites](#prerequisites)
2. [Upgrading Neovim](#upgrading-neovim)
3. [Understanding the cmp to blink.cmp Migration](#understanding-the-cmp-to-blinkcmp-migration)
4. [Upgrading Dependencies](#upgrading-dependencies)
5. [Kickstart.nvim Configuration Updates](#kickstartnvim-configuration-updates)
6. [Health Check Resolution](#health-check-resolution)
7. [Troubleshooting](#troubleshooting)
8. [Performance Improvements](#performance-improvements)

## Prerequisites

Before starting this upgrade process, ensure you have:

- Linux-based system (Ubuntu, Debian, Fedora, Arch, etc.)
- Basic command line knowledge
- Current Neovim installation (any version)
- Internet connection for downloading updates

## Upgrading Neovim

### Step 1: Remove Old Installation

First, determine how Neovim is currently installed:

```bash
# Check current installation
which nvim
nvim --version

# Common installation paths
which -a nvim
```

If installed via package manager:
```bash
# Ubuntu/Debian
sudo apt remove neovim

# Fedora
sudo dnf remove neovim

# Arch
sudo pacman -R neovim
```

### Step 2: Download Latest Neovim

Download the latest stable release using curl:

```bash
# Create temporary directory
cd ~
mkdir -p ~/tmp && cd ~/tmp

# Download latest Neovim (Linux x86_64) - use specific version to avoid redirect issues
curl -L -o nvim-linux-x86_64.tar.gz https://github.com/neovim/neovim/releases/download/v0.11.2/nvim-linux-x86_64.tar.gz

# Alternative: If the above fails, try the generic latest URL
# curl -L -o nvim-linux-x86_64.tar.gz https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz

# Verify download
ls -lh nvim-linux-x86_64.tar.gz
file nvim-linux-x86_64.tar.gz

# The file should be around 10-11MB, not just a few bytes
# If it's small (< 1MB), the download likely failed - try the alternative URL
```

### Step 3: Extract and Install

```bash
# Extract to /opt (recommended location)
sudo tar -C /opt -xzf nvim-linux-x86_64.tar.gz

# Create symbolic link
sudo ln -sf /opt/nvim-linux-x86_64/bin/nvim /usr/local/bin/nvim

# Add to PATH in your shell config
echo 'export PATH="/opt/nvim-linux-x86_64/bin:$PATH"' >> ~/.bashrc
# or for zsh users:
echo 'export PATH="/opt/nvim-linux-x86_64/bin:$PATH"' >> ~/.zshrc

# Reload shell configuration
source ~/.bashrc  # or ~/.zshrc
```

### Step 4: Verify Installation

```bash
# Check version
nvim --version

# Should show v0.11.1 or higher
# Verify path
which nvim
```

## Understanding the cmp to blink.cmp Migration

### What Changed

Kickstart.nvim has migrated from `nvim-cmp` to `blink.cmp` for completion. This change brings:

**Performance Improvements:**
- **6x faster fuzzy matching** with Rust backend
- **0.5-4ms completion latency** (async, single core)
- **Better memory efficiency** and reduced stuttering
- **Automatic fallback** to Lua if Rust binary fails

**Enhanced Features:**
- **Built-in signature help** - see function signatures while typing
- **Improved function parameter completion**
- **Better typo resistance** in fuzzy matching
- **Terminal completion** support (Neovim 0.11+)

**Simplified Configuration:**
- **Works out of the box** with no additional setup
- **Built-in sources** for LSP, buffer, path, and snippets
- **Sane defaults** that follow Vim conventions

### Key Differences

| Feature | nvim-cmp | blink.cmp |
|---------|----------|-----------|
| **Accept completion** | `<CR>` (Enter) | `<C-y>` (Ctrl+y) |
| **Snippet engine** | External (LuaSnip) | Built-in (vim.snippet) |
| **Performance** | Good | Excellent |
| **Configuration** | Extensive setup required | Minimal setup |

## Upgrading Dependencies

### fzf (Fuzzy Finder)

Upgrade fzf for better telescope performance:

```bash
# Check current version
fzf --version

# Download latest fzf - use specific version to avoid redirect issues
curl -L -o fzf-linux_amd64.tar.gz https://github.com/junegunn/fzf/releases/download/v0.63.0/fzf-0.63.0-linux_amd64.tar.gz

# Alternative: If the above fails, try generic latest URL
# curl -L -o fzf-linux_amd64.tar.gz https://github.com/junegunn/fzf/releases/latest/download/fzf-linux_amd64.tar.gz

# Verify download (should be around 1.5MB)
ls -lh fzf-linux_amd64.tar.gz
file fzf-linux_amd64.tar.gz

# Extract and install
tar -xzf fzf-linux_amd64.tar.gz
sudo mv fzf /usr/bin/fzf
sudo chmod +x /usr/bin/fzf

# Verify installation
fzf --version  # Should show 0.63.0 or higher

# Clean up
rm fzf-linux_amd64.tar.gz
```

### fd (Fast find alternative)

Install fd for enhanced telescope capabilities:

```bash
# Download latest fd - use specific version to avoid redirect issues
curl -L -o fd.tar.gz https://github.com/sharkdp/fd/releases/download/v10.2.0/fd-v10.2.0-x86_64-unknown-linux-gnu.tar.gz

# Alternative: If the above fails, try generic latest URL
# curl -L -o fd.tar.gz https://github.com/sharkdp/fd/releases/latest/download/fd-v10.2.0-x86_64-unknown-linux-gnu.tar.gz

# Verify download (should be around 1.5MB)
ls -lh fd.tar.gz
file fd.tar.gz

# Extract and install
tar -xzf fd.tar.gz
sudo cp fd-v10.2.0-x86_64-unknown-linux-gnu/fd /usr/local/bin/
sudo chmod +x /usr/local/bin/fd

# Verify installation
fd --version

# Clean up
rm -rf fd.tar.gz fd-v10.2.0-x86_64-unknown-linux-gnu

# Note: On some systems, fd might be called fd-find via package manager
# If you already have fd-find installed, you can create a symlink:
# sudo ln -s /usr/bin/fd-find /usr/local/bin/fd
```

### TypeScript Language Server

Update TypeScript language server via Mason:

```bash
# In Neovim
:MasonInstall typescript-language-server

# Or update existing installation
:MasonUpdate
```

## Kickstart.nvim Configuration Updates

### Step 1: Update Kickstart.nvim

```bash
# Navigate to your Neovim config
cd ~/.config/nvim

# If you cloned kickstart originally
git pull origin main

# If you copied the files, re-download
# Backup your custom changes first!
```

### Step 2: Configure blink.cmp

The new blink.cmp configuration in `lua/kickstart/plugins/blink-cmp.lua`:

```lua
return {
  'saghen/blink.cmp',
  lazy = false, -- lazy loading handled internally
  dependencies = 'rafamadriz/friendly-snippets',
  version = 'v0.*',
  opts = {
    keymap = {
      preset = 'default',
      ['<C-space>'] = { 'show', 'show_documentation', 'hide_documentation' },
      ['<C-e>'] = { 'hide' },
      ['<C-y>'] = { 'select_and_accept' },
      ['<C-p>'] = { 'select_prev', 'fallback' },
      ['<C-n>'] = { 'select_next', 'fallback' },
      ['<C-b>'] = { 'scroll_documentation_up', 'fallback' },
      ['<C-f>'] = { 'scroll_documentation_down', 'fallback' },
      ['<Tab>'] = { 'snippet_forward', 'fallback' },
      ['<S-Tab>'] = { 'snippet_backward', 'fallback' },
    },
    
    appearance = {
      use_nvim_cmp_as_default = true,
      nerd_font_variant = 'mono'
    },
    
    sources = {
      default = { 'lsp', 'path', 'snippets', 'buffer' },
    },
    
    completion = {
      accept = {
        auto_brackets = {
          enabled = true,
        },
      },
      documentation = {
        auto_show = true,
        auto_show_delay_ms = 200,
      },
    },
    
    -- Use Rust fuzzy matching for better performance
    -- The following setting enables the high-performance Rust backend
    fuzzy = {
      implementation = 'prefer_rust_with_warning',
    },
    -- Alternative: Use Lua implementation if you prefer no external dependencies
    -- fuzzy = { implementation = 'lua' },
  },
}
```

### Step 3: Disable Legacy Providers

Add to your `init.lua` to disable unused legacy providers:

```lua
-- Disable legacy providers (reduces warnings)
vim.g.loaded_node_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_python3_provider = 0
vim.g.loaded_ruby_provider = 0
```

### Step 4: Configure Lazy.nvim

Update your lazy.nvim configuration to disable luarocks:

```lua
require('lazy').setup({
  -- Your existing plugins
  'NMAC427/guess-indent.nvim',
  require 'kickstart.plugins.gitsigns',
  require 'kickstart.plugins.which-key',
  require 'kickstart.plugins.telescope',
  require 'kickstart.plugins.lspconfig',
  require 'kickstart.plugins.conform',
  require 'kickstart.plugins.blink-cmp',
  require 'kickstart.plugins.tokyonight',
  require 'kickstart.plugins.todo-comments',
  require 'kickstart.plugins.mini',
  require 'kickstart.plugins.treesitter',
  
  { import = 'custom.plugins' },
}, {
  ui = {
    -- Nerd Font icons (if available)
    icons = vim.g.have_nerd_font and {} or {
      cmd = '⌘',
      config = '🛠',
      event = '📅',
      ft = '📂',
      init = '⚙',
      keys = '🗝',
      plugin = '🔌',
      runtime = '💻',
      require = '🌙',
      source = '📄',
      start = '🚀',
      task = '📌',
      lazy = '💤 ',
    },
  },
  
  -- Disable luarocks to avoid warnings
  rocks = {
    enabled = false,
  },
})
```

## Health Check Resolution

After completing the upgrade, run health checks to ensure everything is working:

```bash
# In Neovim, run comprehensive health check
:checkhealth

# Check specific components
:checkhealth telescope
:checkhealth blink.cmp
:checkhealth lazy
:checkhealth fzf_lua
```

### Common Health Check Issues and Solutions

**1. fzf Version Warning**
```bash
# ⚠️ WARNING 'fzf' >= 0.53 is recommended
# Solution: Follow the fzf upgrade steps above
```

**2. blink.cmp Fuzzy Library**
```lua
-- ✅ RESOLVED: Use Rust implementation for better performance
fuzzy = {
  implementation = 'prefer_rust_with_warning',
}

-- Alternative: Use Lua implementation if you prefer no external dependencies
-- fuzzy = { implementation = 'lua' }
```

This enables the high-performance Rust-based fuzzy matcher, which provides ~6x better performance than the Lua implementation. The `prefer_rust_with_warning` setting will automatically download the pre-built binary and fall back to Lua if it fails.

**3. Lazy.nvim Luarocks Warnings**
```lua
-- ❌ ERROR luarocks not installed
-- Solution: Disable luarocks in lazy.nvim setup
rocks = {
  enabled = false,
}
```

**4. Telescope fd Warning**
```bash
# ⚠️ WARNING fd: not found
# Solution: Follow the fd installation steps above
```

**5. Node.js Provider Warnings**
```lua
-- ⚠️ WARNING Missing "neovim" npm package
-- Solution: Disable provider in init.lua
vim.g.loaded_node_provider = 0
```

## Troubleshooting

### blink.cmp Not Working

**Issue:** Completions not showing
```lua
-- Check if blink.cmp is loaded
:lua print(require('blink.cmp').is_available())

-- Reload blink.cmp
:lua require('blink.cmp').reload()
```

**Issue:** Keymaps not working
```bash
# Check current keymaps
:map <C-y>
:map <C-Space>
:map <Tab>
```

### Neovim Configuration Issues

**Issue:** Neovim won't start
```bash
# Start with minimal config
nvim --clean

# Check for syntax errors
nvim --headless -c 'checkhealth' -c 'quit'
```

**Issue:** Plugins not loading
```bash
# Check lazy.nvim status
:Lazy

# Force plugin update
:Lazy update
```

### Performance Issues

**Issue:** Slow completion
```lua
-- Check blink.cmp performance
:lua print(vim.inspect(require('blink.cmp').config.performance))

-- Ensure using Lua fuzzy implementation
fuzzy = {
  implementation = 'lua',
}
```

## Performance Improvements

### Before vs After Comparison

**Completion Performance:**
- **nvim-cmp:** 10-50ms typical response time
- **blink.cmp:** 0.5-4ms response time (6x faster)

**Fuzzy Matching:**
- **fzf 0.29:** Basic fuzzy matching
- **fzf 0.63:** Advanced fuzzy matching with better typo resistance

**File Finding:**
- **find command:** Slower recursive search
- **fd:** 2-3x faster with better ignore patterns

### Optimizations Applied

1. **Completion Engine:** Migrated to high-performance blink.cmp
2. **Fuzzy Finder:** Updated to latest fzf with performance improvements
3. **File Operations:** Added fd for faster file discovery
4. **Memory Usage:** Disabled unused providers to reduce memory footprint
5. **Plugin Management:** Optimized lazy.nvim configuration

## Key Takeaways

### What You've Gained

- **Modern Neovim (0.11+):** Latest features and performance improvements
- **Blazing Fast Completion:** 6x faster with blink.cmp
- **Enhanced Function Signatures:** Better development experience
- **Improved File Operations:** Faster searching with fd and updated fzf
- **Clean Configuration:** Removed warnings and optimized settings

### Important Changes to Remember

1. **Completion Accept:** Use `Ctrl+y` instead of `Enter` to accept completions
2. **Snippet Navigation:** Use `Tab`/`Shift+Tab` for snippet field navigation
3. **Function Signatures:** Available automatically with `Ctrl+k` to toggle
4. **Health Checks:** Run `:checkhealth` regularly to monitor system health

### Maintenance Tips

- **Regular Updates:** Keep Neovim and dependencies updated
- **Health Monitoring:** Run `:checkhealth` after major changes
- **Performance Monitoring:** Monitor completion and search performance
- **Backup Configs:** Always backup your configuration before major changes

## Conclusion

This is a modern, high-performance Neovim setup with the latest features and optimizations. The migration from nvim-cmp to blink.cmp, combined with updated dependencies, provides a significantly enhanced development experience with better performance and more features.

---

*This guide is maintained for Linux systems and tested on Ubuntu 22.04, but the curl-based installation methods should work on any Linux distribution.*
