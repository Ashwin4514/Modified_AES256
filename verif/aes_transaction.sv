class aes_transaction extends uvm_sequence_item;
    `uvm_object_utils(aes_transaction);
    
    logic [127:0] enc_input, dec_output;
    
  function new(string name = "aes_transaction");
    super.new(name);
  endfunction
    
  function string covert2string();
    return $sformatf("enc_input: %h, dec_output: %h", enc_input, dec_output);
  endfunction
endclass