#!/bin/bash

# Gather markdown files
mapfile -t files < <(find . -type f -name "*.md")
total=${#files[@]}
count=0

# Progress bar
progress_bar() {
  local progress=$1
  local total=$2
  local width=40
  local percent=$(( progress * 100 / total ))
  local filled=$(( progress * width / total ))
  local empty=$(( width - filled ))
  printf "\r["
  printf "%0.s#" $(seq 1 $filled)
  printf "%0.s-" $(seq 1 $empty)
  printf "] %3d%% (%d/%d)" "$percent" "$progress" "$total"
}

for file in "${files[@]}"; do
  ((count++))

  # --- Step 1: SED FIXES ---
  # Add > before infobox line (only if not already there)
  sed -i 's/^\[!infobox|left clean wmed\]/>[!infobox|left clean wmed]/' "$file"

  # Only modify image line in front-matter
  sed -i -E 's/^image:\s*!\[\]\(2\.%20Mechanics\//image: 2. Mechanics\//g' "$file"

  # Remove trailing .webp#right) → .webp)
  sed -i -E 's/\.webp#right\)/.webp)/g' "$file"

  # --- Step 2: Blockquote between infobox and ^statblock ---
  awk '
    BEGIN {in_block=0}
    /^>?\[!infobox\|left clean wmed\]/ { print; in_block=1; next }
    /^\^statblock/ { print; in_block=0; next }
    {
      if (in_block) {
        if ($0 !~ /^>/) { print ">" $0 }
        else { print }
      } else {
        print
      }
    }
  ' "$file" > "$file.tmp" && mv "$file.tmp" "$file"

  # --- Step 3: Update Progress Bar ---
  progress_bar "$count" "$total"
done

# Done
echo
echo "✅ All $total Markdown files processed successfully!"
