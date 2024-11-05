# -*- coding: utf-8 -*-

import subprocess
import os

from i3pystatus import Status

green="#98c379"
red="#e06c75"
yellow="#d19a66"

status = Status(standalone=True, click_events=True)

# Displays clock like this:
# Tue 30 Jul 11:59:46 PM KW31
status.register("clock", format= ("%Y-%m-%d %I:%M %p", "Europe/Kyiv"))
# Sound 100 ♪
status.register("pulseaudio", format="{volume} ♪")


# Shows the average load of the last minute and the last 5 minutes
# (the default value for format is used)
status.register("load", format="{avg1}")

status.register("mem",
    format="MEM {percent_used_mem}%",
    color="#aaaaaa",
    warn_percentage=80,
    alert_percentage=90
    )

status.register("disk",
    path="/",
    format="{avail}G",
    color="#ffffff",
)
status.register("battery",
    format="{status} {percentage:.2f}% {remaining:%E%hh:%Mm}",
    alert=True,
    alert_percentage=15,
    color="#ffffff",
    critical_color=red,
    status={
        "DIS": "⬇",
        "CHR": "⬆",
        "FULL": "✔",
    },
)


status.run()
