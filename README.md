# first

A tiny command-line calculator written in OCaml and built with Dune.

## Requirements

- OCaml 4.14 or newer
- Dune 3.12 or newer
- opam

## Setup

```sh
opam switch create . 5.3.0
eval "$(opam env)"
opam install . --deps-only --with-test
```

## Build and test

```sh
dune build @all
dune runtest
```

## Use the calculator

The CLI supports addition, subtraction, multiplication, and division:

```sh
dune exec first -- add 12 3  # 15.
dune exec first -- sub 12 3  # 9.
dune exec first -- mul 12 3  # 36.
dune exec first -- div 12 3  # 4.
```

The command format is `first <add|sub|mul|div> <number> <number>`.
Invalid operations, invalid numbers, and division by zero produce an error message.
