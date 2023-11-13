#!/usr/bin/env bash

# Function to create symbolic links
install_links() {
    echo "Installing..."
    sudo ln -sf "$DIR/ai.sh" /usr/local/bin/ai.sh
    sudo ln -sf "$DIR/aiup.sh" /usr/local/bin/aiup.sh
    sudo ln -sf "$DIR/llm_parse.py" /usr/local/bin/llm_parse.py
    sudo ln -sf "$DIR/llm_save.py" /usr/local/bin/llm_save.py
    chmod +x "$DIR/ai.sh"
    echo "Installation complete."
}

# Function to remove symbolic links
uninstall_links() {
    echo "Uninstalling..."
    sudo rm -f /usr/local/bin/ai.sh
    sudo rm -f /usr/local/bin/aiup.sh
    sudo rm -f /usr/local/bin/llm_parse.py
    sudo rm -f /usr/local/bin/llm_save.py
    echo "Uninstallation complete."
}

# Absolute path to the directory containing the script
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Main menu for the user
echo "Select an option:"
echo "1) Install"
echo "2) Uninstall"
read -p "Enter your choice (1/2): " choice

case $choice in
    1)
        install_links
        ;;
    2)
        uninstall_links
        ;;
    *)
        echo "Invalid choice. Exiting."
        exit 1
        ;;
esac

