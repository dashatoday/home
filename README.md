# home


if [ -d "$DIRECTORY" ]; then
  mkdir 1
  cd 1
  mogrify -path ./ -resize 25% ./../../dasha/*.JPG
  ls -v | cat -n | while read n f; do mv -n "$f" "$n.JPG"; done
fi
  mkdir 2
