 
 #runs httprobe on all the hosts from certspotter

certprobe(){
	curl -s https://crt.sh/\?q\=\%.$1\&output\=json | jq -r '.[].name_value' | sed 's/\*\.//g' | sort -u | tee -a ./all.txt
}

alias nikto='nikto -Tuning 1,2,3,4,5,7,8,9,0,a,b,c -C all $@'

# envs
export WORKON_HOME=$HOME/.envs
export VIRTUALENVWRAPPER_PYTHON=/usr/bin/python3
