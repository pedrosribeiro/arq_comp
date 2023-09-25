# Arquitetura e Organização de Computadores

## About

Lorem ipsum dolor sit amet

## Tools used
Analyzer, compiler and simulator: GHDL - Version 3.0.0

Waveform viewer: GTKWave Analyzer - Version 3.3.100

## Running a testbench

```bash
ghdl -a file_tb.vhd
ghdl -e file_tb
ghdl -r file_tb --wave=file_tb.ghw
gtkwave file_tb.ghw
```

or

```bash
sh compile.sh
```