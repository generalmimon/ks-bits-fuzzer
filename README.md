# Kaitai Struct bits int fuzzer

See https://github.com/kaitai-io/kaitai_struct/issues/949

A simple fuzzing system intended to rigorously test methods for reading bit-sized integers in all runtime libraries that [Kaitai Struct](https://kaitai.io/) supports, namely:

<details>
  <summary>List of <code>read_bits_int_{be,le}</code> implementations in all runtime libraries</summary>

* [C++/STL](https://github.com/kaitai-io/kaitai_struct_cpp_stl_runtime) - `cpp_stl_98` , `cpp_stl_11`
  - [<code>read_bits_int_**be**</code>](https://github.com/kaitai-io/kaitai_struct_cpp_stl_runtime/blob/master/kaitai/kaitaistream.cpp#:~:text=%3A%3Aread_bits_int_be)
  - [<code>read_bits_int_**le**</code>](https://github.com/kaitai-io/kaitai_struct_cpp_stl_runtime/blob/master/kaitai/kaitaistream.cpp#:~:text=%3A%3Aread_bits_int_le)

* [C#](https://github.com/kaitai-io/kaitai_struct_csharp_runtime) - `csharp`
  - [<code>ReadBitsInt**Be**</code>](https://github.com/kaitai-io/kaitai_struct_csharp_runtime/blob/master/KaitaiStream.cs#:~:text=ulong%20ReadBitsIntBe)
  - [<code>ReadBitsInt**Le**</code>](https://github.com/kaitai-io/kaitai_struct_csharp_runtime/blob/master/KaitaiStream.cs#:~:text=ulong%20ReadBitsIntLe)

* [Go](https://github.com/kaitai-io/kaitai_struct_go_runtime) - `go`
  - [<code>ReadBitsInt**Be**</code>](https://github.com/kaitai-io/kaitai_struct_go_runtime/blob/master/kaitai/stream.go#:~:text=%20ReadBitsIntBe%28n%20)
  - [<code>ReadBitsInt**Le**</code>](https://github.com/kaitai-io/kaitai_struct_go_runtime/blob/master/kaitai/stream.go#:~:text=%20ReadBitsIntLe%28n%20)

* [Java](https://github.com/kaitai-io/kaitai_struct_java_runtime) - `java`
  - [<code>readBitsInt**Be**</code>](https://github.com/kaitai-io/kaitai_struct_java_runtime/blob/master/src/main/java/io/kaitai/struct/KaitaiStream.java#:~:text=long%20readBitsIntBe)
  - [<code>readBitsInt**Le**</code>](https://github.com/kaitai-io/kaitai_struct_java_runtime/blob/master/src/main/java/io/kaitai/struct/KaitaiStream.java#:~:text=long%20readBitsIntLe)

* [JavaScript](https://github.com/kaitai-io/kaitai_struct_javascript_runtime) - `javascript`
  - [<code>readBitsInt**Be**</code>](https://github.com/kaitai-io/kaitai_struct_javascript_runtime/blob/master/KaitaiStream.js#:~:text=readBitsIntBe%20%3D%20function)
  - [<code>readBitsInt**Le**</code>](https://github.com/kaitai-io/kaitai_struct_javascript_runtime/blob/master/KaitaiStream.js#:~:text=readBitsIntLe%20%3D%20function)

* [Lua](https://github.com/kaitai-io/kaitai_struct_lua_runtime) - `lua`
  - [<code>read_bits_int_**be**</code>](https://github.com/kaitai-io/kaitai_struct_lua_runtime/blob/master/kaitaistruct.lua#:~:text=function%20KaitaiStream%3Aread_bits_int_be)
  - [<code>read_bits_int_**le**</code>](https://github.com/kaitai-io/kaitai_struct_lua_runtime/blob/master/kaitaistruct.lua#:~:text=function%20KaitaiStream%3Aread_bits_int_le)

* [Nim](https://github.com/kaitai-io/kaitai_struct_nim_runtime) - `nim`
  - [<code>readBitsInt**Be**</code>](https://github.com/kaitai-io/kaitai_struct_nim_runtime/blob/master/kaitai_struct_nim_runtime.nim#:~:text=proc%20readBitsIntBe)
  - [<code>readBitsInt**Le**</code>](https://github.com/kaitai-io/kaitai_struct_nim_runtime/blob/master/kaitai_struct_nim_runtime.nim#:~:text=proc%20readBitsIntLe)

* [Perl](https://github.com/kaitai-io/kaitai_struct_perl_runtime) - `perl`
  - [<code>read_bits_int_**be**</code>](https://github.com/kaitai-io/kaitai_struct_perl_runtime/blob/master/lib/IO/KaitaiStruct.pm#:~:text=sub%20read_bits_int_be)
  - [<code>read_bits_int_**le**</code>](https://github.com/kaitai-io/kaitai_struct_perl_runtime/blob/master/lib/IO/KaitaiStruct.pm#:~:text=sub%20read_bits_int_le)

* [PHP](https://github.com/kaitai-io/kaitai_struct_php_runtime) - `php`
  - [<code>readBitsInt**Be**</code>](https://github.com/kaitai-io/kaitai_struct_php_runtime/blob/master/lib/Kaitai/Struct/Stream.php#:~:text=function%20readBitsIntBe)
  - [<code>readBitsInt**Le**</code>](https://github.com/kaitai-io/kaitai_struct_php_runtime/blob/master/lib/Kaitai/Struct/Stream.php#:~:text=function%20readBitsIntLe)

* [Python](https://github.com/kaitai-io/kaitai_struct_python_runtime) - `python`
  - [<code>read_bits_int_**be**</code>](https://github.com/kaitai-io/kaitai_struct_python_runtime/blob/master/kaitaistruct.py#:~:text=def%20read_bits_int_be)
  - [<code>read_bits_int_**le**</code>](https://github.com/kaitai-io/kaitai_struct_python_runtime/blob/master/kaitaistruct.py#:~:text=def%20read_bits_int_le)

* [Ruby](https://github.com/kaitai-io/kaitai_struct_ruby_runtime) - `ruby`
  - [<code>read_bits_int_**be**</code>](https://github.com/kaitai-io/kaitai_struct_ruby_runtime/blob/master/lib/kaitai/struct/struct.rb#:~:text=def%20read_bits_int_be)
  - [<code>read_bits_int_**le**</code>](https://github.com/kaitai-io/kaitai_struct_ruby_runtime/blob/master/lib/kaitai/struct/struct.rb#:~:text=def%20read_bits_int_le)
</details>

## Project structure

* `gen.ipynb` ([Jupyter](https://jupyter.org/) Notebook) - [1. Generating tests](#1-generating-tests-genipynb)
* `test.sh` - run generated tests in the specified language (Bash script) - [2. Running tests](#2-running-tests-testsh)

## How it works

### 1. Generating tests (`gen.ipynb`)

#### Bit layouts

Configuration:

| Name | Description | Recommended value |
| --- | --- | --- |
| `MAX_BITS` | <p>Maximum number of bits for a single bit integer (i.e. max value of the argument to the `read_bits_int{be,le}` method).</p> | `64` for most languages, `32` for JavaScript |
| `TOTAL_BITS` | <p>Total size in bits of the entire layout. **Must** be divisible by 8 (i.e. 8, 16, 24, 32, 40, etc.)</p> | `MAX_BITS + 8` (works well with `FIELDS = 3`) |
| `FIELDS` | Number of fields in the layout. | `3` |

Function `get_bit_layouts` will enumerate all bit layouts matching the parameters above. However, there will usually be too many of these, much more than is needed to reliably reveal bugs in the bits int reading functions.

If we make an assumption that all spontaneous errors in the implementations only affect readings of ints with bit width close to the limit (mainly `MAX_BITS`, less often `MAX_BITS - 1`), we can substantially reduce the number of bit layouts by allowing only those that contain fields with potentially problematic sizes:

```py
bit_layouts_all = get_bit_layouts(FIELDS, MAX_BITS, TOTAL_BITS)
bit_layouts = list(filter(lambda bl: (MAX_BITS in bl) or (MAX_BITS - 1 in bl), bit_layouts_all))
```

Using the recommended configuration, this will select **57 layouts** from a total of 2593. These 57 layouts will generate 2688 tests[^1]. If this is too much, exclude layouts only containing the `MAX_BITS - 1` field:

```py
bit_layouts = list(filter(lambda bl: (MAX_BITS in bl), bit_layouts_all))
```

2688 tests (for both `MAX_BITS` and `MAX_BITS - 1` fields) doesn't sound like much, but in compiled languages they

1. require more than 1 GiB of storage (in C++/STL every test is compiled to a ~0.6 MiB ".o" object file, so 2688 object files alone need 1.6 GiB),
2. take tens of minutes to compile - you'll notice if you wait 40 minutes (for 2688 tests) or 20 minutes (for 1248 tests) per endianness.

Excluding the `MAX_BITS - 1` field reduces the number to 1248 tests (27 layouts), which keep these problematic factors within reasonable limits: building tests takes 18 minutes for a single bit endianness (double for both endians); object files are 730 MiB and the resulting executable `ks_tests` takes 166 MiB, so it fits into 1 GiB nicely.

However, it is important to eventually test bit layouts with the `MAX_BITS - 1` field as well, because they can also detect bugs (especially in languages where signed bit shifts are used).

#### Fill patterns

A bit layout only says how to split `TOTAL_BITS` into several summands (number of summands is `FIELDS`); now we have to fill the fields with actual values. Some bugs may only occur when using a certain combination of fillings. Since it is not obvious what combinations will trigger bugs, all combinations of predefined **fill patterns** are generated. Default fillings look like this:

```py
{0: [''],
 1: ['0', '1'],
 2: ['00', '01', '10', '11'],
 3: ['000', '011', '100', '111'],
 4: ['0000', '0111', '1000', '1111'],
 5: ['00000', '01111', '10000', '11111'],
 6: ['000000', '011111', '100000', '111111'],
 # ...
}
```

For illustration, there are 16 (= 4 * 4) filling combinations for the bit layout `(5, 3)`:

<details>
  <summary>Filling combinations for layout <code>(5, 3)</code></summary>

```py
[((0, '00000'), (0, '000')),
 ((0, '00000'), (1, '011')),
 ((0, '00000'), (2, '100')),
 ((0, '00000'), (3, '111')),

 ((1, '01111'), (0, '000')),
 ((1, '01111'), (1, '011')),
 ((1, '01111'), (2, '100')),
 ((1, '01111'), (3, '111')),

 ((2, '10000'), (0, '000')),
 ((2, '10000'), (1, '011')),
 ((2, '10000'), (2, '100')),
 ((2, '10000'), (3, '111')),

 ((3, '11111'), (0, '000')),
 ((3, '11111'), (1, '011')),
 ((3, '11111'), (2, '100')),
 ((3, '11111'), (3, '111'))]
```

</details>

#### Test generation

Please configure the **target directory**:

```py
target_dir = Path("""R:\Temp""")
```

`R:\Temp` is just what works for me when using [ImDisk Toolkit](https://sourceforge.net/projects/imdisk-toolkit/) on Windows to create a 1 GiB ramdisk. You can set it to any existing directory.

The generated directory structure will look like this:

```
{target_dir}/
 ├── ksy/
 │   ├── be/
 │   |   ├── b0b8b64.ksy
 │   |   ├── b0b64b8.ksy
 │   |   ├── b1b7b64.ksy
 │   |   ├── ⋮
 │   |   └── b64b8b0.ksy
 │   └── le/
 │       ├── b0b8b64.ksy
 │       ├── ⋮
 │       └── b64b8b0.ksy
 ├── kst/
 │   ├── be/
 │   │   ├── b0b8b64_v0x0x0.kst
 │   │   ├── b0b8b64_v0x0x1.kst
 │   │   ├── ⋮
 │   │   ├── b0b8b64_v0x3x3.kst
 │   │
 │   │   ├── b0b64b8_v0x0x0.kst
 │   │   ├── ⋮
 │   │   ├── b0b64b8_v0x3x3.kst
 │   │
 │   │   ├── b1b7b64_v0x0x0.kst
 │   │   ├── ⋮
 │   │   ├── b1b7b64_v1x3x3.kst
 │   │
 │   │   ├── ⋮
 │   │   └── b64b8b0_v3x3x0.kst
 │   └── le/
 │       ├── b0b8b64_v0x0x0.kst
 │       ├── ⋮
 │       └── b64b8b0_v3x3x0.kst
 └── src/
     ├── 00_00_00_00_00_00_00_00_00.bin
     ├── 00_00_00_00_00_00_00_00_01.bin
     ├── 00_00_00_00_00_00_00_00_0f.bin
     ├── ⋮
     ├── ff_ff_ff_ff_ff_ff_ff_ff_fe.bin
     └── ff_ff_ff_ff_ff_ff_ff_ff_ff.bin
```

Directory `ksy/` contains .ksy specifications of bit layouts (there are subfolders `be/` and `le/` for each [`meta/bit-endian`](https://doc.kaitai.io/user_guide.html#bit-endian) value). For example, here are the contents of `ksy/le/b0b8b64.ksy`:

```ksy
meta:
  id: b0b8b64
  bit-endian: le
seq:
  - id: a
    type: b0
  - id: b
    type: b8
  - id: c
    type: b64
```

Directory `kst/` is intended for [KST](https://doc.kaitai.io/kst.html) test specs that [KST translator](https://doc.kaitai.io/kst.html#_invoking_kst_translator) translates into unit test modules for a particular target language. A typical .kst spec looks like this (`kst/be/b1b7b64_v1x2x1.kst`):

```yml
id: b1b7b64
data: c0_7f_ff_ff_ff_ff_ff_ff_ff.bin
asserts:
  - actual: a
    expected: true
  - actual: b
    expected: 0x40
  - actual: c
    expected: 0x7fff_ffff_ffff_ffff
```

The `data` key specifies what binary file from the **`src/` directory** to use. Names of `src/` files exactly reflect their contents[^2].

### 2. Running tests (`test.sh`)

First, configure the base directories (see the top of [`test.sh`](./test.sh)):

```bash
o_base=/r/Temp
l_base=/c/temp/kaitai_struct/tests
```

* `o_base` is the output base directory, it **must** be in sync with what you set in `fuzz.ipynb` (section [Test generation](#test-generation)).
* `l_base` is the location of the `tests` directory in the full https://github.com/kaitai-io/kaitai_struct repository checkout. In the `tests` repository, the [branch `generalmimon:ks-bits-fuzzer`](https://github.com/generalmimon/kaitai_struct_tests/tree/ks-bits-fuzzer) **must be checked out**.

Usage:

```bash
./test.sh <language>
```

Valid `<language>` identifiers are listed at the [top of this README](#kaitai-struct-bits-int-fuzzer) - expand the "list of runtime libraries" section.

The `test.sh` script compiles and runs tests generated previously by `gen.ipynb` in the specified language. This is done for each [bit endianness](https://doc.kaitai.io/user_guide.html#bit-endian) individually. It happens in these steps:

0. Set up directory symlinks in `l_base` directory ([`kaitai_struct_tests`](https://github.com/kaitai-io/kaitai_struct_tests) repo) pointing to subdirectories of `o_base`.[^3]

   For target languages where testing depends on project configuration files or bootstrap files: if `$l_base/spec/<language>` is a regular directory (not a symlink), recursively copy any files other than test specs from here to `$o_base/spec/<language>` before replacing the directory with a symlink.

1. Use `kaitai-struct-compiler` to translate `.ksy` files to parsing modules into the `$o_base/compiled/<language>/` directory.
2. Use KST translator to translate `.kst` specs (`$o_base/kst/{be,le}/*.kst`) to unit test modules, stored in `$o_base/spec/<language>/`.
3. Launch the `./ci-<language>` script, which takes the source code of generated parsers, unit tests and the runtime library and finally builds (if source code needs to be compiled in the particular language) and runs the tests.

The auxiliary project files mentioned in step 0 sometimes require manual intervention. On the first run, everything should work, provided that the [branch `generalmimon:ks-bits-fuzzer`](https://github.com/generalmimon/kaitai_struct_tests/tree/ks-bits-fuzzer) is checked out in the `$l_base/tests` repository. However, if you have already run the tests and then deleted the directory with test specs, the project files are deleted too. At this point, if you want to run the tests again, you **have to** go to `/tests` directory and discard changes to `spec/<language>` folder using Git so that the project files are restored and can be used again.

[^1]: BTW, this can be easily calculated. In these 57 layouts, 12 layouts have a 1-bit field (2 possible fillings: `'0'` and `'1'`) and 12 layouts contain a 0-bit field (only 1 possible filling: `''`) :

      ```py
      >>> (57 - 12 - 12) * (4**3) + 12 * (2 * 4**2) + 12 * (1 * 4**2)
      2688
      ```

[^2]: If `KaitaiStream` objects were directly created from byte arrays, the entire `src/` folder could be eliminated (and the possible inefficiency of having to open and read from actual files too), but KST translator currently only supports stream instantiation from a file. It _could_ be modified to support instantiation from literal byte arrays, but I decided to take the path of least resistance and reuse the existing infrastructure as much as possible with minimal modifications.

      In some languages, I encountered "too many open files" errors when exceeding a certain number of tests, but these can and should be fixed by ensuring that files are closed as soon as they're no longer needed (this has been already done for Lua: https://github.com/generalmimon/kaitai_struct_tests/commit/eb49372d96c449328da730a0c130b7f06340beb4). Other than that, not even a hundred thousand files (required by ~125k tests) were a problem on a ramdisk.

[^3]: This is to allow having the output `o_base` directory on a ramdisk, while the main `kaitai_struct_tests` repository is on a persistent hard drive. Symlinks satisfy almost all test scripts and project files that rely on hardcoded paths and avoid most trouble related to changing the paths, having to refactor them to variables/arguments, etc.
