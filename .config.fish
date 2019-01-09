# REMOVE FISH GREETING
set fish_greeting ""

# REUSE ALIASES FROM ~/.aliasrc
egrep "^alias " ~/.aliasrc | while read e
        set var (echo $e | sed -E "s/^alias ([A-Za-z0-9_-]+)=(.*)\$/\1/")
        set value (echo $e | sed -E "s/^alias ([A-Za-z0-9_-]+)=(.*)\$/\2/")

        # remove surrounding quotes if existing
        set value (echo $value | sed -E "s/^\"(.*)\"\$/\1/")

    # evaluate variables. we can use eval because we most likely just used "$var"
        set value (eval echo $value)

    # set an alias
    alias $var="$value"
end

# REUSE ENVIRONMENT VARIABLES FROM ~/.bashrc
egrep "^export " ~/.bashrc | while read e
    set var (echo $e | sed -E "s/^export ([A-Z0-9_]+)=(.*)\$/\1/")
    set value (echo $e | sed -E "s/^export ([A-Z0-9_]+)=(.*)\$/\2/")

    # remove surrounding quotes if existing
    set value (echo $value | sed -E "s/^\"(.*)\"\$/\1/")

    if test $var = "PATH"
        # replace ":" by spaces. this is how PATH looks for Fish
        set value (echo $value | sed -E "s/:/ /g")

        # use eval because we need to expand the value
        eval set -xg $var $value

        continue
    end

    # evaluate variables. we can use eval because we most likely just used "$var"
    set value (eval echo $value)

    #echo "set -xg '$var' '$value' (via '$e')"

    switch $value
            case '`*`';
            # executable
            set NO_QUOTES (echo $value | sed -E "s/^\`(.*)\`\$/\1/")
            set -x $var (eval $NO_QUOTES)
        case '*'
            # default
            set -xg $var $value
        end
end

function lb
        set file ~/LogBook/(date '+%Y-%m-%d').md
        if test -f $file;
                vim $file
		        echo 'loaded logbook entry ' $file
        else
                echo '# '(date '+%Y-%m-%d') | vim -
		        echo 'created logbook entry ' $file
        end
end

function pomodoro --argument work break
	# https://github.com/rlue/timer
    set x 1
    while true
        echo "Pomodoro $x: work $work minutes, break $break minutes"
        timer $work $break
        set x (math $x+1)
    end
end

# CONDA ACTIVATE/DEACTIVATE FUNCTIONS
source /opt/miniconda3/etc/fish/conf.d/conda.fish
