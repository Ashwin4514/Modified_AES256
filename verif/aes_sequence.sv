class aes_sequence extends uvm_sequence#(aes_sequence_item);
    
  `uvm_object_utils(aes_sequence);
  
  function new(string name = "aes_sequence");
    super.new(name);
  endfunction
  
  virtual task body();
    repeat(10) begin
      req = aes_sequence_item::type_id::create("req");
      `uvm_info("Sequencer", $sformatf("Starting item in Sequence."), UVM_LOW)
      start_item(req);
      req.randomize();
      `uvm_info("AES_SEQUENCE", $sformatf("Key: %h, Data_in: %h, Seed: %h, Data_enC: %h, Data_deC: %h", req.key, req.data_in, req.sbox_seed, req.data_out_enc, req.data_out_dec), UVM_LOW)

      `uvm_info("Sequence", $sformatf("Generating a New Item."), UVM_LOW)
      finish_item(req);
    end
  endtask
  
endclass