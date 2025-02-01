class aes_test extends uvm_test;
    `uvm_component_utils(aes_test)
    aes_env env;
    aes_sequence seq;
    
  function new(string name = "aes_test", uvm_component parent = null);
    super.new(name, parent);
    endfunction
    
    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        
        env = aes_env::type_id::create("env", this);
        seq = aes_sequence::type_id::create("seq", this);
        
    endfunction
    
    virtual function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
    endfunction
  
     virtual function void end_of_elaboration();
      //print's the topology
      print();
    endfunction
  
    task run_phase(uvm_phase phase);
      	uvm_root uvm_root_hdl = uvm_root::get();
      	seq.start(env.agent.sequencer);
      	#50;
        `uvm_info("AEST_TEST", "AES Test Completed", UVM_LOW);
    endtask
endclass
