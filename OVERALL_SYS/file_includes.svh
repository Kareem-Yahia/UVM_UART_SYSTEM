//============================================================
// Central UVM Include Ordering File
// Purpose : Explicitly include all UVM source files in the
//           correct compile order.
// Notes   :
//   - This file should be `included` once (usually in top.sv)
//   - Ordering matters: interfaces, seq_items, config objects
//     before agents/envs/tests
//============================================================

//============================================================
// FIFO UVM COMPONENTS
// - FIFO verification agent, env, coverage, scoreboard, etc.
//============================================================
`include "./UVM_FIFO/FIFO_if.sv"
`include "./UVM_FIFO/FIFO_seq_item.sv"
`include "./UVM_FIFO/FIFO_config_obj.sv"
`include "./UVM_FIFO/FIFO_sequencer.sv"
`include "./UVM_FIFO/FIFO_monitor.sv"
`include "./UVM_FIFO/FIFO_agent.sv"
`include "./UVM_FIFO/FIFO_cov.sv"
`include "./UVM_FIFO/FIFO_scoreboard.sv"
`include "./UVM_FIFO/FIFO_env.sv"

//============================================================
// REGISTER FILE (RAL + AGENT)
// - UVM Register Layer models and reg-file verification agent
//============================================================
// RAL register definitions
`include "./UVM_REG_FILE/reg_file_seq_item.sv"
`include "./UVM_REG_FILE/reg_file_config_obj.sv"
`include "./UVM_REG_FILE/reg_file_if.sv"
`include "./UVM_REG_FILE/ral_ALU_Operand_A_config.sv"
`include "./UVM_REG_FILE/ral_ALU_Operand_B_config.sv"
`include "./UVM_REG_FILE/ral_Div_Ratio_config.sv"
`include "./UVM_REG_FILE/ral_uart_config.sv"
`include "./UVM_REG_FILE/ral_block_reg_file_config.sv"
`include "./UVM_REG_FILE/ral_sys_reg_file_config.sv"

// RAL environment and adapter
`include "./UVM_REG_FILE/reg2reg_file_adapter.sv"

// Reg-file agent components
`include "./UVM_REG_FILE/reg_file_sequencer.sv"
`include "./UVM_REG_FILE/reg_file_driver.sv"
`include "./UVM_REG_FILE/reg_file_monitor.sv"
`include "./UVM_REG_FILE/reg_file_scoreboard.sv"
`include "./UVM_REG_FILE/reg_file_agent.sv"
`include "./UVM_REG_FILE/ral_env.sv"
`include "./UVM_REG_FILE/reg_file_env.sv"

//============================================================
// DATA SYNCHRONIZATION UVM COMPONENTS
// - CDC / synchronization checking and monitoring
//============================================================
`include "./UVM_SYNC/DATA_SYNC_sva.sv"
`include "./UVM_SYNC/SYNC_if.sv"
`include "./UVM_SYNC/SYNC_seq_item.sv"
`include "./UVM_SYNC/SYNC_config_obj.sv"
`include "./UVM_SYNC/SYNC_sequencer.sv"
`include "./UVM_SYNC/SYNC_monitor.sv"
`include "./UVM_SYNC/SYNC_cov.sv"
`include "./UVM_SYNC/SYNC_scoreboard.sv"
`include "./UVM_SYNC/SYNC_agent.sv"
`include "./UVM_SYNC/SYNC_env.sv"

//============================================================
// UART TX UVM COMPONENTS
// - Transmit-side UART verification
//============================================================
`include "./UVM_TX/TX_if.sv"
`include "./UVM_TX/TX_seq_item.sv"
`include "./UVM_TX/TX_config_obj.sv"
`include "./UVM_TX/TX_sequencer.sv"
`include "./UVM_TX/TX_monitor.sv"
`include "./UVM_TX/TX_cov.sv"
`include "./UVM_TX/TX_scoreboard.sv"
`include "./UVM_TX/TX_agent.sv"
`include "./UVM_TX/TX_env.sv"

//============================================================
// UART FULL UVM ENVIRONMENT
// - Complete UART agent (TX + RX), assertions, and tests
//============================================================
`include "./UVM_uart/uart_if.sv"
`include "./UVM_uart/uart_seq_item.sv"
`include "./UVM_uart/uart_config_obj.sv"
`include "./UVM_uart/uart_sequencer.sv"
`include "./UVM_uart/uart_driver.sv"
`include "./UVM_uart/uart_monitor.sv"
`include "./UVM_uart/uart_cov.sv"
`include "./UVM_uart/uart_scoreboard.sv"
`include "./UVM_uart/uart_sequence.sv"
`include "./UVM_uart/uart_agent.sv"
`include "./UVM_uart/uart_env.sv"
`include "./UVM_uart/uart_sva.sv"

//============================================================
// SYSTEM-LEVEL (TOP) UVM COMPONENTS
// - Virtual sequencer, system env, and integration tests
//============================================================
`include "./UVM_TOP/sys_if.sv"
`include "./UVM_TOP/sys_seq_item.sv"
`include "./UVM_TOP/sys_config_obj.sv"
`include "./UVM_TOP/sys_sequencer.sv"
`include "./UVM_TOP/sys_vsequencer.sv"
`include "./UVM_TOP/sys_driver.sv"
`include "./UVM_TOP/sys_monitor.sv"
`include "./UVM_TOP/sys_cov.sv"
`include "./UVM_TOP/sys_scoreboard.sv"
`include "./UVM_TOP/sys_sequence.sv"
`include "./UVM_TOP/sys_vseq.sv"
`include "./UVM_TOP/sys_agent.sv"
`include "./UVM_TOP/sys_env.sv"
`include "./UVM_TOP/top_env.sv"
`include "./UVM_TOP/sys_test.sv"
