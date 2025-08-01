import constants::*;
import wires::*;

module execute_stage (
    input logic reset,
    input logic clear,
    input logic clock,
    input postdecoder_out_type postdecoder_out,
    output postdecoder_in_type postdecoder_in,
    input alu_out_type alu_out,
    output alu_in_type alu_in,
    input lsu_out_type lsu_out,
    output lsu_in_type lsu_in,
    input csr_alu_out_type csr_alu_out,
    output csr_alu_in_type csr_alu_in,
    input div_out_type div_out,
    output div_in_type div_in,
    input mul_out_type mul_out,
    output mul_in_type mul_in,
    output register_write_in_type register_win,
    output forwarding_execute_in_type forwarding_ein,
    input csr_out_type csr_out,
    output csr_in_type csr_in,
    input mem_out_type dmem_out,
    input execute_in_type a,
    input execute_in_type d,
    output execute_out_type y,
    output execute_out_type q
);
  timeunit 1ns; timeprecision 1ps;

  execute_reg_type r, rin;
  execute_reg_type v;

  always_comb begin

    v = r;

    v.done = d.f.done;

    v.instr = d.f.instr;

    v.instr.op.cwren = 0;
    v.instr.op.crden = 0;
    v.instr.op.nop = 0;
    v.instr.op.csreg = 0;
    v.instr.op.division = 0;
    v.instr.op.mult = 0;
    v.instr.op.ecall = 0;
    v.instr.op.mret = 0;
    v.instr.op.fence = 0;
    v.instr.op.wfi = 0;

    v.instr.div_op = init_div_op;
    v.instr.mul_op = init_mul_op;

    if (d.e.stall == 1) begin
      v = r;
      v.instr.op = r.instr.op_b;
    end

    v.stall = 0;

    v.enable = ~(d.e.stall | csr_out.trap | csr_out.mret | clear);

    v.miss = 0;

    v.mode = csr_out.mode;

    postdecoder_in.instr = v.instr.instr;
    postdecoder_in.mcounteren = csr_out.mcounteren;
    postdecoder_in.mode = v.mode;

    if (v.instr.op.valid == 0) begin
      v.instr.imm = postdecoder_out.imm;
      v.instr.alu_op = postdecoder_out.alu_op;
      v.instr.csr_op = postdecoder_out.csr_op;
      v.instr.div_op = postdecoder_out.div_op;
      v.instr.mul_op = postdecoder_out.mul_op;
      v.instr.op.wren = postdecoder_out.wren;
      v.instr.op.rden1 = postdecoder_out.rden1;
      v.instr.op.rden2 = postdecoder_out.rden2;
      v.instr.op.cwren = postdecoder_out.cwren;
      v.instr.op.crden = postdecoder_out.crden;
      v.instr.op.lui = postdecoder_out.lui;
      v.instr.op.nop = postdecoder_out.nop;
      v.instr.op.csreg = postdecoder_out.csreg;
      v.instr.op.division = postdecoder_out.division;
      v.instr.op.mult = postdecoder_out.mult;
      v.instr.op.ecall = postdecoder_out.ecall;
      v.instr.op.ebreak = postdecoder_out.ebreak;
      v.instr.op.mret = postdecoder_out.mret;
      v.instr.op.fence = postdecoder_out.fence;
      v.instr.op.wfi = postdecoder_out.wfi;
      v.instr.op.valid = postdecoder_out.valid;
    end

    if (v.instr.waddr == 0) begin
      v.instr.op.wren = 0;
    end

    if (v.instr.op.rden1 == 0) begin
      v.instr.rdata1 = 0;
    end
    if (v.instr.op.rden2 == 0) begin
      v.instr.rdata2 = 0;
    end

    v.instr.npc = v.instr.pc + ((v.instr.instr[1:0] == 2'b11) ? 4 : 2);

    if (v.instr.op.valid == 0) begin
      v.instr.op.exception = 1;
      v.instr.ecause = except_illegal_instruction;
      v.instr.etval = v.instr.instr;
    end else if (v.instr.op.ebreak == 1) begin
      v.instr.op.exception = 1;
      v.instr.ecause = except_breakpoint;
      v.instr.etval = v.instr.instr;
    end else if (v.instr.op.ecall == 1) begin
      v.instr.op.exception = 1;
      v.instr.ecause = except_env_call_mach;
      v.instr.etval = v.instr.instr;
    end

    if (v.done == 0) begin
      v.instr.op.exception = 0;
    end

    csr_in.crden = v.instr.op.crden;
    csr_in.craddr = v.instr.caddr;

    v.instr.crdata = csr_out.crdata;

    alu_in.rdata1 = v.instr.rdata1;
    alu_in.rdata2 = v.instr.rdata2;
    alu_in.imm = v.instr.imm;
    alu_in.sel = v.instr.op.rden2;
    alu_in.alu_op = v.instr.alu_op;

    v.instr.wdata = alu_out.res;

    csr_alu_in.cdata = v.instr.crdata;
    csr_alu_in.rdata1 = v.instr.rdata1;
    csr_alu_in.imm = v.instr.imm;
    csr_alu_in.sel = v.instr.op.rden1;
    csr_alu_in.csr_op = v.instr.csr_op;

    v.instr.cwdata = csr_alu_out.cdata;

    div_in.rdata1 = v.instr.rdata1;
    div_in.rdata2 = v.instr.rdata2;
    div_in.enable = v.instr.op.division & v.enable;
    div_in.op = v.instr.div_op;

    v.instr.ddata = div_out.result;
    v.instr.dready = div_out.ready;

    mul_in.rdata1 = v.instr.rdata1;
    mul_in.rdata2 = v.instr.rdata2;
    mul_in.enable = v.instr.op.mult & v.enable;
    mul_in.op = v.instr.mul_op;

    v.instr.mdata = mul_out.result;
    v.instr.mready = mul_out.ready;

    lsu_in.ldata = dmem_out.mem_rdata;
    lsu_in.byteenable = v.instr.byteenable;
    lsu_in.lsu_op = v.instr.lsu_op;

    v.instr.ldata = lsu_out.res;

    if (v.instr.op.auipc == 1) begin
      v.instr.wdata = v.instr.address;
    end else if (v.instr.op.lui == 1) begin
      v.instr.wdata = v.instr.imm;
    end else if (v.instr.op.jal == 1) begin
      v.instr.wdata = v.instr.npc;
    end else if (v.instr.op.jalr == 1) begin
      v.instr.wdata = v.instr.npc;
    end else if (v.instr.op.crden == 1) begin
      v.instr.wdata = v.instr.crdata;
    end else if (v.instr.op.mult == 1) begin
      v.instr.wdata = v.instr.mdata;
    end else if (v.instr.op.division == 1) begin
      v.instr.wdata = v.instr.ddata;
    end

    if (v.instr.op.mult == 1) begin
      v.stall = ~v.instr.mready;
    end else if (v.instr.op.division == 1) begin
      v.stall = ~v.instr.dready;
    end

    if (v.instr.op.load == 1) begin
      v.instr.wdata = v.instr.ldata;
      v.miss = dmem_out.mem_error;
      v.stall = ~dmem_out.mem_ready;
    end else if (v.instr.op.store == 1) begin
      v.miss  = dmem_out.mem_error;
      v.stall = ~dmem_out.mem_ready;
    end

    if (v.miss == 1) begin
      v.instr.op.exception = 1;
      v.instr.ecause = v.instr.op.load == 1 ? except_load_access_fault : except_store_access_fault;
      v.instr.etval = r.instr.address;
    end

    v.instr.op_b = v.instr.op;

    if ((v.stall | csr_out.trap | csr_out.mret | clear) == 1) begin
      v.instr.op = init_operation;
    end

    if (v.instr.op.nop == 1) begin
      v.instr.op.valid = 0;
    end

    register_win.wren = v.instr.op.wren;
    register_win.waddr = v.instr.waddr;
    register_win.wdata = v.instr.wdata;

    forwarding_ein.wren = v.instr.op.wren;
    forwarding_ein.waddr = v.instr.waddr;
    forwarding_ein.wdata = v.instr.wdata;

    csr_in.valid = v.instr.op.valid;
    csr_in.cwren = v.instr.op.cwren;
    csr_in.cwaddr = v.instr.caddr;
    csr_in.cwdata = v.instr.cwdata;

    csr_in.mret = v.instr.op.mret;
    csr_in.exception = v.instr.op.exception;
    csr_in.epc = v.instr.pc;
    csr_in.ecause = v.instr.ecause;
    csr_in.etval = v.instr.etval;

    rin = v;

    y.instr = v.instr;
    y.stall = v.stall;

    q.instr = r.instr;
    q.stall = r.stall;

  end

  always_ff @(posedge clock) begin
    if (reset == 0) begin
      r <= init_execute_reg;
    end else begin
      r <= rin;
    end
  end

endmodule
