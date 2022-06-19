#!/bin/bash
dunstify --urgency=low "Volume $(pamixer --get-volume)%"
