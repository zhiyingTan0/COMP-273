# This program illustrates an exercise of capitalizing a string.
# The test string is hardcoded. The program should capitalize the input string
# Comment your work

	.data

inputstring: 	.asciiz "I am a student at Mcgill University"
outputstring:	.space 100


	.text
	.globl main

main:     li $v0,4 
          la $a0,inputstring
          syscall
          
          #$t0  is the pointer of inputstring
          #$t4 is the pointer of outputstring
          la $t4,outputstring
          la $t0,inputstring
          
          lb $t3 0($t0)

loop :    beq $t3 , $0 , exit
          #$t3 is the character that $t0 is pointing to
          #here try to check if the character is lower case letter
          addi $t2,$t3,-91
          #if it is not lower case ot space character
          #go to label
          bltz $t2,label
          #invert the lower case to upper case letter
          addi $t3, $t3, -32
          #then store the byte to the address of outpursting
          #and print that charcter
          sb $t3 , 0($t4)
          li $v0,4 
          la $a0,outputstring
          syscall
          
          
          
          #move the pointer forward
          addi $t0,$t0,1
          #and load the byte at the position
          lb $t3, 0($t0)
          j loop 
         
         
label:    #store the byte to inputstring
          #then print that caracter
          sb $t3 , 0($t4)
          li $v0,4 
          la $a0,outputstring
          syscall
          addi $t0,$t0,1
          lb $t3, 0($t0)
          j loop
          
 



exit:     li $v0 ,4 
          la $a0,outputstring
          syscall
