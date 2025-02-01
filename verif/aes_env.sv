`include "aes_agent.sv"
`include "aes_scoreboard.sv"

class aes_env extends uvm_env;
    `uvm_component_utils(aes_env)
    
    aes_agent agent;
    aes_scoreboard sc;
    
    function new(string name = "aes_env", uvm_component parent);
        super.new(name, parent);
    endfunction
    
    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        //Instantiate components
        agent = aes_agent::type_id::create("agent", this);
        sc  = aes_scoreboard::type_id::create("sc", this);
      `uvm_info("DEBUG", $sformatf("Agent: %b, Sc: %b", (agent != null),(sc != null)), UVM_LOW)

    endfunction 
    
    virtual function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
      `uvm_info("DEBUG", "Entering aes_agent connect_phase", UVM_LOW);
        
      //Connect monitor's analysis port to scoreboard
        agent.monitor.ap.connect(sc.analysis_port);
    endfunction
 endclass
