# GCU 1F3 V1.0 Firmware build Quickstart

## Tested platforms
This firmware is developed and tested in a **CentOS 7 64 bit** and a **Debian 9 64 bit** real hardware platform.

It is foreseen to support also some others Linux container installations in the near future.

## Required software

1) Vivado 2018.3 ( at least HLx Editions) for Linux 
2) trimode emac license ( https://www.xilinx.com/products/intellectual-property/temac.html  even an evaluation is OK)
3) opbasm ( https://kevinpt.github.io/opbasm/)

## Clone the repository

1) this repository depends from other git submodules, please clone with the following command:

```bash
$ git clone --recursive https://baltig.infn.it/juno-pd/electronics/Firmware_GCU1F3.git
```
2) enter the repo:
```bash
$ cd Firmware_GCU1F3
```
3) go to the ``externals/ipbus-software`` subdirectory:
```bash
$ cd externals/ipbus-firmware
```
4) checkout the latest(?!) stable tag:
```bash
$ git checkout v1.3
```

## Firmware build instruction

1) please be sure that vivado executables are in your $PATH; normally is enough to run:
```bash
$ source /path/to/your/Vivado/installation/Vivado/2018.3/settings64.sh
```
2) enter in the Firmware_GCU1F3 directory:
```bash
$ cd Firmware_GCU1F3
$ make all
```

you will find the ``firmware.bit`` in the ```results``` subdir.
