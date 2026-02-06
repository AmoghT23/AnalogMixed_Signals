//--------------------Design--------------------

module voltageDivider( 
  						input real vin,
  						output real vout);
  
  parameter real r1 = 10_000;
  parameter real r2 = 10_000;
  
  always @(*) begin
    vout = (vin * r2)/(r1+r2);
  end 
endmodule 

//--------------------Testbench--------------------

module voltageDivider_tb;

  real vin;
  real vout;
  real expected_vout;

  real r1 = 10_000;
  real r2 = 10_000;

  voltageDivider dut(.*);

  task check_voltage(input real vin_val);
    begin
      vin = vin_val;
      #1; 

      expected_vout = (vin * r2) / (r1 + r2);
		
      if ( $abs(vout - expected_vout) > 1e-6 ) begin
        $error("FAIL: vin=%f, vout=%f, expected=%f",
                vin, vout, expected_vout);
      end
      else begin
        $display("PASS: vin=%f, vout=%f", vin, vout);
      end
    end
  endtask

  initial begin
    repeat (100) begin
      check_voltage($urandom_range(0, 5000) / 1000.0);
    end
    $finish;
  end

endmodule
