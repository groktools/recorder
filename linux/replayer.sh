command -v cnee >/dev/null 2>&1 || { echo >&2 "cnee not found.  Aborting."; exit 1; }
ofile=$1
cnee --replay -f $ofile.xns
