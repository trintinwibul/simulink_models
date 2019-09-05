// This is the memory map header file for 'acoustic_delay_buffer'
// Generated by High Level Design Compiler for Intel(R) FPGAs Version 18.0 (Release Build #614) on Fri Apr 05 13:33:36 2019

// This file contains the address of each register in the design, with the block name, 
// read/write mode, and description in the block parameters as comments for each.

// Each section denotes one ModelIP/ModelBus block and is laid out as follows:
// <block name> : <description from block>
// <REGISTER_NAME>_BIT_WIDTH <bit width from block>
// <REGISTER_NAME>_FRAC_WIDTH <frac width from block>
// <REGISTER_NAME>_PRIVATE_SPACE <is the private register space box checked?>
// Then, for each addressable word of the block:
// <REGISTER_NAME>_LSB <LSB of word>
// <REGISTER_NAME>_MSB <MSB of word>
// <REGISTER_NAME>_WIDTH <width of word>
// <REGISTER_NAME> <word address in hex format> <read/write mode>

#define AVALON_BUS_WIDTH 32
#define AVALON_ADDRESS_WIDTH 1
// acoustic_delay_buffer/adb/RegField : Number of samples of delay to compensate for acoustic propagation delay
#define ACOUSTIC_DELAY_BUFFER_ADB_REGFIELD_BIT_WIDTH 12
#define ACOUSTIC_DELAY_BUFFER_ADB_REGFIELD_FRAC_WIDTH 0
#define ACOUSTIC_DELAY_BUFFER_ADB_REGFIELD_PRIVATE_SPACE false
#define ACOUSTIC_DELAY_BUFFER_ADB_REGFIELD_LSB 0
#define ACOUSTIC_DELAY_BUFFER_ADB_REGFIELD_MSB 11
#define ACOUSTIC_DELAY_BUFFER_ADB_REGFIELD_WIDTH 12
#define ACOUSTIC_DELAY_BUFFER_ADB_REGFIELD 0x0 // Read/Write 
