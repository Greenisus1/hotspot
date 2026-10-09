# Hotspot

Standalone split of the original app in `microsoftcopilotcodeusedonpi`. Original code and app name kept, with only local-path/update wiring and approved credential removal/prompt changes. The source repository is untouched.

## What it does and needs

NetworkManager Wi-Fi cloning/access-point tool. Requires root, nmcli and supported Wi-Fi hardware. Changes live networking. Use only networks you own or may administer.

## Run

Use the Pi App Store to install and launch. Installation only checks Bash syntax; it does not run administrative actions or install prerequisites. Read the script before selecting Run.

From an extracted checkout:

```sh
bash app-store.sh install
bash app-store.sh run
```

## Safety and limits

This is the original prototype, not a rewritten or hardware-validated release. Some inherited operations may fail or interrupt the system. Prompts do not guarantee safe recovery. Network passwords are requested locally where needed; no OS password is embedded. Use normal sudo authentication. Don't enter credentials on an untrusted/shared terminal.

Do not run unattended on an important Pi. Keep backups. Only administer systems/networks you own or have permission to use.

Linux checks: Bash syntax and packaging tests pass. Raspberry Pi hardware and non-Linux systems are untested. No privileged action was run during validation.

## Tests

```sh
python3 test_packaging.py
```

Version 1.0.0 is the standalone packaging version, not a claim that inherited features changed.

## DietPi-safe fullscreen launch (1.0.1)

The Store opens a fullscreen terminal status/help menu. H shows the legacy clone script's help. R requires nmcli to already be installed and a local-console confirmation before starting the original NetworkManager route. It can still disrupt networking and is not hardware validated. Missing nmcli stops before any password prompt or network changes. No automatic NetworkManager installation.

For DietPi, use dietpi-software to select WiFi HotSpot, with Ethernet uplink and a supported Wi-Fi adapter. Then use dietpi-config > Networking Options: Adapters > WiFi to change SSID/key/channel. Native DietPi uses hostapd and isc-dhcp-server, not this NetworkManager clone route. See https://dietpi.com/docs/software/advanced_networking/ . Use a local console with recovery access, not an SSH-only connection.

Legacy hotspot-installer-v0.1.sh remains available as supplied and bypasses the menu; it does not install the fullscreen wrapper. Read it before use. Linux terminal and mocked missing-nmcli checks pass; real Raspberry Pi/network changes remain untested.
