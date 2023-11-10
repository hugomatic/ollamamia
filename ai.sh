#!/bin/bash

model=$OLLAMA_MODEL

# Run Ollama with model argument and redirect output to out.txt using tee
ollama run $model $1 | tee out.txt | llm_parse.py && llm_save.py blocks.json
# Clear the current line to avoid half-written prompt from background output

