#! /run/current-system/sw/bin/sh

# Assign script arguments to variables
home_config=$1
system_config=$2
flags=$3

# List of home configurations
home_configs="maximiliann "
# List of system configurations
system_configs="bf-109 "

# Check if both arguments are provided
if [ -z "$home_config" ] || [ -z "$system_config" ]; then
echo "Usage: $0 <home_config> <system_config> [--verbose] [--rebuild-bootloader]"
echo "Available system configurations: $system_configs"
echo "Available home configurations: $home_configs"
exit 1
fi

# Check if the chosen configurations in the lists
if ! echo $home_configs | grep -q $home_config; then
echo "Invalid home configuration: $home_config"
echo "Available home configurations: $home_configs"
exit 1
fi
if ! echo $system_configs | grep -q $system_config; then
echo "Invalid system configuration: $system_config"
echo "Available system configurations: $system_configs"
exit 1
fi

# Ask the user for confirmation to delete the contents of /etc/nixos and replace them with the new configuration
echo "This script will replace the contents of /etc/nixos with the configuration of $system_config and the home configuration of $home_config."
read -p "Do you want to continue? [y/N] " -n 1 -r
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]; then
echo "Aborted."
exit 1
fi

# Delete the contents of /etc/nixos
sudo rm -rf /etc/nixos/*

# Copy the configuration files to /etc/nixos
current_dir=$(dirname $0)
sudo rsync -r --exclude .git $current_dir /etc/nixos

# Change the owner of the copied files to root
sudo chown -R root:root /etc/nixos

# Cd to /etc/nixos
cd /etc/nixos

# Rebuild the system configuration
if [ "$flags" = "--verbose" ]; then
echo "Upgrading system configuration... (verbose)"
sudo nixos-rebuild switch --upgrade --flake .#$system_config --show-trace --impure
elif [ "$flags" = "--rebuild-bootloader" ]; then
echo "Upgrading system configuration... (rebuild-bootloader)"
sudo nixos-rebuild switch --upgrade --flake .#$system_config --impure
else
echo "Upgrading system configuration..."
sudo nixos-rebuild switch --upgrade --flake .#$system_config --impure
fi

# Switch to the home configuration
echo "Switching to home configuration..."
home-manager switch --flake .#$home_config

# Exit with the exit code of the last command
exit $?
