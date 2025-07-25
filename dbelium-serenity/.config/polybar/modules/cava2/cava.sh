#! /bin/bash

bar="▁▂▃▄▅▆▇█"
dict="s/;//g;"

# creating "dictionary" to replace char with bar
i=0
while [ $i -lt ${#bar} ]
do
    dict="${dict}s/$i/${bar:$i:1}/g;"
    i=$((i=i+1))
done

# write cava config
config_file="./polybar_cava_config"
echo "
[general]
bars = 15

[output]
method = raw
raw_target = /dev/stdout
data_format = ascii
ascii_max_range = 7

[input]
method = pulse
source = auto

[smoothing]
monstercat = 1
waves = 0
" > $config_file

# read stdout from cava
cava -p $config_file | while read -r line; do
    echo $line | sed $dict
done