#!/usr/bin/env bash

# Stow away your configs to $HOME
for file in *; do
       if [ -d "$file" ]; then
		stow "$file"
    echo "$file has been stowed"
	    fi
done	
