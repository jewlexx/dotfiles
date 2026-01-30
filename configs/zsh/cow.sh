HOUR="$(date +%H)"

if [ $HOUR -gt 18 ];
then
    echo "Good evening" | cowsay -f bong
elif [ $HOUR -gt 12 ];
then
    echo "Good afternoon" | cowsay -f bong
else
    echo "Good morning" | cowsay -f bong
fi;