let usage () =
  prerr_endline "Usage: first <add|sub|mul|div> <number> <number>";
  prerr_endline "Example: first add 12 3";
  exit 1

let () =
  if Array.length Sys.argv <> 4 then usage ();
  let operation = Sys.argv.(1) in
  try
    let left = float_of_string Sys.argv.(2) in
    let right = float_of_string Sys.argv.(3) in
    let result = First.calculate operation left right in
    print_endline (string_of_float result)
  with
  | Failure message ->
      prerr_endline ("Invalid number: " ^ message);
      exit 1
  | Invalid_argument message ->
      prerr_endline ("Error: " ^ message);
      exit 1
