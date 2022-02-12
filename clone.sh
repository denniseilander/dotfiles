#!/bin/sh

echo "Cloning repositories..."

SITES=$HOME/Sites
PACKAGES=$SITES/packages

# Personal
git clone git@github.com:denniseilander/laravel-passport-scopes-restriction.git $PACKAGES/passport-scopes-restriction