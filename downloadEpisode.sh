#!/bin/bash

function downloadEpisode () {
series=$1
episode=$2
url="https://roosterteeth.com/watch"

case $series in
    1)
    link="$url/rwby-season-1-episode-$episode"
    ;;
    2)
    link="$url/rwby-season-2-rwby-volume-2-chapter-$episode"
    ;;
    3)
    special=$(volume3 $episode) || echo "Season $series is unsupported or unavailable."
    link="$url/rwby-season-3-$special"
    ;;
    4)
    special=$(volume4 $episode) || echo "Season $series is unsupported or unavailable."
    link="$url/$special"
    ;;
    5)
    special=$(volume5 $episode) || echo "Season $series is unsupported or unavailable."
    link="$url/rwby-volume-5-$special"
    ;;
    [6-9])
    link="$url/rwby-volume-$series-$episode"
    ;;
    *)
    echo "Season $series is unsupported or unavailable."
    link="null"
    exit 0
    ;;
esac

echo $link

# download 1080p video
youtube-dl -f bestvideo $link -o "RWBY-V$series-Ep$episode-video.mp4"
# download audio
youtube-dl -f hls-audio-0-en__Main_ $link -o "RWBY-V$series-Ep$episode-audio.mp4"

ffmpeg -loglevel quiet -stats -i "RWBY-V$series-Ep$episode-video.mp4" -i "RWBY-V$series-Ep$episode-audio.mp4" -c:v copy -c:a copy "RWBY Volume $series Chapter $episode.mp4"
rm "RWBY-V$series-Ep$episode-audio.mp4"
rm "RWBY-V$series-Ep$episode-video.mp4"
}

# V1 = rwby-season-1-episode-N
# V2 = rwby-season-2-rwby-volume-2-chapter-N
# V3 = varies
# V4 = rwby-volume-4-volume-4-chapter-N-HASH + E7 is different
# V5 = varies
# V6+ = rwby-volume-V-N
