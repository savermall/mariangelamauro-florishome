#!/bin/bash
set -u
cd /home/saverio/.openclaw/workspace/florishome-site
mkdir -p img
n=0
while IFS=$'\t' read -r file url; do
  [ -z "$file" ] && continue
  curl -sL -A 'Mozilla/5.0 (X11; Linux x86_64)' -o "$file" "$url" &
  n=$((n+1))
  while [ "$(jobs -r | wc -l)" -ge 6 ]; do wait -n 2>/dev/null || break; done
done < dl.tsv
wait
echo "DOWNLOADS_DONE"
ls -la img | wc -l
du -sh img