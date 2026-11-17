let calculate operation left right =
  match operation with
  | "add" -> left +. right
  | "sub" -> left -. right
  | "mul" -> left *. right
  | "div" ->
      if right = 0. then invalid_arg "cannot divide by zero";
      left /. right
  | _ -> invalid_arg ("unknown operation: " ^ operation)
