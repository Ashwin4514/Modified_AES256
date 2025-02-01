
class aes_driver extends uvm_driver#(aes_sequence_item);
  
  virtual dut_if dut_intf;
  `uvm_component_utils(aes_driver)
    
  function new(string name = "driver", uvm_component parent);
        super.new(name,parent);
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if(!uvm_config_db#(virtual dut_if)::get(this, "", "vif", dut_intf)) begin
        `uvm_fatal("AES Driver", "Virtual Interface is not set in uvm_config_db")
    end
  endfunction
  
 virtual task run_phase(uvm_phase phase);
  forever begin
    `uvm_info("DRIVER", $sformatf("Wait for item from sequencer."), UVM_LOW)
    seq_item_port.get_next_item(req);
    `uvm_info("DRIVER",  $sformatf("Driving the Request."), UVM_LOW)
    //Driving inputs with proper clock sync.
    @(posedge dut_intf.clk);
     dut_intf.key <= req.key;
     dut_intf.data_in <= req.data_in;
     dut_intf.sbox_seed <= req.sbox_seed;
    `uvm_info("DRIVER",  $sformatf("Added Request.Will wait for DUT Response"), UVM_LOW)
    @(posedge dut_intf.clk); //Wait for a clock cycle.
     req.data_out_dec = dut_intf.data_out_dec;
     req.data_out_enc = dut_intf.data_out_enc;
     
   	seq_item_port.item_done();
    `uvm_info("DRIVER", $sformatf("Finished Driving the Sequence. Moving to next one."), UVM_LOW);

  	end 
 endtask  
endclass
