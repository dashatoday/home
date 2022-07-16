cd images
for i in $(seq 1 1000);
do
  DIRECTORY=$i
  if [ -d "$DIRECTORY" ]; then
    echo "exist: $DIRECTORY"
  else
    mkdir $DIRECTORY
    cd $DIRECTORY
    mogrify -path ./ -resize 25% ./../../dasha/*.JPG
    ls -v | cat -n | while read n f; do mv -n "$f" "$n.JPG"; done
    break
  fi
done

cd ../../pages
for p in $(seq 1 1000);
do
  PAGE=$p
  if [ -f "$PAGE.html" ]; then
    echo "exist: $PAGE.html"
  else
    echo "<!DOCTYPE html>
    <html lang="ru">
    <head>
      <meta charset="UTF-8">
      <meta name="viewport" content="width=device-width, initial-scale=1.0">
      <meta http-equiv="X-UA-Compatible" content="ie=edge">
      <title>Dashatoday #$PAGE</title>
      <link rel="stylesheet" href="./../style.css">
    </head>
    <body>
      <div class='day'>Dashatoday #$PAGE</div>
    " >> "$PAGE.html"

    for file in ./../images/$PAGE/*.JPG;
    do
      echo "<a href="$file"><img src="$file" alt="$file" /></a>" >> "$PAGE.html"
    done

    echo "
      <div>
        <a class='page' href="$(($PAGE-1)).html">< prev page</a><a class='page' href="$(($PAGE+1)).html">next page ></a>
      </div>
      </body></html>
    " >> "$PAGE.html"
    break
  fi
done

cd ../

rm -rf index.html

echo "<!DOCTYPE html>
<html lang="ru">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <meta http-equiv="X-UA-Compatible" content="ie=edge">
  <title>Dashatoday</title>
  <link rel="stylesheet" href="./../style.css">
</head>
<body>
  <div class='day'>Dashatoday</div>
" >> "index.html"

for file in ./pages/*.html;
do
  echo "<a href="$file"><div class='day-link'>Dashatoday #"${file//[A-Za-z\/\.]/}"</div></a>" >> "index.html"
done

echo "</body></html>" >> "index.html"
