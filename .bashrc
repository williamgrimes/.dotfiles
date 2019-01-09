# ~/.bashrc

###############################
# SOURCE ALIASES AND FUNCTIONS
###############################
source ~/.aliasrc

###############################
# LANGUAGE OPTIONS
###############################
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

###############################
# LOGBOOK FUNCTION
###############################
# function lb() {
#     file=~/LogBook/$(date '+%Y-%m-%d').md
#     if [ -e "$file" ]; then
#         vim "$file"
#     else 
#         echo "# $(date '+%Y-%m-%d')" > "$file"
#         vim "$file"
#     fi 
# }

# added by Miniconda3 installer
export PATH="/opt/miniconda3/bin:$PATH"
