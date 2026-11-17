let description code =
  match code with
  | 0 -> "Clear sky"
  | 1 -> "Mainly clear"
  | 2 -> "Partly cloudy"
  | 3 -> "Overcast"
  | 45 | 48 -> "Foggy"
  | 51 | 53 | 55 -> "Drizzle"
  | 56 | 57 -> "Freezing drizzle"
  | 61 | 63 | 65 -> "Rain"
  | 66 | 67 -> "Freezing rain"
  | 71 | 73 | 75 | 77 -> "Snow"
  | 80 | 81 | 82 -> "Rain showers"
  | 85 | 86 -> "Snow showers"
  | 95 | 96 | 99 -> "Thunderstorm"
  | _ -> "Unknown conditions"

let icon code =
  match code with
  | 0 -> "☀️"
  | 1 | 2 -> "🌤️"
  | 3 -> "☁️"
  | 45 | 48 -> "🌫️"
  | 51 | 53 | 55 | 56 | 57 -> "🌦️"
  | 61 | 63 | 65 | 66 | 67 | 80 | 81 | 82 -> "🌧️"
  | 71 | 73 | 75 | 77 | 85 | 86 -> "❄️"
  | 95 | 96 | 99 -> "⛈️"
  | _ -> "🌡️"
