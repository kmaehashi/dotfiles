#!/bin/bash -ue

open "$(dirname ${0})/Pro (Kenichi).terminal"
osascript -e '
    tell application "Terminal"
        set the default settings to current settings of the selected tab of the window 0
        close the window 0
    end tell
'
