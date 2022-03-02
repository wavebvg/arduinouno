#!/bin/sh

echo "Привет" | RHVoice-client -s anna+CLB -r -0.3 | aplay
