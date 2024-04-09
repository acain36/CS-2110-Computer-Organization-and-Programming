;;=============================================================
;; CS 2110 - Fall 2022
;; Homework 5 - fourCharacterStrings
;;=============================================================
;; Name: 
;;=============================================================


;; Pseudocode (see PDF for explanation)
;;
;; int count = 0;
;; int chars = 0;
;; int i = 0;
;;
;;  while(str[i] != '\0') {
;;      if (str[i] != ' ') 
;;          chars++;
;;      
;;      else {
;;          if (chars == 4) 
;;              count++;   
;;          chars = 0;
;;      }
;;      i++;
;;  }
;; ***IMPORTANT***
;; - Assume that all strings provided will end with a space (' ').
;; - Special characters do not have to be treated differently. For instance, strings like "it's" and "But," are considered 4 character strings.
;;

.orig x3000
	;; YOUR CODE HERE
	LD R0, STRING       ; R0 is address of first character (STRING)

	LD R1, SPACE        ; R1 is SPACE

	AND R2, R2, #0      ; R2 is the counter

	AND R3, R3, #0      ; R3 is the length of the words (chars)

	AND R4, R4, #0      ; R4 is i

WHILE_LOOP
    LDR R5, R0, #0      ; R5 is the address of the character
    BRz END_WHILE       ; End for loop if address is 0

    ADD R5, R5, R1      ; Add SPACE constant to current address
    BRz ELSE_STATEMENT

    ADD R3, R3, #1      ; chars++
    BR END_IF

ELSE_STATEMENT ADD R3, R3, #-4     ; if chars == 4, then R3 will be 0
    BRnp INNER_ELSE     ; if R3 is negative or positive, move to nested else

    ADD R2, R2, #1      ; count++

INNER_ELSE AND R3, R3, #0      ; Set chars to 0

END_IF
    ADD R4, R4, #1      ; i++
    ADD R0, R0, #1
    BR WHILE_LOOP

END_WHILE
    ST R2, ANSWER       ; Storing the count of the number of 4 letter words

	HALT


SPACE 	.fill #-32
STRING	.fill x4000
ANSWER .blkw 1

.end


.orig x4000

.stringz "I love CS 2110 and assembly is very fun! "

.end
