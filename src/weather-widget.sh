#!/bin/env bash

# Get the directory where the script is located
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
ENV_FILE="$SCRIPT_DIR/.env"
CACHE_FILE="/tmp/weather-cache.json"
CACHE_DURATION=1800  # 30 minutes in seconds

# Load environment variables
if [ -f "$ENV_FILE" ]; then
    export $(cat "$ENV_FILE" | xargs)
fi

API_KEY="$ACCUWEATHER_API_KEY"
LOCATION_CODE="298886" # Hammarsdale location code
URL="http://dataservice.accuweather.com/currentconditions/v1/$LOCATION_CODE?apikey=$API_KEY"

# Debug function
debug_response() {
    local response=$1
    echo "API Response:" > /tmp/weather-debug.log
    echo "$response" >> /tmp/weather-debug.log
}

# Function to get the weather data
get_weather_data() {
    local weather_data
    weather_data=$(curl -s "$URL")

    # Debug the response
    debug_response "$weather_data"

    if [ $? -eq 0 ] && [ ! -z "$weather_data" ]; then
        echo "$weather_data"
    else
        echo ""
    fi
}

# Function to get the weather icon
get_weather_icon() {
    local icon_code=$1

    case $icon_code in
        1) echo "󰖙" ;;                # Sunny
        2) echo "󰖕" ;;               # Partly Cloudy
        3) echo "" ;;               # Partly Cloudy
        4) echo "" ;;               # Partly Cloudy
        5) echo "󰖐" ;;                # Cloudy
        6) echo "" ;;               # Showers
        7) echo "" ;;               # Thunderstorms
        8) echo "" ;;                # Snowy
        10) echo "󰖑" ;;              # Fog
        11) echo "󰖝" ;;              # Windy
        12) echo "" ;;              # Light Showers
        13) echo "󰙿" ;;              # Snowy Showers
        14) echo "" ;;              # Sleet
        15) echo "" ;;             # Freezing Rain
        16) echo "󰙿" ;;              # Snowy Showers
        17) echo "󰖒" ;;              # Hail
        18) echo "" ;;              # Dust
        19) echo "" ;;              # Smoke
        20) echo "󱞙" ;;              # Ash
        21) echo "󰼯" ;;              # Squalls
        22) echo "" ;;              # Tornado
        23) echo "󰢘" ;;              # Hurricane
        24) echo "" ;;              # Tropical Storm
        25) echo "󰖝" ;;              # Windy
        26) echo "" ;;              # Overcast
        27) echo "󰖔" ;;              # Clear Night
        28) echo "󰼱" ;;              # Partly Cloudy Night
        29) echo "" ;;              # Mostly Clear Night
        30) echo "" ;;              # Mostly Clear Night
        31) echo "" ;;               # Scattered Clouds
        *) echo "" ;;               # Unknown
    esac
}

# Main function to fetch weather and display info
fetch_weather_info() {
    local weather_data
    weather_data=$(get_weather_data)

    if [ -z "$weather_data" ]; then
        echo "❓"  # Display when API call fails
        return 1
    fi

    # Extract weather information with debug output
    echo "$weather_data" > /tmp/weather-debug-before-jq.log

    # Modified jq command with error checking
    local icon_code
    icon_code=$(echo "$weather_data" | jq -r '.[0].WeatherIcon // empty')

    if [ -z "$icon_code" ]; then
        echo "❓"  # Display when JSON parsing fails
        return 1
    fi

    # Get and print only the weather icon
    get_weather_icon "$icon_code"
}

# Run the main function
fetch_weather_info
