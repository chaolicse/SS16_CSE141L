###############################################################################
#
#  CSE 141L 
#
#     Simple fibonacci test bench.
#        test passed - 0x600DBEEF in register $s0 and $s1
#        test failed - 0xDEADBEEF in register $s0 and $s1
#        $t0 - expected sum after n ($s3) iterations
#        $t1 - actual sum after n ($s3) iterations
#
#        test the following instructions: lw, sw, j, jal, jr, add, addi, ori,
#                                         sll, stlu
#
#        does not expect a implicit branch delay slot, e.g., must insert nop 
#        after branches, jumps, and loads
#
#  Change Log:
#     6/27/2016 - Chao (Jack) Li - Initial Implementation
#
###############################################################################

   .globl      __start

   .text

__start:
      j      MAIN
      sll    $zero, $zero, 0

   # int fib(int n): 
   #     return n < 2 ? n : fib(n-1) + fib(n-2)
   #
   # fib seq: 0 1 1 2 3 5 8 13 21 34
   #
   # n      := $a0
   # result := $v0
   #
fib:
      addi  $sp, $sp, -8         # room for $ra and one temporary
      sw    $ra, 4($sp)          # save $ra
      addu  $v0, $zero, $a0      # pre-load return value as n

      addi  $t0, $zero, 2
      sltu  $t0, $a0, $t0        # if(n < 2) return n
      bne   $t0, $0, fib_rt      #     blt
      sll   $zero, $zero, 0

      sw    $a0, 0($sp)          # save a copy of n
      addi  $a0, $a0, -1         # n - 1
      jal   fib                  # fib(n - 1)
      sll   $zero, $zero, 0

      lw    $a0, 0($sp)          # retrieve n
      sll   $zero, $zero, 0
      sw    $v0, 0($sp)          # save result of fib(n - 1)
      addi  $a0, $a0, -2         # n - 2
      jal   fib                  # fib(n - 2)
      sll   $zero, $zero, 0
      
      lw    $v1, 0($sp)          # retrieve fib(n - 1)
      sll   $zero, $zero, 0
      add   $v0, $v0, $v1        # fib(n - 1) + fib(n - 2)

fib_rt:
      lw    $ra, 4($sp)          # restore $ra
      addi  $sp, $sp, 8          # restore $sp
      jr    $ra                  # back to caller
      sll   $zero, $zero, 0


   ## 
   #  print(n)
   #     optional: print Fibonacci number to MIPS console
   #        n := $a0   
   #     
print:
      addi     $v0, $zero, 1     # print_int     
      syscall   
      addi     $a0, $zero, 0x20  # ' '
      addi     $v0, $zero, 11    # print_character
      syscall
      jr       $ra
      sll      $zero, $zero, 0

MAIN:

###############################################################################
## single Fibonacci test n = 4
###############################################################################
      addi     $s7, $zero, 1        # test case := 1
      addi     $a0, $zero, 4        # n = 4
      jal      fib
      sll      $zero, $zero, 0
      add      $t0, $zero, $v0
      addi     $t1, $zero, 3        # expected result: fib(4) := 3
      bne      $t0, $t1, FAILED


      # optional display on MIPS console
      #
      # add      $a0, $zero, $v0
      # jal      print
      # sll      $zero, $zero, 0

###############################################################################
## looped Fibonacci test case (1 to n)
###############################################################################
      addi     $s7, $zero, 2        # test case := 1
      
      # Change the jump address depending on your ssl implementation
      #j        SSL_IMPLEMENTED      
      #sll      $zero, $zero, 0      # nop

      # Execute the following instructions if your ssl instruction behaves
      # only as an nop instuction
      #
      addi     $t0, $zero, 0x4000
      sub      $s0, $zero, $t0
      sub      $s0, $s0, $t0        # $s0 should now contain 0xffffc000
      sub      $s0, $s0, $t0        # $s0 should now contain 0xffff8000
      sub      $s0, $s0, $t0        # $s0 should now contain 0xffff0000

      addi     $s1, $zero, 0x4000   # 0x00004000
      add      $s1, $s1, $s1        # 0x00008000
      add      $s1, $s1, $s1        # 0x00010000
      add      $s1, $s1, $s1        # 0x00020000
      add      $s1, $s1, $s1        # 0x00040000
      add      $s1, $s1, $s1        # 0x00080000
      add      $s1, $s1, $s1        # 0x00100000
      add      $s1, $s1, $s1        # 0x00200000
      add      $s1, $s1, $s1        # 0x00400000
      add      $s1, $s1, $s1        # 0x00800000
      add      $s1, $s1, $s1        # 0x01000000
      add      $s1, $s1, $s1        # 0x02000000
      add      $s1, $s1, $s1        # 0x04000000
      add      $s1, $s1, $s1        # 0x08000000
      add      $s1, $s1, $s1        # 0x10000000

      j        SSL_NOT_IMPLEMENTED
      sll      $zero, $zero, 0

      # Execute the following instructions if your ssl instruction behaves 
      # as the standard MIPS ssl instruction
      #
SSL_IMPLEMENTED: 
      ori      $s0, $zero, 0xffff
      sll      $s0, $s0, 16

      ori      $s1, $zero, 0x1000
      sll      $s1, $s1, 16 

SSL_NOT_IMPLEMENTED:

      # looped fibonacci test case 1 to n 
      #
      addi     $s2, $zero, 0        # loop count
      addi     $s3, $zero, 10       # loop termination condition
      add      $s4, $zero, $s1      # write address
L1:
      add      $a0, $zero, $s2
      jal      fib
      sll      $zero, $zero, 0

      sw       $v0, 0($s4)          # save result
      addi     $s4, $s4, 4

      # optional display on MIPS console
      #
      # add      $a0, $zero, $v0
      # jal      print
      # sll      $zero, $zero, 0

      addi     $s2, $s2, 1
      bne      $s2, $s3, L1 
      sll      $zero, $zero, 0


      addi     $s2, $zero, 0        # loop count 
      add      $s4, $zero, $s1      # load address 
      add      $t1, $zero, $zero    # sum register
L2:
      lw       $t0, 0($s4)          # load result
      addi     $s4, $s4, 4
      add      $t1, $t1, $t0        # sum result

      addi     $s2, $s2, 1
      bne      $s2, $s3, L2         
      sll      $zero, $zero, 0      # nop


      addi     $t0, $zero, 88       # expected result: change this depending on
                                    # your loop count

      bne      $t0, $t1, FAILED
      sll      $zero, $zero, 0       
      j        PASSED
      sll      $zero, $zero, 0      



# failed result stored in $t1
FAILED:
   ori      $s0, $zero, 0xDEAD
   ori      $s1, $zero, 0xBEEF
   addi     $25, $zero, 1           # indicate end of test to fib_tb.v
   j        DONE
   

PASSED:
   ori     $s0, $zero, 0x600D
   ori     $s1, $zero, 0xBEEF
   addi    $25, $zero, 1            # indicate end of test to fib_tb.v

DONE:

