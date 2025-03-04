# Shortcuts
alias copyssh="pbcopy < $HOME/.ssh/id_ed25519.pub"
alias reloadshell="source $HOME/.zshrc"
alias reloaddns="dscacheutil -flushcache && sudo killall -HUP mDNSResponder"
alias ll="/opt/homebrew/opt/coreutils/libexec/gnubin/ls -AhlFo --color --group-directories-first"
alias phpstorm='open -a /Applications/PhpStorm.app "`pwd`"'
alias shrug="echo '¯\_(ツ)_/¯' | pbcopy"
alias c="clear"
alias compile="commit 'compile'"
alias version="commit 'version'"
alias sublime='open -a /Applications/Sublime\ Text.app "`pwd`"'

# Directories
alias documents="cd $HOME/Documents"
alias dotfiles="cd $DOTFILES"
alias downloads="cd $HOME/Downloads"
alias home="cd $HOME"
alias library="cd $HOME/Library"
alias sites="cd $HOME/Sites"
alias work="cd $HOME/workspace"

UNAME_MACHINE="$(/usr/bin/uname -m)"

if [[ "${UNAME_MACHINE}" == "arm64" ]]
then
  # On ARM macOS, brew extensions will be installed to /opt/homebrew
  PHP_PATH="/opt/homebrew/opt"
  COMPOSER_PATH="/opt/homebrew/bin/composer"
else
  # On Intel macOS, brew extensions will be installed to to /usr/local
  PHP_PATH="/usr/local/opt"
  COMPOSER_PATH="/usr/local/opt/composer/bin/composer"
fi

# PHP
alias php74="$PHP_PATH/php@7.4/bin/php"
alias php80="$PHP_PATH/php@8.0/bin/php"
alias php81="$PHP_PATH/php@8.1/bin/php"

alias composer74="php74 $COMPOSER_PATH"
alias composer80="php80 $COMPOSER_PATH"
alias composer81="php81 $COMPOSER_PATH"

alias pecl74="$PHP_PATH/php@7.4/bin/pecl"
alias pecl80="$PHP_PATH/php@8.0/bin/pecl"
alias pecl81="$PHP_PATH/php@8.1/bin/pecl"

# Laravel
alias a="php artisan"
alias a74="php74 artisan"
alias a80="php80 artisan"
alias a81="php81 artisan"
alias create-database="touch ./database/database.sqlite"
alias clearlog="rm -rf ./storage/logs/laravel.log"
alias clearlogs="rm -rf ./storage/logs/*.log"
alias mf="php artisan migrate:fresh"
alias mfs="php artisan migrate:fresh --seed"
alias seed="php artisan db:seed"

# SQL Server
alias mssql="docker run -e ACCEPT_EULA=Y -e SA_PASSWORD=password -p 1433:1433 mcr.microsoft.com/mssql/server:2017-latest"

# Git
alias gst="git status"
alias gb="git branch"
alias gc="git checkout"
alias gl="git log --oneline --decorate --color"
alias amend="git add . && git commit --amend --no-edit"
alias commit="git add . && git commit -m"
alias diff="git diff"
alias force="git push --force"
alias nah="git clean -df && git reset --hard"
alias nuke="git clean -df && git reset --hard"
alias pop="git stash pop"
alias pull="git pull"
alias push="git push"
alias resolve="git add . && git commit --no-edit"
alias stash="git stash -u"
alias unstage="git restore --staged ."
alias wip="commit wip"
