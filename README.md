# Distance-Measuring-Equipment
This is a Zynq700 FPGA based code for measuring distance of object based on a squared sign wave signal. This includes DAC, ADC, and distance calculation parameters. 
📡 FPGA-Based Digital Signal Receiver System

This repository contains a modular Verilog HDL implementation of a digital signal receiver system, designed for FPGA deployment. The design integrates signal generation, clock division, address generation, enable control, averaging, and receiver logic into a complete top-level system.

The project is structured in a clean, hierarchical manner, making it suitable for learning, simulation, and extension to real hardware.

📁 Project Structure
.
├── addrGen.v          # Address generator logic
├── clk_1MHz_div.v     # Clock divider (system clock → 1 MHz)
├── enControl.v        # Enable/control signal generator
├── movingAvg.v        # Moving average filter
├── receiver.v         # Core receiver logic
├── receiver_top.v     # Receiver subsystem wrapper
├── signalGen.v        # Test/input signal generator
└── top.v              # Top-level module

🧠 Design Overview

The system simulates a digital signal acquisition and processing pipeline:

Clock Conditioning

The incoming high-frequency system clock is divided down to 1 MHz for predictable signal sampling.

Signal Generation

A configurable signal generator produces test input data for verification and simulation.

Control & Enable Logic

Enable signals coordinate data flow, ensuring synchronized operation between modules.

Address Generation

Memory or buffer addressing logic supports sequential data access.

Signal Processing

A moving average filter smooths the incoming signal to reduce noise.

Receiver Logic

The receiver processes filtered data and prepares it for downstream use or observation.

🧩 Module Descriptions
🔹 clk_1MHz_div.v

Divides the input system clock to a 1 MHz clock

Ensures deterministic timing for signal processing

🔹 signalGen.v

Generates a digital test signal

Useful for simulation and functional verification

🔹 enControl.v

Produces enable pulses and control signals

Synchronizes data capture and processing stages

🔹 addrGen.v

Generates sequential addresses

Typically used for memory indexing or sample tracking

🔹 movingAvg.v

Implements a moving average filter

Reduces noise by averaging consecutive samples

🔹 receiver.v

Core receiver logic

Processes incoming data and filtered samples

🔹 receiver_top.v

Encapsulates receiver-related submodules

Improves modularity and reuse

🔹 top.v

Top-level integration module

Instantiates all submodules and connects the full system

🛠️ How to Use
Simulation

Set top.v as the top module

Provide a system clock and reset

Observe processed outputs from the receiver

FPGA Deployment

Assign physical clock and reset pins

Synthesize with your preferred FPGA toolchain

Adjust clock divider parameters if required

🎯 Key Features

Modular and hierarchical design

Clean separation of control, data, and processing paths

Easy to extend with:

ADC interfaces

Memory blocks

Communication interfaces (UART/SPI)
