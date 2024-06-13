#!/bin/bash

# Define directories for input and output
input_dir="./mt_data_to_score"
output_dir="./scored_mt_data"

# Array of language pairs
language_pairs=("zh-en_2M" "en-ru_2M")

# Loop over each language pair and execute the prediction script
for lang_pair in "${language_pairs[@]}"; do
    echo "Processing $lang_pair..."

    # Run the prediction command, ignoring errors
    python -m metricx23.predict \
        --tokenizer google/mt5-xl \
        --model_name_or_path google/metricx-23-qe-xl-v2p0 \
        --max_input_length 1024 \
        --batch_size 16 \
        --input_file "$input_dir/$lang_pair.jsonl" \
        --output_file "$output_dir/$lang_pair.jsonl" \
        --qe || echo "Failed to process $lang_pair but continuing..."
done

echo "All processes completed."
