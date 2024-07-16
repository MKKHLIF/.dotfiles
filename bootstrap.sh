#!/bin/bash

# Function to display the welcome message
display_welcome() {
  echo " __  __ ____  _______     _______ _    _ _______ ______ "
  echo "|  \/  |  _ \| ____\ \   / / ____| |  | |__   __|  ____|"
  echo "| \  / | |_) |  _|  \ \_/ /|  _| | |  | |  | |  | |__   "
  echo "| |\/| |  _ <| |___  \   / | |___| |__| |  | |  |  __|  "
  echo "| |  | | |_) |_____|  | |  |_____|____/|  |_|  |_|     "
  echo "|_|  |_|____/|_____|  |_|  (C) MK DOTFILES INSTALLATION"
  echo "========================================================"
}

# Function to ask for OS choice and handle it
handle_os_choice() {
  while true; do
    echo "Are you on Arch or OpenSUSE? (Type 'arch' or 'opensuse'):"
    read os_choice
    case $os_choice in
      arch)
        echo "Running installation for Arch..."
        if ./scripts/arch/install_arch.sh; then
          break
        else
          echo "Failed to run Arch installation script. Please check the script and try again."
        fi
        ;;
      opensuse)
        echo "Running installation for OpenSUSE..."
        if ./scripts/opensuse/install_opensuse.sh; then
          break
        else
          echo "Failed to run OpenSUSE installation script. Please check the script and try again."
        fi
        ;;
      *)
        echo "Invalid option. Please choose either 'arch' or 'opensuse'."
        ;;
    esac
  done
}

# Function to ask for Display Manager choice and handle it
handle_dm_choice() {
  while true; do
    echo "Which Display Manager do you want to setup? (Type 'dwm', 'hyprland', or 'both'):"
    read dm_choice
    case $dm_choice in
      dwm)
        echo "Setting up DWM..."
        ./scripts/display_manager/dwm_setup.sh && break || echo "Failed to setup DWM. Please check the script and try again."
        ;;
      hyprland)
        echo "Setting up Hyprland..."
        ./scripts/display_manager/hyprland_setup.sh && break || echo "Failed to setup Hyprland. Please check the script and try again."
        ;;
      both)
        echo "Setting up both DWM and Hyprland..."
        if ./scripts/display_manager/dwm_setup.sh && ./scripts/display_manager/hyprland_setup.sh; then
          break
        else
          echo "Failed to setup both DWM and Hyprland. Please check the scripts and try again."
        fi
        ;;
      *)
        echo "Invalid option. Please choose either 'dwm', 'hyprland', or 'both'."
        ;;
    esac
  done
}

# Function to perform additional setup
additional_setup() {
  echo "Running additional setup..."
  if ./scripts/additional_setup.sh; then
    echo "Additional setup complete."
  else
    echo "Failed to complete additional setup. Please check the script and try again."
  fi
}

# Main script execution
display_welcome
handle_os_choice
handle_dm_choice
additional_setup
echo "Setup complete. Please reboot your system to apply changes."