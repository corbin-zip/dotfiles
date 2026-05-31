# Corbin's dotfiles

Corbin's dotfiles for an X11/dwm desktop on Arch Linux.

## Deployment

[CARBS](https://github.com/corbin-zip/carbs) is the install script for this setup. It handles package installation, symlinking these dotfiles, and configuring the full environment from a fresh Arch install.

## Paired programs

These dotfiles are intended to be used alongside:

- [dwm](https://github.com/corbin-zip/dwm) - window manager
- [dwmblocks](https://github.com/corbin-zip/dwmblocks) - status bar
- [st](https://github.com/corbin-zip/st) - terminal emulator

## Configuration

Settings live under `.config/` where possible. Configs include:

- **nvim** - text editor
- **zsh** - shell (profile, aliases, functions)
- **yazi / lf** - file managers
- **mpd / ncmpcpp** - music daemon and client
- **mpv** - video player
- **nsxiv** - image viewer
- **newsboat** - RSS reader
- **btop** - system monitor
- **lazygit** - git interface
- **dunst** - notification daemon
- **zathura** - document viewer
- **x11** - xinitrc, xprofile, xresources
- **pipewire / pulse** - audio
- **wal** - color scheme / pywal hooks

## Scripts

General-purpose scripts are in `.local/bin/`. Notable ones:

- `shortcuts` - generates keybindings and shell aliases from bookmark files (see below)
- `setbg` - sets the desktop wallpaper
- `dmenu*` - various dmenu-driven utilities (mounts, bookmarks, recordings, etc.)
- `linkhandler` - routes URLs to the appropriate program
- `compiler` / `opout` - compile documents and open output
- `sysact` - system actions menu (shutdown, reboot, etc.)
- `remapd` / `remaps` - keyboard remapping for desktop/laptop

Statusbar scripts for dwmblocks are in `.local/bin/statusbar/`.

## Bookmark system

Directory and file bookmarks are stored in plain text:

- `.config/shell/bm-dirs` - directory bookmarks
- `.config/shell/bm-files` - file bookmarks

The `shortcuts` script reads these and generates:

- shell aliases (`~/.config/shell/shortcutrc`)
- env variables (`~/.config/shell/shortcutenvrc`)
- zsh named directories (`~/.config/shell/zshnameddirrc`)
- yazi `cd` keybindings (`~/.config/yazi/keymap.toml`)
- lf `cd` keybindings (`~/.config/lf/shortcutrc`)
- vim/nvim command-mode mappings (`~/.config/nvim/shortcuts.vim`)

Shortcuts are regenerated automatically on login and whenever `bm-dirs` or `bm-files` is saved in nvim.

---

Originally forked from [LukeSmithxyz/voidrice](https://github.com/LukeSmithxyz/voidrice). It's also worth trying out [mutt-wizard](https://github.com/lukesmithxyz/mutt-wizard).
