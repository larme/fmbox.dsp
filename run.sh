FNAME=${1:-test}
faust2sndfile "$FNAME.dsp" && "./$FNAME" data.wav out.wav && python3 display.py
