#!/bin/env bash

CACHE_DIR="$HOME/.cache/weather-widget"
CACHE_FILE="$CACHE_DIR/weather.txt"

# Fetch the weather in format=1 (emoji + temperature)
weather=$(curl -s "wttr.in/Hammarsdale?format=1")

# Ensure the cache directory exists
mkdir -p "$CACHE_DIR"

# Save it to a cache file
echo "$weather" > $CACHE_FILE
