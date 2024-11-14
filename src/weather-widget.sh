#!/bin/env bash

# Get the directory where the script is located
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
ENV_FILE="$SCRIPT_DIR/.env"
CACHE_FILE="$HOME/.cache/weather-widget/weather-cache.json"
DEBUG_LOG="$HOME/.cache/weather-widget/weather-debug.log"
CACHE_DURATION=1800  # 30 minutes in seconds

# Ensure the cache directory exists
mkdir -p "$HOME/.cache/weather-widget"

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
    echo "API Response:" > "$DEBUG_LOG"
    echo "$response" >> "$DEBUG_LOG"
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
        1) echo "󰖙" ;;                 # Sunny
        2) echo "󰖕" ;;                 # Mostly Sunny
        3) echo "" ;;                 # Partly Sunny
        4) echo "" ;;                 # Partly Intermittent Clouds
        5) echo "" ;;                 # Hazy Sunshine
        6) echo "󰅟" ;;               # Mostly Cloudy
        7) echo "" ;;                # Cloudy
        8) echo "" ;;                 # Dreary (Overcast)
        11) echo "󰖑" ;;                # Fog
        12) echo "" ;;               # Showers
        13) echo "" ;;              # Mostly Cloudy w/ Showers
        14) echo "" ;;                # Partly Sunny w/ Showers
        15) echo "" ;;                # Thunderstorms
        16) echo "" ;;                # Mostly Cloudy w/ Thunderstorms
        17) echo "" ;;               # Partly Sunny w/ Thunderstorms
        18) echo "" ;;                # Rain
        19) echo "" ;;               # Flurries
        20) echo "󰅟" ;;               # Most Cloudy w/ Flurries
        21) echo "󰖙" ;;               # Partly Sunny w/ Flurries
        22) echo "" ;;                # Snow
        23) echo "󰖘" ;;                # Mostly Cloudy w/ Snow
        24) echo "" ;;                # Ice
        25) echo "" ;;                # Sleet
        26) echo "" ;;               # Freezing Rain
        29) echo "󰙿" ;;                # Rain and Snow
        30) echo "󱣖" ;;                # Hot
        31) echo "󱩱" ;;                # Cold
        32) echo "󰖝" ;;                # Windy
        33) echo "" ;;                # Clear
        34) echo "" ;;               # Mostly Clear
        35) echo ""  ;;               # Partly Cloudy
        36) echo ""  ;;               # Intermittent Clouds
        37) echo ""  ;;               # Hazy Moonlight
        38) echo ""  ;;               # Mostly Cloudy
        39) echo ""  ;;               # Partly Cloudy w/ Showers
        40) echo ""  ;;               # Mostly Cloudy w/ Showers
        41) echo ""  ;;               # Partly Cloudy w/ Thunderstorms
        42) echo ""  ;;               # Mostly Cloudy w/ Thunderstorms
        43) echo "󰅟"  ;;              # Mostly Cloudy w/ Flurries
        44) echo ""  ;;               # Mostly Cloudy w/ Snow
        *) echo "" ;;                 # Unknown
    esac
}

# Main function to fetch weather and display info
fetch_weather_info() {
    # Clear cache if outdated
    if [ -f "$CACHE_FILE" ] && [ $(($(date +%s) - $(stat -c %Y "$CACHE_FILE"))) -ge $CACHE_DURATION ]; then
        rm "$CACHE_FILE"
    fi

    local weather_data
    weather_data=$(get_weather_data)

    if [ -z "$weather_data" ]; then
        echo "󱧣"  # Display when API call fails
        return 1
    fi

    # save the weather data to the cache file
    echo "$weather_data" > "$CACHE_FILE"

    # Extract weather information with debug output
    echo "$weather_data" > "$DEBUG_LOG"

    # Modified jq command with error checking
    local icon_code
    icon_code=$(echo "$weather_data" | jq -r '.[0].WeatherIcon // empty')

    if [ -z "$icon_code" ]; then
        echo "󱔢"  # Display when JSON parsing fails
        return 1
    fi

    # Get and print only the weather icon
    get_weather_icon "$icon_code"
}

# Run the main function
fetch_weather_info
