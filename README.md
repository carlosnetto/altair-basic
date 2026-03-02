# Altair BASIC Original Source Code OCR Project

## Project Goal
The goal of this project is to digitize the original source code of Altair BASIC, as published by Bill Gates on [Gates Notes](https://www.gatesnotes.com/microsoft-original-source-code).

Our process involves:
1. **OCR the PDF:** Extracting the text from the provided PDF document (`Original-Microsoft-Source-Code.pdf`).
2. **Convert to 8080 Assembly:** Cleaning up the OCR output and converting it into valid Intel 8080 assembly code.
3. **Run in an Altair Simulator:** Ultimately, we want to compile this assembly and run it successfully in an Altair 8800 simulator.

## Call for Collaborators
**We need your help!**

Currently, AI tools are having a tough time accurately parsing and OCRing the original PDF document due to its age, formatting, and handwritten notes.

If you are interested in retro-computing, 8080 assembly, or just want to help preserve a piece of computing history, your contributions are highly welcome.

### How you can help:
*   Manually verifying and correcting OCR'd pages.
*   Helping to write or adapt scripts to automate the parsing and cleanup process.
*   Translating the cleaned text into compilable 8080 assembly.
*   Testing the code in Altair simulators.

## Project Structure
*   `CLAUDE.md`: Instructions for Claude Code (Anthropic AI CLI). Contains the OCR workflow, decoder ring, gold standard header, and completed page inventory. Read this before starting any AI-assisted transcription session.
*   `GEMINI.md`: Ground truth context document for AI transcription sessions (originally written for Gemini, now used with all AI tools). Contains the 4-column matrix spec, forensic correction rules, and known global symbol mappings.
*   `HISTORY.md`: A detailed narrative of the project's milestones, discoveries (like the PDP-10 listing format), and progress so far.
*   `Original-Microsoft-Source-Code.pdf`: The primary source document provided by Bill Gates.
*   `.gitignore`: Excludes system-specific and unnecessary files (like `.DS_Store`) from the repository.
*   `images/`: Contains raw `.jpg` extractions from the PDF and preprocessed `-ocr-ready.png` versions.
    *   `page-XXX.jpg`: Raw extraction using `pdfimages`.
    *   `page-XXX-ocr-ready.png`: Preprocessed image for better OCR accuracy.
*   `tools/`: Helper scripts for the project.
    *   `ocr-preprocess.sh`: Uses ImageMagick to clean and sharpen raw images to aid OCR systems.
*   `src/`: The reconstructed `.MAC` source files (PDP-10 MACRO-10 listing transcriptions).
    *   `page-000.MAC` through `page-003.MAC`: Verified transcriptions of the first four physical pages.

## AI Tool Setup
To start a new AI-assisted transcription session:
- **Claude Code:** The `CLAUDE.md` file is loaded automatically. Also pass `GEMINI.md` as context.
- **Gemini / other tools:** Paste the contents of `GEMINI.md` as the first prompt, then reference the relevant `src/page-XXX.MAC` files for continuity.

Feel free to open issues, submit pull requests, or reach out if you want to join the effort!
