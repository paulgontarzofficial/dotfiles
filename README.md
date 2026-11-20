# dotfiles

My personal configuration files for **zsh**, **tmux**, and **vim**, managed with [GNU Stow](https://www.gnu.org/software/stow/).

## What's inside

```
dotfiles/
├── install_packages.sh   # Installs the base packages (stow, vim, tmux)
├── stow.sh               # Symlinks every config folder into $HOME
├── .p10k.zsh             # Powerlevel10k prompt config
├── zsh/
│   └── .zshrc            # Oh My Zsh + Powerlevel10k setup
├── tmux/
│   ├── .tmux.conf        # tmux config
│   └── .tmux.conf.bak    # Older version of the tmux config
└── vim/
    └── .vimrc            # Vim config
```

Each top-level folder (`zsh`, `tmux`, `vim`) is a Stow "package". Its contents mirror where the files should live in your home directory, so `stow vim` creates `~/.vimrc → ~/dotfiles/vim/.vimrc`.

## Highlights

### zsh
- [Oh My Zsh](https://ohmyz.sh/) with the [Powerlevel10k](https://github.com/romkatv/powerlevel10k) theme (two-line, classic style, 24-hour clock)
- Plugins: `git`, `zsh-autosuggestions`, `zsh-syntax-highlighting`, `colored-man-pages`
- Runs `neofetch` when a new shell starts
- `ll` alias for `ls -lah`
- Adds `~/.local/bin` and the Ruby gem bin directory to `PATH`

### tmux
- Prefix remapped to **`Ctrl-a`** (instead of `Ctrl-b`)
- Mouse support, windows and panes numbered from 1, automatic window renumbering
- 50,000 lines of scrollback, true-color support
- Vi-style copy mode with system clipboard support
- Plugins via [TPM](https://github.com/tmux-plugins/tpm): [Dracula theme](https://draculatheme.com/tmux) and [vim-tmux-navigator](https://github.com/christoomey/vim-tmux-navigator)

### vim
- 2-space indentation with spaces, auto and smart indent
- Relative line numbers, a column marker at 80 characters, mouse support
- `industry` color scheme with true colors
- Smart-case incremental search with highlighting
- Persistent undo history saved to `~/.vim/undo`

## Prerequisites

`install_packages.sh` installs **stow**, **vim**, and **tmux**. The zsh setup needs a few more things that you install yourself:

- `zsh` and `git`
- [`neofetch`](https://github.com/dylanaraps/neofetch) (or remove the `neofetch` line from `.zshrc`)
- [Oh My Zsh](https://ohmyz.sh/#install)
- [Powerlevel10k](https://github.com/romkatv/powerlevel10k). `.zshrc` loads it from two places, so install it in both:
  ```sh
  git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/powerlevel10k
  git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k"
  ```
- The custom Oh My Zsh plugins:
  ```sh
  git clone https://github.com/zsh-users/zsh-autosuggestions "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions"
  git clone https://github.com/zsh-users/zsh-syntax-highlighting "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting"
  ```
- A [Nerd Font](https://www.nerdfonts.com/) set as your terminal font, so the prompt icons display correctly
- [TPM](https://github.com/tmux-plugins/tpm) for tmux plugins:
  ```sh
  git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
  ```

## Installation

1. **Clone the repo into your home directory.** Stow links files into the *parent* of the directory it runs from, so the repo has to sit directly in `$HOME`:
   ```sh
   git clone https://github.com/paulgontarzofficial/dotfiles.git ~/dotfiles
   cd ~/dotfiles
   ```

2. **Install the base packages.** The script detects your package manager (`apt`, `dnf`, `pacman`, `zypper`, or `apk`) and reports how many packages failed:
   ```sh
   chmod +x install_packages.sh stow.sh
   ./install_packages.sh
   ```
   To install more packages, add them to the `packages` array at the top of the script.

3. **Back up any existing configs.** Stow won't overwrite real files, so move them out of the way first:
   ```sh
   for f in ~/.zshrc ~/.tmux.conf ~/.vimrc ~/.p10k.zsh; do [ -f "$f" ] && mv "$f" "$f.backup"; done
   ```

4. **Stow the configs.** This runs `stow` on every folder in the repo:
   ```sh
   ./stow.sh
   ```
   To link a single package instead:
   ```sh
   stow vim
   ```

5. **Link the Powerlevel10k config.** `.p10k.zsh` sits at the root of the repo instead of in a Stow package, so `stow.sh` doesn't pick it up. Link it by hand:
   ```sh
   ln -s ~/dotfiles/.p10k.zsh ~/.p10k.zsh
   ```

6. **Finish up.**
   - Make zsh your default shell: `chsh -s "$(which zsh)"`, then open a new terminal.
   - Start tmux and press **`Ctrl-a`** then **`I`** (capital i) to install the tmux plugins.

## tmux key bindings

The prefix is **`Ctrl-a`**.

| Keys | Action |
|---|---|
| `prefix` `r` | Reload `~/.tmux.conf` |
| `prefix` `h` / `j` / `k` / `l` | Move to the pane on the left / below / above / right |
| `prefix` `H` / `J` / `K` / `L` | Resize the pane by 5 cells (repeatable) |
| `prefix` `Esc` | Enter copy mode |
| `v` (in copy mode) | Start a selection |
| `y` (in copy mode) | Copy the selection and exit copy mode |
| `prefix` `p` | Paste |
| `prefix` `I` | Install TPM plugins |

## Customizing

- **Prompt:** run `p10k configure` to regenerate `.p10k.zsh` with the setup wizard.
- **Edit a config:** because the files in `$HOME` are symlinks, editing `~/.zshrc` (for example) edits the copy in this repo. Commit and push to keep it in sync.
- **Add a new program:** create a folder named after the program, put its dotfiles inside using the same layout they'd have under `$HOME`, then run `stow <folder>`.

## Uninstalling

Remove the symlinks for a package with:

```sh
cd ~/dotfiles
stow -D zsh tmux vim
rm ~/.p10k.zsh
```
