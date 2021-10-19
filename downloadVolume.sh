#!/bin/bash
. ./downloadEpisode.sh
. ./episodes.sh

volume=$1

if [ ! -d "Volume $volume" ]
then
    mkdir "Volume $volume"
fi

cd Volume\ $volume

for episode in {1..16}
do
    downloadEpisode $volume $episode
done
cd ..