package configure;
  timeunit 1ns; timeprecision 1ps;

  parameter hardware = 1;

  parameter mul_performance = 1;

  parameter buffer_depth = 4;

  parameter tim_width = 32;
  parameter tim_depth = 1024;

  parameter ram_depth = 1;

  parameter ram_type = 1;

  parameter rom_base_addr = 32'h00;
  parameter rom_mask_addr = 32'hFF;

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

  parameter sys_freq = 50000000;  // 50MHz

  parameter cpu_freq = 25000000;  // 25MHz
  parameter per_freq = 5000000;   // 5MHz
  parameter rtc_freq = 1000000;   // 1MHz
  parameter baudrate = 115200;

  parameter clk_divider_cpu = sys_freq / cpu_freq;
  parameter clk_divider_per = sys_freq / per_freq;
  parameter clk_divider_rtc = cpu_freq / rtc_freq;
  parameter clk_divider_bit = cpu_freq / baudrate;

endpackage
