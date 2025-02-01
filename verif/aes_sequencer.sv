class aes_sequencer extends uvm_sequencer#(aes_sequence_item);
    `uvm_component_utils(aes_sequencer)
  	
  	virtual dut_if vif; 
    
    function new(string name = "aes_sequencer", uvm_component parent);
        super.new(name, parent);
    endfunction
    
endclass