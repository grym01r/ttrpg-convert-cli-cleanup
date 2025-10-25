# What This Script Does

For every .md file in the directory (including subfolders):

1. Fixes Infobox Formatting

Ensures the infobox line begins with a blockquote marker:

>[!infobox|left clean wmed]

2. Blockquotes Infobox Contents

Everything between the infobox line and the next ^statblock line is automatically prefixed with > so it renders as a block.

Before:

[!infobox|left clean wmed]
Name: Creature
Type: Beast
...
^statblock


After:

\>[!infobox|left clean wmed] <br>
\>Name: Creature <br>
\>Type: Beast <br>
\>... <br>
^statblock

3. Fixes Front-Matter Image Paths

Only in front-matter (image: lines):

Converts:

>image: ![](2.%20Mechanics/SomeImage.webp#right)


to

>image: 2. Mechanics/SomeImage.webp


This does not change any other image references in the Markdown body.

4. Shows a Progress Bar

Displays percentage and file count while processing.

# Requirements

Bash shell (Linux / macOS / WSL / Git Bash)

GNU sed and awk (default on Linux/macOS)

# Usage

Place the script in the root directory containing your .md files.

Make executable:

chmod +x fix-markdown-formatting.sh


Run:

`./cleanup.sh`

# Recommended Workflow

Commit or back up your markdown files before running the script.

Run the script.

Verify formatting on a few example files.

Commit the results once you approve.

#Notes & Limitations

The script assumes infobox sections end at the first line beginning with ^statblock.

Only front-matter image lines beginning with image: are modified.

Files are updated in-place, but temporary .tmp files are used safely.

# Example File Before & After

Before

statblock:
`[!infobox|left clean wmed]
Name: Skeleton
HP: 13`
YAML frontmatter:
`image: ![](2.%20Mechanics/Skeleton.webp#right)`



After
statblock:
`\>[!infobox|left clean wmed]
\>Name: Skeleton
\>HP: 13`

YAML frontmatter:
`image: 2. Mechanics/Skeleton.webp`

