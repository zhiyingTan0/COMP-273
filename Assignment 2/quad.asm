          .data
a:        .asciiz"a: "
b:        .asciiz"b: "
c:        .asciiz"c: "
comma:    .asciiz","
no:       .asciiz"No solution"
result:   .asciiz"Result: "
yes:      .asciiz"YES ("
end:      .asciiz")"

const:    .word 10
          .text
          .globl main
          
main:     li $v0,4     #print a :
          la $a0, a
          syscall
          
          li $v0,5    #read the input from user
          syscall
          add $t0,$zero,$v0
          
          li $v0,4     #print b:
          la $a0 , b
          syscall
          
          li $v0,5     #from b from user
          syscall
          add $t1 ,$zero, $v0
          
          li $v0,4     #print c:
          la $a0 , c
          syscall
          
          li $v0,5   #read c from user
          syscall
          add $t2 ,$zero, $v0
          
          li $v0,4
          la $a0 , result
          syscall
          
         
    
          add $t8 , $zero,$zero   #need a register as accumulator
          add $t4 ,$zero ,$zero   #$t4 is the step size i in the loop

loop:     slt $t9, $t2 , $t4 #compare c with $t4 
          beq $t9,1 ,exit
          mul $t5 ,$t4 ,$t4  #get the x^2
          rem $t6 ,$t5 ,$t1  #get x^2 mod b and stored in $t6
          rem $t7 ,$t0 ,$t1  #get a mod b and stored in $t7
          beq $t6 , $t7 ,label # if $t6 equals to $t7 then we go to label
          addi $t4 , $t4 , 1 #increase the step size by 1
          
          j loop
    
          
                      
label:    beq $t8 ,$zero , first  #if this is the first number to get here then go to first 
          
          
          li $v0 , 4         #print the , first
          la $a0 , comma
          syscall
          
          li $v0 , 1            #print the number
          add $a0 ,$zero , $t4
          syscall
          
          addi $t8 , $t8,1      #record the # of x we get
          addi $t4 , $t4 , 1
          j loop
 
                   
first:    li $v0 , 4         #if this is the first x to be print then print yes first
          la $a0 , yes 
          syscall


          li $v0 , 1
          add $a0 ,$zero , $t4
          syscall
          
         
          addi $t8 , $t8,1
          addi $t4 , $t4 , 1
          j loop
          
exit:     bne $t8 ,$zero ,fin  #the accumulator = 0 means no solution
          li $v0 ,4
          la $a0,no
          syscall
          
fin:      li $v0 , 4     # print the ) at the end if accumulator is not zero
          la $a0 , end
          syscall
           
