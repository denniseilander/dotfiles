#!/bin/sh

echo "Cloning repositories..."

SITES=$HOME/Sites
PACKAGES=$SITES/packages

# Personal
git clone git@github.com:denniseilander/dotfiles.git $PACKAGES/passport-scopes-restriction