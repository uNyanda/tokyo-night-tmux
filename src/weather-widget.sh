#!/bin/env bash

if [ -f .env ]; then
  export $(cat .env | xargs)
fi

API_KEY="$ACCUWEATHER_API_KEY"
LOCATION_CODE="298937" # Hammarsdale location code
URL="http://api.accuweather.com/currentconditions/v1/$LOCATION_CODE?apikey=$API_KEY&language=en-us"

# Function to get the weather data
get_weather_data() {
    curl -s "$URL"
}

# Function to get the weather icon
get_weather_icon() {
    local icon_code=$1

    case $icon_code in
        1) echo "☀️" ;;               # Sunny
        2) echo "🌤️" ;;              # Partly Cloudy
        3) echo "🌤️" ;;              # Partly Cloudy
        4) echo "🌤️" ;;              # Partly Cloudy
        5) echo "☁️" ;;              # Cloudy
        6) echo "🌧️" ;;              # Showers
        7) echo "⚡" ;;               # Thunderstorms
        8) echo "❄️" ;;              # Snow
        10) echo "🌫️" ;;             # Fog
        11) echo "🌬️" ;;             # Windy
        12) echo "🌦️" ;;             # Light Showers
        13) echo "🌨️" ;;             # Snow Showers
        14) echo "🌨️" ;;             # Sleet
        15) echo "❄️💧" ;;            # Freezing Rain
        16) echo "🌨️" ;;             # Snow Showers
        17) echo "💥" ;;              # Hail
        18) echo "🌬️" ;;             # Dust
        19) echo "🌫️" ;;             # Smoke
        20) echo "🌫️" ;;             # Ash
        21) echo "🌬️" ;;             # Squalls
        22) echo "🌪️" ;;             # Tornado
        23) echo "🌀" ;;              # Hurricane
        24) echo "🌩️" ;;             # Tropical Storm
        25) echo "🌬️" ;;             # Windy
        26) echo "🌥️" ;;             # Overcast
        27) echo "🌙" ;;              # Clear Night
        28) echo "🌙" ;;              # Partly Cloudy Night
        29) echo "🌘" ;;              # Mostly Clear Night
        30) echo "🌑" ;;              # Mostly Clear Night
        31) echo "☁️" ;;              # Scattered Clouds
        *) echo "❓" ;;               # Unknown
    esac
}

# Function to fetch weather and display the icon
fetch_weather_and_icon() {
    local weather_data
    weather_data=$(get_weather_data)

    # Extract icon code from the weather data
    local icon_code
    icon_code=$(echo "$weather_data" | jq -r '.[0].WeatherIcon')

    # Get the corresponding weather icon
    local icon
    icon=$(get_weather_icon "$icon_code")

    # Print the weather icon
    echo "$icon"
}

# Fetch and display the weather icon
fetch_weather_and_icon
