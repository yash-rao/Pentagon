# Pentagon

# All-in-One Reverse Engineering and Debugging Docker Environment

This Docker project provides a comprehensive environment for reverse engineering, binary analysis, virtualization, and document processing, combining multiple powerful tools in a single, easy-to-use setup. It is ideal for security researchers, reverse engineers, and developers who require a robust toolkit for analyzing binaries, debugging, and testing virtual machines.

## Key Features:
- **Ghidra**: A powerful reverse engineering suite developed by the NSA, used for analyzing and disassembling binaries.
- **ghidrecomp**: A Python-based companion tool for Ghidra, designed for decompiling binaries to aid in software analysis.
- **BinDiff**: A binary comparison tool that identifies and highlights similarities and differences between two binary files, useful for patch analysis and vulnerability research.
- **Quickemu**: A lightweight virtualization tool that simplifies running virtual machines quickly and efficiently.
- **Stirling-PDF**: A versatile PDF and document processing tool, accessible via a web interface on port 8080, that supports tasks like OCR (Optical Character Recognition) and document manipulation.
- **GEF (GDB Enhanced Features)**: A powerful plugin for GDB, providing enhanced debugging capabilities with commands for heap analysis, memory inspection, and improved backtraces.
- **jbig2enc**: A specialized tool for encoding JBIG2 files, useful in certain document processing pipelines.

## Tools and Utilities:
- **Ghidra**: `/opt/ghidra/ghidraRun`
- **ghidrecomp**: Integrated with Ghidra, run using `ghidrecomp -h`
- **BinDiff**: Binary comparison tool accessible via `bindiff`
- **Quickemu**: Virtual machine manager accessible via `quickemu`
- **Stirling-PDF**: Web-based PDF processing tool accessible at `http://localhost:8080` after running the command:
  ```bash
  java -jar /opt/Stirling-PDF/Stirling-PDF-0.29.0.jar
