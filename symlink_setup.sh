#!/bin/bash
: '
This script sets up dotfiles configuration, either locally or remotely.

It first checks if the --remote flag is passed as a command-line argument.
If it is, it configures remote dotfiles by calling the backup_and_link function with a set of remote dotfiles.
If the flag is not passed, it first creates the fish config directory if it does not exist, then creates symlinks for a set of local dotfiles and emacs configuration directory.

The script uses a WAIT_TIME variable to sleep for 10 seconds before configuring the dotfiles.
'


WAIT_TIME="10s"

backup_and_link() {
    : '
    This function takes in a file name as an argument, checks if it exists in the home directory,
    creates a backup with a timestamp in the format of YYYYMMDDHHSS,
    and then creates a symbolic link from the specified dotfiles directory to the home directory.

    If the file name includes a `.remote` suffix this is dropped in the linked file.
    '

    FILE=$1

    remove_remote_suffix() {
        local FILE="$1"
        local SUBSTRING=".remote"
        if [[ "${FILE}" == *"$SUBSTRING" ]]; then
          echo "${FILE%$SUBSTRING}"
        else
          echo "${FILE}"
        fi
    }

    FILE_DROP_REMOTE=$(remove_remote_suffix "$FILE")


    if [ -f ~/$FILE_DROP_REMOTE ]; then
        TIMESTAMP=$(date +%Y%m%d%H%M%S)
        BACKUP_FILE="${FILE_DROP_REMOTE}_backup_${TIMESTAMP}"

        echo "${FILE_DROP_REMOTE} exists, creating a backup file ${BACKUP_FILE}"
        mv ~/$FILE_DROP_REMOTE ~/$BACKUP_FILE
    fi


    echo "Creating a symlink for ${FILE}"
    ln -s ~/.dotfiles/$FILE ~/$FILE_DROP_REMOTE
}


if [ "$1" = "--remote" ]; then

    echo "Remote dotfiles configuring; sleep for ${WAIT_TIME} seconds before continuing."

    sleep $WAIT_TIME

    backup_and_link ".bashrc.remote"
    backup_and_link ".aliasrc.remote"
    backup_and_link ".tmux.conf.remote"
    backup_and_link ".vimrc"

else

    echo "Dotfiles configuring; sleep for ${WAIT_TIME} seconds before continuing."

    sleep $WAIT_TIME

    FISH_CONFIG="~/.config/fish"

    if [ ! -d $FISH_CONFIG ]
    then
        echo "Creating fish config directory at ${FISH_CONFIG}."
        mkdir -p $FISH_CONFIG
    else
        echo "Directory ${FISH_CONFIG} exists, remove it and try again."
        exit 0
    fi

    echo "Creating a symlink for .config.fish"
    ln -s ~/.dotfiles/config.fish ~/.config/fish/config.fish

    backup_and_link ".gitconfig"
    backup_and_link ".tmux.conf"
    backup_and_link ".vimrc"

    echo "Creating a symlink for ~/.emacs.d/"
    ln -s ~/.dotfiles/personal ~/.emacs.d/

fi

