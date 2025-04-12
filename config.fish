set fish_greeting ""

################################################################################
# fish setup
################################################################################
#  sudo apt install fish

################################################################################
# prompt https://github.com/fish-shell/fish-shell/blob/master/share/functions/fish_prompt.fish
################################################################################
# also choose colors with fish_config
function fish_prompt --description 'Write out the prompt'
    set -l last_pipestatus $pipestatus
    set -l last_status $status
    set -l normal (set_color normal)

    if set -q VIRTUAL_ENV
        echo -n -s "(" (basename "$VIRTUAL_ENV") ")" (set_color normal) " "
    end

    # Write pipestatus
    set -l prompt_status (__fish_print_pipestatus " [" "]" "|" (set_color $fish_color_status) (set_color --bold $fish_color_status) $last_pipestatus)

    echo -n -s $normal "["(date "+%H:%M:%S")"]" (set_color 5E81AC)  "[$USER]"(set_color 81A1C1) "["(prompt_hostname)"] " (set_color D08770) (prompt_pwd) $normal (fish_vcs_prompt) $normal $prompt_status $suffix " "
end

################################################################################
# EDITORS
################################################################################
set -gx EDITOR "vim"
set -gx VISUAL "vim"

################################################################################
# aliases
################################################################################
alias c='clear'
alias r='reset'
alias q='exit'

alias mv='mv -i'

alias ..="cd .."
alias ...='cd ../..'
alias ....='cd ../../..'
alias lll='ls -lh'
alias lll='ls -lha'
alias rm='rm -I'

alias install='sudo apt install'
alias update='sudo apt update'
alias upgrade='sudo apt upgrade'

alias vdd='vd $1 --csv-delimieter="|"'

alias weather='curl wttr.in/uzes'
alias speedtest='curl -s https://raw.githubusercontent.com/sivel/speedtest-cli/master/speedtest.py | python3 -'

################################################################################
# SYSTEM SERVICES
# zoxide - https://github.com/ajeetdsouza/zoxide
################################################################################
alias services-running='systemctl list-units --type=service --state=running'
alias services-failed='systemctl --failed'
zoxide init fish | source

function services-log --argument serv n
    journalctl --lines=$n -f -u $serv -o cat
end

################################################################################
################################################################################

################################################################################
# GUAKE THEMES 
# how to get palettes
# 1 - change theme in preferences
# 2 - dconf dump /org/guake/style/ > guake-settings.dconf
# add completions file
# guake_theme -n '__fish_use_subcommand' -f
################################################################################
set -g available_themes arthur day github linux solarized_light solarized_dark_high_contrast solarized_dark sdarcula nord tomorrow hemisu_light hemisu_dark
function guake_theme -a theme_name -d "Sets guake theme from within terminal."
  set -l palette ""

  switch $theme_name
    case arthur
      set palette "'#3D3D35352A2A:#CDCD5C5C5C5C:#8686AFAF8080:#E8E8AEAE5B5B:#64649595EDED:#DEDEB8B88787:#B0B0C4C4DEDE:#BBBBAAAA9999:#555544444444:#CCCC55553333:#8888AAAA2222:#FFFFA7A75D5D:#8787CECEEBEB:#999966660000:#B0B0C4C4DEDE:#DDDDCCCCBBBB:#DDDDEEEEDDDD:#1C1C1C1C1C1C'"
    case day
      set palette "'#090903030000:#DBDB2D2D2020:#0101A2A25252:#FDFDEDED0202:#0101A0A0E4E4:#A1A16A6A9494:#B5B5E4E4F4F4:#A5A5A2A2A2A2:#5C5C58585555:#E8E8BBBBD0D0:#3A3A34343232:#4A4A45454343:#80807D7D7C7C:#D6D6D5D5D4D4:#CDCDABAB5353:#F7F7F7F7F7F7:#4A4A45454343:#F7F7F7F7F7F7'"
    case github
      set palette "'#3E3E3E3E3E3E:#97970B0B1616:#070796962A2A:#F8F8EEEEC7C7:#00003E3E8A8A:#E9E946469191:#8989D1D1ECEC:#FFFFFFFFFFFF:#666666666666:#DEDE00000000:#8787D5D5A2A2:#F1F1D0D00707:#2E2E6C6CBABA:#FFFFA2A29F9F:#1C1CFAFAFEFE:#FFFFFFFFFFFF:#3E3E3E3E3E3E:#F4F4F4F4F4F4'"
    case linux
      set palette "'#000000000000:#aaaa00000000:#0000aaaa0000:#aaaa55550000:#00000000aaaa:#aaaa0000aaaa:#0000aaaaaaaa:#aaaaaaaaaaaa:#555555555556:#ffff55555555:#5555ffff5555:#ffffffff5555:#55555555ffff:#ffff5555ffff:#5555ffffffff:#ffffffffffff:#ffffffffffff:#000000000000'"
    case solarized_light
      set palette "'#000027273131:#d0d01b1b2424:#727289890505:#a5a577770505:#20207575c7c7:#c6c61b1b6e6e:#252591918585:#72729f9fcfcf:#00001e1e2626:#bdbd36361212:#46465a5a6161:#525267676f6f:#707081818383:#58585656b9b9:#818190908f8f:#fcfcf4f4dcdc:#525267676f6f:#fcfcf4f4dcdc'"
    case solarized_dark_high_contrast
      set palette "'#000027273131:#D0D01B1B2424:#6B6BBEBE6C6C:#A5A577770505:#20207575C7C7:#C6C61B1B6E6E:#252591918585:#E9E9E2E2CBCB:#000063638888:#F4F415153B3B:#5050EEEE8484:#B1B17E7E2828:#17178D8DC7C7:#E1E14D4D8E8E:#0000B2B29E9E:#FCFCF4F4DCDC:#9B9BC1C1C2C2:#00001E1E2626'"
    case solarized_dark
      set palette "'#000027273131:#D0D01B1B2424:#727289890505:#A5A577770505:#20207575C7C7:#C6C61B1B6E6E:#252591918585:#E9E9E2E2CBCB:#00001E1E2626:#BDBD36361212:#46465A5A6161:#525267676F6F:#707081818383:#58585656B9B9:#818190908F8F:#FCFCF4F4DCDC:#707081818383:#00001E1E2626'"
    case sdarcula
      set palette "'#252529292A2A:#F2F248484040:#626296965555:#B6B688880000:#20207575C7C7:#79797F7FD4D4:#151596968D8D:#D2D2D8D8D9D9:#252529292A2A:#F2F248484040:#626296965555:#B6B688880000:#20207575C7C7:#79797F7FD4D4:#151596968D8D:#D2D2D8D8D9D9:#D2D2D8D8D9D9:#3D3D3F3F4141'"
    case nord
      set palette "'#3B3B42425252:#BFBF61616A6A:#A3A3BEBE8C8C:#EBEBCBCB8B8B:#8181A1A1C1C1:#B4B48E8EADAD:#8888C0C0D0D0:#E5E5E9E9F0F0:#4C4C56566A6A:#BFBF61616A6A:#A3A3BEBE8C8C:#EBEBCBCB8B8B:#8181A1A1C1C1:#B4B48E8EADAD:#8F8FBCBCBBBB:#ECECEFEFF4F4:#D8D8DEDEE9E9:#2E2E34344040'"
    case tomorrow
      set palette "'#000000000000:#C8C828282828:#71718C8C0000:#EAEAB7B70000:#41417171AEAE:#89895959A8A8:#3E3E99999F9F:#FFFFFEFEFEFE:#000000000000:#C8C828282828:#70708B8B0000:#E9E9B6B60000:#41417070AEAE:#89895858A7A7:#3D3D99999F9F:#FFFFFEFEFEFE:#4D4D4D4D4C4C:#FFFFFFFFFFFF'"
    case hemisu_light
      set palette "'#777777777777:#FFFF00005555:#737391910000:#50503D3D1515:#535380809191:#5B5B34345E5E:#535380809191:#999999999999:#999999999999:#D6D65E5E7676:#9C9CC7C70000:#949475755555:#9D9DB3B3CDCD:#A1A18484A4A4:#8585B2B2AAAA:#BABABABABABA:#444444444444:#EFEFEFEFEFEF'"
    case hemisu_dark
      set palette "'#444444444444:#FFFF00005454:#B1B1D6D63030:#9D9D89895E5E:#6767BEBEE3E3:#B5B57676BCBC:#56569A9A9F9F:#EDEDEDEDEDED:#777777777777:#D6D65E5E7575:#BABAFFFFAAAA:#ECECE1E1C8C8:#9F9FD3D3E5E5:#DEDEB3B3DFDF:#B6B6E0E0E5E5:#FFFFFFFFFFFF:#FFFFFFFFFFFF:#000000000000'"
    case '*'
      return 1
  end

  if test -n "$palette"
    dconf write /org/guake/style/font/palette $palette
    echo "Guake theme '$theme_name' set successfully."
  end
end
complete -c guake_theme -a '$available_themes' -f

################################################################################
# BLUETOOTH
################################################################################
set -g DEVICES WH1000XM3 WF1000XM5 UEBOOM2
set -g WH1000XM3 "14:3F:A6:A8:74:B8"
set -g WF1000XM5 "AC:80:0A:A6:01:37"
set -g UEBOOM2 "C0:28:8D:8F:98:30"

function bc -a device -d "connect to bluetooth devices in DEVICES"
  if contains -- $device $DEVICES
    bluetoothctl connect $$device 
  else
    echo "Device '$device' not found in the list: $DEVICES"
  end
end
complete -f -c bc -a "$DEVICES"

function bd -a device -d "disconnect from bluetooth devices in DEVICES"
  if contains -- $device $DEVICES
    bluetoothctl disconnect $$device 
  else
    echo "Device '$device' not found in the list: $DEVICES"
  end
end
complete -f -c bd -a "$DEVICES"

function bd-all -d "disconnect from all bluetooth devices"
  set -l connected_devices (bluetoothctl devices Connected | awk '{print $2}')

  if test -z "$connected_devices"
    echo "No Bluetooth devices are currently connected."
    return 0
  end

  echo "Disconnecting from the following devices:"
  for device in $connected_devices
    echo "- $device"
    bluetoothctl disconnect $device
    if test $status -ne 0
      echo "Error disconnecting from $device."
    end
  end

  echo "Successfully attempted to disconnect from all connected Bluetooth devices."
end

function bl --wraps bluetoothctl -d 'List connected Bluetooth devices or show message'
    set devices (bluetoothctl devices Connected)
    if test -z "$devices"
        echo "No connected Bluetooth devices."
    else
        echo "Connected bluetooth devices: "
        echo -e "    $devices"
    end
end

