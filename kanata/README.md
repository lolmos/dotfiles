# Kanata Keyboard Configuration

Keyboard remapping configuration using [Kanata](https://github.com/jtroo/kanata) for the **Logitech Ergo K860**.

## Goals

- **Full keyboard functionality preserved** — no disabling F-keys, media keys, or any standard keys
- **Home row mods** as the first layer — tap for letters, hold for modifiers
- **Incremental approach** — start minimal, add layers gradually
- **macOS compatible** — using Karabiner-DriverKit or native support

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
