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
- **Page 1:** Captured the "Common File" header and basic configuration flags (LPT, DSKFUN, STRING).
- **Page 2:** Captured the copyright notice, development timeline (Feb-April 1975), and initial memory/stack constants (`NUMLEV`, `LINLEN`).
- **Page 3:** Documented the `INTERNAL` and `EXTERNAL` symbol definitions, linking the various modules of the system.

## Current Status (March 2, 2026)
The project is currently moving into the deep reconstruction of the `RST` subroutines and the core interpreter logic. AI assistance is being used to provide "Ground Truth" checks against the `GEMINI.md` context file to maintain consistency across sessions.
