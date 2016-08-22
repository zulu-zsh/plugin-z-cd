#!/usr/bin/env zsh

function cd() {
  # If no parameters passed, cd to home directory
  if [[ $# = 0 ]]; then
    builtin cd "$HOME"
    return $?
  fi

  # If a minus is the only parameter, cd to the previous directory
  if [[ "\"$@\"" = "\"-\"" ]]; then
    builtin cd -
    return $?
  fi

  # If only one parameter passed, and it's not a directory
  # in the current working directory, check the `z` database for matches
  if [[ -z "$2" ]]; then
    if [[ ! -d "$1" ]]; then
      if _z "$1"; then
        return $?
      fi
    fi
  else
    builtin cd $1 $2
    return $?
  fi

  # If path is in the current working directory, but is
  # not a directory itself, then show an error
  if [[ ! -d "$1" ]]; then
    echo "Directory does not exist"
    return 1
  fi

  # Pass to builtin cd as a backup
  builtin cd "$@"

  return $?
}
