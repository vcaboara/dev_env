#!/bin/bash

# install_vim.sh
# This script installs or updates Vim using apt package manager,
# sets up vim-plug, symlinks the .vimrc file, and installs plugins.
# Designed for Linux environments (including WSL).

# --- Configuration ---
# Define the source path for your .vimrc file relative to where the script is run.
# Assuming the script is run from the root of your dev_env repo.
VIM_CONFIG_SRC="vimrc"

# Define the destination path in the user's home directory.
VIM_CONFIG_DEST="$HOME/.vimrc"

# Define the installation paths for vim-plug.
VIM_PLUG_DIR="$HOME/.vim/autoload"
VIM_PLUG_DEST="$VIM_PLUG_DIR/plug.vim"

# --- End Configuration ---


# Function to display messages
log() {
    echo "[INFO] $1"
}

# Function to display warnings
warn() {
    echo "[WARN] $1"
}

# Function to display errors and exit
error() {
    echo "[ERROR] $1" >&2
    exit 1
}

# Function to install or update a package using apt-get
# Args: package_name, command_to_check, flag_variable_name (e.g., VIM_INSTALLED)
install_or_update_package() {
    local package_name="$1"
    local cmd_to_check="$2"
    local flag_var_name="$3"

    log "Checking for $package_name..."
    if command -v "$cmd_to_check" &> /dev/null; then
        log "$package_name is already installed. Attempting to update..."
        if sudo apt-get upgrade "$package_name" -y; then
            log "$package_name updated successfully or was already latest."
            eval "$flag_var_name=true"
        else
            warn "Failed to update $package_name."
            # Still consider it installed if the upgrade failed but command exists
            eval "$flag_var_name=true"
        fi
    else
        log "$package_name not found. Installing $package_name..."
        if sudo apt-get install "$package_name" -y; then
            log "$package_name installed successfully."
            eval "$flag_var_name=true"
        else
             error "Failed to install $package_name using apt-get. Make sure your repositories are configured correctly."
             eval "$flag_var_name=false" # Explicitly set to false on failure
        fi
    fi
}


# Function to setup vim-plug
# Args: plug_dir, plug_dest
setup_plug() {
    local plug_dir="$1"
    local plug_dest="$2"

    log "Setting up vim-plug in $plug_dir..."
    mkdir -p "$plug_dir"
    if [ ! -f "$plug_dest" ]; then
        log "Downloading vim-plug to $plug_dest..."
        curl -fLo "$plug_dest" --create-dirs \
            https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim || warn "Failed to download vim-plug to $plug_dest."
    else
        log "vim-plug already exists at $plug_dest. Skipping download."
    fi
}

# Function to create symlink for config
# Args: config_src, config_dest
symlink_config() {
    local config_src="$1"
    local config_dest="$2"

    log "Attempting to symlink config from $config_src to $config_dest using ln -sf..."
    if [ -f "$config_src" ]; then
        # Create the symlink, forcing overwrite if destination exists
        ln -sf "$(pwd)/$config_src" "$config_dest"
        if [ $? -eq 0 ]; then
            log "Successfully created symlink for config."
        else
            warn "Failed to create symlink for config from $(pwd)/$config_src to $config_dest."
        fi
    else
        warn "Config source file not found: $config_src. Cannot create symlink."
    fi
}

# Function to install plugins
# Args: editor_command, config_dest, installed_flag_var (e.g., VIM_INSTALLED)
install_plugins() {
    local editor_cmd="$1"
    local config_dest="$2"
    local flag_var_name="$3"
    local installed_status
    local temp_vim_script

    # Get the boolean status from the variable name
    eval "installed_status=\$${flag_var_name}"

    # Check if editor command exists AND the config file/symlink exists AND editor was successfully installed/found
    if command -v "$editor_cmd" &> /dev/null && [ -L "$config_dest" ] && [ "$installed_status" = true ]; then
        log "Installing plugins for $editor_cmd using a temporary script..."

        # Create a temporary file for the Vim script
        temp_vim_script=$(mktemp /tmp/${editor_cmd}_plug_install_script.XXXXXX.vim)

        # Write the Vim commands into the temporary script file
        # We'll still use the autocmd approach within the script for a clean exit after PlugInstall
        cat << EOF > "$temp_vim_script"
try
  " Ensure vim-plug is sourced
  if !filereadable(expand('~/.vim/autoload/plug.vim'))
    echo "vim-plug not found! Cannot install plugins."
    " Exit Vim with an error code if plug.vim is missing
    cquit 1
  endif
  source ~/.vim/autoload/plug.vim

  " Set up autocommand to quit after PlugInstall finishes
  autocmd User PlugInstall Post quitall

  " Run PlugInstall
  PlugInstall

  " Fallback quit just in case autocmd doesn't fire immediately in this context
  " Might need a small delay depending on how PlugInstall works
  " sleep 1 " Uncommenting sleep can sometimes help, but isn't ideal
  qa!

catch /^Vim\%((\a\+)\)\=:E/
  echomsg "Error during plugin installation: " . v:exception
  " Exit Vim with an error code on error
  cquit 1
endtry

EOF

        # Execute Vim with the temporary script in silent mode
        # -S: Source the script file
        # -e: Start in Ex mode (usually implied by -s or -es, but explicit doesn't hurt)
        # -s: Silent mode (prevents most interactive prompts)
        vim -es -S "$temp_vim_script"

        # Capture the exit code of Vim
        local vim_exit_code=$?

        # Remove the temporary script file
        rm "$temp_vim_script"

        # Check the exit code
        if [ "$vim_exit_code" -eq 0 ]; then
            log "$editor_cmd plugin installation finished successfully."
        else
            warn "$editor_cmd plugin installation encountered issues. Vim exited with code $vim_exit_code."
            warn "Check your .vimrc for errors and ensure plugins are correctly listed."
        fi

    else
        log "$editor_cmd not installed, config not symlinked, or installation failed. Skipping plugin installation."
    fi
}


log "Starting Vim installation/update and configuration script..."

# --- Variables to track successful installs ---
# This is global so helper functions can set it
VIM_INSTALLED=false

# --- Installation/Update ---

# Check for apt-get (expected on Linux/WSL)
if command -v apt-get &> /dev/null; then
    log "Using apt-get for installation."
    sudo apt-get update || error "Failed to update apt package lists."

    # Install/Update Vim
    install_or_update_package "vim" "vim" "VIM_INSTALLED"

else
    error "Could not find apt-get package manager. This script is designed for Linux environments (including WSL)."
fi


# --- Post-Installation Configuration ---

log "Starting post-installation configuration..."

# Setup vim-plug and symlink configs only if Vim was installed/found
if [ "$VIM_INSTALLED" = true ]; then
    setup_plug "$VIM_PLUG_DIR" "$VIM_PLUG_DEST"
    symlink_config "$VIM_CONFIG_SRC" "$VIM_CONFIG_DEST"
fi

# Install plugins only if Vim was installed/found AND config was symlinked successfully
# (Assuming config includes Plug commands)
install_plugins "vim" "$VIM_CONFIG_DEST" "VIM_INSTALLED"


log "Vim installation, update, and configuration script finished."
