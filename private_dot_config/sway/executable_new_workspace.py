#! /usr/bin/env python3
#
# Written by Filippo Bonazzi for i3 (2016) and sway (2024)
##############################################################################
#
# Read the JSON representation of the list of workspaces, get the focused
# workspace and open the first empty workspace available on the same output.
#
# We convert JSON directly to Python data by exploiting the similar syntax,
# we just need to convert "true" and "false" to "True" and "False". This is
# kind of a hack but it works fine for this short script.

import subprocess
import argparse
import sys
import json

# Parse arguments
parser = argparse.ArgumentParser(
    description="Launch a new workspace on the active output.",
    epilog="Designed to run on a dual-monitor setup with odd workspaces "
    "on the left and even workspaces on the right.")
# Fill holes in the numbering
parser.add_argument("-f", "--fill-holes", action="store_true",
                    help="Fill holes in the workspace numbering on the active "
                    "output [Default: False]")
parser.add_argument("-w", "--window-manager", type=str, choices=["i3", "sway"],
                    default="sway", help="Select the window manager [Default: sway]")
args = parser.parse_args()

msg_cmd = "swaymsg" if args.window_manager == "sway" else "i3-msg"

# Get a list of workspaces
try:
    o = subprocess.run([msg_cmd, "-t", "get_workspaces"], capture_output=True, check=True).stdout.decode().strip()
except subprocess.CalledProcessError as e:
    print(e.output)
    print(f"Could not get list of workspaces from {msg_cmd}. Aborting...")
    sys.exit(1)

# Obtain a dict of workspaces as dictionaries from JSON
workspaces = {w["num"]: w for w in json.loads(o)}

# Find the focused workspace and save its output
for w in workspaces.values():
    if w["focused"]:
        focused_output = w["output"]
        focused_workspace = w["num"]
        break
if args.fill_holes:
    # Find the lowest free workspace
    new = 1
    while new in workspaces.keys():
        new += 1
else:
    # Find the highest workspace and increase it
    new = max([w["num"] for w in workspaces.values()]) + 1

try:
    subprocess.check_call([msg_cmd, "workspace", str(new)])
except subprocess.CalledProcessError as e:
    print(e)
    print(f"Could not open workspace {new}. Aborting...")
    sys.exit(1)
