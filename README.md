# MIMO-GP

# 📘 Introduction

Welcome to the Beamforming MIMO Project repository!  
This project presents the design and implementation of a **fully digital beamforming transceiver system** for 5G wireless communications in the **mmWave frequency band at 39 GHz**. The system is tailored for **massive MIMO (Multiple-Input Multiple-Output)** technology, which significantly improves spectral efficiency by allowing base stations to simultaneously serve multiple users over the same frequency resources.

Digital beamforming, used in both the transmitter and receiver chains, offers fine-grained control over beam patterns, enabling adaptive and directional signal transmission. Unlike analog beamforming, which shares a single RF chain, this system provides **per-element RF chain processing**, allowing for superior beamforming precision and flexibility at the cost of higher complexity.
- **QPSK modulation**
- **Square-root raised cosine filtering**
- **Digital up/down conversion**
- **ΣΔ modulation and 1-bit quantization**
- **Complex weight multiplication for beamforming**
- **Multi-stage interpolation and decimation**


This project is implemented using **MATLAB/Simulink for system modeling** and transitions to **RTL and ASIC design flows**, making it a comprehensive design from simulation to hardware-ready implementation.

---



# 🗂️ Table of Contents

- [`/docs/`](./Documentation) - Documentation, reports, or design notes  
- [`/Mdl/`](./System_Modeling) - Floating and Fixed point models with helper MATLAB functions  
- [`/ASIC/`](./ASIC_Flow) - RTL, Scripts and Files of the Digital ASIC Flow  
- [`README.md`](./README.md) - Project overview and documentation  

---

# 📌 Project Description

This project develops a **Massive MIMO Digital Beamforming Transceiver** targeting 5G communications. It leverages **fully digital beamforming** to achieve high spatial resolution and spectral efficiency, making it ideal for modern base stations operating in dense urban environments.

The system is built on a **4x4 antenna array** and processes signals from RF to bits entirely in the digital domain. Both the **transmitter and receiver chains** are implemented using a modular pipeline that includes advanced signal processing techniques.
The full signal chain—from bit generation to beamformed RF output and back—includes:
- **Transmitter chain**: QPSK modulation, square-root filtering, interpolation, digital up-conversion, sigma-delta modulation, and DAC output.
- **Receiver chain**: Sigma-delta ADC, interleaving, digital down-conversion, beamforming using complex weights, decimation, matched filtering, and symbol demodulation.
---

# 🗂️ Repository Structure

This repository is organized into several main folders, each serving a distinct purpose in the design and development of the Massive MIMO Digital Beamforming Transceiver system:

---

## 📁 ASIC_FLOW

This folder contains the complete RTL synthesis and Place & Route (PnR) files for both the transmitter and receiver sections of the transceiver. It includes:

- **Synthesis scripts** for logic synthesis of RTL modules.
- **PnR scripts** for backend implementation including floorplanning and placement.
- **Output files** such as timing reports, area/power estimates, and netlists.
- Organized by Tx and Rx submodules.

---

## 📁 Documentation

This folder houses all formal documentation associated with the project, including:

- **Block Diagrams**: Visual representations of the transmitter and receiver signal chains.
- **Project Thesis**: A comprehensive report detailing the project objectives, design methodology, system architecture, and results.

---

## 📁 System_Modelling

This directory contains the complete system-level models developed in MATLAB/Simulink:

- **Floating Point Model**: Ideal high-precision model for functional verification.
- **Fixed Point Model**: Hardware-accurate model suitable for RTL translation and quantization-aware analysis.
- **Subfolder:**:
  - Scripts to **convert decimal data to binary formats** for digital transmission.
  - MATLAB files to **generate beamforming constants** used in digital weight calculations.
  - A utility to **calculate SQNR (Signal-to-Quantization-Noise Ratio)** of various blocks in the chain.

---

"""


Features – TBU



## 📬 Contacts

Feel free to reach out to any of the team members for questions or collaboration!

| Name              | Email                       | LinkedIn                                                                        |
|-------------------|-----------------------------|---------------------------------------------------------------------------------|
| Yousif Ahmed      | yousifahmedp7@gmail.com     | [@Yousif Ahmed]([(https://www.linkedin.com/in/yousif-ahmed-a97766252/)])                                                                            |
| Ziad Ahmed        | zziad.ahmed.17@gmail.com    | [@Ziad Ahmed]([https://www.linkedin.com/in/ziad-ahmed-02620b249?utm_source=share&utm_campaign=share_via&utm_content=profile&utm_medium=android_app])|
| Charlie Nguyen    | charlie.n@example.com       | [@charlie-nguyen](https://github.com/charlie-nguyen)    |
| asdjniasdhaisdas  | adsdadas                    | dasdddddddddddddddddddddddddd                           |
| asdjniasdhaisdas  | adsdadas                    | dasdddddddddddddddddddddddddd                           |
| asdjniasdhaisdas  | adsdadas                    | dasdddddddddddddddddddddddddd                           |
| asdjniasdhaisdas  | adsdadas                    | dasdddddddddddddddddddddddddd                           |
| asdjniasdhaisdas  | adsdadas                    | dasdddddddddddddddddddddddddd                           |
| asdjniasdhaisdas  | adsdadas                    | dasdddddddddddddddddddddddddd                           |
| asdjniasdhaisdas  | adsdadas                    | dasdddddddddddddddddddddddddd                           |

**Supervisors:**
- Dr. Michael Ibrahim

> _Developed at Ain Shams University, Faculty of Engineering, ECE Department (2024–2025)_

