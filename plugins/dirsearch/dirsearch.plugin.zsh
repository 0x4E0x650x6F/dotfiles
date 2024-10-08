compdef _dirsearch dirsearch


_dirsearch () {
  integer ret=1
  local -a args
  local I="-h --help --version"
  local U="$I -u --url"

  args+=(
      "($I -u --url)"{-u+,--url=}'[URL Target]:host:_hosts'
      "($I -L --url-list=)"{-L+,--url-list=}'[URL list]:file:_files'
      "($U -e --extensions)"{-e+,--extensions=}'[Extensions]:ext:'
      "($U -w --wordlist)"{-w+,--wordlist=}'[Wordlist or lists separated by ,]:wlist:_sequence -s, _files '
      "($U -l --lowercase)"{-l,--lowercase}'[Lowercase]'
      "($U -f --force-extensions)"{-f,--force-extensions}'[Force extensions for every wordlist entry (like in DirBuster]'
      "($U -s --delay)"{-s+,--delay=}'[Delay between requests]:float:'
      "($U -R --recursive-level-max)"{-R+,--recursive-level-max=}'[recursive level max]:int:'
      "($I)--suppress-empty[suppress empty results]"
      "($U)--scan-subdir=[Scan subdirectories of the given -u|--url (separated by comma)]:subdirs:"
      "($U)--exclude-subdir=[Exclude the following subdirectories during recursive scan separated by ,]:excl:"
      "($U -t --threads)"{-t+,--threads=}'[The number of threads]:num_threads:'
      "($U -x --exclude-status)"{-x+,--exclude-status=}'[Exclude Status codes]:exclude-status:_files'
      "($U)--exclude-regexps=[Exclude responses by regexps, separated by ,]:exc-regex:"
      "($U -c --cookie)"{-c+,--cookie=}'[HTTP cookies]:cookie:'
      "($U --ua --user-agent)"{--ua+,--user-agent=}'[User Agent]:ua:'
      "($U -F --follow-redirects)"{-F,--follow-redirects}'[Follow redirects]'
      "($U -H -header)"{-H+,--header=}'[Headers to add (example: --header "Referer: example.com" --header "User-Agent: IE"]:headers:((
            X-Forwarded-For\:Source\ spoof X-Forwarded-For 127.0.0.1
            Origin=fu\:The\ Origin\ request\ header\ indicates\ where\ a\ fetch\ originates\ from
      ))'
      "($U)--random-agents[Random User-Agent]"
      "($U)--timeout=[Connection timeout]"
      "($U  --proxy, --http-proxy)"{--proxy=,--http-proxy=}'[Http Proxy (example: localhost:8080)]:proxy:_hosts'
      "($U)--http-method=[Method to use, default: GET, possible also: HEAD;POST]"
      "($U)--max-retries=[Max Retries]"
      "($U -b --request-by-hostname)"{-b+,--request-by-hostname}'[By default dirsearch will request by IP for speed. This forces requests by hostname]'
      "($U)--simple-report=[SIMPLEOUTPUTFILE Only found paths]"
      "($U)--plain-text-report=[PLAIN TEXT OUTPUT FILE Found paths with status codes]"
      "($U)--json-report=[JSON OUTPUT FILE]"
      '(- *)'{-h,--help}'[Display help and exit]'
      '(- *)--version[Output version information and acknowledgments]'
  )    
  _arguments -w -s -S $args && ret=0
  return ret
}

dirs-search() {
    if [ -n "$1" ];
    then
        if [ -n "$2" ];
        then
            dirsearch -u $1 -e ',php,asp,aspx,jsp,js,html,do,action' -r -H "X-Forwarded-For:127.0.0.1" -x 400 --random-agents -w $2
        else
            echo "dirs <domain> <ext> <opt:dictionary>"
        fi
    else
        echo "dirs <domain> <ext> <opt:dictionary>"
    fi
}

dirs() {
    if [ -n "$1" ];
    then
        if [ -n "$2" ];
        then
            #wordlists="$($(find $3 -type f) -exec echo -n ',{}' \; | cut -d , -f2-)"
            for wordlist in  $(find $2 -type f -iname '*.txt');
            do 
              dirsearch -u $1 -e ',php,asp,aspx,jsp,js,html,do,action' -b -r -H "X-Forwarded-For:127.0.0.1" -x 400,301 --random-agents -w $wordlist
            done
            
        else
            dirsearch -u $1 -e ',php,asp,aspx,jsp,js,html,do,action' -b -r -H "X-Forwarded-For:127.0.0.1" -x 400 --random-agents  -w "$HOME/src/enum/dirsearch/db/dicc.txt"
        fi
    else
        echo "dirs <domain> <ext> <opt:dictionary>"
    fi
}


dirs-list() {
    if [ -n "$1" ];
    then
        if [ -n "$2" ];
        then   
            dirsearch -L $1 -e ',php,asp,aspx,jsp,js,html,do,action' -b -r -H "X-Forwarded-For:127.0.0.1" -x 400 --random-agents -w $2
        else
            dirsearch -L $1 -e ',php,asp,aspx,jsp,js,html,do,action' -b -r -H "X-Forwarded-For:127.0.0.1" -x 400 --random-agents  -w "$HOME/src/enum/dirsearch/db/dicc.txt"
        fi
    else
        echo "dirs <domain> <ext> <opt:dictionary>"
    fi
}
