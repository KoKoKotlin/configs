# Sourced by every zsh (interactive or not) — keep it to environment only.

# Keep $PATH free of duplicates (path is the array tied to $PATH).
typeset -U path PATH

# Rust toolchain (adds ~/.cargo/bin)
[[ -r "$HOME/.cargo/env" ]] && . "$HOME/.cargo/env"

path=(
  "$HOME/.local/bin"
  $path
  "$HOME/bin/android-studio/bin"
)
export PATH
