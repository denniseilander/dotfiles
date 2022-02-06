#!/bin/sh

echo "Cloning repositories..."

SITES=$HOME/Sites
PACKAGES=$SITES/packages

# Personal
gh repo clone denniseilander/laravel-passport-scopes-restriction $PACKAGES/passport-scopes-restriction