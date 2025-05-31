import wires::*;

module register (
    input wire reset,
    input wire clock,
    input register_read_in_type register_rin,
    input register_write_in_type register_win,
    output register_out_type register_out
);
  timeunit 1ns; timeprecision 1ps;

  logic [31:0] reg_file[0:31];

  initial begin
    for (int i = 0; i < 32; i = i + 1) begin
      reg_file[i] = 0;
    end
  end

  assign register_out.rdata1 = reg_file[register_rin.raddr1];
  assign register_out.rdata2 = reg_file[register_rin.raddr2];

  always_ff @(posedge clock) begin
    if (register_win.wren == 1) begin
      reg_file[register_win.waddr] <= register_win.wdata;
    end
  end

endmodule
