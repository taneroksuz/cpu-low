package configure;
  timeunit 1ns; timeprecision 1ps;

  parameter hardware = 0;

  parameter mul_performance = 1;

  parameter buffer_depth = 4;

  parameter tim_width = 32;
  parameter tim_depth = 8192;

  parameter ram_depth = 262144;

  parameter ram_type = 0;

  parameter rom_base_addr = 32'h00;
  parameter rom_mask_addr = 32'h7F;

  parameter spi_base_addr = 32'h100000;
  parameter spi_mask_addr = 32'h0FFFFF;

  parameter uart_tx_base_addr = 32'h1000000;
  parameter uart_tx_mask_addr = 32'h0000003;

  parameter uart_rx_base_addr = 32'h1000004;
  parameter uart_rx_mask_addr = 32'h0000003;

  parameter clint_base_addr = 32'h2000000;
  parameter clint_mask_addr = 32'h000FFFF;

  parameter tim_base_addr = 32'h10000000;
  parameter tim_mask_addr = 32'h000FFFFF;

  parameter ram_base_addr = 32'h80000000;
  parameter ram_mask_addr = 32'h000FFFFF;

  parameter cpu_freq = 1000000000;  // 1GHz
  parameter per_freq = 200000000;  // 200MHz
  parameter rtc_freq = 1000000;  // 1MHz
  parameter baudrate = 115200;

  parameter clk_divider_per = cpu_freq / per_freq;
  parameter clk_divider_rtc = cpu_freq / rtc_freq;
  parameter clk_divider_bit = cpu_freq / baudrate;

endpackage
