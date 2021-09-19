#!/bin/bash

wttr=$(curl --silent wttr.in/Cary?format=j1)

echo -n $(jq '.current_condition[0].FeelsLikeF' <(echo ${wttr}) | xargs )F
echo -n " "
echo -n UV: $(jq '.current_condition[0].uvIndex' <(echo ${wttr}) | xargs )/11+
