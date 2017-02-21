ostype() {
  uname | awk '{print tolower($0)}'
}

is_osx() {
  if [[ "$(ostype)" == 'darwin' ]]; then
    return 0
  else
    return 1
  fi
}
