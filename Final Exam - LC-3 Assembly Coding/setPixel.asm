;;=============================================================
;; CS 2110 - Fall 2021
;; Final Exam - Set Pixel
;;=============================================================
;; Name: 
;;=============================================================

;; Pseudocode (see PDF for additional information)
;; 
;; offset = 0;
;; for (i = 0; i < ROW; i++) {
;;		offset += WIDTH;
;; }
;; offset += COL;
;; VIDEOBUFFER[offset] = COLOR

.orig x3000

;; YOUR CODE HERE
;; R0 = OFFSET
;; R1 = ROW
;; R2 = COL
;; R3 = WIDTH

AND R0, R0, #0
AND R1, R1, #0
AND R2, R2, #0
AND R3, R3, #0

LD R1, ROW
LD R2, COL
LD R3, WIDTH

;;Begin FOR_LOOP
;;R4 = i
AND R4, R4, #0

FOR_LOOP
    ADD R5, R1, R4      ;; R5 = ROW - i (exit iff nz)
    BRnz END_FOR
    
    ADD R0, R0, R3      ;; OFFSET = OFFSET + WIDTH
    ADD R4, R4, #-1     ;; i--
    BR FOR_LOOP

END_FOR

ADD R0, R0, R2          ;; OFFSET = OFFSET + COL

LEA R5, VIDEOBUFFER     ;; R5 = Mem_addr(VideoBuffer)
ADD R5, R5, R0          ;; R5 = VideoBuffer[OFFSET]
LD R1, COLOR            ;; R1 = COLOR 
STR R1, R5, #0          ;; VideoBuffer[OFFSET] = COLOR


HALT

COLOR .fill xFFFF
ROW .fill 1
COL .fill 1

HEIGHT .fill 2
WIDTH .fill 2

VIDEOBUFFER .fill x4000

.end

.orig x4000
    .fill 2
    .fill 1
    .fill 1
    .fill 0
.end