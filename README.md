# ollamamia
terminal tools for ollama

![save](images/ollamamia.png)

## Installation

This package contains a set of useful scripts and Python files that can be easily installed on your system. The installation process creates symbolic links in `/usr/local/bin`, making the scripts accessible from anywhere in the terminal.

### Prerequisites

Before installing, ensure you have `sudo` privileges on your system, as the installation script requires elevated permissions to create symbolic links in `/usr/local/bin`.

### Install (and uninstall) Steps

1. **Clone the Repository (Optional)**:
   If the scripts are hosted in a git repository, first clone the repository to your local machine. Otherwise, ensure you have the scripts (`ai.sh`, `aiup.sh`, `llm_parse.py`, `llm_save.py`) downloaded.

   ```bash
   git clone https://github.com/hugomatic/ollamamia.git
   cd ollamamia
  ```

2. **Run the setup script**:
   The setup script creates links to the scripts in /usr/local/bin
   ```bash
   sudo ./setup.bash

   Select an option:
   1) Install
   2) Uninstall
   Enter your choice (1/2):
   ```
### try it out

  ```bash
   ai.sh "tell me a joke"
  ```

  Select a default model:

  ```bash
  source aiup.sh
  ```
  This will copy the model name is in the OLLAMA_MODEL environemnet variable for this terminal.
