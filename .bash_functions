# ~/.bash_functions

###############################
# LOGBOOK FUNCTION
###############################
function lb() {
	file=~/logbook/$(date '+%Y-%m-%d').md
	if [ -e "$file" ]; then
    	vim "$file"
	else 
    	echo "# $(date '+%Y-%m-%d')" > "$file"
    	vim "$file"
	fi 
}

###############################
# MARKDOWN VIEWER
###############################
function mdv () {
  pandoc $1 | lynx -stdin -vikeys
}
