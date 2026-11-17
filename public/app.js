const $ = (id) => document.getElementById(id);
const weatherInfo = (code) => {
  if (code === 0) return ["Clear sky", "☀️"];
  if (code === 1) return ["Mainly clear", "🌤️"];
  if (code === 2) return ["Partly cloudy", "⛅"];
  if (code === 3) return ["Overcast", "☁️"];
  if ([45, 48].includes(code)) return ["Foggy", "🌫️"];
  if ([51, 53, 55, 56, 57].includes(code)) return ["Drizzle", "🌦️"];
  if ([61, 63, 65, 66, 67, 80, 81, 82].includes(code)) return ["Rain", "🌧️"];
  if ([71, 73, 75, 77, 85, 86].includes(code)) return ["Snow", "❄️"];
  if ([95, 96, 99].includes(code)) return ["Thunderstorm", "⛈️"];
  return ["Changeable", "🌡️"];
};
const timeOnly = (value) => value ? value.slice(11, 16) : "--:--";
const dayName = (date, index) => index === 0 ? "Today" :
  new Date(date + "T12:00:00").toLocaleDateString(undefined, { weekday: "short" });

async function loadWeather(city) {
  $("message").classList.remove("error");
  $("message").textContent = "Checking the sky over " + city + "…";
  $("dashboard").style.opacity = ".45";
  try {
    const response = await fetch("/api/weather?city=" + encodeURIComponent(city));
    const result = await response.json();
    if (!response.ok) throw new Error(result.error || "Weather could not be loaded.");
    const { location, weather } = result;
    const current = weather.current, daily = weather.daily;
    const [condition, icon] = weatherInfo(current.weather_code);
    $("place-name").textContent = location.name + (location.country ? ", " + location.country : "");
    $("local-time").textContent = "Local time · " + new Date().toLocaleTimeString([], { hour: "2-digit", minute: "2-digit" });
    $("temperature").textContent = Math.round(current.temperature_2m);
    $("feels-like").textContent = Math.round(current.apparent_temperature);
    $("weather-icon").textContent = icon;
    $("condition-label").textContent = condition;
    $("precipitation").textContent = current.precipitation + " mm";
    $("humidity").textContent = current.relative_humidity_2m + "%";
    $("wind").textContent = Math.round(current.wind_speed_10m) + " km/h";
    $("sunrise").textContent = timeOnly(daily.sunrise?.[0]);
    $("sunset").textContent = timeOnly(daily.sunset?.[0]);
    const tips = {
      0: "Clear skies ahead. It could be a lovely day to get outside.",
      1: "Mostly sunny with a few clouds drifting by. Enjoy the light.",
      2: "A mix of sun and clouds. A light layer might be just right.",
      3: "Cloud cover is in charge today. Keep an eye on the sky."
    };
    $("weather-tip").textContent = tips[current.weather_code] ||
      (current.precipitation > 0 ? "Rain is around. An umbrella could come in handy." : "Take a moment to enjoy the weather, wherever you are.");
    $("forecast").innerHTML = daily.time.map((date, index) => {
      const [label, symbol] = weatherInfo(daily.weather_code[index]);
      return `<div class="forecast-day"><div class="day">${dayName(date, index)}</div><div class="icon" title="${label}">${symbol}</div><div class="range">${Math.round(daily.temperature_2m_max[index])}° <span class="low">${Math.round(daily.temperature_2m_min[index])}°</span></div></div>`;
    }).join("");
    $("message").textContent = "Updated just now · Forecast for " + location.name;
    $("dashboard").style.opacity = "1";
  } catch (error) {
    $("message").textContent = error.message;
    $("message").classList.add("error");
    $("dashboard").style.opacity = "1";
  }
}
$("search-form").addEventListener("submit", (event) => {
  event.preventDefault();
  const city = $("city-input").value.trim();
  if (city) loadWeather(city);
});
loadWeather("Lahore");
