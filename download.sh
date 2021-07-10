#!/bin/sh

# create a temporary working directory to not disturb the 
# rest of the music folder that might already be sorted
mkdir -p scriptWorking && cd scriptWorking

# Download the specified song / album with spotdl in m4a format by default
spotdl -of m4a $1

# because spotdl doesn't remove it for some reason
rm Temp .cache -r

# create the artist directories if they don't already exist
# main logic working for every song file
for i in $PWD/*; do

  # create a directory with the artist name

  # This changes the name from "Artist - song" to "Artist%song" for easier use
  # by the other commands
  FIXEDNAME=`echo $i | sed -e 's/.*\///' -e 's/ - /%/'`


  DIRNAME=`echo $FIXEDNAME | cut -d '%' -f1`
  SONGNAME=`echo $FIXEDNAME | cut -d '%' -f2`


  # this creates a folder with the artist name OUTSIDE of the working folder
  mkdir -p "../$DIRNAME"

  ## move the file to the directory
  mv "$DIRNAME - $SONGNAME" "../$DIRNAME/$SONGNAME"

done

# and afterwards, the temporary working directories get deleted
# You can potentially also change the -r to a -d so that only an empty directory
# get's deleted
cd ../ && rm scriptWorking -r
