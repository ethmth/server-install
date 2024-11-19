#!/bin/bash

/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

echo >> /Users/ethan/.bash_profile
echo 'eval "$(/usr/local/bin/brew shellenv)"' >> /Users/ethan/.bash_profile
eval "$(/usr/local/bin/brew shellenv)"