// Central UVM include ordering file
// Automatically generated: list UVM sources in the required compile order


// Configurations (early)
`include "CONFIGURATIONS/agent_config.sv"
`include "CONFIGURATIONS/env_config.sv"
`include "CONFIGURATIONS/sys_top_config.sv"

// Interfaces
//`include "INTERFACES/sys_intf.sv"

// UVM System (memory) - sequence items first
`include "UVM_SYS/sys_seq_item_mem.sv"
`include "UVM_SYS/sys_rst_sequence.sv"
`include "UVM_SYS/sys_sequencer_mem.sv"
`include "UVM_SYS/sys_env_virtual_sequencer.sv"
`include "UVM_SYS/top_env_virtual_sequencer.sv"
`include "UVM_SYS/sys_driver_mem.sv"
`include "UVM_SYS/sys_monitor_mem.sv"
`include "UVM_SYS/sys_agent_mem.sv"
`include "UVM_SYS/sys_scoreboard_1.sv"
`include "UVM_SYS/sys_scoreboard_2.sv"
`include "UVM_SYS/sys_scoreboard_3.sv"
`include "UVM_SYS/sys_scoreboard_4.sv"
`include "UVM_SYS/sys_scoreboard_5.sv"
`include "UVM_SYS/sys_env.sv"
`include "UVM_SYS/sys_top_env.sv"





// UART RX environment
`include "UVM_UART_RX/uart_config_obj.sv"
`include "UVM_UART_RX/uart_seq_item.sv"
`include "UVM_UART_RX/uart_sequence.sv"
`include "UVM_UART_RX/uart_sequencer.sv"
`include "UVM_UART_RX/uart_driver.sv"
`include "UVM_UART_RX/uart_monitor.sv"
`include "UVM_UART_RX/uart_scoreboard.sv"
`include "UVM_UART_RX/uart_agent.sv"
`include "UVM_UART_RX/uart_cov.sv"
`include "UVM_UART_RX/uart_env.sv"
`include "UVM_UART_RX/uart_sva.sv"

// UART TX environment
`include "UVM_UART_TX/TX_seq_item.sv"
`include "UVM_UART_TX/TX_config_obj.sv"
//`include "UVM_UART_TX/TX_if.sv"
`include "UVM_UART_TX/TX_monitor.sv"
`include "UVM_UART_TX/TX_scoreboard.sv"
`include "UVM_UART_TX/TX_agent.sv"
`include "UVM_UART_TX/TX_cov.sv"
`include "UVM_UART_TX/TX_env.sv"

// AES environment (svh first, then pkg and top)
`include "UVM_AES/AES_config.svh"
`include "UVM_AES/AES_sequence_item.svh"
`include "UVM_AES/AES_sequencer.svh"
`include "UVM_AES/AES_sequence.svh"
`include "UVM_AES/AES_driver.svh"
`include "UVM_AES/AES_monitor.svh"
`include "UVM_AES/AES_agent.svh"
`include "UVM_AES/AES_scoreboard.svh"
`include "UVM_AES/AES_collector.svh"
`include "UVM_AES/AES_env.svh"



// Virtual sequences and tests

`include "UVM_SYS/sys_vseq_base.sv"
`include "UVM_SYS/sys_vseq_smoke_test.sv"


`include "UVM_SYS/sys_base_test.sv"
`include "UVM_SYS/sys_smoke_test.sv"
