`timescale 1ns/1ns

module test;

   wire clk;
   reg rst_n;
 /*  reg alw_high_sig;

	 logic wr_val, wr_done;
	 logic [7:0] arb_gnt_vec;
	 */

 // reg start_event,
 logic ack,req,resp;

   // Check wr_val is not same as wr_done
   ovl_window u_chk_mutex_wr_valid( 
			     .clock     (clk),
			     .reset     (rst_n), 
			     .enable    (1'b1),
			     .test_expr (ack),
			     .start_event(req),
                             .end_event(resp)
			     );

   // simple signal check OVL 
/*   ovl_next u_ovl_next ( 
			     .clock     (clk),
			     .reset     (rst_n), 
			     .enable    (1'b1),
			     .test_expr (alw_high_sig)
			     );

   // use function
   ovl_next u_ovl_a_fn ( 
			     .clock     (clk),
			     .reset     (rst_n), 
			     .enable    (1'b1),
			     .test_expr ( ($countones (arb_gnt_vec) <= 1))
			     );
			     */

   initial begin
      // Dump waves
      $dumpfile("dump.vcd");
      $dumpvars(1, test);


 rst_n = 0;
 req = 0;
 ack = 0;
 resp = 0;
 #1 rst_n = 1;
 wait_clks(2);
 ack = 1;
 wait_clks(4);
 req =1;
 wait_clks(2);
 resp = 1;

 #1 rst_n = 1;
 wait_clks(4);
 ack =1;
 req = 0;
 wait_clks(2);
 resp=1;
//ack = 1;
//req = 1;


      wait_clks(10);

      #5000 $finish;
   end

   task wait_clks (input int num_clks = 1);
      repeat (num_clks) @(posedge clk);
   endtask : wait_clks

  ivl_uvm_ovl_clk_gen #(.FREQ_IN_MHZ(100)) u_clk_100 (clk);

endmodule


