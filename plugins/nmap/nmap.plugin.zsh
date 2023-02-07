# nmap shortcuts

# list nse scripts 
compdef _nse-complete nse-help
compdef _nse-complete nse-show

local nmap_script_path="/usr/share/nmap/scripts/"

_nse-complete() {
    _arguments "1: :_files -W $nmap_script_path"
}


nse-help() {
    if [ -n "$1" ];
    then
        nmap --script-help $1
    else
        echo "nse-help <script-name>.nse"
    fi
}

nse-show() {
    if [ -n "$1" ];
    then
        more "$nmap_script_path/$1"
    else
        echo "nmap-show <script-name>.nse"
    fi
}
