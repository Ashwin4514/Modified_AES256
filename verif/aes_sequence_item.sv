class aes_sequence_item extends uvm_sequence_item;

  rand logic [255:0] key;
  rand logic [127:0] data_in;
  rand logic [255:0] sbox_seed;
  logic [127:0] data_out_enc;
  logic [127:0] data_out_dec;
  
  `uvm_object_utils(aes_sequence_item);


  function new(string name = "aes_sequence_item");
    super.new(name);
endfunction

endclass
