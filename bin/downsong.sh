file=/tmp/songs.txt
for i in `cat $file`
do
 youtube-dl -x --audio-format mp3 $i 
done
