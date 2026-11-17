(lang dune 3.12)
(name first)
(generate_opam_files true)

(package
 (name first)
 (synopsis "An animated OCaml weather dashboard")
 (description "A beginner-friendly weather dashboard powered by Open-Meteo.")
 (depends
  (ocaml (>= 4.14))
  (dune (>= 3.12))
  dream
  cohttp-lwt-unix
  yojson
  uri))