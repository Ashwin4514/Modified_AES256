`include "aes_transaction.sv"

class aes_monitor extends uvm_monitor;
    
    virtual dut_if mif;
    aes_sequence_item tx;
    
  uvm_analysis_port #(aes_sequence_item) ap;
    `uvm_component_utils(aes_monitor)
    
    function new(string name = "aes_monitor", uvm_component parent);
        super.new(name, parent);
      ap = new("ap", this);
    endfunction
    
    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        tx = aes_sequence_item::type_id::create("tx", this);
        if (!uvm_config_db#(virtual dut_if)::get(this, "", "vif", mif)) begin
            `uvm_fatal("Monitor", "Virtual Interface not set in monitor.")
        end
    endfunction
    
    virtual task run_phase(uvm_phase phase);
      forever begin
        @(posedge mif.clk);
        tx.key = mif.cb_mon.key;
        tx.data_in = mif.cb_mon.data_in;
        tx.sbox_seed = mif.cb_mon.sbox_seed;
        tx.data_out_enc = mif.cb_mon.data_out_enc;
        tx.data_out_dec = mif.cb_mon.data_out_dec;
        
        `uvm_info("AES_MONITOR", $sformatf("Captured -> Key: %h, Data_in: %h, Seed: %h, Enc_out: %h, Dec_out: %h",tx.key, tx.data_in, tx.sbox_seed, tx.data_out_enc, tx.data_out_dec), UVM_LOW);
        //Send to the scoreboard
        ap.write(tx);
      end
    endtask
        
endclass
