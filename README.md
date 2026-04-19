# Dotfiles

Stow usage

```bash
stow . --adopt
```

## Requirements

* Nvim
* fzf
* lua luarock
* ripgrep
* fd-find
* EZA <https://github.com/eza-community/eza>
* https://docs.atuin.sh/cli/guide/installation/#__tabbed_2_1
* https://github.com/dandavison/delta

## zsh plugins

<https://github.com/zdharma-continuum/zinit>
<https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins>

* <https://github.com/zsh-users/zsh-syntax-highlighting>
* <https://github.com/zsh-users/zsh-completions>
* <https://github.com/zsh-users/zsh-autosuggestions>
* <https://github.com/Aloxaf/fzf-tab/wiki/Configuration>

## Starship

<https://starship.rs/>

## delta
.gitconfig

```bash
[core]
	pager = delta
[interactive]
	diffFilter = delta --color-only
[include]
	path = /home/mascanio/.config/delta/themes/catppuccin.gitconfig
[delta]
	features = catppuccin-macchiato
	navigate = true
	dark = true
  line-numbers = true
[merge]
	conflictStyle = zdiff3
```


## Themes

https://github.com/catppuccin/atuin
https://github.com/catppuccin/bat
https://github.com/catppuccin/lazygit
https://github.com/catppuccin/delta

