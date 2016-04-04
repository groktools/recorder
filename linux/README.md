# Record/Replay on linux

These scripts allow easy record and replay of user sessions on linux.

## Pre-requsites
These scripts require [GNU Xnee](http://www.gnu.org/software/xnee/) to work. Here are the install instructions:

1. Download XNee
2. Build and install it

    ./configure --enable-gui=no # might have to install some X libs, disabling gui ensures no gtk issues in make step.
    ./make   # if you get a gtk issue, use the option above and remake
    ./make install

# Install
Add shell scripts in this folder to your path.

# usage

* To record, run `recorder.sh "context"`, where context is a string that explains the context for the recording. The script will use it to name the log file.
* To replay, run `replay.sh logfile`, where logfile is the name of the log from the record step.
