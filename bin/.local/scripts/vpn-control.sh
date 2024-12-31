#!/bin/bash

# VPN connection UUID (replace with your actual UUID)
VPN_ID="53304121-bd32-4cd2-8001-7d2ec8f7e9f9"

# Function to get VPN status
get_status() {
    # Check if the VPN is active by UUID and active status
    if nmcli -t -f uuid,active connection show | grep -q "^${VPN_ID}:yes$"; then
        # Get the VPN IP address if active
        ADDR=$(nmcli -t -f ip4.address connection show "$VPN_ID" | awk -F'/' '{print $1}')
        echo "{\"text\": \"󱠽 VPN\", \"tooltip\": \"VPN connected: $ADDR\", \"class\": \"enabled\"}"
    else
        # If not active, show disconnected status
        echo "{\"text\": \"󱠾 VPN\", \"tooltip\": \"VPN disconnected\", \"class\": \"disabled\"}"
    fi
}

# Function to toggle VPN
toggle_vpn() {
    # Check if the VPN is active by UUID and active status
    if nmcli -t -f uuid,active connection show | grep -q "^${VPN_ID}:yes$"; then
        # Disconnect the VPN
        if nmcli connection down "$VPN_ID"; then
            notify-send "VPN" "VPN disconnected successfully"
        else
            notify-send "VPN" "Failed to disconnect VPN"
        fi
    else
        # Connect the VPN
        if nmcli connection up "$VPN_ID" --ask; then
            notify-send "VPN" "VPN connected successfully"
        else
            notify-send "VPN" "Failed to connect VPN"
        fi
    fi
}

# Main logic
case "$1" in
    status)
        get_status
        ;;
    toggle)
        toggle_vpn
        ;;
    *)
        echo "Usage: $0 {status|toggle}"
        exit 1
        ;;
esac

