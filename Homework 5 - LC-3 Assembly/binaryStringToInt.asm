;;=============================================================
;; CS 2110 - Fall 2022
;; Homework 5 - binaryStringToInt
;;=============================================================
;; Name: 
;;=============================================================

;; Pseudocode (see PDF for explanation)
;;
;;    int result = x4000; (given memory address to save the converted value)
;;    String binaryString= "01000000"; (given binary string)
;;    int length = 8; (given length of the above binary string)
;;    int base = 1;
;;    int value = 0;
;;    while (length > 0) {
;;        int y = binaryString.charAt(length - 1) - 48;
;;        if (y == 1) {
;;            value += base;
;;        }     
;;            base += base;
;;            length--;
;;    }
;;    mem[result] = value;
.orig x3000

    LD R0, length           ; R0 is length

    LD R1, binaryString
    ADD R1, R1, R0
    ADD R1, R1, #-1         ; R1 is the address for the first character

    AND R2, R2, #0
    ADD R2, R2, #1          ; R2 is the Base

    AND R3, R3, #0          ; R3 is the Result

    AND R4, R4, #0          ; R4 is the value

WHILE_LOOP
    ADD R0, R0, #0
    BRnz END_WHILE          ; Ends when length is 0 or negative

    LDR R4, R1, #0          ; Setting the Value to the character

    ADD R4, R4, #-12
    ADD R4, R4, #-12
    ADD R4, R4, #-12
    ADD R4, R4, #-12

    BRnz OP_0               ; When the value is negative or 0

    ADD R3, R3, R2          ; When the value is 1

    OP_0 ADD R2, R2, R2     ; Increasing the base, decreasing length and address
    ADD R0, R0, #-1
    ADD R1, R1, #-1

    BR WHILE_LOOP

END_WHILE
    LD R2, result           ; Storing result to memory
    STR R3, R2, #0

    HALT

    binaryString .fill x5000
    length .fill 8
    result .fill x4000
.end 

.orig x5000
    .stringz "010010100"
.end
