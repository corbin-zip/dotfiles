# Corbin's dotfiles

Corbin's dotfiles for an X11/dwm desktop on Arch Linux. The repo is meant to be used as a single GNU stow package targeting `$HOME`, so deploying it is one `stow` command and the configs in your home directory stay symlinked into a normal git clone -- or you could just use it like any other dotfiles repo out there :)

## Deployment

[CARBS](https://github.com/corbin-zip/carbs) is the install script for this setup, though not strictly necessary. It handles package installation, symlinking these dotfiles, and configuring the full environment from a fresh Arch install.

`verify-stow` audits the symlinks afterward and can repair them interactively with `-f`, which is handy after moving files around or stowing a private repo on top.

## Paired programs

These dotfiles are intended to be used alongside my suckless builds:

- [dwm](https://github.com/corbin-zip/dwm) - window manager
- [dwmblocks](https://github.com/corbin-zip/dwmblocks) - status bar
- [st](https://github.com/corbin-zip/st) - terminal emulator
- [dmenu](https://github.com/corbin-zip/dmenu) - launcher and menu for the various `dmenu*` scripts

## Theming

The whole desktop is themed through one pywal16 pipeline. Three entry points feed it:

- `setbg` - set a wallpaper and derive a 16-color palette from it
- `settokyo` - apply a fixed named scheme (tokyonight-moon by default) without touching the wallpaper
- `restoretheme` - re-apply the last scheme at login

All three end in the same `postrun` hook, which renders dunst, zathura, and btop configs from templates, replays the new color sequences into every open terminal, restarts dunst, and tells dwm to re-read Xresources. Since dwm, dmenu, and st all read the wal colors too, one command re-themes everything from the window manager down to the notification daemon, VS Code included.

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
- **dunst** - notification daemon (rendered from a wal template, see above)
- **zathura** - document viewer (same)
- **x11** - xinitrc, xprofile, xresources
- **pipewire / pulse** - audio
- **wal** - templates, colorschemes, and the postrun hook

## Scripts

General-purpose scripts are in `.local/bin/`. Notable ones:

- `shortcuts` - generates keybindings and shell aliases for half a dozen programs from two bookmark files (see below)
- `setbg` / `settokyo` / `restoretheme` - the theming entry points described above
- `dmenu*` - dmenu-driven utilities: mounting (`dmenumount`, `dmenumountcifs`, `unmounter`), screen recording (`dmenurecord`), bookmarks, unicode picker, process killer, audio sink switcher (`dmenusink`), and more
- `linkhandler` - routes URLs to the appropriate program (mpv, nsxiv, browser, etc.)
- `compiler` / `opout` - compile documents (LaTeX, markdown, groff, etc.) and open the output
- `sysact` - system actions menu (shutdown, reboot, lock, etc.)
- `remapd` / `remaps` - keyboard remapping for desktop/laptop
- `verify-stow` - audit and repair the stow symlinks

Statusbar modules for dwmblocks are in `.local/bin/statusbar/`. They're click-aware via dwm's statuscmd patch. A few of the less ordinary ones:

- `sb-claude` - shows remaining Claude Code usage (the rolling 5-hour and weekly windows) by querying the OAuth usage endpoint with the token Claude Code already stores locally; cached so the endpoint isn't hammered, clickable for details or a forced refresh
- `sb-forecast` / `sb-doppler` - weather forecast and radar
- `sb-caffeine` - toggle screen blanking from the bar
- `sb-firmware` / `sb-popfwupd` - pending firmware updates via fwupd

Cron jobs live in `.local/bin/cron/`, including `todoist-calcurse-sync` (syncs Todoist tasks into calcurse) and `plex-mpd-sync` (mirrors Plex playlists into mpd).

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

So adding one line to `bm-dirs` gives you the same shortcut in the shell, both file managers, and nvim. Shortcuts are regenerated automatically on login and whenever `bm-dirs` or `bm-files` is saved in nvim.

---

Originally forked from [LukeSmithxyz/voidrice](https://github.com/LukeSmithxyz/voidrice). It's also worth trying out [mutt-wizard](https://github.com/lukesmithxyz/mutt-wizard).
