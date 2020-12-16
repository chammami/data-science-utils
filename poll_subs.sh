#!/bin/bash
SLUG=${riiid-test-answer-prediction} # default follows :-
for i in $(seq 1 48); do
    date
    TXT=$(kaggle competitions submissions -c $SLUG -v)
    if ! (echo "$TXT" | cut -d, -f4 | grep -q pending); then
        kaggle competitions submissions -c $SLUG  # show subs
        spd-say "nothing pending"
        break
    fi
    sleep 10
done
