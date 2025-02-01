class aes_scoreboard extends uvm_scoreboard;
    `uvm_component_utils(aes_scoreboard);
    
  uvm_analysis_imp #(aes_sequence_item, aes_scoreboard) analysis_port;
      // Declare a clocking block to sync with the DUT's clock
 
    function new(string name = "aes_scoreboard", uvm_component parent);
        super.new(name, parent);
        analysis_port = new("analysis_port", this);
    endfunction    
    
  virtual function write(aes_sequence_item tx);
        //Check if decryption output matches the encryption input(plaintext)  
    if (tx.data_out_dec != tx.data_in) begin
      `uvm_error("SCOREBOARD", $sformatf("Mismatch: enc_input= %h, dec_output=%h", tx.data_in, tx.data_out_dec));
        end else begin
          `uvm_info("SCOREBOARD", $sformatf("Match: enc_input=%h, dec_output=%h", tx.data_in, tx.data_out_dec), UVM_LOW);
        end
  endfunction
endclass