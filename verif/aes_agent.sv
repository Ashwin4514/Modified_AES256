
`include "aes_sequencer.sv"
`include "aes_monitor.sv"
`include "aes_driver.sv"

class aes_agent extends uvm_agent;
    `uvm_component_utils(aes_agent);
    
    aes_driver driver;
    aes_sequencer sequencer;
    aes_monitor monitor;
  
    
    function new(string name = "aes_agent", uvm_component parent);
        super.new(name, parent);
    endfunction
    
    function void build_phase(uvm_phase phase);
      `uvm_info("DEBUG", "Entering aes_agent build_phase", UVM_LOW);
        super.build_phase(phase);
        driver = aes_driver::type_id::create("driver", this);
        monitor = aes_monitor::type_id::create("monitor" ,this);
      	sequencer = aes_sequencer::type_id::create("sequencer", this);
      `uvm_info("DEBUG", $sformatf("Driver: %b, Monitor: %b, Sequencer: %b", (driver != null), (monitor != null), (sequencer != null)), UVM_LOW)

    endfunction
    
    function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        driver.seq_item_port.connect(sequencer.seq_item_export);
    endfunction
    
    
endclass