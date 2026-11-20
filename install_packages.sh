#!/usr/bin/env bash

# Define colors
RED=$(tput setaf 1)
GREEN=$(tput setaf 2)
YELLOW=$(tput setaf 3)
BLUE=$(tput setaf 4)
BOLD=$(tput bold)
RESET=$(tput sgr0)

failed_pack=0

# Feel free to add anymore packages that may be needed
packages=(
	stow
	vim
	tmux
)

# Verify package manager to use for installation
for pac_man in apt dnf pacman zypper apk; do
	if command -v "$pac_man" /dev/null 2>&1; then
		PKG_MANAGER="$pac_man"
		break
	fi
done

# Print out package manager
if [ -n "$PKG_MANAGER" ]; then
	echo "${GREEN}Package manager found: $PKG_MANAGER${RESET}"
else
	echo "${RED}No supported package manager found${RESET}"
fi

# Install packages onto system
for pkg in "${packages[@]}"; do
	echo "${GREEN}Installing $pkg...${RESET}"
	sudo $PKG_MANAGER install -y $pkg
	if [ $(echo $?) == 1 ]; then
		echo "${RED}$pkg was not installed${RESET}"
		((failed_pack++))
	else
		continue
	fi
done

printf "\n${RED}Number of failed packages: %d${RESET}\n" "$failed_pack"



