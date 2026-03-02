# Altair BASIC Original Source Code OCR Project

## Project Goal
The goal of this project is to digitize the original source code of Altair BASIC, as published by Bill Gates on [Gates Notes](https://www.gatesnotes.com/microsoft-original-source-code). 

Our process involves:
1. **OCR the PDF:** Extracting the text from the provided PDF document (`Original-Microsoft-Source-Code.pdf`).
2. **Convert to 8080 Assembly:** Cleaning up the OCR output and converting it into valid Intel 8080 assembly code.
3. **Run in an Altair Simulator:** Ultimately, we want to compile this assembly and run it successfully in an Altair 8800 simulator.

## Call for Collaborators 🤝
**We need your help!** 

Currently, AI tools are having a tough time accurately parsing and OCRing the original PDF document due to its age, formatting, and handwritten notes. 

If you are interested in retro-computing, 8080 assembly, or just want to help preserve a piece of computing history, your contributions are highly welcome. 

### How you can help:
*   Manually verifying and correcting OCR'd pages.
*   Helping to write or adapt scripts to automate the parsing and cleanup process.
*   Translating the cleaned text into compilable 8080 assembly.
*   Testing the code in Altair simulators.

## Project Structure
*   `GEMINI.md`: The technical "Ground Truth" for AI transcription. Use this file as context when prompting AI tools to ensure consistent parsing of the 4-column matrix and printer artifacts.
*   `HISTORY.md`: A detailed narrative of the project's milestones, discoveries (like the PDP-10 listing format), and progress so far.
*   `Original-Microsoft-Source-Code.pdf`: The primary source document provided by Bill Gates.

Feel free to open issues, submit pull requests, or reach out if you want to join the effort!