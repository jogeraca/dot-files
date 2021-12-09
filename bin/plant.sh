while :
do
    inotifywait -q -e modify -e create --format "%w" . | xargs java -jar ~/dot-files/bin/plantuml.jar -tsvg 
    echo "============ rebuild ============"
done
