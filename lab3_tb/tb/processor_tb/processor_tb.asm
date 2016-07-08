###############################################################################
#
# Primitive MIPS processor test bench
#     Test the following instructions: addi, add, sub, and, or, xor, 
#     nor, sw, lw 
#
#  Change Log:
#  07/08/2016 - Chao (Jack) Li - Initial Implementation
#

   .globl      __start

   .text

__start:

   addi     $2, $0, 1         # reg2 := 0x0000_0001
   add      $3, $2, $2        # reg3 := 0x0000_0002
   sub      $4, $0, $2        # reg4 := 0xFFFF_FFFF

   addi     $5, $0, 0x00FF
   addi     $6, $0, 0x00F0
   and      $5, $5, $6        # reg5 := 0x0000_00F0

   addi     $6, $0, 0x00FF
   addi     $7, $0, 0x00F0
   or       $6, $6, $7        # reg6 := 0x0000_00FF

   addi     $7, $0, 0x00FF
   addi     $8, $0, 0x0F0F
   xor      $7, $7, $8        # reg7 := 0x0000_0FF0

   addi     $8, $0, 0x00FF
   addi     $9, $0, 0x0F0F
   nor      $8, $8, $9        # reg8 := 0xFFFF_F000   


   # Data Segment Entry
   addi     $10, $0, 0x4000
   add      $10, $10, $10     # $10 := 0x0000_8000
   add      $10, $10, $10     # $10 := 0x0001_0000
   add      $10, $10, $10     # $10 := 0x0002_0000
   add      $10, $10, $10     # $10 := 0x0004_0000
   add      $10, $10, $10     # $10 := 0x0008_0000
   add      $10, $10, $10     # $10 := 0x1000_0000
   add      $10, $10, $10     # $10 := 0x0020_0000
   add      $10, $10, $10     # $10 := 0x0040_0000
   add      $10, $10, $10     # $10 := 0x0080_0000
   add      $10, $10, $10     # $10 := 0x0100_0000
   add      $10, $10, $10     # $10 := 0x0200_0000
   add      $10, $10, $10     # $10 := 0x0400_0000
   add      $10, $10, $10     # $10 := 0x0800_0000
   add      $10, $10, $10     # $10 := 0x1000_0000


   addi     $11, $0, 0xFF
   sw       $11, 0($10)       # mem addr 0x1000_0000 := 0x0000_00FF


   lw       $9, 0($10)        # reg9 := 0x0000_00FF 
   add      $0, $0, $0        # nop
   add      $0, $0, $0        # nop

   addi     $25, $0, 1        # indicate end of test for processor_tb.v 
   