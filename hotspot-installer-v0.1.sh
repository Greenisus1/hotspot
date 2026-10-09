#!/bin/bash
# 📥 install-hotspot-2.1.sh — Interactive Installer for hotspot.sh with shortcut management

SCRIPT_URL="https://raw.githubusercontent.com/Greenisus1/hotspot/main/hotspot.sh"
INSTALL_DIR="/usr/local/bin"
DEFAULT_NAME="hotspot"
SHORTCUT_TRACKER="$HOME/.hotspot_shortcuts.txt"
INSTALLER_NAME="install-hotspot-2.1.sh"

print_header() {
  echo "┌───────────────────────────────┐"
  echo "│     🔧 Hotspot Installer      │"
  echo "└───────────────────────────────┘"
}

print_menu() {
  echo ""
  echo "press 1 → Install for the first time (recommended)"
  echo "press 2 → Update the hotspot file"
  echo "press 3 → System updates + fresh install (not recommended)"
  echo "press 4 → Update this installer (coming soon)"
  echo "press 5 → Uninstall this installer"
  echo ""
}

main() {
  print_header
  print_menu

  read -rp "Choose option → " choice

  case "$choice" in
    1)
      echo "📦 Installing hotspot.sh for the first time..."
      curl -fsSL "$SCRIPT_URL" -o "$INSTALL_DIR/$DEFAULT_NAME" || {
        echo "❌ Failed to download hotspot.sh"; exit 1;
      }
      chmod +x "$INSTALL_DIR/$DEFAULT_NAME"
      echo "✅ Installed as '$DEFAULT_NAME'"
      ;;
    2)
      echo "🔄 Updating hotspot.sh..."
      curl -fsSL "$SCRIPT_URL" -o "$INSTALL_DIR/$DEFAULT_NAME" && chmod +x "$INSTALL_DIR/$DEFAULT_NAME"
      echo "✅ Updated '$DEFAULT_NAME'"
      ;;
    3)
      echo "⚠️ Running system updates first (not recommended)..."
      sudo apt update && sudo apt upgrade -y
      echo "📦 Installing hotspot.sh..."
      curl -fsSL "$SCRIPT_URL" -o "$INSTALL_DIR/$DEFAULT_NAME" && chmod +x "$INSTALL_DIR/$DEFAULT_NAME"
      echo "✅ Installed as '$DEFAULT_NAME'"
      ;;
    4)
      echo "🚧 Update for this installer is coming soon..."
      ;;
    5)
      echo "🗑️ Uninstalling this installer..."
      rm -f "$PWD/$INSTALLER_NAME"
      echo "✅ Removed '$INSTALLER_NAME'"
      exit 0
      ;;
    *)
      echo "❌ Invalid choice. Exiting."
      exit 1
      ;;
  esac

  # 🔧 Shortcut Setup
  echo "saved as \"$DEFAULT_NAME\""
  echo "To change it press 1, to create another press 2, press 3 to save"
  read -rp "Enter choice → " sc_choice

  case "$sc_choice" in
    1)
      read -rp "Enter new shortcut name: " newname
      mv "$INSTALL_DIR/$DEFAULT_NAME" "$INSTALL_DIR/$newname"
      echo "$newname" >> "$SHORTCUT_TRACKER"
      echo "✅ Renamed to '$newname'"
      ;;
    2)
      read -rp "Enter name for additional shortcut: " othername
      cp "$INSTALL_DIR/$DEFAULT_NAME" "$INSTALL_DIR/$othername"
      chmod +x "$INSTALL_DIR/$othername"
      echo "$othername" >> "$SHORTCUT_TRACKER"
      echo "✅ Created shortcut '$othername'"
      ;;
    3)
      echo "$DEFAULT_NAME" >> "$SHORTCUT_TRACKER"
      echo "✅ Shortcut saved as '$DEFAULT_NAME'"
      ;;
    *)
      echo "⚠️ Invalid choice. Using default name: '$DEFAULT_NAME'"
      echo "$DEFAULT_NAME" >> "$SHORTCUT_TRACKER"
      ;;
  esac

  # 📋 Show all saved shortcuts
  echo -e "\n📁 Saved Shortcuts:"
  i=1
  while read -r line; do
    echo "shortcut#$i: $line"
    ((i++))
  done < "$SHORTCUT_TRACKER"

  # 🚀 Launch prompt
  echo -n "run it? → "
  read -r launch

  shopt -s nocasematch
  case "$launch" in
    y|yes|yea|yeah|yas|YeS|Y|YES|yEs|yES|yeS )
      bash "$INSTALL_DIR/$DEFAULT_NAME"
      ;;
    n|no|nar|Nar|nah|NO|No )
      echo "❌ Exit requested. Installer process complete."
      ;;
    * )
      echo "⚠️ Invalid response. Exit assumed."
      ;;
  esac
}

main
