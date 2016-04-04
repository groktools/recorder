command -v cnee >/dev/null 2>&1 || { echo >&2 "cnee not found.  Aborting."; exit 1; }
ctxt=$1
ofile=${ctxt// /_}
cnee --record  --mouse --keyboard -o ./$ofile.xns
