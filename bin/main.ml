open Lwt.Infix

let member name json = Yojson.Basic.Util.member name json
let as_string = function `String value -> value | _ -> ""
let as_float = function `Float value -> value | `Int value -> float_of_int value | _ -> 0.0
let as_int = function `Int value -> value | `Float value -> int_of_float value | _ -> 0

let fetch_json uri =
  Cohttp_lwt_unix.Client.get uri >>= fun (response, body) ->
  Cohttp_lwt.Body.to_string body >|= fun body ->
  let status = Cohttp.Response.status response |> Cohttp.Code.code_of_status in
  if status < 200 || status >= 300 then
    failwith ("Weather service returned HTTP " ^ string_of_int status);
  Yojson.Basic.from_string body

let add_params uri params = List.fold_left Uri.add_query_param' uri params

let get_weather city =
  let geocoding_uri =
    add_params (Uri.of_string "https://geocoding-api.open-meteo.com/v1/search")
      [ ("name", city); ("count", "1"); ("language", "en"); ("format", "json") ]
  in
  fetch_json geocoding_uri >>= fun geocoding ->
  let places = match member "results" geocoding with `List places -> places | _ -> [] in
  match places with
  | [] -> Lwt.fail_with ("I couldn't find a city called " ^ city ^ ".")
  | place :: _ ->
      let name = as_string (member "name" place) in
      let country = as_string (member "country" place) in
      let latitude = as_float (member "latitude" place) in
      let longitude = as_float (member "longitude" place) in
      let forecast_uri =
        add_params (Uri.of_string "https://api.open-meteo.com/v1/forecast")
          [
            ("latitude", string_of_float latitude);
            ("longitude", string_of_float longitude);
            ("current", "temperature_2m,relative_humidity_2m,apparent_temperature,is_day,precipitation,weather_code,wind_speed_10m");
            ("daily", "weather_code,temperature_2m_max,temperature_2m_min,sunrise,sunset,precipitation_probability_max");
            ("timezone", "auto"); ("forecast_days", "7");
          ]
      in
      fetch_json forecast_uri >|= fun forecast ->
      let code = as_int (member "weather_code" (member "current" forecast)) in
      `Assoc [
        ("location", `Assoc [
          ("name", `String name); ("country", `String country);
          ("latitude", `Float latitude); ("longitude", `Float longitude)
        ]);
        ("condition", `String (Weather.description code));
        ("icon", `String (Weather.icon code));
        ("weather", forecast)
      ]

let read_file path = Lwt_io.with_file ~mode:Lwt_io.Input path Lwt_io.read

let static_file path content_type _request =
  read_file path >|= fun contents ->
  Dream.respond ~headers:[ ("content-type", content_type) ] contents

let weather_handler request =
  let city = match Dream.query request "city" with
    | Some city when String.trim city <> "" -> String.trim city
    | _ -> "Lahore"
  in
  Lwt.catch
    (fun () -> get_weather city >|= fun data -> Dream.json (Yojson.Basic.to_string data))
    (fun error ->
      let message = Printexc.to_string error in
      Dream.json ~status:`Bad_Request
        (Yojson.Basic.to_string (`Assoc [ ("error", `String message) ])))

let () =
  print_endline "Weather dashboard running at http://localhost:8080";
  Dream.run ~port:8080
    (Dream.logger (Dream.router [
      Dream.get "/" (static_file "public/index.html" "text/html; charset=utf-8");
      Dream.get "/styles.css" (static_file "public/styles.css" "text/css; charset=utf-8");
      Dream.get "/app.js" (static_file "public/app.js" "text/javascript; charset=utf-8");
      Dream.get "/api/weather" weather_handler
    ]))
