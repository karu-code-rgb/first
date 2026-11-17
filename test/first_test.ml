let check operation left right expected =
  let actual = First.calculate operation left right in
  assert (abs_float (actual -. expected) < 0.000001)

let () =
  check "add" 12. 3. 15.;
  check "sub" 12. 3. 9.;
  check "mul" 12. 3. 36.;
  check "div" 12. 3. 4.;
  (try
     ignore (First.calculate "div" 1. 0.);
     failwith "division by zero should fail"
   with Invalid_argument _ -> ());
  (try
     ignore (First.calculate "mod" 5. 2.);
     failwith "unknown operations should fail"
   with Invalid_argument _ -> ())
