# Altair BASIC OCR — Claude Code Instructions

## Project Context
This project digitizes the original 1975 Altair BASIC source code from a Bill Gates PDF. The source is a **PDP-10 MACRO-10 assembler listing** (`.LST`) that cross-assembles to **Intel 8080** machine code, written by Gates, Allen, and Davidoff in early 1975.

**Always read `GEMINI.md` before starting any OCR session** — it is the ground truth context document.

---

## OCR Workflow

### Image strategy
For any page `XXX`, always read **both** versions:
- `images/page-XXX.jpg` — raw `pdfimages` extraction; higher resolution; use this first
- `images/page-XXX-ocr-ready.png` — ImageMagick preprocessed (grayscale, deskew, sharpen); cross-reference when characters are ambiguous

### Output format for `src/page-XXX.MAC`
These files are transcription records, not compilable source. Format:

```
; [page header block: banner, LPTSPL header, listing page header]
; ============================================================

; [Seq] [Value]  [Editor] [Source]
  N    OOOOOO      EEEEE  source                       ;comment
```

- **Seq**: right-aligned decimal sequence number
- **Value**: 6-digit octal assembled value (blank for assembler directives)
- **Editor**: 5-digit SOS/TECO editor line number (increments by 20 or 100)
- **Source**: MACRO-10 source, indented to align columns
- **Comments**: `;TEXT` — no space after semicolon (matches original)

---

## The 4-Column Matrix
Every non-blank listing line:
```
[Seq]  [Value]   [Editor]  [Source code]   ;comment
  4    000002     00400    LENGTH==2        ;0 MEANS 4K, 1 MEANS 8K, 2 MEANS 12K
```

---

## Decoder Ring — Printer Artifact Corrections

| Appears as | Read as | Notes |
|---|---|---|
| `H` or `H+I` | `M` | Very common — M splits at the middle stroke |
| `O` or `A` | `D` | |
| `8` | `B` | |
| `1` | `I` | |
| `"nnn` | `^Dnnn` or `^Onnn` | Caret prints as a close-quote in degraded scans |
| `5` | `3` | In printer banners — ink bleed artifact |
| `=` (in dates) | `-` | `10=SEP=75` → `10-SEP-75` |
| `b` (in dates) | `6` | `b-SEP-b4` → `6-SEP-64` |

**Rule:** When in doubt, mark the value as `[UNREADABLE]` and note it. Do not guess.

---

## Key MACRO-10 Syntax (cross-assembling for Intel 8080)

| Syntax | Meaning |
|---|---|
| `==` | Symbol assignment (absolute) |
| `=` | Relocatable (address) assignment |
| `^D` | Force decimal interpretation |
| `^O` | Force octal interpretation |
| `IFE expr,<block>` | Assemble block if expr == 0 |
| `IFN expr,<block>` | Assemble block if expr != 0 |
| `XWD a,b` | 18-bit half-word pack (PDP-10 specific) |
| `;;` | Preferred inline comment style |
| `DEFINE name(args),<body>` | Macro definition |
| `RST n` | Intel 8080 restart instruction |

---

## Gold Standard Header (verified from `page-000.MAC`)

```
LPTSPL VERSION 6(344)  RUNNING ON LPT0
*START* USER MITS  (6000,6000) JOB F3 SEQ, 42 DATE 10-SEP-75 08:24:32 MONITOR ALBUQUERQUE SCHOOLS 5076 *START*
REQUEST CREATED: 10-SEP-75  03:18:06
FILE: DSKB0:F3[6000,6000] CREATED: 10-SEP-75 03:16:02 PRINTED: 10-SEP-75 08:52:43
QUEUE SWITCHES: /FILEASCII /COPIES:2 /SPACING:1 /LIMIT:1305 /FORMS:NORMAL
FILE WILL BE DELETED AFTER PRINTING
```

Listing page header format (two lines):
```
BASIC MCS 8080  GATES/ALLEN/DAVIDOFF    MACRO 47(113) 03:12 10-SEP-75 PAGE N
F3    MAC    6-SEP-64 HH:MM              <SUBTTL>
```

---

## Key Global Symbols

| Symbol | Octal Value | Meaning |
|---|---|---|
| `LENGTH` | 2 | Build size (0=4K, 1=8K, 2=12K) |
| `REALIO` | 1 | Real hardware (not simulator) |
| `NUMLEV` | 023 | `17 + LENGTH*2` — stack levels reserved |
| `LINLEN` | 0110 | `^D72` — teletype line length |
| `BUFLEN` | 0110 | `^D72` — input buffer size |
| `CLMWID` | 0016 | `"014` — comma column width (14 chars) |
| `RAMBOT` | 020000 | Bottom of RAM for pure-code switch |
| `FAC` | — | Floating Accumulator |
| `TXTAB` | — | Text table origin |
| `FRETOP` | — | Top of free memory |

---

## Completed Pages

| File | Listing Page | Seq Lines | Content |
|---|---|---|---|
| `src/page-000.MAC` | PAGE 1 | 1–53 | Printer banner, LPTSPL header, config flags, RST DEFINEs |
| `src/page-001.MAC` | PAGE 1-1 | 54–79 | PUSHR/POPR/MOVRI DEFINEs, PRINTX conditionals |
| `src/page-002.MAC` | PAGE 1 + 1-1 | 80–131 | Copyright, authorship, constants (NUMLEV, LINLEN, etc.) |
| `src/page-003.MAC` | PAGE 1-1 + PAGE 2 | 132–224 | INTERNAL/EXTERNAL symbols, RST subroutine explanations |

---

## Important Notes
- The first physical page (`page-000`) includes the **F3 job printer banner** before the actual listing begins
- `RADIX 10` is set at seq line 109 (page-002) — lines before that use octal by default
- The `^` character is rendered as `"` in many scanned lines — always interpret `"Dnn` as `^Dnn`
- Trust the greenbar paper lines as horizontal anchors; if a line looks blank, it probably is
- `DSFFUN` in any context is almost certainly `DSKFUN` (K fragmented by ink bleed)
