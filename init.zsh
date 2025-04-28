if (( ! ${+HOMEBREW_PREFIX} )); then
  () {
    local prefix cmd
    for prefix in /opt/homebrew /usr/local /home/linuxbrew/.linuxbrew; do
      if [[ -e ${prefix}/bin/brew ]]; then
        cmd=${prefix}/bin/brew
        break
      fi
    done
    if [[ -z ${cmd} ]] return 1
    if [[ ! ( -s ${1} && ${1} -nt ${cmd} ) ]]; then
      ${cmd} shellenv >! ${1} || return 1
      zcompile -UR ${1}
    fi
    source ${1}
  } ${0:h}/brew-shellenv.zsh || return 1
fi
