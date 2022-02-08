#!/bin/sh -e

set -o pipefail

. /c/temp/kaitai_struct/tests/config

# note: Git Bash must be run as Administrator!
export MSYS=winsymlinks:nativestrict

odir='/r/Temp/bin'
ldir='/c/temp/kaitai_struct/tests/src'; { if [ ! -L "$ldir" ] && [ -d "$ldir" ]; then  rm -vrf "$ldir"; fi; } && ln -sfn "$odir" "$ldir"
ls -l "$ldir"

odir='/r/Temp/compiled'
mkdir -p "$odir"
ldir='/c/temp/kaitai_struct/tests/compiled'; { if [ ! -L "$ldir" ] && [ -d "$ldir" ]; then  rm -vrf "$ldir"; fi; } && ln -sfn "$odir" "$ldir"
ls -l "$ldir"

odir='/r/Temp/spec/javascript'
mkdir -p "$odir"
ldir='/c/temp/kaitai_struct/tests/spec/javascript'; { if [ ! -L "$ldir" ] && [ -d "$ldir" ]; then  rm -vrf "$ldir"; fi; } && ln -sfn "$odir" "$ldir"
ls -l "$ldir"

cd '/c/temp/kaitai_struct/tests'

# odir="$JAVASCRIPT_RUNTIME_DIR"
ldir="$JAVASCRIPT_MODULES_DIR/kaitai-struct"; { if [ -L "$ldir" ]; then rm -v "$ldir"; elif [ -d "$ldir" ]; then  rm -vrf "$ldir"; fi; }

for bit_endian in be le; do
    odir=/r/Temp/kst/"$bit_endian"
    ldir='/c/temp/kaitai_struct/tests/spec/ks'; { if [ ! -L "$ldir" ] && [ -d "$ldir" ]; then  rm -vrf "$ldir"; fi; } && ln -sfn "$odir" "$ldir"
    ls -l "$ldir"

    odir=/r/Temp/ksy/"$bit_endian"
    ldir='/c/temp/kaitai_struct/tests/formats'; { if [ ! -L "$ldir" ] && [ -d "$ldir" ]; then  rm -vrf "$ldir"; fi; } && ln -sfn "$odir" "$ldir"
    ls -l "$ldir"

    echo 'kaitai-struct-compiler:'
    time find "$odir" -name '*.ksy' -type f -print0 | xargs -r0 \
        "$COMPILER_DIR/jvm/target/universal/stage/bin/kaitai-struct-compiler" -- \
        -t javascript -d "$FORMATS_COMPILED_DIR/javascript"

    if ! find "$FORMATS_COMPILED_DIR/javascript" -maxdepth 1 -name '*.js' -print -quit; then
        echo 'Error: no JS file compiled, exiting'
        exit 1
    fi

    echo './spec_kst_to_all:'
    time ./spec_kst_to_all -t javascript -f --all-specs

    ./ci-javascript
    odir='/r/Temp/test_out/javascript/'
    mkdir -p "$odir"
    mv test_out/javascript/ci.json "$odir/$bit_endian.json"
done
