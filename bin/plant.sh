while :
do
    inotifywait -q -e modify --format "%w" *.puml | xargs java -jar ~/dot-files/bin/plantuml.jar -tsvg 
    echo "============ rebuild ============"
done
