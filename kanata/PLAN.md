# Kanata Configuration Plan

Incremental plan for building up keyboard layers on the Logitech Ergo K860.
The key principle: **never lose access to any existing key functionality**.

## Phase 1: Basic Home Row Mods (Start Here)

- [ ] Create base `defsrc` that maps the full keyboard layout
- [ ] Add home row mods on one side only (left hand: A/S/D/F) to test comfort
- [ ] Tune tap-hold timing (start conservative: 200ms tap, 200ms hold)
- [ ] Validate all F-keys, media keys, and special keys still work
- [ ] Run for a week and note pain points

### Why one side first?
Starting with just the left hand lets you keep the right hand "normal" as a fallback
while you build muscle memory. Less overwhelming than both sides at once.

## Phase 2: Full Home Row Mods

- [ ] Add right-hand home row mods (J/K/L/;)
- [ ] Adjust timing based on Phase 1 experience
- [ ] Consider `tap-hold-press` vs `tap-hold-release` strategies
- [ ] Add anti-roll / chord detection if needed for fast typing

## Phase 3: Navigation Layer

- [ ] Add a nav layer (e.g., hold Space or Caps Lock to activate)
- [ ] H/J/K/L → Left/Down/Up/Right (vim-style)
- [ ] U/I → Home/End
- [ ] Y/O → Page Up/Page Down
- [ ] Backspace/Delete on convenient keys

## Phase 4: Symbol/Number Layer

- [ ] Number row accessible from home row
- [ ] Common programming symbols (brackets, braces, pipes) on a layer
- [ ] Reduce pinky stretching for frequently used symbols

## Phase 5: App/Window Management Layer

- [ ] Quick launch / switch shortcuts
- [ ] Window tiling keybinds (if using yabai/Aerospace)
- [ ] Workspace navigation

## Tuning Notes

Keep track of timing and behavioral adjustments here as you go:

- `tap-time`: How long a key can be held before it becomes a hold (start: 200ms)
- `hold-time`: How long before the hold action activates (start: 200ms)
- `eager` vs `lazy` tap-hold: eager sends tap immediately, lazy waits

## Resources

- [Kanata docs](https://github.com/jtroo/kanata/blob/main/docs/config.adoc)
- [Home row mods guide](https://precondition.github.io/home-row-mods)
- [Kanata macOS setup](https://github.com/jtroo/kanata/blob/main/docs/setup-macos.md)
