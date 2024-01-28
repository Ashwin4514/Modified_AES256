# Modified_AES256
A different approach than just using Rinjdahl's sbox values using Verilog.
Used smaller LFSRs which is a part of the Cryptographic Pseudo Random Generators.
Advantages over sbox values?
 -> Provides more randomness.
 -> Instead of a limited LUT, we can generate random numbers every time.
 -> Safer as it is unpredictable like key generation.

Encryption:
![encrypt_sim](https://github.com/Ashwin4514/Modified_AES256/assets/64789016/f32c0715-64ff-4640-9a7f-c610c3188454)

Decryption:
![decrypt_sim](https://github.com/Ashwin4514/Modified_AES256/assets/64789016/5cf77d06-7f4c-4051-80ff-bebdc6daefe3)


