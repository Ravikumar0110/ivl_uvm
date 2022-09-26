`timescale 1ns/1ns

module test;

   wire clk;
   reg rst_n;
   reg data;
       
   // simple signal check OVL 
   ovl_never_unknown_async  u_ovl_never_unknown_async ( 
	  
			     .reset     (rst_n), 
			     .enable    (1'b1),
			     .test_expr (data)
			     );
   

   initial begin
      // Dump waves
      $dumpfile("dump.vcd");
      $dumpvars(1, test);

      // Initialize values.
      rst_n = 0;
       data = 1'b0;

      $display("ovl_never_unknown_async does not fire at rst_n");
      data =1'b0;
      wait_clks(5);

      rst_n = 1;
      wait_clks(5);
      $display("Out of reset");

      data = 1'b0;
      $display("ovl_one_never_unknown has fired: test_expr value is :%d",data);

      wait_clks(5);
     data = 1'b1;
     $display("ovl_one_never_unknown has fired: test_expr value is :%d",data);
  
     
     wait_clks(10);

      $finish;
   end

   task wait_clks (input int num_clks = 1);
      repeat (num_clks) @(posedge clk);
   endtask : wait_clks

  ivl_uvm_ovl_clk_gen #(.FREQ_IN_MHZ(100)) u_clk_100 (clk);

endmodule
