# AES-256 Modification with Dynamic SBox and Custom PRNG

## **Overview**

This project implements a modified version of the AES-256 encryption algorithm. The enhancements include a dynamic SBox substitution mechanism powered by a ChaCha20-based pseudo-random number generator (PRNG) and flexible parameterization to explore new cryptographic techniques. This implementation provides a balance between strong encryption and a modular design for customization and experimentation.

---

## **Key Features**

### **Dynamic SBox Substitution**

- Utilizes a ChaCha20-based PRNG to dynamically generate constants for SBox substitution.
- Enhances security by introducing round-dependent randomness to the substitution process.
- Increases resilience against attacks targeting static substitution tables.

### **Modified AES-256 Workflow**

- Retains the core AES structure with 14 rounds of transformations.
- Includes:
  - **AddRoundKey**: XORs the state with round-specific keys.
  - **Dynamic SBox Substitution**: Replaces static SBoxes with PRNG-generated transformations.
  - **ShiftRows**: Circular byte shifts for diffusion.
  - **MixColumns**: Multiplication in GF(2^8) for further diffusion.

### **ChaCha20-based PRNG**

- Generates pseudo-random values for SBox transformations.
- Incorporates a 256-bit seed and round-dependent input to ensure unique outputs for each encryption round.

### **Flexible Design**

- Parameterized for easy experimentation with:
  - Number of rounds (default: 14).
  - Key size (default: 256 bits).
  - Custom PRNG integration.

### **Comprehensive Decryption Path**

- Implements inverse transformations:
  - **InverseShiftRows**: Reverses the byte shifts.
  - **InverseSubBytes**: Uses PRNG outputs to reverse dynamic SBox transformations.
  - **InverseMixColumns**: Undoes column mixing.

---

## **Architecture**

The system is designed using modular Verilog code, with each AES transformation encapsulated in its module:

- **Encryption Path**: Implements the full encryption process.
- **Decryption Path**: Mirrors the encryption process using inverse transformations.
- **Key Expansion Module**: Generates round keys for all transformations.
- **PRNG Module**: Dynamically generates round-specific constants.

---

## **Code Highlights**

- **Encryption Module:**
  - Chains all AES rounds with dynamic SBox substitutions.
  - Displays intermediate states for debugging and verification.
- **Decryption Module:**
  - Applies transformations in reverse order for seamless recovery of plaintext.
- **PRNG:**
  - ChaCha20-inspired generator ensures reproducible randomness for cryptographic strength.

---

## **Usage**

### **Encryption Example**

![encrypt_sim](https://github.com/user-attachments/assets/d624c266-a51d-421a-9031-627547b195d6)


### **Decryption Example**

![decrypt_sim](https://github.com/user-attachments/assets/75bc943f-b043-4242-b84f-8b4a9930db63)


## **Future Enhancements**

- Integration of additional dynamic transformations for increased complexity.
- Optimizations for FPGA and ASIC implementations.
- Exploration of hybrid cryptographic techniques by combining AES with other ciphers.

---

## **Getting Started**

1. Clone the repository.
2. Simulate the design using a Verilog simulator (e.g., ModelSim, Vivado).
3. Use the provided basic test benches provided to encrypt and decrypt.

---

## **Contributions**

We welcome contributions to:

- Improve the modularity of the code.
- Enhance the randomness mechanisms.
- Test the implementation against known cryptographic attacks.

---

## **Acknowledgments**

Inspired by the principles of AES and ChaCha20, this project combines the strengths of both algorithms to push the boundaries of cryptographic design.

---

## **License**

This project is licensed under the MIT License. You may use and modify it for your own purposes.

