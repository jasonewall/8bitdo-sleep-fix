#!/bin/sh

VENDOR_ID=2dc8 # 8BitDo

echo "===================================================="
echo "⚡ 8BitDo Sleep Fix: Auto-ID & Port Discovery ⚡"
echo "===================================================="
echo ""

# --- STEP 1: CAPTURE ACTIVE STATE & PHYSICAL PORT ---
echo "👉 STEP 1: Please turn your 8BitDo controller ON."
echo "Make sure it is fully connected to your system right now."
read -p "Press [ENTER] once the controller is ON and connected..."
echo ""

SYS_PATH=$(grep -l "$VENDOR_ID" /sys/bus/usb/devices/*/idVendor 2>/dev/null | head -n 1)

if [ -z "$SYS_PATH" ]; then
    echo "❌ Error: Could not find any 8BitDo device. Check your connection."
    exit 1
fi

DEV_BUS_PORT=$(basename "$(dirname "$SYS_PATH")")

USB_HUB="usb$(echo "$DEV_BUS_PORT" | cut -d'-' -f1)"

ACTIVE_ID=$(cat "$(dirname "$SYS_PATH")/idProduct" 2>/dev/null)

echo "✅ Found Active Product ID: [ $ACTIVE_ID ]"
echo "⚓ Physical Location Detected: Hub [ $USB_HUB ] | Port Path [ $DEV_BUS_PORT ]"
echo ""

# --- STEP 2: CAPTURE INACTIVE STATE ---
echo "👉 STEP 2: Now, turn your 8BitDo controller OFF."
echo "(Or dock it so it goes into sleep/charging mode)."
read -p "Press [ENTER] once the controller is completely OFF..."

# Read the product ID from the exact same physical path to see what it changed to
INACTIVE_ID=$(cat "$(dirname "$SYS_PATH")/idProduct" 2>/dev/null)

if [ -z "$INACTIVE_ID" ]; then
    echo "❌ Error: The USB receiver was completely unplugged. Please leave it plugged in."
    exit 1
fi

echo "✅ Found Inactive Product ID: [ $INACTIVE_ID ]"
echo ""

# Fallback check to ensure they actually changed states
if [ "$ACTIVE_ID" == "$INACTIVE_ID" ]; then
    echo "⚠️ Warning: Both IDs are matching ($ACTIVE_ID). The controller may not have powered off completely."
    echo "   or you may have initiated the active ID scan while the controller was off."
    echo ""
    echo "Please turn the controller on and try again."
    exit 1
fi

echo "✅ Found Inactive Product ID: [ $INACTIVE_ID ]"
echo ""

cat > 8bitdo-sleep-fix.env <<EOF
PORT=$DEV_BUS_PORT
HUB=$USB_HUB
VENDOR_ID=$VENDOR_ID
PRODUCT_ID=$ACTIVE_ID
IDLE_PRODUCT_ID=$INACTIVE_ID
EOF
