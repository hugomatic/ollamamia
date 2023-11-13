#!/bin/bash

# Check if OLLAMA_MODEL is not set or is empty
if [ -z "$OLLAMA_MODEL" ]; then
    echo "OLLAMA_MODEL is not set: source aiup.sh"
    source aiup.sh
else
    model=$OLLAMA_MODEL
fi

model=$OLLAMA_MODEL


# Run Ollama with model argument and redirect output to out.txt using tee
ollama run $model $1 | tee out.txt | llm_parse.py && llm_save.py blocks.json
# Clear the current line to avoid half-written prompt from background output

