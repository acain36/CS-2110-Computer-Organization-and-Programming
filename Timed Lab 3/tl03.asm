;; TLDR Linked List Structure:
;;
;; For this Timed Lab, you are given a doubly-linked list and you need to check
;; if its data is a palindrome ignoring case.
;; Each node in the doubly-linked list is represented by three consecutive words in memory.
;; Each node has data, the address of the previous node, and the address of the next node.
;;
;; Given the address `node`, you can do
;; * `mem[node]` to get the data
;; * `mem[node + 1]` to get the address of the previous node
;; * `mem[node + 2]` to get the address of the next node

; Data for the one test
.orig x6000
        .fill 'a'
        .fill x0000
        .fill x4000
.end

.orig x4000
        .fill 'b'
        .fill x6000
        .fill x5000
.end

.orig x5000
        .fill 'A'
        .fill x4000
        .fill x0000
.end

.orig x3000

    ; One test is at the bottom of this file
    BR test_start


;; to_lowercase function
;; Parameter c: Character encoded in ASCII
;; Returns: Lowercase version of c if it's in the range 'A' to 'Z'; otherwise
;;          just c unchanged
;;
;; Examples:
;; * to_lowercase('a') == 'a'
;; * to_lowercase('A') == 'a'
;; * to_lowercase('5') == '5'

to_lowercase
.fill x1dba
.fill x7f84
.fill x7b83
.fill x1ba2
.fill x7180
.fill x7381
.fill x6344
.fill x2015
.fill x1040
.fill x080c
.fill x2013
.fill x1040
.fill x0209
.fill x2011
.fill x1040
.fill x7143
.fill x6180
.fill x6381
.fill x1d63
.fill x6f42
.fill x6b41
.fill xc1c0
.fill x7343
.fill x6180
.fill x6381
.fill x1d63
.fill x6f42
.fill x6b41
.fill xc1c0
.fill xffbf
.fill xffa6
.fill x0020


;; This function takes in two nodes from the doubly-linked list as input. It
;; outputs whether they contain equal data ignoring case. Note that case is
;; ignored. All the characters should be taken to lowercase before comparing
;; them.
;;
;; Parameter node1: The address of a node in the doubly-linked list
;; Parameter node2: The address of a node in the doubly-linked list
;; Returns: 1 if both nodes have the same data ignoring case, 0 otherwise
;;
;; Examples:
;; * are_letters_equal on node1 containing 'A' and node2 containing 'A' returns 1
;; * are_letters_equal on node1 containing 'A' and node2 containing 'a' returns 1
;; * are_letters_equal on node1 containing '5' and node2 containing '6' returns 0
;;
;; Pseudocode:
;; // (Checkpoint 1)
;; are_letters_equal(Node node1 (address), Node node2 (address)) {
;;      char letter1 = mem[node1];
;;      char letter2 = mem[node2];
;;
;;      letter1 = to_lowercase(letter1);
;;      letter2 = to_lowercase(letter2);
;;
;;      if (letter1 == letter2) {
;;          return 1;
;;      } else {
;;          return 0;
;;      }
;; }

are_letters_equal

    ;; BUILD STACK

    ADD R6, R6, #-4
    STR R5, R6, #1
    STR R7, R6, #2
    ADD R5, R6, #0
    ADD R6, R6, #-6
    STR R4, R6, #0
    STR R3, R6, #1
    STR R2, R6, #2
    STR R1, R6, #3
    STR R0, R6, #4

    ;; FUNCTION

    ;;      char letter1 = mem[node1];
    ;;      char letter2 = mem[node2];

    LDR R0, R5, #4      ; R0 = node1_address
    LDR R0, R0, #0      ; R0 = node1.data

    LDR R1, R5, #5      ; R1 = node2_address
    LDR R1, R1, #0      ; R1 = node2.data

    ;;      letter1 = to_lowercase(letter1);
    ;;      letter2 = to_lowercase(letter2);

    ADD R6, R6, #-1     ; Room for arg (node1.data)
    STR R0, R6, #0      ; Push arg
    JSR to_lowercase    ; Call subroutine
    LDR R0, R6, #0      ; R0 = to_lowercase(node1.data)
    ADD R6, R6, #2      ; Pop off values
    STR R0, R5, #0      ; Save R0 as a local variable (R5[0] -> to_lowercase(node1.data))

    ADD R6, R6, #-1     ; Room for arg (node2.data)
    STR R1, R6, #0      ; Push arg
    JSR to_lowercase    ; Call subroutine
    LDR R1, R6, #0      ; R1 = to_lowercase(node2.data)
    ADD R6, R6, #2      ; Pop off values
    STR R1, R5, #-1     ; Save R0 as a local variable (R5[-1] -> to_lowercase(node2.data))

    ;;      if (letter1 == letter2) {
    ;;          return 1;
    ;;      } else {
    ;;          return 0;
    ;;      }
    ;; }

    AND R2, R2, 0       ; R2 = return value = 0
    NOT R1, R1
    ADD R1, R1, #1      ; R1 = ~(to_lowercase(node2.data))
    ADD R1, R1, R0      ; R1 = to_lowercase(node1.data) + -(to_lowercase(node2.data))
    BRz IF_EQUAL
    BR END_IF
IF_EQUAL
    ADD R2, R2, #1      ; R2 = return value = 1
END_IF
    STR R2, R5, #3      ; R5[3] -> R2=returnValue

    ;; STACK TEARDOWN

    LDR R0, R6, #4
    LDR R1, R6, #3
    LDR R2, R6, #2
    LDR R3, R6, #1
    LDR R4, R6, #0
    ADD R6, R5, #0
    LDR R5, R6, #1
    LDR R7, R6, #2
    ADD R6, R6, #3

    RET

;; Takes in both the head and tail addresses for a doubly-linked list, and
;; returns whether the data contained inside is a palindrome ignoring case. Note
;; that case is ignored. All the characters should be taken to lowercase before
;; comparing them.
;;
;;
;; Parameter head: The address of the first node in the doubly-linked list
;; Parameter tail: The address of the last node in the doubly-linked list
;; Returns: 1 if the list's data represents a palindrome ignoring case; 0
;;          otherwise
;;
;; Examples:
;; * is_palindrome on "aba" returns 1
;; * is_palindrome on "abA" returns 1
;; * is_palindrome on "abba" returns 1
;; * is_palindrome on "ab!" returns 0
;; * is_palindrome on "Happy Birthday!" returns 0
;;
;; Pseudocode:
;; is_palindrome(Node head (address), Node tail (address)) {
;;      // (Checkpoint 2 - Base Case)
;;      if (head == 0 || tail == 0) {
;;          return 1;
;;      }
;;
;;      if (are_letters_equal(head, tail) == 0) {
;;          return 0;
;;      }
;;
;;      // (Checkpoint 3 - Recursion)
;;      Node new_head = mem[head + 2];
;;      Node new_tail = mem[tail + 1];
;;
;;      return is_palindrome(new_head, new_tail);
;; }

is_palindrome

    ;; BUILD STACK

    ADD R6, R6, #-4
    STR R5, R6, #1
    STR R7, R6, #2
    ADD R5, R6, #0
    ADD R6, R6, #-6
    STR R4, R6, #0
    STR R3, R6, #1
    STR R2, R6, #2
    STR R1, R6, #3
    STR R0, R6, #4

    ;; FUNCTION

    ;; CHECKPOINT 2

    ;;      if (head == 0 || tail == 0) {
    ;;          return 1;
    ;;      }
    ;;
    ;;      if (are_letters_equal(head, tail) == 0) {
    ;;          return 0;
    ;;      }

    LDR R0, R5, #4      ; R0 = head_address
    STR R0, R5, #0      ; R5[0] -> R0=head_address
    ADD R0, R0, #0
    BRz EQUALS_ZERO     ; R0 == 0

    LDR R1, R5, #5      ; R1 = tail_address
    STR R1, R5, #-1     ; R5[-1] -> R1=tail_address
    ADD R1, R1, #0
    BRz EQUALS_ZERO     ; R1 == 0
    BR IF_2

EQUALS_ZERO
    AND R2, R2, #0
    ADD R2, R2, #1      ; R2 = 1 = returnValue
    BR END_FUNCTION

IF_2
    LDR R3, R5, #4      ; R0 = head.data
    LDR R4, R5, #5      ; R1 = tail.data
    ADD R6, R6, #-2     ; Room for two arguments
    STR R3, R6, #0      ; R6[0] -> head.data
    STR R4, R6, #1      ; R6[1] -> tail.data

    JSR are_letters_equal

    AND R2, R2, #0
    LDR R2, R6, #0      ; R2 = are_letters_equal(head.data, tail.data)
    ADD R6, R6, #3      ; Pop off arguments
    ADD R2, R2, #0
    BRz END_FUNCTION    ; If R2 = 0, then return
    BR ELSE_STATEMENT   ; If R2 != 0, then go to else statement for recursion

    ;; CHECKPOINT 3


ELSE_STATEMENT

    ;;      Node new_head = mem[head + 2];
    ;;      Node new_tail = mem[tail + 1];

    LDR R0, R5, #0      ; R0 = head_address
    ADD R0, R0, #2      ; R0 = head_address + 2
    LDR R0, R0, #0      ; R0 = mem[head_address + 2]

    LDR R1, R5, #-1     ; R1 = tail_address
    ADD R1, R1, #1      ; R1 = tail_address + 1
    LDR R1, R1, #0      ; R1 = mem[tail_address + 1]

    ;;      return is_palindrome(new_head, new_tail);

    ADD R6, R6, #-2     ; Room for two arguments
    STR R0, R6, #0      ; R6[0] -> R0=mem[head_address + 2]
    STR R1, R6, #1      ; R6[1] -> R1=mem[tail + 1]

    JSR is_palindrome

    LDR R2, R6, #0      ; R2 = is_palindrome(new_head, new_tail)
;; POTENTIALLY RETURN TO BEGINNING OF FIRST IF!!

    ADD R6, R6, #3      ; Pop off old arguments
    BR END_FUNCTION

END_FUNCTION
    STR R2, R5, #3      ; R5[3] -> R2=returnValue

    ;; STACK TEARDOWN

    LDR R0, R6, #4
    LDR R1, R6, #3
    LDR R2, R6, #2
    LDR R3, R6, #1
    LDR R4, R6, #0
    ADD R6, R5, #0
    LDR R5, R6, #1
    LDR R7, R6, #2
    ADD R6, R6, #3

    RET


; Helper code that runs one test
test_start

    ; Set up the stack
    LD R6, initial_r6

    ; Place arguments on the stack
    LD R0, head_addr
    LD R1, tail_addr
    ADD R6, R6, -2
    STR R0, R6, 0
    STR R1, R6, 1

    ; Set all the other registers to notable values
    ; Done to ease debugging
    LD R0, initial_r0
    LD R1, initial_r1
    LD R2, initial_r2
    LD R3, initial_r3
    LD R4, initial_r4
    LD R5, initial_r5
    LD R7, initial_r7

    ; Call the function
    ; Pop off return value and arguments
    JSR is_palindrome
    ADD R6, R6, 3

    HALT

; Easy to recognize initial values for registers
; Chosen to ease debugging
initial_r0 .fill xDEAD
initial_r1 .fill xBEEF
initial_r2 .fill x2110
initial_r3 .fill x2200
initial_r4 .fill x4290
initial_r5 .fill xCAFE
initial_r6 .fill xF000
initial_r7 .fill x8000

; Arguments to pass to the subroutine
head_addr .fill x6000
tail_addr .fill x5000

.end
