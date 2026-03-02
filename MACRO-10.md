# PDP-10 MACRO-10 Assembler Notes
*This document summarizes key concepts from the DECsystem-10 MACRO Assembler Reference Manual (April 1978) relevant to interpreting the Altair BASIC source code.*

The original Altair BASIC source code (written by Gates, Allen, and Davidoff) was written in PDP-10 MACRO-10 assembler. It was a cross-assembler configuration targeting the Intel 8080 processor.

## Conditional Assembly (`IFE`, `IFN`)
The MACRO-10 assembler uses conditional directives to include or exclude blocks of code during assembly based on the value of compile-time switches (like `LENGTH` or `STRING`).

*   **`IFE expression, <code>`** (If Equal to Zero):
    Evaluates the `expression`. If it is exactly `0`, the specified `<code>` (usually enclosed in angle brackets `< >` if it spans multiple statements) is assembled.
    *Example:* `IFE LENGTH,< ... >` assembles the block only if `LENGTH` is 0 (4K version).

*   **`IFN expression, <code>`** (If Not Equal to Zero):
    Evaluates the `expression`. If it evaluates to any value *other* than `0`, the `<code>` is assembled.
    *Example:* `IFN STRING,<^D10>` assembles a Line Feed (`^D10`) only if strings are enabled (`STRING != 0`).

## Word Structures (`XWD`)
The PDP-10 was a 36-bit machine. Its assembler provides mechanisms for manipulating these 36-bit words.

*   **`XWD lefthalf, righthalf`** (Transfer Word):
    A pseudo-op that forms a 36-bit word containing two 18-bit values.
    The `lefthalf` expression evaluates to the high-order 18 bits (bits 0-17), and the `righthalf` expression evaluates to the low-order 18 bits (bits 18-35).
    In the context of cross-assembling for the 8-bit Intel 8080 (which has 16-bit addresses), `XWD` is often used to efficiently pack two 16-bit pointers or configuration values into a single PDP-10 storage location for the cross-assembler to process.

## Macros (`DEFINE`)
MACRO-10 features a powerful macro facility for text substitution and code generation.

*   **`DEFINE macroname(args), <macrobody>`**:
    Defines a reusable macro. When `macroname` is invoked later in the source, the assembler substitutes it with the `<macrobody>`, replacing any dummy `args` with the actual parameters provided.
    *Example:* `DEFINE CHRGET,<RST 2>` defines the `CHRGET` macro to emit the Intel 8080 `RST 2` instruction.

## Radix Control
By default, early versions of MACRO-10 assume an **octal** base for numbers.
*   **`^D`**: Forces interpretation of the following digits as **Decimal** (e.g., `^D13` is Carriage Return).
*   **`^O`**: Forces interpretation of the following digits as **Octal** (e.g., `^O20000`).
*   **`RADIX 10`**: A directive that changes the default base to decimal for all following lines (seen in the Altair source around sequence line 109).

## Symbol Definitions
*   **`==`**: Defines a symbol as an **absolute** value. It is constant regardless of where the code is loaded. (e.g., `LENGTH==2`).
*   **`=`**: Defines a symbol as a **relocatable** value (typically an address). It is evaluated relative to the current location counter.

## Block Enclosures
MACRO-10 heavily uses angle brackets `< >` to group multiple lines or statements together to serve as a single operand for directives like `IFE`, `IFN`, `IRP`, and `DEFINE`.
