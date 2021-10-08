#!/usr/bin/env bash

_vimrc_path="$HOME/.vimrc"
_vim_path="$HOME/.vim"
_gr='\033[0;32m'
_nc='\033[0m'

declare -a _packages=(
     "tomasr/molokai"
     "rust-lang/rust.vim"
     "fatih/vim-go"
     "vim-scripts/indentpython.vim"
     "nvie/vim-flake8"
     "tell-k/vim-autopep8"
     "xavierd/clang_complete"
     "rhysd/vim-clang-format"
     "itspriddle/vim-shellcheck"
     "LucHermitte/lh-vim-lib.git"
     "LucHermitte/lh-tags.git"
     "LucHermitte/lh-dev.git"
     "LucHermitte/lh-style.git"
     "LucHermitte/lh-brackets.git"
     "LucHermitte/vim-refactor.git"
     "LucHermitte/mu-template.git"
     "tomtom/stakeholders_vim.git"
     "vim-scripts/AutoComplPop"
     "vim-syntastic/syntastic"
     "preservim/tagbar"
     "Raimondi/delimitMate"
     "kien/ctrlp.vim"
     "preservim/nerdtree"
     "tpope/vim-fugitive"
     "tpope/vim-dadbod"
)

archive_existing_config() {
  local timestamp_date
  local archive_path
  local dotvimrc
  local dotvim

  timestamp_date="$(date +"D%Y-%m-%d_T%H-%M-%S")"
  archive_path="./vim_$timestamp_date.zip"
  dotvimrc="./dotvimrc_$timestamp_date"
  dotvim="./dotvim_$timestamp_date"

  if [[ -f "$_vimrc_path" ]]; then
    cp "$_vimrc_path" "$dotvimrc"
    zip -r "$archive_path" "$dotvimrc"
    rm "$dotvimrc"
    rm "$_vimrc_path"
  fi

  if [[ -d "$_vim_path" ]]; then
    cp -R "$_vim_path" "$dotvim"
    zip -r "$archive_path" "$dotvim"
    rm -rf "$dotvim"
    rm -rf "$_vim_path"
  fi

  echo "${_gr}NOTE: The existing .vimrc and .vim contents are archived at $archive_path${_nc}"
}

download_packages() {
  local start_path

  start_path="$_vim_path/pack/lib/start"
  mkdir -p "$start_path"

  cd "$start_path" || { >&2 echo "$start_path not found"; exit 1; }
  for p in "${_packages[@]}"; do
    git clone "https://github.com/$p"
  done
  cd - || { >&2 echo "previous path not found"; exit 1; }

  # additional config
  vim -u NONE -c "helptags fugitive/doc" -c q
  vim -u NONE -c "helptags dadbod/doc" -c q

  echo "${_gr}Packages Downloaded:"
  ls "$start_path"
  echo "${_nc}"
}

main() {
  archive_existing_config 
  download_packages
  cat ./dotvimrc_default > "$_vimrc_path"
}

main "$@"
