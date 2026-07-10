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

# Setup

Only tested on bazzite so far.

This is all run from the Terminal application in Bazzite's desktop mode. It will either be called Konsole (KDE) or Terminal (Gnome) depending on the desktop you chose for your Bazzite install.

My bazzite install came with all the dependencies (git and make) to get this to work so I'm assuming yours is the same. If you see an error like "command not found"... maybe it's time to update. I'm not really sure.

Once you're in the terminal prompt type these commands:

1. `git clone https://github.com/jasonewall/8bitdo-sleep-fix.git` - Clone this repository to your home directory. Terminal should start you off there. We're using a protocol here that does not require you to have a Git/GitHub account of your own.
1. `cd 8bitdo-sleep-fix` - Changes to the new directory creatd by the clone operation.
1. `make install`. Pay attention to the state it asks your controller to be in. Recording the states properly is important to get the shutdown to work. Also note it will prompt you for your password bazzite asked you to setup when you first installed it. It needs permissions to put files in spaces Linux considers sensitive, so the prompt is coming from Linux/Bazzite itself.

That's it. You're done!

Please note that this will wire up the sleep functionality to the specific port you have the dongle plugged into. If you need to change ports there's a command below to redetect the ports.

If this is causing you issues you can disable it (see below command table).

Make sure you're running these commands from the directory we just created. So if you're in a fresh terminal always run `cd 8bitdo-sleep-fix` first!

| Command          | What It Do                                                                                                                                                                                                     |
| ---------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `make disable `  | Disables the sleep hook service without removing anything from your system.                                                                                                                                    |
| `make enable`    | Re-enable the sleep hook after you've disabled it.                                                                                                                                                             |
| `make uninstall` | Deletes the files from your system directories that were originally created by `make install`                                                                                                                  |
| `make update`    | If there's changes to the scripts made this command will copy those changes to your system folder without needing to uninstall/install again. It will also skip the detect device ID step from a full install. |
| `make detect`    | Rerun the detection step from the initial install without needing to do a full install. Run this if you change which port the dongle is plugged into.                                                          |
| `make dump`      | Outputs some troubleshooting information. Please include a copy of this output when asking for help/reporting issues.                                                                                          |
