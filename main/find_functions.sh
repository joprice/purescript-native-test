for file in $(find output -name "*.go"); do
  echo $file
  grep "func " $file | sed "s/func \([A-ZꞋ][w_0-9]*\)(.*/\1/" | head -n2
done
