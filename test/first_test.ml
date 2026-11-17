let () =
  assert (Weather.description 0 = "Clear sky");
  assert (Weather.description 61 = "Rain");
  assert (Weather.description 95 = "Thunderstorm");
  assert (Weather.icon 0 = "☀️");
  assert (Weather.icon 71 = "❄️");
  assert (Weather.description 999 = "Unknown conditions")