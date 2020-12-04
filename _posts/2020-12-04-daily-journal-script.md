---
layout: post
title: Daily journal script
---

Writing daily is a good thing for many reasons, and making it dead-easy is a
great way to ensure you stick to the habit. Over the years I've tried various
applications to write and ultimately I've ended up with plaintext
markdown-formatted files in a Dropbox folder. I have a small bash script that
will either open todays journal file or create a new one. It also supports
piping into the journal, although I rarely use this.

Here is the script:

``` bash
#!/bin/bash
# Create a dated text file at a specific location and append text to it.
#
# Usage:
#   $ jrnl something you want to jot down (appends that text to the file)
#   $ xclip -o | jrnl                     (appends your clipboard to the file)
#   $ jrnl                                (opens the file in your editor)
#
# Produces:
#   YYYY-MM-DD.md in your $NOTES_DIRECTORY (this is set below).

set -e

readonly NOTES_DIRECTORY="${NOTES_DIRECTORY:-"${HOME}/Dropbox/journal"}"
readonly NOTES_FILE="$(date +%Y-%m-%d).md"
readonly NOTES_PATH="${NOTES_DIRECTORY}/${NOTES_FILE}"

if [ ${#} -eq 0 ]; then
  if [ -p "/dev/stdin" ]; then
    (cat; printf "\n\n") >> "${NOTES_PATH}"
  else
    eval "${EDITOR}" "${NOTES_PATH}"
  fi
else
  printf "%s\n\n" "${*}" >> "${NOTES_PATH}"
fi
```

Running `jrnl` in a terminal will open the days journal file.

I use a folder structure of `journal/YYYY-DD-MM.md` for the current year. For
each new year I archive the years notes in a `YYYY` folder. So far this has
worked well, but I've considered keeping a journal file per month instead.
