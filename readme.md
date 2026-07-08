# Low Level Modulator

A microprocessor-based modulator built on an **Altera DE2-115 FPGA**, running a custom **processor** written in Verilog with software authored in assembly. Synth Synthesis is an interactive toy that teaches modulator modulation to beginners (ages 8+) by pairing a live, animated waveform with synchronized audio — letting users *see* and *hear* how amplitude, frequency, and phase changes reshape a sound in real time.

---

## Overview

Learning a modulator is hard because modulation is abstract: you tweak a parameter and a sound changes, but the *why* stays hidden. The modulator closes that gap. The user is given a **target waveform** and a **base waveform** of their choosing (sine, square, or saw), then modulates the base wave to match the target. Every change updates both the on-screen wave and the audio simultaneously, turning an invisible concept into something concrete and playable.
 
The system is a full hardware/software co-design: a hand-built processor on the FPGA, low-level device drivers, a DSP pipeline that turns audio samples into pixels, and game logic that drives the target-matching experience.

## Features

- **Real-time modulation** across five parameters (amplitude, frequency, phase, and more), freely combinable for a wide range of sounds.
- **Synced audio + visual** — a live waveform on the VGA display moves in lockstep with the audio output.
- **Three base wavetables** — sine, square, and saw, selectable from the start menu.
- **Target-matching gameplay** — a switch flips between the user's wave and the target wave to compare.
- **Reset & replay** — clear all modulations or restart a session without power-cycling.
- **Simple GUI** — four pixel-art screens loaded from SD card for low-friction navigation.

## Hardware

| Component | Role |
|---|---|
| Altera DE2-115 FPGA | Hosts the processor, game logic, and all I/O |
| VGA monitor | Displays the waveform and menu screens |
| Speaker (with volume knob) | Plays the audio of each waveform; headphones supported |
| PS/2 keyboard | Primary navigation and modulation controls |
| DE2 slide switch | Toggles between target and current waveform |
| SD card | Stores binary image assets for the UI screens |

## Architecture

The software is organized into cooperating systems, all coordinated by a centralized, non-blocking finite state machine so the keyboard, display, and speaker never busy-wait on one another.

- **Main** — top-level control: welcome screen and the core game loop, calling into playback and drawing routines.
- **Modulator** — applies arithmetic to base wavetable values (sine/saw/square) to compute audio and display arrays; handles wave selection, the modulation loop, and audio-to-display conversion.
- **Update** — centralizes turn/state logic for the external hardware, enabling non-blocking keyboard, display, and speaker handling.
- **Audio** — streams sample arrays produced by the modulator to the speaker.
- **Display** — renders the moving waveform and menu screens, clearing stale pixels for a clean animation.
- **Keyboard** — non-blocking driver; maps keys to state transitions and modulation parameters.
- **SD Card** — supplies the sprite/screen binaries, offloading UI storage from the DE2.

### Signal flow

```
Keyboard ──► Update (FSM) ──► Main (game loop)
                                 │
                                 ├─► Modulator ──► audio array ──► Audio ──► Speaker
                                 │                └► display array ─► Display ─► VGA
                                 └─► Screen assets ◄── SD Card
```

The DSP pipeline synthesizes 32-bit audio by phase-indexing into the three wavetables, applies the active modulations, and writes parallel fixed-length buffers — one for the speaker, one for the VGA renderer — so sound and picture stay in sync.

## Build & Run

The project targets the toolchain used in the course.

1. **Assemble** the software with `as`: choose the top-level assembly file (`main.e`, which `#include`s the other modules) and click **Assemble** to produce `main.mif`.
2. **Simulate** in `as` by loading the `.mif` and clicking **Run** to verify behavior before touching hardware.
3. **Synthesize** the Verilog  processor and I/O controllers in Quartus to produce `top.sof`.
4. **Program** the DE2-115 with `top.sof`, then load `main.mif` into memory via the Quartus memory content editor.
5. Connect the VGA monitor, speaker, and keyboard, insert the SD card with the UI assets, and run.

> `as` builds are available for Windows, macOS, and Linux, and on CAEN Windows via the software list.

## Repository Layout

Selected files from the project tree:

- **Verilog (`.v`)** — processor and datapath: `top.v`, `control.v`, `ram.v`, `register.v`, plus ALU/logic units (`add13.v`, `subtract_26.v`, `greater.v`, `isZero.v`, `tristate.v`, `reset_toggle.v`, ...).
- **Assembly software (`.e`, `.m`)** — `main.e`, `modulator.e`, `update.e`, `audio_play.e`/`play_wave.e`, `vga_driver.e`/`vga.e`, `keyboard.e`, `sd.e`, `screen_display.e`, `draw_wave.e`/`draw_sine.e`, wavetables (`sine.e`, `saw.e`, `square.e`), `color100.m`, and test harnesses (`vgatest.e`, `speakertest.e`, `sd_test.e`, ...).
- **Assets** — `Main_menu.png`, `Goal.png`, `Current.png`, `select.png` and their `.bin`/`.e` encodings for SD-card loading.
- **Build artifacts** — `top.sof`, `main.mif`, and Quartus reports (`top.map.rpt`, `top.fit.summary`, ...).

## Known Limitations

- The DE2's **integer-only math** constrains the modulation range; some combinations sound less musical than intended.
- At higher frequencies the small sample count and normalized display range reduce **waveform definition** on screen.
- A rare input sequence can let **frequency modulation alter the target wave**, which should stay static.
- No **numeric feedback** on modulation state or closeness to the target — users read progress by ear and shape only.
- No built-in prompts to **encourage experimentation** beyond the user's own curiosity.

## Future Work

- Move off integer math to a more flexible platform for cleaner modulation.
- Add a **playground mode** separate from the target challenge.
- Show **closeness feedback** — a match indicator, color change to green, and a success sound.
- Display **current parameter values** (numbers or sliders) so users can replicate and reason about their modulations.
- Redesign controls to act on **one modulation at a time**, reducing on-screen clutter.

## References

- R. E. Mayer, *Multimedia Learning*, 3rd ed. Cambridge University Press, 2020.
- P. R. Cook, *Real Sound Synthesis for Interactive Applications*. CRC Press, 2002.
- J. Twells, "The 14 most important synths in electronic music history," *FACT Magazine*, Apr. 2017.