package wires;
  timeunit 1ns; timeprecision 1ps;

  import constants::*;

  typedef struct packed {
    logic [0 : 0] alu_add;
    logic [0 : 0] alu_sub;
    logic [0 : 0] alu_sll;
    logic [0 : 0] alu_srl;
    logic [0 : 0] alu_sra;
    logic [0 : 0] alu_slt;
    logic [0 : 0] alu_sltu;
    logic [0 : 0] alu_and;
    logic [0 : 0] alu_or;
    logic [0 : 0] alu_xor;
  } alu_op_type;

  parameter alu_op_type init_alu_op = '{
      alu_add : 0,
      alu_sub : 0,
      alu_sll : 0,
      alu_srl : 0,
      alu_sra : 0,
      alu_slt : 0,
      alu_sltu : 0,
      alu_and : 0,
      alu_or : 0,
      alu_xor : 0
  };

  typedef struct packed {
    logic [0 : 0] divs;
    logic [0 : 0] divu;
    logic [0 : 0] rem;
    logic [0 : 0] remu;
  } div_op_type;

  parameter div_op_type init_div_op = '{divs : 0, divu : 0, rem : 0, remu : 0};

  typedef struct packed {
    logic [0 : 0] muls;
    logic [0 : 0] mulh;
    logic [0 : 0] mulhsu;
    logic [0 : 0] mulhu;
  } mul_op_type;

  parameter mul_op_type init_mul_op = '{muls : 0, mulh : 0, mulhsu : 0, mulhu : 0};

  typedef struct packed {
    logic [0 : 0] lsu_lb;
    logic [0 : 0] lsu_lbu;
    logic [0 : 0] lsu_lh;
    logic [0 : 0] lsu_lhu;
    logic [0 : 0] lsu_lw;
    logic [0 : 0] lsu_sb;
    logic [0 : 0] lsu_sh;
    logic [0 : 0] lsu_sw;
  } lsu_op_type;

  parameter lsu_op_type init_lsu_op = '{
      lsu_lb : 0,
      lsu_lbu : 0,
      lsu_lh : 0,
      lsu_lhu : 0,
      lsu_lw : 0,
      lsu_sb : 0,
      lsu_sh : 0,
      lsu_sw : 0
  };

  typedef struct packed {
    logic [0 : 0] bcu_beq;
    logic [0 : 0] bcu_bne;
    logic [0 : 0] bcu_blt;
    logic [0 : 0] bcu_bge;
    logic [0 : 0] bcu_bltu;
    logic [0 : 0] bcu_bgeu;
  } bcu_op_type;

  parameter bcu_op_type init_bcu_op = '{
      bcu_beq : 0,
      bcu_bne : 0,
      bcu_blt : 0,
      bcu_bge : 0,
      bcu_bltu : 0,
      bcu_bgeu : 0
  };

  typedef struct packed {
    logic [0 : 0] csrrw;
    logic [0 : 0] csrrs;
    logic [0 : 0] csrrc;
    logic [0 : 0] csrrwi;
    logic [0 : 0] csrrsi;
    logic [0 : 0] csrrci;
  } csr_op_type;

  parameter csr_op_type init_csr_op = '{
      csrrw : 0,
      csrrs : 0,
      csrrc : 0,
      csrrwi : 0,
      csrrsi : 0,
      csrrci : 0
  };

  typedef struct packed {
    logic [31 : 0] rdata1;
    logic [31 : 0] rdata2;
    logic [31 : 0] imm;
    logic [0 : 0] sel;
    alu_op_type alu_op;
  } alu_in_type;

  typedef struct packed {logic [31 : 0] res;} alu_out_type;

  typedef struct packed {
    logic [31 : 0] rdata1;
    logic [31 : 0] rdata2;
    logic [0 : 0] enable;
    div_op_type op;
  } div_in_type;

  typedef struct packed {
    logic [31 : 0] result;
    logic [0 : 0]  ready;
  } div_out_type;

  typedef struct packed {
    logic [31 : 0] data1;
    logic [31 : 0] data2;
    logic [31 : 0] op1;
    logic [31 : 0] op2;
    logic [0 : 0] op1_signed;
    logic [0 : 0] op2_signed;
    logic [0 : 0] op1_neg;
    logic [5 : 0] counter;
    logic [64 : 0] result;
    logic [0 : 0] division;
    logic [0 : 0] negativ;
    logic [0 : 0] divisionbyzero;
    logic [0 : 0] overflow;
    logic [0 : 0] ready;
    div_op_type op;
  } div_reg_type;

  parameter div_reg_type init_div_reg = '{
      data1 : 0,
      data2 : 0,
      op1 : 0,
      op2 : 0,
      op1_signed : 0,
      op2_signed : 0,
      op1_neg : 0,
      counter : 0,
      result : 0,
      division : 0,
      negativ : 0,
      divisionbyzero : 0,
      overflow : 0,
      ready : 0,
      op : init_div_op
  };

  typedef struct packed {
    logic [31 : 0] rdata1;
    logic [31 : 0] rdata2;
    logic [0 : 0] enable;
    mul_op_type op;
  } mul_in_type;

  typedef struct packed {
    logic [31 : 0] result;
    logic [0 : 0]  ready;
  } mul_out_type;

  typedef struct packed {
    logic [31 : 0] op1;
    logic [31 : 0] op2;
    logic [0 : 0] op1_signed;
    logic [0 : 0] op2_signed;
    logic [0 : 0] op1_neg;
    logic [5 : 0] counter;
    logic [64 : 0] result;
    logic [0 : 0] mult;
    logic [0 : 0] negativ;
    logic [0 : 0] ready;
    mul_op_type op;
  } mul_reg_type;

  parameter mul_reg_type init_mul_reg = '{
      op1 : 0,
      op2 : 0,
      op1_signed : 0,
      op2_signed : 0,
      op1_neg : 0,
      counter : 0,
      result : 0,
      mult : 0,
      negativ : 0,
      ready : 0,
      op : init_mul_op
  };


  typedef struct packed {
    logic [31 : 0] rdata1;
    logic [31 : 0] rdata2;
    bcu_op_type bcu_op;
  } bcu_in_type;

  typedef struct packed {logic [0 : 0] branch;} bcu_out_type;

  typedef struct packed {
    logic [31 : 0] rdata1;
    logic [31 : 0] imm;
    logic [31 : 0] pc;
    logic [0 : 0] auipc;
    logic [0 : 0] jal;
    logic [0 : 0] jalr;
    logic [0 : 0] branch;
    logic [0 : 0] load;
    logic [0 : 0] store;
    lsu_op_type lsu_op;
  } agu_in_type;

  typedef struct packed {
    logic [31 : 0] address;
    logic [3 : 0]  byteenable;
    logic [0 : 0]  exception;
    logic [7 : 0]  ecause;
    logic [31 : 0] etval;
  } agu_out_type;

  typedef struct packed {
    logic [31 : 0] ldata;
    logic [3 : 0] byteenable;
    lsu_op_type lsu_op;
  } lsu_in_type;

  typedef struct packed {logic [31 : 0] res;} lsu_out_type;

  typedef struct packed {
    logic [31 : 0] cdata;
    logic [31 : 0] rdata1;
    logic [31 : 0] imm;
    logic [0 : 0] sel;
    csr_op_type csr_op;

  } csr_alu_in_type;
  typedef struct packed {logic [31 : 0] cdata;} csr_alu_out_type;

  typedef struct packed {logic [31 : 0] instr;} predecoder_in_type;

  typedef struct packed {
    logic [31 : 0] imm;
    logic [0 : 0] wren;
    logic [0 : 0] rden1;
    logic [0 : 0] rden2;
    logic [0 : 0] auipc;
    logic [0 : 0] jal;
    logic [0 : 0] jalr;
    logic [0 : 0] branch;
    logic [0 : 0] load;
    logic [0 : 0] store;
    bcu_op_type bcu_op;
    lsu_op_type lsu_op;
    logic [0 : 0] valid;
  } predecoder_out_type;

  typedef struct packed {
    logic [31 : 0] instr;
    logic [31 : 0] mcounteren;
    logic [1 : 0]  mode;
  } postdecoder_in_type;

  typedef struct packed {
    logic [31 : 0] imm;
    logic [0 : 0] wren;
    logic [0 : 0] rden1;
    logic [0 : 0] rden2;
    logic [0 : 0] cwren;
    logic [0 : 0] crden;
    logic [0 : 0] lui;
    logic [0 : 0] nop;
    logic [0 : 0] csreg;
    logic [0 : 0] division;
    logic [0 : 0] mult;
    alu_op_type alu_op;
    csr_op_type csr_op;
    div_op_type div_op;
    mul_op_type mul_op;
    logic [0 : 0] ecall;
    logic [0 : 0] ebreak;
    logic [0 : 0] mret;
    logic [0 : 0] fence;
    logic [0 : 0] wfi;
    logic [0 : 0] valid;
  } postdecoder_out_type;

  typedef struct packed {logic [31 : 0] instr;} compress_in_type;

  typedef struct packed {
    logic [31 : 0] imm;
    logic [4 : 0] waddr;
    logic [4 : 0] raddr1;
    logic [4 : 0] raddr2;
    logic [0 : 0] wren;
    logic [0 : 0] rden1;
    logic [0 : 0] rden2;
    logic [0 : 0] lui;
    logic [0 : 0] jal;
    logic [0 : 0] jalr;
    logic [0 : 0] branch;
    logic [0 : 0] load;
    logic [0 : 0] store;
    alu_op_type alu_op;
    bcu_op_type bcu_op;
    lsu_op_type lsu_op;
    logic [0 : 0] ebreak;
    logic [0 : 0] valid;
  } compress_out_type;

  typedef struct packed {
    logic [4 : 0] raddr1;
    logic [4 : 0] raddr2;
  } register_read_in_type;

  typedef struct packed {
    logic [0 : 0]  wren;
    logic [4 : 0]  waddr;
    logic [31 : 0] wdata;
  } register_write_in_type;

  typedef struct packed {
    logic [31 : 0] rdata1;
    logic [31 : 0] rdata2;
  } register_out_type;

  typedef struct packed {
    logic [31 : 0] pc;
    logic [31 : 0] rdata;
    logic [0 : 0]  error;
    logic [0 : 0]  ready;
    logic [0 : 0]  clear;
    logic [0 : 0]  stall;
  } buffer_in_type;

  typedef struct packed {
    logic [31 : 0] pc;
    logic [31 : 0] instr;
    logic [0 : 0]  miss;
    logic [0 : 0]  done;
    logic [0 : 0]  stall;
  } buffer_out_type;

  typedef struct packed {
    logic [0 : 0] wren;
    logic [0 : 0] rden1;
    logic [0 : 0] rden2;
    logic [0 : 0] cwren;
    logic [0 : 0] crden;
    logic [0 : 0] alunit;
    logic [0 : 0] auipc;
    logic [0 : 0] lui;
    logic [0 : 0] jal;
    logic [0 : 0] jalr;
    logic [0 : 0] branch;
    logic [0 : 0] load;
    logic [0 : 0] store;
    logic [0 : 0] fload;
    logic [0 : 0] fstore;
    logic [0 : 0] nop;
    logic [0 : 0] csreg;
    logic [0 : 0] division;
    logic [0 : 0] mult;
    logic [0 : 0] fence;
    logic [0 : 0] ecall;
    logic [0 : 0] ebreak;
    logic [0 : 0] mret;
    logic [0 : 0] wfi;
    logic [0 : 0] jump;
    logic [0 : 0] exception;
    logic [0 : 0] valid;
  } operation_type;

  parameter operation_type init_operation = '{
      wren : 0,
      rden1 : 0,
      rden2 : 0,
      cwren : 0,
      crden : 0,
      alunit : 0,
      auipc : 0,
      lui : 0,
      jal : 0,
      jalr : 0,
      branch : 0,
      load : 0,
      store : 0,
      fload : 0,
      fstore : 0,
      nop : 0,
      csreg : 0,
      division : 0,
      mult : 0,
      fence : 0,
      ecall : 0,
      ebreak : 0,
      mret : 0,
      wfi : 0,
      jump : 0,
      exception : 0,
      valid : 0
  };

  typedef struct packed {
    logic [31 : 0] pc;
    logic [31 : 0] npc;
    logic [31 : 0] instr;
    logic [31 : 0] imm;
    logic [4 : 0] waddr;
    logic [4 : 0] raddr1;
    logic [4 : 0] raddr2;
    logic [4 : 0] raddr3;
    logic [11 : 0] caddr;
    logic [31 : 0] rdata1;
    logic [31 : 0] rdata2;
    logic [31 : 0] crdata;
    logic [31 : 0] cwdata;
    logic [31 : 0] wdata;
    logic [31 : 0] ldata;
    logic [31 : 0] sdata;
    logic [31 : 0] mdata;
    logic [31 : 0] ddata;
    logic [0 : 0] mready;
    logic [0 : 0] dready;
    logic [31 : 0] address;
    logic [3 : 0] byteenable;
    logic [7 : 0] ecause;
    logic [31 : 0] etval;
    operation_type op;
    operation_type op_b;
    alu_op_type alu_op;
    bcu_op_type bcu_op;
    lsu_op_type lsu_op;
    csr_op_type csr_op;
    div_op_type div_op;
    mul_op_type mul_op;
  } instruction_type;

  parameter instruction_type init_instruction = '{
      pc : 32'h0,
      npc : 32'h0,
      instr : 0,
      imm : 0,
      waddr : 0,
      raddr1 : 0,
      raddr2 : 0,
      raddr3 : 0,
      caddr : 0,
      rdata1 : 0,
      rdata2 : 0,
      crdata : 0,
      cwdata : 0,
      wdata : 0,
      sdata : 0,
      ldata : 0,
      mdata : 0,
      ddata : 0,
      mready : 0,
      dready : 0,
      address : 0,
      byteenable : 0,
      ecause : 0,
      etval : 0,
      op : init_operation,
      op_b : init_operation,
      alu_op : init_alu_op,
      bcu_op : init_bcu_op,
      lsu_op : init_lsu_op,
      csr_op : init_csr_op,
      div_op : init_div_op,
      mul_op : init_mul_op
  };

  typedef struct packed {
    instruction_type instr;
    logic [0 : 0] done;
    logic [0 : 0] stall;
  } fetch_out_type;

  typedef struct packed {
    instruction_type instr;
    logic [31 : 0] addr;
    logic [31 : 0] rdata;
    logic [0 : 0] error;
    logic [0 : 0] ready;
    logic [0 : 0] fence;
    logic [0 : 0] spec;
    logic [1 : 0] mode;
    logic [0 : 0] miss;
    logic [0 : 0] done;
    logic [1 : 0] state;
    logic [0 : 0] valid;
    logic [0 : 0] stall;
  } fetch_reg_type;

  parameter fetch_reg_type init_fetch_reg = '{
      instr : init_instruction,
      addr : 0,
      rdata : 0,
      error : 0,
      ready : 0,
      fence : 0,
      spec : 0,
      mode : m_mode,
      miss : 0,
      done : 0,
      state : 0,
      valid : 0,
      stall : 0
  };

  typedef struct packed {
    instruction_type instr;
    logic [0 : 0] stall;
  } execute_out_type;

  typedef struct packed {
    instruction_type instr;
    logic [1 : 0] mode;
    logic [0 : 0] miss;
    logic [0 : 0] done;
    logic [0 : 0] enable;
    logic [0 : 0] stall;
  } execute_reg_type;

  parameter execute_reg_type init_execute_reg = '{
      instr : init_instruction,
      mode : m_mode,
      miss : 0,
      done : 0,
      enable : 0,
      stall : 0
  };

  typedef struct packed {
    logic [11:11] meip;
    logic [9:9]   seip;
    logic [8:8]   ueip;
    logic [7:7]   mtip;
    logic [5:5]   stip;
    logic [4:4]   utip;
    logic [3:3]   msip;
    logic [1:1]   ssip;
    logic [0:0]   usip;
  } csr_mip_reg_type;

  parameter csr_mip_reg_type init_csr_mip_reg = '{
      meip : 0,
      seip : 0,
      ueip : 0,
      mtip : 0,
      stip : 0,
      utip : 0,
      msip : 0,
      ssip : 0,
      usip : 0
  };

  typedef struct packed {
    logic [11:11] meie;
    logic [9:9]   seie;
    logic [8:8]   ueie;
    logic [7:7]   mtie;
    logic [5:5]   stie;
    logic [4:4]   utie;
    logic [3:3]   msie;
    logic [1:1]   ssie;
    logic [0:0]   usie;
  } csr_mie_reg_type;

  parameter csr_mie_reg_type init_csr_mie_reg = '{
      meie : 0,
      seie : 0,
      ueie : 0,
      mtie : 0,
      stie : 0,
      utie : 0,
      msie : 0,
      ssie : 0,
      usie : 0
  };

  typedef struct packed {
    logic [31:31] sd;
    logic [22:22] tsr;
    logic [21:21] tw;
    logic [20:20] tvm;
    logic [19:19] mxr;
    logic [18:18] summ;
    logic [17:17] mprv;
    logic [16:15] xs;
    logic [14:13] fs;
    logic [12:11] mpp;
    logic [8:8]   spp;
    logic [7:7]   mpie;
    logic [5:5]   spie;
    logic [4:4]   upie;
    logic [3:3]   mie;
    logic [1:1]   sie;
    logic [0:0]   uie;
  } csr_mstatus_reg_type;

  parameter csr_mstatus_reg_type init_csr_mstatus_reg = '{
      sd : 0,
      tsr : 0,
      tw : 0,
      tvm : 0,
      mxr : 0,
      summ : 0,
      mprv : 0,
      xs : 0,
      fs : 0,
      mpp : 0,
      spp : 0,
      mpie : 0,
      spie : 0,
      upie : 0,
      mie : 0,
      sie : 0,
      uie : 0
  };

  typedef struct packed {
    csr_mstatus_reg_type mstatus;
    logic [31 : 0] mtvec;
    logic [31 : 0] mscratch;
    logic [31 : 0] mepc;
    logic [31 : 0] mcause;
    logic [31 : 0] mtval;
    logic [63 : 0] mcycle;
    logic [63 : 0] minstret;
    logic [31 : 0] mcounteren;
    logic [31 : 0] mcountinhibit;
    csr_mip_reg_type mip;
    csr_mie_reg_type mie;
  } csr_machine_reg_type;

  parameter csr_machine_reg_type init_csr_machine_reg = '{
      mstatus : init_csr_mstatus_reg,
      mtvec : 0,
      mscratch : 0,
      mepc : 0,
      mcause : 0,
      mtval : 0,
      mcycle : 0,
      minstret : 0,
      mcounteren : 0,
      mcountinhibit : 0,
      mip : init_csr_mip_reg,
      mie : init_csr_mie_reg
  };

  typedef struct packed {
    logic [0 : 0]  valid;
    logic [0 : 0]  cwren;
    logic [0 : 0]  crden;
    logic [11 : 0] cwaddr;
    logic [11 : 0] craddr;
    logic [31 : 0] cwdata;
    logic [0 : 0]  mret;
    logic [0 : 0]  exception;
    logic [31 : 0] epc;
    logic [7 : 0]  ecause;
    logic [31 : 0] etval;
  } csr_in_type;

  typedef struct packed {
    logic [0 : 0]  trap;
    logic [0 : 0]  mret;
    logic [63 : 0] minstret;
    logic [31 : 0] mtvec;
    logic [31 : 0] mepc;
    logic [31 : 0] mcounteren;
    logic [31 : 0] crdata;
    logic [1 : 0]  mode;
  } csr_out_type;

  typedef struct packed {
    logic [4 : 0]  raddr1;
    logic [4 : 0]  raddr2;
    logic [31 : 0] rdata1;
    logic [31 : 0] rdata2;
  } forwarding_register_in_type;

  typedef struct packed {
    logic [0 : 0]  wren;
    logic [4 : 0]  waddr;
    logic [31 : 0] wdata;
  } forwarding_execute_in_type;

  typedef struct packed {
    logic [31 : 0] data1;
    logic [31 : 0] data2;
  } forwarding_out_type;

  typedef struct packed {
    fetch_out_type   f;
    execute_out_type e;
  } fetch_in_type;

  typedef struct packed {
    fetch_out_type   f;
    execute_out_type e;
  } execute_in_type;

  typedef struct packed {
    logic [0 : 0]  mem_valid;
    logic [0 : 0]  mem_instr;
    logic [1 : 0]  mem_mode;
    logic [31 : 0] mem_addr;
    logic [31 : 0] mem_wdata;
    logic [3 : 0]  mem_wstrb;
  } mem_in_type;

  localparam mem_in_type init_mem_in = 0;

  typedef struct packed {
    logic [0 : 0]  mem_ready;
    logic [0 : 0]  mem_error;
    logic [31 : 0] mem_rdata;
  } mem_out_type;

  localparam mem_out_type init_mem_out = 0;

endpackage
