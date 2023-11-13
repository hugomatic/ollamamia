#!/bin/bash

# Reminder for the user
# "Note: To make the OLLAMA_MODEL variable available in your current shell, run this script with 'source' or '.' before its path."

# ANSI color codes
GREEN="\033[32m"
NO_COLOR="\033[0m"

# This script uses 'ollama list' to present a list of models to the user,
# then prompts for a selection to set an environment variable with the chosen model's name.
echo "Fetching list of models..."
echo "-------------------------------------------------------------------------"

# Run 'ollama list' and capture the output, excluding the header
model_list=$(ollama list | tail -n +2)

# Check if the 'ollama list' command returned any models
if [[ -z "$model_list" ]]; then
  echo "No models found. Exiting."
  exit 1
fi

# Display the model list with numbering and highlight the current model in green
echo -e "No.\tNAME\t\tID\t\tSIZE\t\tMODIFIED"
i=1
while read -r line; do
  model_name=$(echo "$line" | awk '{print $1}')
  if [ "$model_name" = "$OLLAMA_MODEL" ]; then
    # Highlight the current model in green
    echo -e "${GREEN}$i.\t$line${NO_COLOR}"
  else
    echo -e "$i.\t$line"
  fi
  ((i++))
done <<< "$model_list"
echo "-------------------------------------------------------------------------"
echo "0. unset OLLAMA_MODEL"

# Prompt the user to select a model by number
read -p "Enter number: " selection
if [ -z "$selection" ]; then
    echo "Cancelled. The current model is: \"$OLLAMA_MODEL\""
    return
fi

# Check if the user entered 0
if [ "$selection" -eq 0 ]; then
    unset OLLAMA_MODEL
    echo "OLLAMA_MODEL has been unset."
else
    selected_model=$(echo "$model_list" | sed -n "${selection}p" | awk '{print $1}')

    # Validate selection and set the OLLAMA_MODEL environment variable
    if [[ -n "$selected_model" ]]; then
      export OLLAMA_MODEL=$selected_model
      echo "You have selected the model: $OLLAMA_MODEL"
    else
      echo "Invalid selection. Please try again."
    fi

fi
