wkhtmltopdf -s Letter -T 0.5cm -R 0.5cm -B 0.5cm -L 0.5cm -O Landscape $1 $2
while true
do
    inotifywait -q -e modify $1
    echo "file changed"
    wkhtmltopdf -s Letter -T 0.5cm -R 0.5cm -B 0.5cm -L 0.5cm -O Landscape $1 $2
done

