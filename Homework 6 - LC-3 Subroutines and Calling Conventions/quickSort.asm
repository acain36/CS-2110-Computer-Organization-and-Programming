;;=============================================================
;; CS 2110 - Fall 2021
;; Homework 6 - Quick Sort
;;=============================================================
;; Name:
;;============================================================

;; In this file, you must implement the 'quicksort' and 'partition' subroutines.

;; Little reminder from your friendly neighborhood 2110 TA staff: don't run
;; this directly by pressing 'RUN' in complx, since there is nothing put at
;; address x3000. Instead, load it and use 'Debug' -> 'Simulate
;; Subroutine Call' and choose the 'quicksort' or 'partition' label.


;; Pseudocode:

;; Partition

;;    partition(int[] arr, int low, int high) {
;;        int pivot = arr[high];
;;        int i = low - 1;
;;        for (j = low; j < high; j++) {
;;            if (arr[j] < pivot) {
;;                i++;
;;                int temp = arr[j];
;;                arr[j] = arr[i];
;;                arr[i] = temp;
;;            }
;;        }
;;        int temp = arr[high];
;;        arr[high] = arr[i + 1];
;;        arr[i + 1] = temp;
;;        return i + 1;
;;    }
        
;; Quicksort

;;    quicksort(int[] arr, int left, int right) {
;;        if (left < right) {
;;            int pi = partition(arr, left, right);
;;            quicksort(arr, left, pi - 1);
;;            quicksort(arr, pi + 1, right);
;;        }
;;    }


.orig x3000
    ;; you do not need to write anything here
HALT

partition   ;; please do not change the name of your subroutine
    ;; insert your implementation for partition subroutine

    ADD	R6, R6, -4; Allocate space rv,ra,fp,lv1
        STR	R7, R6, 2	; Save Ret Addr
        STR	R5, R6, 1	; Save Old FP
        ADD	R5, R6, 0	; Copy SP to FP
        ADD	R6, R6, -8; Make room for saved regs
        STR R0, R6, #4
        STR R1, R6, #5
        STR R2, R6, #6
        STR R3, R6, #7
        STR R4, R6, #8


        LDR R0, R5, #4 ; Array
        LDR R1, R5, #5 ; Low
        ADD R1, R1, #-1; = I
        STR R1, R5, #-1 ; stores i

        LDR R2, R5, #6 ; High
        ADD R0, R0, R2
        LDR R3, R0, #0 ; pivot = array[high]
        STR R3, R5, #0 ; stores pivot
        LDR R0, R5, #4

        LDR R4, R5, #5 ; J = low
        STR R4, R5, #-2 ; stores j


        ;; FOR LOOP

    FOR1
        LDR R2, R5, #6

        NOT R2, R2
        ADD R2, R2, #1

        ADD R4, R4, R2 ;; Low < High

        BRzp EFOR1
        NOT R2, R2
        ADD R2, R2, #1
        ADD R4, R4, R2  ;; restore values of J and High

        ;; if arr[j] < pivot
        ADD R0, R0, R4
        LDR R2, R0, #0 ; R2 = arr[j]
        LDR R0, R5, #4

        NOT R3, R3
        ADD R3, R3, #1

        ADD R2, R2, R3 ; Arr[j] < pivot

        BRzp EL1

        ;; THEN {
        LDR R2, R5, #6
        LDR R3, R5, #-3

         ADD R1, R1, #1 ; I++
         STR R1, R5, -1
         ADD R0, R0, R4
         LDR R2, R0, #0
         STR R2, R5, #-3           ; int temp = arr[j];
         ADD R0, R0, R4      ; arr[i]
         LDR R0, R0, #0
         STR R0, R2, #0       ;arr[j] = arr[i];
         LDR R0, R5, #4 ; restore R0 = Array
         ADD R0, R0, R1
         STR R3, R0, #0      ;arr[i] = temp;
         LDR R0, R5, #4 ; Restore R0 = Array
         ADD R0, R0, R2
         LDR R3, R0, #0 ; pivot = array[high]
         LDR R0, R5, #4



        LDR R2, R5, #6 ; Restore R2, high

        ADD R4, R4, #1 ;; J++
        BR FOR1
        ;; }

        ;; else go back through the FOR LOOP
        EL1
        LDR R2, R5, #6
        ADD R4, R4, #1 ;; J++
        BR FOR1


    ;; END of FOR LOOP
    EFOR1
        LDR R0, R5, #4
        LDR R2, R5, #6
        ADD R0, R0, R2
        LDR R3, R0, #0   ; int temp = arr[high];
        STR R3, R5, -3
        LDR R0, R5, #4
        ADD R1, R1, #1   ; I = I + 1

        ADD R0, R0, R1 ; arr [i + 1]
        LDR R4, R0, #0
        LDR R0, R5, #4
        ADD R0, R0, R2
        STR R4, R0, #0   ; arr[high] = arr[i + 1];
        LDR R0, R5, #4

        ADD R0, R0, R1
        STR R3, R0, #0
        STR R1, R5, #3





    ;;Stack Teardown

        LDR	R0, R6, 4; Restore R0
        LDR	R1, R6, 3; Restore R1
        LDR R2, R6, 2
        LDR R3, R6, 1
        LDR R4, R6, 0

        ADD	R6, R5, 0	; Restore SP
        LDR	R5, R6, 1	; Restore FP
        LDR	R7, R6, 2	; Restore RA
        ADD	R6, R6, 3	; Pop ra,fp,lv1



        RET

quicksort   ;; please do not change the name of your subroutine
    ;; insert your implementation for quicksort subroutine
    ADD	R6, R6, -4; Allocate space rv,ra,fp,lv1
        		STR	R7, R6, 2	; Save Ret Addr
        		STR	R5, R6, 1	; Save Old FP
        		ADD	R5, R6, 0	; Copy SP to FP
        		ADD	R6, R6, -5  ; Make room for saved regs
        		STR R0, R5, -1
        		STR R1, R5, -2
        		STR R2, R5, -3
        		STR R3, R5, -4
        		STR R4, R5, -5

    ;; main code
        LDR R0, R5, #4 ; Arr
        LDR R1, R5, #5 ; left
        LDR R2, R5, #6 ; right

        NOT R2, R2,
        ADD R2, R2, #1

        ADD R1, R1, R2

        BRzp ENDIF1

        NOT R2, R2,
        ADD R2, R2, #1 ; restore right back to positive
        ADD R1, R1, R2 ; restore R1 back to left

        ADD R6, R6, -3
        STR R0, R6, 0
        STR R1, R6, 1
        STR R2, R6, 2

        JSR partition
        LDR R3, R6, #0
        ADD R6, R6, #4

        ADD R3, R3, #-1
        ADD R6, R6, #-3
        STR R0, R6, 0 ; array
        STR R1, R6, 1 ; left
        STR R3, R6, 2; pi

        JSR quicksort


        ADD R6, R6, #1
        ADD R3, R3, #2

        STR R0, R6, 0 ; array
        STR R3, R6, 1 ; pi
        STR R2, R6, 2; right
        JSR quicksort









        ENDIF1
        ADD R6, R6, #4



    ;; tear down
        LDR R4, R5, -5
        LDR R3, R5, -4
        LDR R2, R5, -3
        LDR	R1, R5, -2; Restore R1
        LDR	R0, R5, -1; Restore R0
        ADD	R6, R5, 0	; Restore SP
        LDR	R5, R6, 1	; Restore FP
        LDR	R7, R6, 2	; Restore RA
        ADD	R6, R6, 3	; Pop ra,fp,lv1

        RET

STACK .fill xF000
.end


;; Assuming the array starts at address x4000, here's how the array [1,3,2,5] represents in memory
;; Memory address           Data
;; x4000                    1
;; x4001                    3
;; x4002                    2
;; x4003                    5
