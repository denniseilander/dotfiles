#!/bin/sh

echo "Setting up your Mac..."

# Check for Homebrew and install if we don't have it
if test ! $(which brew); then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

  UNAME_MACHINE="$(/usr/bin/uname -m)"

  if [[ "${UNAME_MACHINE}" == "arm64" ]]
  then
    # On ARM macOS, brew will be installed to /opt/homebrew
    echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> $HOME/.zprofile
    eval "$(/opt/homebrew/bin/brew shellenv)"
    PHP_PATH="/opt/homebrew/opt"
    COMPOSER_PATH="/opt/homebrew/bin/composer"
  else
    # On Intel macOS, brew will be installed to to /usr/local
    echo 'eval "$(/usr/local/bin/brew shellenv)"' >> $HOME/.zprofile
    eval "$(/usr/local/bin/brew shellenv)"
    PHP_PATH="/usr/local/opt"
    COMPOSER_PATH="/usr/local/opt/composer/bin/composer"
  fi
fi

# Oh My Zsh Setup
ZSH_CUSTOM_PATH=${ZSH_CUSTOM:-~/.dotfiles/zsh-custom}

# Check for Oh My Zsh and install if we don't have it
if [ ! -e $HOME/.oh-my-zsh ]; then
  /bin/sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/HEAD/tools/install.sh)"
fi

# Removes .zshrc from $HOME (if it exists) and symlinks the .zshrc file from the .dotfiles
rm -rf $HOME/.zshrc
ln -s $HOME/.dotfiles/.zshrc $HOME/.zshrc

# Symlink aliases.zsh to zsh-custom directory
ln -sf $HOME/.dotfiles/aliases.zsh $ZSH_CUSTOM_PATH/aliases.zsh

# Symlink path.zsh to zsh-custom directory
ln -sf $HOME/.dotfiles/path.zsh $ZSH_CUSTOM_PATH/path.zsh

if [ ! -e $ZSH_CUSTOM_PATH/plugins/zsh-autosuggestions ]; then
  git clone https://github.com/zsh-users/zsh-autosuggestions $ZSH_CUSTOM_PATH/plugins/zsh-autosuggestions
fi

# Install spaceship prompt for ZSH
if [ ! -e $ZSH_CUSTOM_PATH/themes/spaceship-prompt ]; then
  git clone https://github.com/spaceship-prompt/spaceship-prompt.git $ZSH_CUSTOM_PATH/themes/spaceship-prompt --depth=1

  rm -rf $ZSH_CUSTOM_PATH/themes/spaceship.zsh-theme
  ln -s $ZSH_CUSTOM_PATH/themes/spaceship-prompt/spaceship.zsh-theme $ZSH_CUSTOM_PATH/themes/spaceship.zsh-theme
fi

# Create hushlogin file to remove "last login" in terminal
touch ~/.hushlogin

# Update Homebrew recipes
brew update

# Install all our dependencies with bundle (See Brewfile)
brew tap homebrew/bundle
brew bundle --file $DOTFILES/Brewfile

# Set default MySQL root password and auth type
brew services start mysql
mysql -u root -e "ALTER USER root@localhost IDENTIFIED WITH mysql_native_password BY ''; FLUSH PRIVILEGES;"

# Symlink pcre2 to fix bug when installing using pecl (PHP LATEST, 8.0, 7.4)
ln -s $PHP_PATH/pcre2/include/pcre2.h /opt/homebrew/opt/php/include/php/ext/pcre/pcre2.h
ln -s $PHP_PATH/pcre2/include/pcre2.h /opt/homebrew/opt/php@8.0/include/php/ext/pcre/pcre2.h
ln -s $PHP_PATH/pcre2/include/pcre2.h /opt/homebrew/opt/php@7.4/include/php/ext/pcre/pcre2.h

# Install PHP [LATEST, 8.0, 7.4] extensions with PECL
pecl install igbinary imagick redis pcov
$PHP_PATH/php@8.0/bin/pecl install igbinary imagick redis pcov
$PHP_PATH/php@7.4/bin/pecl install igbinary imagick redis pcov

# Install global Composer packages
$COMPOSER_PATH global require laravel/installer laravel/valet beyondcode/expose themsaid/ibis

# Install Laravel Valet
$HOME/.composer/vendor/bin/valet install

echo 'To support multiple PHP versions at once, check https://dev.to/dyriavin/serving-sites-with-different-php-version-using-laravel-valet-49jl'

# Create a Sites directory
mkdir $HOME/Sites

# Create sites subdirectories
mkdir $HOME/Sites/packages

# Clone Github repositories
$DOTFILES/clone.sh

# Symlink the .gitignore_globale file to the home directory
ln -s $DOTFILES/.gitignore_global $HOME/.gitignore_global

# Set the global gitignore file
git config --global core.excludesfile ~/.gitignore_global

# Symlink the Mackup config file to the home directory
ln -s $DOTFILES/.mackup.cfg $HOME/.mackup.cfg

# Set macOS preferences - we will run this last because this will reload the shell
source $DOTFILES/.macos
