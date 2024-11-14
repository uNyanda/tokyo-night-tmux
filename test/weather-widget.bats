#!/usr/bin/env bats

# Test setup
setup() {
  export WEATHER_API_KEY="your_api_key_here"
  export WEATHER_LOCATION="Pinetown"
  mkdir -p ~/.cache/weather-widget
}

teardown() {
  rm -f ~/.cache/weather-widget/weather-cache.json
}

@test "Test if weather icon is displayed" {
  run ~/Projects/tokyo-night-tmux/src/weather-widget.sh
  [[ "$output" =~ .*.* ]]  # Check for the icon with flexible matching
}

@test "Test cached weather data" {
  run cat ~/.cache/weather-widget/weather-cache.json
  [[ "$output" =~ "description" ]]
  [[ "$output" =~ "\"WeatherIcon\":7" ]]
}

@test "Test weather API call" {
  run ~/Projects/tokyo-night-tmux/src/weather-widget.sh
  [[ -f ~/.cache/weather-widget/weather-cache.json ]]
}

@test "Test API error handling" {
  export WEATHER_API_KEY="invalid_api_key"
  run ~/Projects/tokyo-night-tmux/src/weather-widget.sh
  [[ $status -eq 1 ]]
}
