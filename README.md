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

1. Clone the repo to some where in your home directory.
2. Run `make setup` (or `./setup.sh`) to discover your controller's IDs and generate a local config file named `8bitdo-sleep-fix.env`.
3. Review and adjust the values in `8bitdo-sleep-fix.env` if needed.
4. Run `make install`. This will:
   1. Copy the script to `/etc/scripts/8bitdo-sleep-fix`
   2. Install the discovered values to `/etc/default/8bitdo-sleep-fix`
   3. Set up `8bitdo-sleep-fix.service` as the sleep hook and enable it

You can update the values later by editing `/etc/default/8bitdo-sleep-fix` and restarting the service with `sudo systemctl restart 8bitdo-sleep-fix.service`.
