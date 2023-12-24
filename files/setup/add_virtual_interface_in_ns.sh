#!/bin/bash 

# Add a virtual interface to a network namespace.
function add_interface() {
    local ns_name="$1"
    local interface="$2"
    local phy
    phy="$(get_phy "${interface}")"
    iw phy "${phy}" set netns name "${ns_name}" || { echo "Fatal: Unable to move device '${phy}' (${interface}) to network namespace '${ns_name}'."; set -e; }
    return 0
}

function get_interface_left() {
	ls /sys/class/net -1 | grep wlan | head -1
}

# Return the physical device for the given wireless network interface
# get_phy <interface>
function get_phy() {
    local interface="$1"
    cat "/sys/class/net/${interface}/phy80211/name"
}

inter="$(get_interface_left)"
add_interface $1 ${inter}
