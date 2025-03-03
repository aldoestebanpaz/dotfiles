export_to_path() {
  bin_path=$1
  [[ -d "${bin_path}" ]] && export PATH=${bin_path}:$PATH
}

export_to_path "/usr/local/share/npm/bin"
export_to_path "/usr/local/bin"
export_to_path "/usr/local/sbin"
export_to_path ~/bin

unset -f export_to_path
