# Atmos — OCaml Weather Dashboard

A beginner-friendly weather dashboard with a polished animated interface, built with an OCaml web server and the free [Open-Meteo API](https://open-meteo.com/).

## Features

- Search for cities around the world
- Current temperature, feels-like temperature, humidity, wind and precipitation
- Sunrise and sunset times
- Seven-day forecast
- Animated glass-style interface that adapts to mobile screens
- No API key required

## Requirements

- OCaml 5.x (OCaml 4.14+ should also work)
- opam
- Dune 3.12+

## Install

Clone this branch:

```sh
git clone -b feat/ocaml-weather-dashboard https://github.com/karu-code-rgb/first.git
cd first
```

Create a local opam switch and install dependencies:

```sh
opam switch create . 5.3.0
eval "$(opam env)"
opam install . --deps-only
```

## Run

Start the dashboard:

```sh
dune exec first
```

Open **http://localhost:8080** in your browser. Search for a city such as Lahore, London, Tokyo, or New York.

Stop the server with `Ctrl+C`.

## Test and build

```sh
dune build @all
dune runtest
```

## How it works

- `bin/main.ml` runs a small Dream web server and fetches weather data from Open-Meteo.
- `lib/weather.ml` translates weather condition codes into readable labels and icons.
- `public/` contains the HTML, CSS animations, and browser-side JavaScript.
- `test/` contains simple tests for weather descriptions.

Weather data is provided by [Open-Meteo](https://open-meteo.com/). No API key is needed.