# 8bitdo-sleep-fix

Somewhat more robust solution to the 8bitdo controller/usb wake problem.

### Issue

- 8bitdo doesn't mark the USB dongle as a USB wake device like a keyboard or mouse so bazzite won't let it be a wake device.
- Blind forcing the usb hub to allow wake causes a the system to immediately wake on sleep because the 8bitdo dongle registers itself as a different device as it turns itself off.

Previously the agreed on solution has been to put a 20 second delay into the sleep lifecycle of your bazzite device. I didn't like that so I:

1. Added a force unbind that causes the 8bitdo controller to turn off as soon as you sleep.
2. Waits for the idle version of the device to show up (or for 20 seconds)
3. Enables usb wake on the hub level.

On wake we:

1. Disable usb wake at the hub level.
2. Attempt to rebind the usb port (not sure if this is valueable yet)

### Setup

Only tested on bazzite so far.

1. Clone the repo to some where in your home directory
2. Open 8bitdo-sleep-fix and set:
   - PORT
   - HUB
   - VENDOR_ID
   - PRODUCT_ID
   - IDLE_PRODUCT_ID
3. Run `make install`. This will:
   1. Copy 8bitdo-sleep-fix to /usr/bin/local
   2. Setup 8bitdo-sleep-fix.service as the sleep hook to run the script
   3. enable the service and restart daemons for you.
