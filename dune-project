(lang dune 3.12)
(name first)
(generate_opam_files true)

(package
 (name first)
 (synopsis "An OCaml project")
 (description "A starter OCaml project built with Dune.")
 (depends
  (ocaml (>= 4.14))
  (dune (>= 3.12))))
