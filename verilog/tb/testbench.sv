import configure::*;

module testbench ();

  timeunit 1ns; timeprecision 1ps;

  logic reset;
  logic clock;
  logic clock_per;
  logic sclk;
  logic mosi;
  logic miso;
  logic ss;
  logic rx;
  logic tx;
  logic sram_ce_n;
  logic sram_we_n;
  logic sram_oe_n;
  logic sram_ub_n;
  logic sram_lb_n;
  logic [17:0] sram_addr;
  wire [15:0] sram_dq;

  logic [31 : 0] host[0:0] = '{default: '0};

  logic [31 : 0] stoptime = 10000000;
  logic [31 : 0] counter = 0;

  integer reg_file;
  integer csr_file;
  integer mem_file;

  initial begin
    $readmemh("host.dat", host);
  end

  initial begin
    string filename;
    if ($value$plusargs("FILENAME=%s", filename)) begin
      $dumpfile(filename);
      $dumpvars(0, testbench);
    end
  end

  initial begin
    string maxtime;
    if ($value$plusargs("MAXTIME=%s", maxtime)) begin
      stoptime = maxtime.atoi();
    end
  end

  initial begin
    reset = 0;
    clock = 1;
    clock_per = 1;
  end

  initial begin
    #10 reset = 1;
  end

  always #0.5 clock = ~clock;
  always #5.0 clock_per = ~clock_per;

  initial begin
    string filename;
    if ($value$plusargs("REGFILE=%s", filename)) begin
      reg_file = $fopen(filename, "w");
      for (int i = 0; i < stoptime; i = i + 1) begin
        @(posedge clock);
        if (testbench.soc_comp.cpu_comp.execute_stage_comp.a.e.instr.op.wren == 1) begin
          $fwrite(reg_file, "PERIOD = %t\t", $time);
          $fwrite(reg_file, "PC = %x\t",
                  testbench.soc_comp.cpu_comp.execute_stage_comp.a.e.instr.pc);
          $fwrite(reg_file, "WADDR = %x\t",
                  testbench.soc_comp.cpu_comp.execute_stage_comp.a.e.instr.waddr);
          $fwrite(reg_file, "WDATA = %x\n",
                  testbench.soc_comp.cpu_comp.execute_stage_comp.a.e.instr.wdata);
        end
      end
      $fclose(reg_file);
    end
  end

  initial begin
    string filename;
    if ($value$plusargs("CSRFILE=%s", filename)) begin
      csr_file = $fopen(filename, "w");
      for (int i = 0; i < stoptime; i = i + 1) begin
        @(posedge clock);
        if (testbench.soc_comp.cpu_comp.execute_stage_comp.a.e.instr.op.cwren == 1) begin
          $fwrite(csr_file, "PERIOD = %t\t", $time);
          $fwrite(csr_file, "PC = %x\t",
                  testbench.soc_comp.cpu_comp.execute_stage_comp.a.e.instr.pc);
          $fwrite(csr_file, "WADDR = %x\t",
                  testbench.soc_comp.cpu_comp.execute_stage_comp.a.e.instr.caddr);
          $fwrite(csr_file, "WDATA = %x\n",
                  testbench.soc_comp.cpu_comp.execute_stage_comp.a.e.instr.cwdata);
        end
      end
      $fclose(csr_file);
    end
  end

  initial begin
    string filename;
    if ($value$plusargs("MEMFILE=%s", filename)) begin
      mem_file = $fopen(filename, "w");
      for (int i = 0; i < stoptime; i = i + 1) begin
        @(posedge clock);
        if (testbench.soc_comp.cpu_comp.execute_stage_comp.a.e.instr.op.store == 1) begin
          if (|testbench.soc_comp.cpu_comp.execute_stage_comp.a.e.instr.byteenable == 1) begin
            $fwrite(mem_file, "PERIOD = %t\t", $time);
            $fwrite(mem_file, "PC = %x\t",
                    testbench.soc_comp.cpu_comp.execute_stage_comp.a.e.instr.pc);
            $fwrite(mem_file, "WADDR = %x\t",
                    testbench.soc_comp.cpu_comp.execute_stage_comp.a.e.instr.address);
            $fwrite(mem_file, "WSTRB = %b\t",
                    testbench.soc_comp.cpu_comp.execute_stage_comp.a.e.instr.byteenable);
            $fwrite(mem_file, "WDATA = %x\n",
                    testbench.soc_comp.cpu_comp.execute_stage_comp.a.e.instr.sdata);
          end
        end
      end
      $fclose(mem_file);
    end
  end

  always_ff @(posedge clock) begin
    if (counter == stoptime) begin
      $finish;
    end else begin
      counter <= counter + 1;
    end
  end

  always_ff @(posedge clock) begin
    if (testbench.soc_comp.cpu_comp.fetch_stage_comp.dmem_in.mem_valid == 1) begin
      if (testbench.soc_comp.cpu_comp.fetch_stage_comp.dmem_in.mem_addr[31:2] == host[0][31:2]) begin
        if (|testbench.soc_comp.cpu_comp.fetch_stage_comp.dmem_in.mem_wstrb == 1) begin
          $display("%d", testbench.soc_comp.cpu_comp.fetch_stage_comp.dmem_in.mem_wdata);
          $finish;
        end
      end
    end
  end

  soc soc_comp (
      .reset(reset),
      .clock(clock),
      .clock_per(clock_per),
      .sclk(sclk),
      .mosi(mosi),
      .miso(miso),
      .ss(ss),
      .rx(rx),
      .tx(tx),
      .sram_ce_n(sram_ce_n),
      .sram_we_n(sram_we_n),
      .sram_oe_n(sram_oe_n),
      .sram_ub_n(sram_ub_n),
      .sram_lb_n(sram_lb_n),
      .sram_dq(sram_dq),
      .sram_addr(sram_addr)
  );

endmodule
