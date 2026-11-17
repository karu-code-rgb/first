# first

A small OCaml project built with [Dune](https://dune.build/).

## Requirements

- OCaml 4.14 or newer
- Dune 3.12 or newer
- opam (recommended for managing the OCaml toolchain)

## Getting started

Create or select an opam switch, then install the project dependencies:

```sh
opam switch create . 5.3.0 --deps-only
 eval "$(opam env)"
opam install . --deps-only --with-test
```

Build the project and run its tests:

```sh
dune build @all
dune runtest
```

Run the example executable:

```sh
dune exec first
```

The reusable `First` module lives in `lib/`, the executable entry point is in `bin/`, and tests are in `test/`.
