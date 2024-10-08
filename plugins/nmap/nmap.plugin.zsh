# nmap shortcuts

# list nse scripts 
compdef _nse-complete nse-help
compdef _nse-complete nse-show


_nse-complete() {
 _arguments "1: :_files -W /usr/share/nmap/scripts/"
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
        more "/usr/share/nmap/scripts/"$1
    else
        echo "nmap-show <script-name>.nse"
    fi
}
