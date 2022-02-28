#!/usr/bin/env bash

set -e
set -o pipefail

o_base=/r/Temp
l_base=/c/temp/kaitai_struct/tests
if uname -r | grep -q WSL; then
    o_base='/mnt'$o_base
    l_base='/mnt'$l_base
fi

lang=$1

case $lang in
javascript )
    lang_compiled_glob='*.js'
    ;;
java )
    lang_compiled_glob='*.java'
    ;;
php )
    lang_compiled_glob='*.php'
    ;;
go )
    lang_compiled_glob='*.go'
    ;;
csharp )
    lang_compiled_glob='*.cs'
    ;;
lua )
    lang_compiled_glob='*.lua'
    ;;
perl )
    lang_compiled_glob='*.pm'
    ;;
python )
    lang_compiled_glob='*.py'
    ;;
ruby )
    lang_compiled_glob='*.rb'
    ;;
nim )
    lang_compiled_glob='*.nim'
    ;;
cpp_stl_98 | cpp_stl_11 )
    lang_compiled_glob='*.cpp'
    ;;
*)
    echo "Error: unrecognized lang '$lang', exiting"
    exit 2
esac

# note: Git Bash must be run as Administrator or the [Developer
# Mode](https://docs.microsoft.com/en-us/windows/apps/get-started/enable-your-device-for-development)
# must be enabled!
export MSYS=winsymlinks:nativestrict

odir=$o_base/src
ldir=$l_base/src; { if [ ! -L "$ldir" ] && [ -d "$ldir" ]; then  rm -vrf "$ldir"; fi; } && ln -sfn "$odir" "$ldir"
ls -l "$ldir"

odir=$o_base/compiled
mkdir -p "$odir"
ldir=$l_base/compiled; { if [ ! -L "$ldir" ] && [ -d "$ldir" ]; then  rm -vrf "$ldir"; fi; } && ln -sfn "$odir" "$ldir"
ls -l "$ldir"

odir=$o_base/spec/$lang
ldir=$l_base/spec/$lang

mkdir -p "$odir"
if [ ! -L "$ldir" ] && [ -d "$ldir" ]; then
    case $lang in
    java )
        spec_glob='./src/io/kaitai/struct/spec/Test*.java'
        ;;
    php )
        spec_glob='./*Test.php'
        ;;
    csharp )
        spec_glob='./kaitai_struct_csharp_tests/tests/Spec*.cs'
        ;;
    lua )
        spec_glob='./test_*.lua'
        ;;
    perl )
        spec_glob='./Test*.t'
        ;;
    nim )
        spec_glob='./t*.nim'
        ;;
    cpp_stl_98 | cpp_stl_11 )
        spec_glob='./test_*.cpp'
        ;;
    esac

    if [ -n "$spec_glob" ]; then
        ( cd "$ldir"; find . -type f ! -path "$spec_glob" -print0 | xargs -r0 cp -r -v --parents -t "$odir" )
    fi

    # { if [ ! -L "$ldir" ] && [ -d "$ldir" ]; then  rm -vrf "$ldir"; fi; }
    rm -vrf "$ldir"
fi
ln -sfn "$odir" "$ldir"
ls -l "$ldir"

cd "$l_base"
. ./config

if [ "$lang" = javascript ]; then
    ldir="$JAVASCRIPT_MODULES_DIR/kaitai-struct"; { if [ -L "$ldir" ]; then rm -v "$ldir"; elif [ -d "$ldir" ]; then  rm -vrf "$ldir"; fi; }
fi

# 'be '
for bit_endian in be le; do
    odir=$o_base/kst/$bit_endian
    ldir=$l_base/spec/ks; { if [ ! -L "$ldir" ] && [ -d "$ldir" ]; then  rm -vrf "$ldir"; fi; } && ln -sfn "$odir" "$ldir"
    ls -l "$ldir"

    odir=$o_base/ksy/$bit_endian
    ldir=$l_base/formats; { if [ ! -L "$ldir" ] && [ -d "$ldir" ]; then  rm -vrf "$ldir"; fi; } && ln -sfn "$odir" "$ldir"
    ls -l "$ldir"

    ksc_lang=$lang
    if [ "$lang" = cpp_stl_98 ] || [ "$lang" = cpp_stl_11 ]; then
        ksc_lang='cpp_stl'
        set -- --cpp-standard 98
    else
        set --
    fi

    echo 'kaitai-struct-compiler:'
    time find "$odir" -name '*.ksy' -type f -print0 | xargs -r0 \
        "$COMPILER_DIR/jvm/target/universal/stage/bin/kaitai-struct-compiler" -- \
        --java-package io.kaitai.struct.testformats \
        --php-namespace 'Kaitai\Struct\Tests' \
        --go-package test_formats \
        -t "$ksc_lang" -d "$FORMATS_COMPILED_DIR/$lang$([ "$lang" = java ] || [ "$lang" = go ] && printf %s '/src')" \
        "$@"

    if ! find "$FORMATS_COMPILED_DIR/$lang" -maxdepth 1 -name "$lang_compiled_glob" -print -quit; then
        echo "Error: no '$lang_compiled_glob' file compiled, exiting"
        exit 1
    fi

    echo './spec_kst_to_all:'
    ./spec_kst_to_all -t "$lang" -f --all-specs

    ./ci-"$lang"
    echo "Exit code: $?"
    odir=$o_base/test_out/$lang
    mkdir -p "$odir"
    mv "test_out/$lang/ci.json" "$odir/$bit_endian.json"
done
