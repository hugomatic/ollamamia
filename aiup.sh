#!/bin/bash

# Reminder for the user
# "Note: To make the OLLAMA_MODEL variable available in your current shell, run this script with 'source' or '.' before its path."

# This script uses 'ollama list' to present a list of models to the user,
# then prompts for a selection to set an environment variable with the chosen model's name.
echo "current model $OLLAMA_MODEL"
echo "Fetching list of models..."
echo "--------------------------------------------------"

# Run 'ollama list' and capture the output, excluding the header
model_list=$(ollama list | tail -n +2)

# Check if the 'ollama list' command returned any models
if [[ -z "$model_list" ]]; then
  echo "No models found. Exiting."
  exit 1
fi

# Display the model list to the user
echo -e "NAME\tID\tSIZE\tMODIFIED"
echo "$model_list"
echo "--------------------------------------------------"

# Create an array to hold the model names
model_names=()
while IFS= read -r line; do
  model_name=$(echo "$line" | awk '{print $1}')
  model_names+=("$model_name")
done <<< "$model_list"

# Prompt the user to select a model by number
echo "Please select a model by entering the corresponding number:"
select model_choice in "${model_names[@]}"; do
  if [[ -n "$model_choice" ]]; then
    # Set the OLLAMA_MODEL environment variable to the selected model name
    export OLLAMA_MODEL=$model_choice
    echo "You have selected the model: $OLLAMA_MODEL"
    break
  else
    echo "Invalid selection. Please try again."
  fi
done


