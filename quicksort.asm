#studentName: zhiying Tan
#studentID: 260710889

# This MIPS program should sort a set of numbers using the quicksort algorithm
# The program should use MMIO

.data
#any any data you need be after this line 
Array: .space 2048
str0: .asciiz "\nWelcome to Quicksort\n"
buffer:.space 2048
str1: .asciiz "\n<program ends>"

str2: .asciiz "\nThe array is re-initialized\n"
str3: .asciiz"\nThe sorted array is : "
nextline: .asciiz"\n"

	.text
	.globl main

main:	# all subroutines you create must come below "main"


          li $v0,4
          la $a0,str0
          syscall
          
          #la $a1,str0
          #jal round1

          #to print the welcome string in mmio
          la $a1,str0
          jal Write3
                              
                                        
                                                  
round1:

	  #addi $sp,$sp,-4
	  #sw $ra,0($sp)
	  #add $t2,$0,$0
	  la $a1,buffer
	  #la $a2,str2
	  #jal echo1
	 
	  
	 
echo1:	#addi $t2 , $t2,1
        #beq $t2,601, exit1
        jal Read1		# reading and writing using MMIO
	add $a0,$v0,$zero
	
	#for the digits 0 to 9 and space
	beq $a0,48,label1
	beq $a0,49,label1
	
	beq $a0,50,label1
	beq $a0,51,label1
	beq $a0,52,label1
	beq $a0,53,label1
	beq $a0,54,label1
	beq $a0,55,label1
	beq $a0,56,label1
	beq $a0,57,label1
	beq $a0,32,label1
	
	#for the characters  q
	beq $a0,113,quit
	#for the character c
	beq $a0,99,initialize
	#for the character s
	beq $a0,115,sort
	#jal Write1
	#move $t0,$a0
	
	
	#addi $t2, $t2,1
	j echo1

Read1:  lui $t0, 0xffff 	#ffff0000
Loop1:	lw $t1, 0($t0) 		#control
	andi $t1,$t1,0x0001
	beq $t1,$zero,Loop1
	lw $v0, 4($t0) 
	
	#the end of text block is reached when the user hit enter
	#beq $v0,'\n',exit1
			#data	
	jr $ra
label1: 

        sb $a0,0($a1)
	addi $a1,$a1,1
	
        jal Write1
	move $t0,$a0
	
	j echo1

Write1:  lui $t0, 0xffff 	#ffff0000
Loop2: 	lw $t1, 8($t0) 		#control
	andi $t1,$t1,0x0001
	beq $t1,$zero,Loop2
	sw $a0, 12($t0) 	#data	
	jr $ra	
	
exit1: 
#the s part
sort:  

       #add $t9,$0,$0
       #jal printArray
       
       #li $v0,4
       #la $a0,nextline
       #syscall
       
       la $a0,Array
       la $a1,buffer
       #let $s1 be the length of array
       
       add $a0,$s0,$a0
       
       
       
       add $s1,$0,$0
       jal inArray
       
       #lw $t0,Array($0)
       #li $v0,1
       #move $a0,$t0
       #syscall
          #print the buffer out
          addi $t1,$0,60
          sb $t1,0($a1)
          addi $a1,$a1,1
          addi $t1,$0,115
          sb $t1,0($a1)
          addi $a1,$a1,1
          addi $t1,$0,62
          sb $t1,0($a1)
          addi $a1,$a1,1
          
          li $v0,4
          la $a0,buffer
          syscall
          
          #squicksort the array
         
          jal round2
          
          li $v0,4
          la $a0,str3
          syscall
          
          la $a1,str3
          jal Write3
          
          add $t9 ,$0,$0
          addi $s0,$s0,4
          jal printArray
          
          la $a1,Array
          add $t2,$0,$0
          jal writeArray
          
          la $a1,nextline
          jal Write3
          #add $s6,$s0,$0
          
          li $v0,4
          la $a0,nextline
          syscall
          
          #empty the buff for the following step
          add $t0,$0,$0
          la $a1,buffer
          jal emptybuff
          
          #add $a0,$s0,$a0
          
          
          j round1


writeArray: lui $t0, 0xffff 	#ffff0000
Loop5: 	lw $t1, 8($t0) 		#control
	andi $t1,$t1,0x0001
	beq $t1,$zero,Loop5
	
	
	lw $a2,0($a1)
	beq $t2,$s0,echoArray
	#if two digits
	addi $t1,$0,10
	div $a2,$t1
	mflo $t1
	bgtz $t1,twodigits
	
	addi $a2,$a2,48
	sw $a2, 12($t0) 
	
	addi $t2,$t2,4
	addi $a1,$a1,4
	
        #write space
        addi $t4,$0,32
        li $v0,11
	move $a0,$t4
	syscall
     
	
        add $a2,$0,32
        sw $a2,12($t0)	
	j writeArray 
	
twodigits:
    #$t1 needs to be write first
    mflo $t1
    mfhi $t3
    addi $t1,$t1,48
    sw $t1,12($t0)
    
    addi $t4,$0,32
    li $v0,11
	move $a0,$t4
	syscall
	
    addi $t3,$t3,48
    sw $t3,12($t0)
    
    addi $t2,$t2,4
	addi $a1,$a1,4
	
        #write space
        addi $t4,$0,32
	li $v0,11
	move $a0,$t4
	syscall
	
        add $a2,$0,32
        sw $a2,12($t0)	
	j writeArray 
	
    
	
echoArray: 
         jr $ra   	


Write3:  lui $t0, 0xffff 	#ffff0000
Loop4: 	lw $t1, 8($t0) 		#control
	andi $t1,$t1,0x0001
	beq $t1,$zero,Loop4
	
	lb $a2,0($a1)
	beq $a2,$0,echobuffer
	sw $a2, 12($t0) 
	addi $a1,$a1,1
		#data	
	j Write3  
echobuffer: 
         jr $ra   	

         
                         
printArray:
      #addi $t7,$0,80
      #beq $t9,$t7,laa
       beq $t9,$s0,laa
       lw $t8,Array($t9)
       li $v0,1
       move $a0,$t8
       syscall
       
       addi $a1,$0,32
       li $v0,11
       move $a0,$a1
       syscall
       
       addi $t9,$t9,4
       j printArray
       
laa :     
       jr $ra
       
       
inArray:

       lb $t0,0($a1)
       beq $t0,$0,ending
       lb $t1,1($a1)
       beq $t1,32,onedigit
       
       #else 2 digits
       
       addi $t0,$t0,-48
       addi $t1,$t1,-48
       mul $t0,$t0,10
       add $t0,$t0,$t1
       sw $t0,0($a0)
       
       addi $a0,$a0,4
       addi $a1,$a1,3
       addi $s0,$s0,4
       j inArray
onedigit:
       
       addi $t0,$t0,-48
       sw $t0,0($a0)
      
       addi $a0,$a0,4
       addi $a1,$a1,2
       addi $s0,$s0,4
       j inArray
       
ending: jr $ra


round2:
 
       # addi $sp,$sp,-4
        #sw $ra,0($sp)
        #s1 is the pivot
        #$t0 ls low
        add $t0,$0,$0
        
        #s0 is the length of array
        #add $s0,$s6,$s0
        #addi $s0,$s0,-1
        #mul $s0,$s0,4
        addi $s0,$s0,-4
        
        
        
        
quicksort:
       #t0 is the low in this method
       #s0 is the high in the method
       
       
       
       addi $sp,$sp,-4
       sw $ra,0($sp)
       
     
      
       #brunch on greater than or equal to
       #when hi=lo
       beq $t0,$s0,exit
       #when hi <lo
       slt $t9,$s0,$t0
       addi $t8,$0,1
       beq $t9,$t8,exit
       #t1 is the i  inpartition
       #t2 is the high in partition
       #s2 is pivot i partition
       #s3 is the p_pos 
       #let s4 be the low in partition
       
       add $t1 ,$t0,$0
       add $s4,$t0,$0
       addi $t2,$s0,4
       
       
       add $s3,$t0,$0
        
          
       
       lw $s2,Array($t1)
       
      
       jal partition
       lw $t5,Array($s3)
       lw $t6,Array($s4)
       sw $t5,Array($s4)
       sw $t6,Array($s3)
       
       
       #add $t9,$0,$0
       #lw $t9,Array($t9)
       #li $v0,1
       #move $a0,$t9
       #syscall
      
       
       
       addi $sp,$sp,-12
       sw $t0,0($sp)
       sw $s0,4($sp)
       sw $s3,8($sp)
       
       
       
       #beq $t0,$s3,spcialcase
       add $t0,$t0,$0
       addi $s0,$s3,-4
      
       
      
       jal quicksort
       
      
        
       
       #addi $sp,$sp,12
       lw $t0,0($sp)
       lw $s0,4($sp)
       lw $s3,8($sp)
       addi $sp,$sp,12
      
       
      
       
       
       
       addi $t0,$s3,4
       add $s0,$s0,$0
       
      
       
       jal quicksort
         
       #jump back to sort
       #jr $ra
      
       
       jal exit


exit:
         #addi $sp,$sp,4
         lw $ra,0($sp)
         addi $sp,$sp,4
         
         
         jr $ra 
         

partition:
          addi $t1,$t1,4
          
          #slt $t8,$t2,$t1
          #addi $t9,$0,1
          #beq $t8,$t9,exit2
          beq $t1,$t2,exit2
         
          lw $t3,Array($t1)
         
          #if s2>t3 then t4=1 we need to switch
          
          slt $t4,$t3,$s2
      
          #t4 =0 means s2>t3
          #t3 need to be swap
          addi $t9,$0,1
          beq $t4,$t9,small
          j partition

small:
          addi $s3,$s3,4
          
         
          lw $t5,Array($s3)
          lw $t6,Array ($t1)
          
        
          sw $t5,Array($t1)
          sw $t6,Array($s3)
          
          j partition


          
exit2: 

         #jump back to quicksort method
         jr $ra                       


#the  c part
initialize:

         
          
          addi $t1,$0,60
          sb $t1,0($a1)
          addi $a1,$a1,1
          sb $a0,0($a1)
          addi $a1,$a1,1
          addi $t1,$0,62
          sb $t1,0($a1)
          addi $a1,$a1,1
          
          li $v0,4
          la $a0,buffer
          syscall
          
          
          li $v0,4
          la $a0,str2
          syscall
          
          la $a1,str2
          jal Write3
          
          add $t0,$0,$0
          la $a1,buffer
          jal emptybuff
          add $t0,$0,$0
          jal emptyArray
          add $s0,$0,$0
          
          
          j round1

          
emptybuff:


 
          beq $t0,10,done1
          add $t0,$t0,$0
          sb $0,0($a1)
          addi $a1,$a1,1
          addi $t0,$t0,1
          j emptybuff
emptyArray:
          addi $s1,$0,2048
          beq $t0,$s1,done1
          sw $0,Array($t0)
          addi $t0,$t0,4
	  	  	  	  
done1:  
         
	  jr $ra
	  
	  	  	          
#the q part	  	  	          	  	          	  	          
quit:
          li $v0,4
          la $a0,str1
          syscall
          
          la $a1,str1
          jal Write3
          
          li $v0,10
                
