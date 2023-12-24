#!/bin/bash 

function get_interface_ns() {
    local ns_name="$1"
    ip netns exec "${ns_name}" ip a | grep wlan | awk -F: '{print $2}' | tr -d ' '
}

function run() {
	local ns="$1"
	local interface="$(get_interface_ns "${ns}")"
	ip netns exec $ns bash -c "wpa_supplicant -Dnl80211 -i $interface -c /opt/client/$ns.conf"
	ip netns exec $ns bash -c "dhclient -i $interface"
}

run $1
