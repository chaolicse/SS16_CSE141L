###############################################################################
#
# Primitive MIPS processor test bench
#
#  Change Log:
#     6/27/2016 - Chao (Jack) Li - Initial Implementation
#
 
   .data

   .globl   __start

   .text
__start:
   beq      $zero, $zero, JUMP_FORWARD
   sll      $zero, $zero, 0                  # NOP

CHECK_ANSWER:
   sub      $t0, $a0, $a1
   beq      $zero, $t0, PASS
   sll      $zero, $zero, 0
   add      $t0, $zero, $a0               # store actual value to $t0
   add      $t1, $zero, $a1               # store expected value to $t1
   j        FAIL
   sll      $zero, $zero, 0
PASS:
   jr       $ra
   sll      $zero, $zero, 0

JUMP_BACK:
   beq      $zero, $zero, MAIN
   sll      $zero, $zero, 0

JUMP_FORWARD:
   beq      $zero, $zero, JUMP_BACK
   sll      $zero, $zero, 0

MAIN:

   ## ADDI 
   addi     $a0, $zero, 10
   addi     $a1, $zero, 10
   jal      CHECK_ANSWER         ## test: ADDI
   sll      $zero, $zero, 0
   addi     $s3, $s3, 1                

   ## ADDIU 
   addiu    $a0, $zero, -10
   addiu    $a1, $zero, -10
   jal      CHECK_ANSWER         ## test: ADDIU
   sll      $zero, $zero, 0
   addi     $s3, $s3, 1

   ## ADD
   addiu    $t0, $zero, 5
   addiu    $t1, $zero, 6
   add      $a0, $t0, $t1
   addiu    $a1, $zero, 11       
   jal      CHECK_ANSWER         ## test : ADD
   sll      $zero, $zero, 0
   addi     $s3, $s3, 1

   ## Only difference between sub and subu is that sub will trap on overflow,
   ## treating the operands as signed integers.  subu will produce exactly the
   ## same result, but will not trap.

   ## SUB
   addiu    $t0, $zero, 5
   addiu    $t1, $zero, 6
   sub      $a0, $t0, $t1
   addi     $a1, $zero, -1
   jal      CHECK_ANSWER          ## test : SUB
   sll      $zero, $zero, 0
   addiu    $s3, $s3, 1
   
   ## SUBU
   addi     $t0, $zero, -10
   addi     $t1, $zero, -10
   sub      $a0, $t0, $t1
   addi     $a1, $zero, 0
   jal      CHECK_ANSWER          ## test : SUBU
   sll      $zero, $zero, 0
   addiu    $s3, $s3, 1

   ## SLL
   #     skip this if your sll actions only as a nop
   j        SKIP_SLL
   sll      $zero, $zero, 0
   addi     $t0, $zero, 1
   sll      $t1, $t0, 31
   sll      $t2, $t0, 31
   sub      $a0, $t1, $t2
   addi     $a1, $zero, 0
   jal      CHECK_ANSWER         ## test : SLL
   sll      $zero, $zero, 0 
   addiu    $s3, $s3, 1  

SKIP_SLL:

   ## AND
   addiu    $t0, $zero, 0x00FF
   addiu    $t1, $zero, 0x0F0F
   and      $a0, $t0, $t1
   addiu    $a1, $zero, 0x000F
   jal      CHECK_ANSWER         ## test : AND
   sll      $zero, $zero, 0
   addi     $s3, $s3, 1

   ## ANDI
   addiu    $t0, $zero, 0x00FF
   andi     $a0, $t0, 0x0F0F
   addiu    $a1, $zero, 0x000F
   jal      CHECK_ANSWER         ## test : ANDI
   sll      $zero, $zero, 0
   addi     $s3, $s3, 1

   ## OR
   addiu    $t0, $zero, 0x00FF
   addiu    $t1, $zero, 0x0F0F
   or       $a0, $t0, $t1
   addiu    $a1, $zero, 0x0FFF
   jal      CHECK_ANSWER         ## test : OR
   sll      $zero, $zero, 0
   addi     $s3, $s3, 1
   
   ## ORI
   addiu    $t0, $zero, 0x00FF
   ori      $a0, $t0, 0x0F0F
   addiu    $a1, $zero, 0x0FFF
   jal      CHECK_ANSWER         ## test : ORI
   sll      $zero, $zero, 0
   addi     $s3, $s3, 1

   ## NOR
   #     skip this if you do not have sll implemented
   j        SKIP_NOR
   sll      $zero, $zero, 0
   ori      $t1, $zero, 0x00FF
   ori      $t2, $zero, 0x0F0F
   nor      $a0, $t1, $t2
   ori      $t0, $zero, 0xFFFF
   sll      $a1, $t0, 16
   ori      $a1, $a1, 0xF000
   jal      CHECK_ANSWER         ## test : NOR
   sll      $zero, $zero, 0
   addi     $s0, $s0, 1

SKIP_NOR:

   ## XOR
   addiu    $t0, $zero, 0x00FF
   addiu    $t1, $zero, 0x0F0F
   xor      $a0, $t0, $t1
   addiu    $a1, $zero, 0x0FF0
   jal      CHECK_ANSWER            ## test : XOR
   sll      $zero, $zero, 0
   addi     $s3, $s3, 1

   ## XORI
   addiu    $t0, $zero, 0x00FF
   xori     $a0, $t0, 0x0F0F
   addiu    $a1, $zero, 0x0FF0
   jal      CHECK_ANSWER            ## test : XOR
   sll      $zero, $zero, 0
   addi     $s3, $s3, 1

###############################################################################
###############################################################################
###############################################################################
   addi     $t0, $zero, 1
   bne      $t0, $zero, BNE_PASS    ## test : bne
   sll      $zero, $zero, 0
   j        FAIL
   sll      $zero, $zero, 0 
BNE_PASS:
   addi     $s3, $s3, 1
   
   addi     $t0, $zero, -1
   bltz     $t0, BLTZ_PASS          ## test : bltz
   sll      $zero, $zero, 0
   j        FAIL
   sll      $zero, $zero, 0
BLTZ_PASS:
   addi     $s3, $s3, 1

   addi     $t0, $zero, 1
   bgtz     $t0, BGTZ_PASS          ## test : bgtz
   sll      $zero, $zero, 0
   j        FAIL
   sll      $zero, $zero, 0
BGTZ_PASS:
   addi     $s3, $s3, 1

   bgez     $zero, BGEZ_PASS1       ## test  part 1: bgez
   sll      $zero, $zero, 0
   j        FAIL
   sll      $zero, $zero, 0
BGEZ_PASS1:

   addi     $t0, $zero, 1
   bgez     $t0, BGEZ_PASS2         ## test  part 2: bgez
   sll      $zero, $zero, 0
   j        FAIL   
   sll      $zero, $zero, 0
BGEZ_PASS2:
   addi     $s3, $s3, 1
   
   addi     $t0, $zero, 0
   blez     $t0, BLEZ_PASS1         ## test  part 1: blez
   sll      $zero, $zero, 0
   j        FAIL
   sll      $zero, $zero, 0
BLEZ_PASS1:

   addi     $t0, $zero, -1
   blez     $t0, BLEZ_PASS2         ## test  part 2: blez
   sll      $zero, $zero, 0
   j        FAIL
   sll      $zero, $zero, 0
BLEZ_PASS2:
   addi     $s3, $s3, 1


###############################################################################
###############################################################################
###############################################################################

   ## 1 < 2 ==> 1
   addi     $t0, $zero, 1
   addi     $t1, $zero, 2
   slt      $t2, $t0, $t1              ## test  part 1: slt
   bne      $t2, $zero, STL_PASS1
   sll      $zero, $zero, 0
   j        FAIL
   sll      $zero, $zero, 0
STL_PASS1:
   ## 2 < 1
   slt      $t2, $t1, $t0              ## test  part 2: slt
   beq      $t2, $zero, STL_PASS2
   sll      $zero, $zero, 0
   j        FAIL
   sll      $zero, $zero, 0
STL_PASS2:
   addi     $s3, $s3, 1


   ## 1 < 2 ==> 1
   addi     $t0, $zero, 1
   addi     $t1, $zero, 2
   sltu     $t2, $t0, $t1              ## test  part 1: sltu
   bne      $t2, $zero, STLU_PASS1
   sll      $zero, $zero, 0
   j        FAIL
   sll      $zero, $zero, 0
STLU_PASS1:
   ## 2 < 1
   sltu     $t2, $t1, $t0              ## test  part 2: sltu
   beq      $t2, $zero, STLU_PASS2
   sll      $zero, $zero, 0
   j        FAIL
   sll      $zero, $zero, 0
STLU_PASS2:
   addi     $s3, $s3, 1



###############################################################################
###############################################################################
###############################################################################

   j        JALR_FORWARD
   sll      $zero, $zero, 0

JALR_BACK:
   jr       $ra
   sll      $zero, $zero, 0

JALR_FORWARD:
   jalr     JALR_BACK
   sll      $zero, $zero, 0
   addi     $s3, $s3, 1


###############################################################################
###############################################################################
###############################################################################

   addiu    $t0, $zero, 0x4000
   sub      $s0, $0, $t0
   sub      $s0, $s0, $t0    # $s0 should now contain 0xffffc000
   sub      $s0, $s0, $t0    # $s0 should now contain 0xffff8000
   sub      $s0, $s0, $t0    # $s0 should now contain 0xffff0000

   addi     $s1, $0,0x4000
   add      $s1, $s1, $s1    #0x08000
   add      $s1, $s1, $s1    #0x10000
   add      $s1, $s1, $s1    #0x20000
   add      $s1, $s1, $s1    #0x40000
   add      $s1, $s1, $s1    #0x80000
   add      $s1, $s1, $s1    #0x100000
   add      $s1, $s1, $s1    #0x200000
   add      $s1, $s1, $s1    #0x400000
   add      $s1, $s1, $s1    #0x800000
   add      $s1, $s1, $s1    #0x1000000
   add      $s1, $s1, $s1    #0x2000000
   add      $s1, $s1, $s1    #0x4000000
   add      $s1, $s1, $s1    #0x8000000
   add      $s1, $s1, $s1    #0x10000000


   addi     $t0, $0,0x48      
   sw       $t0, 0($s1)       # 'H' store word
   addi     $t1, $0,0x65      
   sw       $t1, 4($s1)       # 'e' store word
   addi     $t2, $0,0x6C      
   sw       $t2, 8($s1)       # 'l' store word
   sw       $t2, 12($s1)      # 'l' store word
   addi     $t3, $0,0x6F      
   sw       $t3, 16($s1)      # 'o'store word

   lw       $t4, 0($s1)       # 'e' load word
   sll      $zero, $zero, 0
   bne      $t4, $t0, FAIL
   sll      $zero, $zero, 0
   lw       $t4, 4($s1)       # 'e' load word
   sll      $zero, $zero, 0
   bne      $t4, $t1, FAIL
   sll      $zero, $zero, 0
   lw       $t4, 8($s1)       # 'l' load word
   sll      $zero, $zero, 0
   bne      $t4, $t2, FAIL
   sll      $zero, $zero, 0
   lw       $t4, 12($s1)      # 'l' load word
   sll      $zero, $zero, 0
   bne      $t4, $t2, FAIL
   sll      $zero, $zero, 0
   lw       $t4, 16($s1)      # 'o' load word
   sll      $zero, $zero, 0
   bne      $t4, $t3, FAIL
   sll      $zero, $zero, 0


   addi     $s3, $s3, 2
###############################################################################
###############################################################################
###############################################################################


   ori      $t0, $0,0x1337       # '1337'
   sw       $t0, 0($s1)          # store word
   ori      $t0, $0,0xCAFE       # 'CAFE'
   sw       $t0, 4($s1)          # store word
   ori      $t0, $0,0x0BAD       # '0BAD'
   sw       $t0, 8($s1)          # store word
   ori      $t0, $0,0xF00D       # 'F00D'
   sw       $t0, 12($s1)         # store word

   ori      $t0, $zero, 0x1111
   ori      $t1, $zero, 0x1111
   ori      $t2, $zero, 0x1111
   ori      $t3, $zero, 0x1111
   ori      $t4, $zero, 0x1111
   ori      $t5, $zero, 0x1111
   ori      $t6, $zero, 0x1111
   ori      $t7, $zero, 0x1111

   lbu      $t0, 0($s1)                ## needs 3 cycles to complete
   sll      $zero, $zero, 0
   ori      $a0, $zero, 0x0037
   bne      $t0, $a0, FAIL
   sll      $zero, $zero, 0
   lbu      $t1, 4($s1) 
   sll      $zero, $zero, 0
   ori      $a0, $zero, 0x00FE
   bne      $t1, $a0, FAIL
   sll      $zero, $zero, 0
   lbu      $t2, 8($s1)
   sll      $zero, $zero, 0
   ori      $a0, $zero, 0x00AD
   bne      $t2, $a0, FAIL 
   sll      $zero, $zero, 0
   lbu      $t3, 12($s1) 
   sll      $zero, $zero, 0
   ori      $a0, $zero, 0x000D
   bne      $t3, $a0, FAIL
   sll      $zero, $zero, 0

   addi     $s3, $s3, 1
###############################################################################
###############################################################################
###############################################################################

   lb       $t0, 0($s1)                ## needs 3 cycles to complete
   sll      $zero, $zero, 0
   ori      $a0, $zero, 0x0037
   bne      $t0, $a0, FAIL
   sll      $zero, $zero, 0
   lb       $t1, 4($s1) 
   sll      $zero, $zero, 0
   ori      $a0, $zero, 0xFFFF
   sll      $a0, $a0, 16
   ori      $a0, $a0, 0xFFFE
   bne      $t1, $a0, FAIL
   sll      $zero, $zero, 0
   lb       $t2, 8($s1)
   sll      $zero, $zero, 0
   ori      $a0, $zero, 0xFFFF
   sll      $a0, $a0, 16
   ori      $a0, $a0, 0xFFAD
   bne      $t2, $a0, FAIL 
   sll      $zero, $zero, 0
   lb       $t3, 12($s1) 
   sll      $zero, $zero, 0
   ori     $a0, $zero, 0x000D
   bne      $t3, $a0, FAIL
   sll      $zero, $zero, 0

   addi     $s3, $s3, 1
###############################################################################
###############################################################################
###############################################################################

   addi     $t0, $zero, 0x2222
   addi     $t1, $zero, 0x2222
   addi     $t2, $zero, 0x2222
   addi     $t3, $zero, 0x2222
   addi     $t4, $zero, 0x2222
   addi     $t5, $zero, 0x2222
   addi     $t6, $zero, 0x2222
   addi     $t7, $zero, 0x2222

   lhu      $t0, 0($s1)                ## needs 3 cycles to complete
   sll      $zero, $zero, 0
   ori     $a0, $zero, 0x1337
   bne      $t0, $a0, FAIL
   sll      $zero, $zero, 0
   lhu      $t1, 4($s1) 
   sll      $zero, $zero, 0
   ori     $a0, $zero, 0xCAFE
   bne      $t1, $a0, FAIL
   sll      $zero, $zero, 0
   lhu      $t2, 8($s1)
   sll      $zero, $zero, 0
   ori     $a0, $zero, 0x0BAD
   bne      $t2, $a0, FAIL 
   sll      $zero, $zero, 0
   lhu      $t3, 12($s1) 
   sll      $zero, $zero, 0
   ori     $a0, $zero, 0xF00D
   bne      $t3, $a0, FAIL
   sll      $zero, $zero, 0

   addi     $s3, $s3, 1
###############################################################################
###############################################################################
###############################################################################

   lh       $t0, 0($s1)                ## needs 3 cycles to complete
   sll      $zero, $zero, 0
   ori      $a0, $zero, 0x1337
   bne      $t0, $a0, FAIL
   sll      $zero, $zero, 0
   lh       $t1, 4($s1) 
   sll      $zero, $zero, 0
   ori      $a0, $zero, 0xFFFF
   sll      $a0, $a0, 16
   ori      $a0, $a0, 0xCAFE
   bne      $t1, $a0, FAIL
   sll      $zero, $zero, 0
   lh       $t2, 8($s1)
   sll      $zero, $zero, 0
   ori      $a0, $zero, 0x0BAD
   bne      $t2, $a0, FAIL 
   sll      $zero, $zero, 0
   lh       $t3, 12($s1) 
   sll      $zero, $zero, 0
   ori      $a0, $zero, 0xFFFF
   sll      $a0, $a0, 16
   ori      $a0, $a0, 0xF00D
   bne      $t3, $a0, FAIL
   sll      $zero, $zero, 0

   addi     $s3, $s3, 1

   addi     $s3, $s3, 1
###############################################################################
###############################################################################
###############################################################################

   j     ALL_PASSED


FAIL:
   ori      $s0, $zero, 0xDEAD
   ori      $s1, $zero, 0xBEEF
   addi     $25, $zero, 1              ## indicate end of test bench
   j        DONE
   sll      $zero, $zero, 0

ALL_PASSED:
   ori     $s0, $zero, 0x600D
   ori     $s1, $zero, 0xBEEF
   addi    $25, $zero, 1              ## indicate end of test bench
   
DONE:   