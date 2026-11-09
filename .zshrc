# ---------------------------------------------------------------------------
# Options
# ---------------------------------------------------------------------------
setopt auto_cd                # type a directory name to cd into it
setopt auto_pushd             # cd pushes onto the dir stack: `cd -<Tab>` lists recent dirs
setopt pushd_ignore_dups
setopt pushd_silent
setopt correct                # "did you mean …?" for mistyped commands
setopt interactive_comments   # allow # comments on the command line

# ---------------------------------------------------------------------------
# History
# ---------------------------------------------------------------------------
HISTFILE="${XDG_CACHE_HOME:-$HOME/.cache}/zsh/history"
[[ -d ${HISTFILE:h} ]] || mkdir -p "${HISTFILE:h}"
HISTSIZE=50000
SAVEHIST=50000
setopt extended_history       # save timestamps
setopt inc_append_history     # write commands right away, not on exit
setopt share_history          # share history between open shells
setopt hist_ignore_dups       # skip consecutive duplicates
setopt hist_ignore_space      # a leading space keeps a command out of history
setopt hist_reduce_blanks
setopt hist_verify            # !! expands into the line instead of running it

# ---------------------------------------------------------------------------
# Colors (used by eza and the completion menu)
# ---------------------------------------------------------------------------
if (( $+commands[vivid] )); then
  export LS_COLORS="$(vivid -m 8-bit generate snazzy)"
elif (( $+commands[dircolors] )); then
  eval "$(dircolors -b)"
fi

# ---------------------------------------------------------------------------
# Completion
# ---------------------------------------------------------------------------
zmodload zsh/complist
zstyle ':completion:*' menu select
zstyle ':completion:*' verbose yes
zstyle ':completion:*' group-name ''
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'   # case-insensitive
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*:descriptions' format '%F{yellow}-- %d --%f'
autoload -Uz compinit
compinit -d "${XDG_CACHE_HOME:-$HOME/.cache}/zsh/zcompdump-$ZSH_VERSION"
_comp_options+=(globdots)        # include hidden files

# ---------------------------------------------------------------------------
# vi mode
# ---------------------------------------------------------------------------
bindkey -v
KEYTIMEOUT=1

# Use vim keys in the tab-complete menu
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
# Backspace/^H can delete past the point where insert mode was entered
bindkey -M viins '^?' backward-delete-char
bindkey -M viins '^H' backward-delete-char

# Up/Down (and k/j in normal mode) search history by what's already typed
autoload -Uz up-line-or-beginning-search down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
for km in viins vicmd; do
  bindkey -M $km '^[[A' up-line-or-beginning-search
  bindkey -M $km '^[OA' up-line-or-beginning-search
  bindkey -M $km '^[[B' down-line-or-beginning-search
  bindkey -M $km '^[OB' down-line-or-beginning-search
done
bindkey -M vicmd 'k' up-line-or-beginning-search
bindkey -M vicmd 'j' down-line-or-beginning-search
unset km

# Cursor shape: block in normal mode, beam in insert mode
_cursor_block() { printf '\e[1 q'; }
_cursor_beam()  { printf '\e[5 q'; }
zle-keymap-select() {
  if [[ $KEYMAP == vicmd ]]; then _cursor_block; else _cursor_beam; fi
}
zle -N zle-keymap-select
zle-line-init() {
  zle -K viins
  _cursor_beam
}
zle -N zle-line-init
# Reset to beam before each command runs, so programs don't inherit a block cursor
autoload -Uz add-zsh-hook
add-zsh-hook preexec _cursor_beam

# Edit the current line in $EDITOR with Ctrl-E (in insert and normal mode)
autoload -Uz edit-command-line
zle -N edit-command-line
bindkey -M viins '^e' edit-command-line
bindkey -M vicmd '^e' edit-command-line

# ---------------------------------------------------------------------------
# Prompt: starship if installed, otherwise [user@host ~/dir](branch)$
# ---------------------------------------------------------------------------
if (( $+commands[starship] )); then
  eval "$(starship init zsh)"
else
  autoload -Uz vcs_info
  add-zsh-hook precmd vcs_info
  zstyle ':vcs_info:*' enable git
  zstyle ':vcs_info:git:*' formats ' %F{cyan}(%b)%f'
  zstyle ':vcs_info:git:*' actionformats ' %F{cyan}(%b|%a)%f'
  setopt prompt_subst
  PS1='%B%F{red}[%F{yellow}%n%F{green}@%F{blue}%M %F{magenta}%~%F{red}]%f${vcs_info_msg_0_}%B$%b '
fi

# ---------------------------------------------------------------------------
# Aliases
# ---------------------------------------------------------------------------
if (( $+commands[eza] )); then
  alias ls='eza --color=auto --icons=auto --group-directories-first'
  alias ll='ls -alF --git'          # with per-file git status
  alias lt='ls --tree --level=2'
else
  alias ls='ls --color=auto --group-directories-first'
  alias ll='ls -alF'
fi
alias grep='grep --color=auto'
alias diff='diff --color=auto'

# Ubuntu ships bat as `batcat` and fd as `fdfind`
if (( $+commands[batcat] )); then
  alias bat='batcat'
  alias cat='batcat --paging=never'
  export MANPAGER="sh -c 'col -bx | batcat -l man -p'"   # colored man pages
  export MANROFFOPT='-c'
fi
(( $+commands[fdfind] )) && alias fd='fdfind'

# ---------------------------------------------------------------------------
# Tools
# ---------------------------------------------------------------------------
# fzf: Ctrl-R fuzzy history, Ctrl-T fuzzy file picker, Alt-C fuzzy cd
if (( $+commands[fzf] )); then
  if (( $+commands[fdfind] )); then
    export FZF_DEFAULT_COMMAND='fdfind --type f --hidden --follow --exclude .git'
    export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
    export FZF_ALT_C_COMMAND='fdfind --type d --hidden --follow --exclude .git'
  fi
  (( $+commands[batcat] )) &&
    export FZF_CTRL_T_OPTS="--preview 'batcat --color=always --style=numbers --line-range=:200 {}'"
  (( $+commands[eza] )) &&
    export FZF_ALT_C_OPTS="--preview 'eza --tree --level=2 --color=always --icons=always {}'"
  source <(fzf --zsh)
fi

# zoxide: `z proj` jumps to the most-used directory matching "proj", `zi` picks with fzf
(( $+commands[zoxide] )) && eval "$(zoxide init zsh)"

# ---------------------------------------------------------------------------
# Plugins
# ---------------------------------------------------------------------------
# Fish-style suggestions from history; accept with → or Ctrl-Space
if [[ -r /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh ]]; then
  ZSH_AUTOSUGGEST_STRATEGY=(history completion)
  source /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh
  bindkey -M viins '^ ' autosuggest-accept
fi

# Syntax highlighting — must be sourced last
[[ -r /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]] &&
  source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
