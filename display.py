import sys
import struct, wave

def main():
    if len(sys.argv) >= 2:
        fname = sys.argv[1]
    else:
        fname = 'out.wav'
    with wave.open(fname, 'rb') as f:
        nframes = f.getnframes()
        print("%d frames" % nframes)
        bs = f.readframes(nframes)
        l = struct.unpack('<' + 'h' * nframes, bs)
        factor = 2 ** 15
        vs = ["%.04f" % (v / factor) for v in l]
        print(', '.join(vs))

if __name__ == '__main__':
    main()
