# Altair BASIC Reconstruction: Project History

This document chronicles the journey of digitizing and reconstructing the original 1975 Altair BASIC source code from the PDF published by Bill Gates.

## The Beginning: September 2025 (Project Context)
The project started with the goal of performing a high-fidelity OCR of the "Original-Microsoft-Source-Code (1).pdf". Early attempts using standard AI models showed that the document is notoriously difficult to parse due to:
- Age-related degradation of the print.
- Non-standard PDP-10 MACRO-10 assembler listing format.
- Overlays of handwritten notes and printer artifacts (e.g., 'M' read as 'H+I').

## Phase 1: Structural Discovery
The team identified that the source is not just raw assembly but a `.LST` (Listing) file generated on a PDP-10. This was a crucial breakthrough, as it explained the four-column matrix:
1.  **Sequential Line Number:** The printer's line count.
2.  **Assembled Value:** Octal machine code.
3.  **Editor Line Number:** 5-digit SOS/TECO line numbers (e.g., 01020).
4.  **Source Code:** The actual Intel 8080 mnemonics and comments.

## Phase 2: Deciphering the "Decoder Ring"
Through iterative prompting and manual verification, several "Forensic Correction Rules" were established:
- **Character Substitutions:** M -> H/H+I, D -> O/A, B -> 8, I -> 1.
- **Assembler Directives:** Identification of `IFE`, `IFN`, `XWD`, and `^D`/`^O` as PDP-10 specific macros used to cross-assemble for the Intel 8080.
- **Authorship Confirmation:** Page 2 confirmed the roles:
    - **Bill Gates:** Runtime stuff.
    - **Paul Allen:** Non-runtime stuff.
    - **Monte Davidoff:** Math package.

## Phase 3: Page-by-Page Reconstruction
- **Page 1 (page-000):** Captured the "Common File" header and basic configuration flags (LPT, DSKFUN, STRING), RST macro definitions.
- **Page 2 (page-001):** Captured the PUSHR/POPR/MOVRI macros and PRINTX build-time diagnostics.
- **Page 3 (page-002):** Captured the copyright notice, development timeline (Feb-April 1975), and initial memory/stack constants (`NUMLEV`, `LINLEN`).
- **Page 4 (page-003):** Documented the `INTERNAL` and `EXTERNAL` symbol definitions, linking the various modules of the system.

## Phase 4: Image Preprocessing & OCR Optimization (March 2026)
To overcome the limitations of standard OCR on degraded 1975 printer output, the project adopted a dual-source image strategy:
- **Raw Extractions:** `pdfimages` was used to extract every page as a raw `.jpg` to preserve original details.
- **Preprocessing Pipeline:** A custom shell script `tools/ocr-preprocess.sh` was developed to clean these images using ImageMagick (grayscale, deskew, and sharpening).
- **Parallel OCR Approach:** By maintaining both the raw and "ocr-ready" versions, the team (and AI models) can cross-reference versions to resolve character ambiguities caused by ink bleeds or faint printing.
- **Initial Verification:** Reconstruction of the first four pages (0-3) has been completed, serving as the benchmark for this new pipeline.

## Phase 5: Transcription Refinements & Claude Code Integration (March 2026)
With the pipeline established, a detailed pass over `page-000.MAC` surfaced several corrections and improvements:

- **Printer Banner Corrected:** The F3 job banner ASCII art at the top of page-000 was re-read from the source image and corrected. The "3" digit is rendered in a specific TOPS-10 LPT block-letter style: open top and bottom curves (showing both sides), narrowing to a right-only stroke in the middle section, with a short middle prong on the far right. This is structurally different from a simple mirrored "8".
- **`DSFFUN` → `DSKFUN`:** Line 28 of page-000 had `DSFFUN==0` (a misread of the K as two characters FF due to ink fragmentation). Corrected to `DSKFUN==0`, consistent with lines 9 and 19 of the same block.
- **New Decoder Ring Rule:** The `^` (caret) character reliably prints as `"` (close-quote) in degraded LPT output. `"D13` → `^D13` (decimal 13 = CR), `"D10` → `^D10` (decimal 10 = LF).
- **New Decoder Ring Rule:** In printer banners, `3` sometimes appears as `5` due to ink bleed — these are artifacts, not actual digit `5` characters.
- **Complete LPTSPL Header:** The full system header (including `QUEUE SWITCHES` and `FILE WILL BE DELETED AFTER PRINTING` lines) was added to `page-000.MAC`.
- **`CLAUDE.md` Created:** A Claude Code-specific instruction file was added to the repo. It documents the OCR workflow, decoder ring, gold standard header, column format, and completed page inventory — enabling consistent AI-assisted transcription across sessions.

## Phase 6: Assembler Rules Validation (March 2026)
To further improve OCR accuracy and resolve ambiguities, the original "DECsystem-10 MACRO Assembler Reference Manual" (April 1978) was sourced. 
- **Directive Validation:** The manual confirmed the behavior of the `IFE` (If Equal to Zero), `IFN` (If Not Equal to Zero), and `XWD` (Transfer Word) pseudo-ops, validating how Gates and Allen cross-assembled code and configured features based on the `LENGTH` system variable.
- **`MACRO-10.md` Created:** A summary of these assembler rules, including radix control (`^D`/`^O`), was placed in the project root as a quick-reference for OCR transcription.
- **The `CONTRW` Anomaly:** Discovered that the flag for allowing Control-O (`^O`) is literally spelled `CONTRW` in the source, not `CONTRO`. The Decoder Ring in all context files was updated to explicitly forbid "fixing" this anomaly.

## Current Status (March 2, 2026)
Pages 0–3 are verified. With the PDP-10 assembler manual rules now integrated into the project's knowledge base (`MACRO-10.md`), the team is prepared to move into the deep reconstruction of the `RST` subroutines and the core interpreter logic, starting from `page-004`.
