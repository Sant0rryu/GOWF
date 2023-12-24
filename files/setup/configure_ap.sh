#!/bin/bash 

function get_interface_ns() {
    local ns_name="$1"
    ip netns exec "${ns_name}" ip a | grep wlan | awk -F: '{print $2}' | tr -d ' '
}

function configure() {
	local ns="$1"
	local interface="$(get_interface_ns "${ns}")"
	echo $interface
	ip netns exec $ns ip link set lo up 
	ip netns exec $ns ip addr add 192.168.40.1/24 dev $interface 
	ip netns exec $ns ip link set $interface up 
	cp /opt/template_ap/$ns.conf /opt
	sed -i "s/%INTERFACE%/$interface/" /opt/$ns.conf
}

configure $1
