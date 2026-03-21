# Kanata Keyboard Configuration

Keyboard remapping configuration using [Kanata](https://github.com/jtroo/kanata) for the **Logitech Ergo K860**.

## Goals

- **Full keyboard functionality preserved** — no disabling F-keys, media keys, or any standard keys
- **Home row mods** as the first layer — tap for letters, hold for modifiers
- **Incremental approach** — start minimal, add layers gradually
- **Cross-platform** — works on macOS, Linux, and Windows

## Installation

### macOS

1. **Install Kanata**
   ```bash
   brew install kanata
   ```

2. **Install Karabiner-DriverKit** (required for virtual keyboard on macOS)
   - Download the `.pkg` from [Karabiner-DriverKit releases](https://github.com/pqrs-org/Karabiner-DriverKit-VirtualHIDDevice/releases) (v6+)
   - Install the package and activate the system extension
   - Verify it's active: `systemextensionsctl list`

3. **Grant Input Monitoring permission**
   - System Settings → Privacy & Security → Input Monitoring
   - Add the Kanata binary (usually `/opt/homebrew/bin/kanata`)

4. **Find your keyboard device name**
   ```bash
   sudo kanata --list-devices
   ```
   Update the `macos-dev-names-include` line in `kanata.kbd` with the name of your Logitech Ergo K860.

5. **Run Kanata**
   ```bash
   sudo kanata -c ~/.config/kanata/kanata.kbd
   ```

6. **Run as a background service (optional)**
   Create a LaunchDaemon plist at `/Library/LaunchDaemons/com.kanata.plist` to start Kanata at boot. Use absolute paths (no `~`).

### Linux

1. **Install Kanata**
   ```bash
   # From source
   cargo install kanata

   # Or download a prebuilt binary from GitHub releases
   # https://github.com/jtroo/kanata/releases
   ```

2. **Set up permissions** (so you don't need `sudo` every time)
   ```bash
   # Add your user to the input and uinput groups
   sudo groupadd uinput
   sudo usermod -aG input $USER
   sudo usermod -aG uinput $USER

   # Create a udev rule for uinput
   echo 'KERNEL=="uinput", MODE="0660", GROUP="uinput", OPTIONS+="static_node=uinput"' \
     | sudo tee /etc/udev/rules/99-uinput.rules

   # Reload udev rules and log out/in for group changes
   sudo udevadm control --reload-rules && sudo udevadm trigger
   ```

3. **Run Kanata**
   ```bash
   kanata -c ~/.config/kanata/kanata.kbd
   ```

4. **Run as a systemd service (optional)**
   ```ini
   # ~/.config/systemd/user/kanata.service
   [Unit]
   Description=Kanata keyboard remapper

   [Service]
   ExecStart=/usr/local/bin/kanata -c %h/.config/kanata/kanata.kbd
   Restart=on-failure

   [Install]
   WantedBy=default.target
   ```
   ```bash
   systemctl --user enable --now kanata
   ```

### Windows

1. **Install Kanata**
   ```powershell
   # Using winget
   winget install jtroo.kanata

   # Or download from GitHub releases
   # https://github.com/jtroo/kanata/releases
   # Use the _wintercept.exe variant for the Interception driver (recommended)
   ```

2. **Install the Interception driver (recommended)**
   - Download from [Interception releases](https://github.com/oblitum/Interception)
   - Run the installer and reboot
   - This gives better compatibility than the default Windows hook mode

3. **Run Kanata**
   ```powershell
   kanata.exe -c C:\Users\you\.config\kanata\kanata.kbd
   ```

4. **Run at startup (optional)**
   - Place a shortcut to Kanata in `shell:startup`
   - Or use Task Scheduler to run it at login

### Platform Notes

| | macOS | Linux | Windows |
|---|---|---|---|
| Driver needed | Karabiner-DriverKit | uinput (built-in) | Interception (optional) |
| Sudo required | Yes | No (with udev rules) | No |
| Config differences | Needs `macos-dev-names-include` | Works out of the box | Use `_wintercept` binary for Interception |

## Home Row Mods (Phase 1)

The initial setup maps home row keys to modifiers when held:

| Key | Tap | Hold |
|-----|-----|------|
| A   | a   | Left Ctrl |
| S   | s   | Left Alt |
| D   | d   | Left Cmd |
| F   | f   | Left Shift |
| J   | j   | Right Shift |
| K   | k   | Right Cmd |
| L   | l   | Right Alt |
| ;   | ;   | Right Ctrl |

## Setup on macOS

1. Install Kanata: `brew install kanata`
2. Install [Karabiner-DriverKit](https://github.com/pqrs-org/Karabiner-DriverKit-VirtualHIDDevice) for virtual keyboard support
3. Symlink config: handled by the dotfiles Makefile
4. Run: `sudo kanata -c ~/.config/kanata/kanata.kbd`

## File Structure

```
kanata/
├── README.md          # This file
├── PLAN.md            # Incremental improvement plan
└── kanata.kbd         # Main Kanata configuration
```
