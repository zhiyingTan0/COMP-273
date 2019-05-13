#studentName: zhiying Tan
#studentID: 260710889

# This MIPS program should count the occurence of a word in a text block using MMIO

.data
#any any data you need be after this line 
str0: .asciiz " \n Word count \n"
str1: .asciiz " Enter the text segment :\n   "
str2 : .asciiz "\n Enter the search word: \n    "    

str3 : .asciiz " \n The word '"
str4: .asciiz "' occured "
str5: .asciiz " time(s).\n press ’e’ to enter another segment of text or ’q’ to quit.\n "

string : .space 80
char: .space 2
buffer: .space 601
word: .space 601

	.text
	.globl main

main:	# all subroutines you create must come below "main"  
    
    
    

          #li $v0,4
          #la $a0,str0
          #syscall
          
          la $a1,str0
          jal Write3
          
         
          #li $v0, 4		# single print statement	
	  #la $a0, str1
	  #syscall 
	  
	  la $a1,str1
	  jal Write3
	  
	  la $a1,buffer
	  addi $t5,$0,32
	  sb $t5,0($a1)
	  addi $a1,$a1,1
	  jal round1
	  
	  #li $v0,4
	  #la $a0,buffer
	  #syscall
	  
	  la $a1,str2
	  jal Write3
	  
	  #li $v0, 4		# single print statement	
	  la $a0, str2
	  la $a1,word
	  add $s0,$0,$0
	  #syscall 
	  jal round2
	  
	  #li $v0,4
	  #la $a0,word
	  #syscall
	  
	
#**************************	  #match****************************************
	  #li $v0,4
	  #la $a0,str3
	  #syscall
	  
	  la $a1,str3
	  jal Write3
	  
	  #li $v0,4
	  #la $a0,string
	  #syscall
	  
	  #li $v0,4
	  #la $a0,word
	  #syscall
	  
	  la $a1,word
	  jal Write3
	  
	  #li $v0,4
	  #la $a0,str4
	  #syscall
	  
	  la $a1,str4
	  jal Write3
	  #
	  la $a0,buffer
	  la $a1,word
	  add $t2,$0,$0
	  #add $a2,$a2,$0
	  #add $s0,$0,$0
	 
	  la $a2,string
	  jal match
	  
	  #li $v0,4
	  #la $a0,string
	  #syscall
	  
	  la $a1,string
	  jal Write3
	  
	  #li $v0,4
	  #la $a0,str5
	  #syscall
	  
	  la $a1,str5
	  jal Write3
	  la $a1,char
	  jal round3
          
          la $a0,char
          lb $t0,0($a0)
          bne $t0,101,end
	  
	  la $a0,buffer
	  jal emptybuff
	  
	  la $a0,word
	  add $t0,$0,$0
	  jal emptyword
	  
	  la $a1,string
	  sb $0,0($a1)
	  sb $0,1($a1)
	  sb $0,2($a1)
	  
	  j main
	  
Write3:  lui $t0, 0xffff 	#ffff0000
Loop7: 	lw $t1, 8($t0) 		#control
	andi $t1,$t1,0x0001
	beq $t1,$zero,Loop7
	
	lb $a2,0($a1)
	beq $a2,$0,echobuffer
	sw $a2, 12($t0) 
	addi $a1,$a1,1
		#data	
	j Write3  
	
echobuffer: 
         jr $ra   	


emptybuff:

          beq $t0,600,done1
          add $t0,$t0,$0
          sb $0,0($a0)
          addi $a0,$a0,1
          addi $t0,$t0,1
          j emptybuff
	  	  	  
done1:  

	  jr $ra	  	  	  	  

	  	  	  	  	  	  	  	  
	  	  	  	  	  	  	  	  	  	  	  	  	  	  	  	  
emptyword:


          beq $t0,600,done2
          add $t0,$t0,$0
          sb $0,0($a0)
          addi $a0,$a0,1
          addi $t0,$t0,1
          
	  j emptyword	  	  
done2:  
          add $a0,$0,$0
	  jr $ra	  	  	  	  

          
	  	  	  	  	  	  	  	  	  	  	  	  	  	  	  	  	  	  	  	  	  	  	  	  	  	  	  	  	  	  	  	  
	  	  	  	  	  	  	  	  	  	  	  	  	  	  	  	  	  	  	  	  	  	  	  	  	  	  	  	  	  	  	  	  	  	  	  	  	  	  	  	  	  	  	  	  	  	  	  	  	  	  	  	  	  	  	  	  	  	  	  	  	  	  	  	  	  	  	  	  	  	  	  	  	  	  	  	  	  	  	  	  	  	  	  	  	  	  	  	  	  	  	  	  	  	  	  	  
round3:


         addi $sp,$sp,-4
         sw $ra,0($sp)
          
echo3:          
        jal Read		# reading and writing using MMIO
	add $a0,$v0,$zero
	
	#beq $a0,101,exit4
	sb $a0,0($a1)
	addi $a1,$a1,1
	
	jal Write
	move $t0,$a0
	j echo3

	
		
			
Read:  	lui $t0, 0xffff 	#ffff0000				
read:	lw $t1, 0($t0) 		#control
	andi $t1,$t1,0x0001
	beq $t1,$zero,read
	lw $v0, 4($t0) 
	
	#the end of text block is reached when the user hit enter
	beq $v0,'\n',exit4
			#data	
	jr $ra

Write:  lui $t0, 0xffff 	#ffff0000
write: 	lw $t1, 8($t0) 		#control
	andi $t1,$t1,0x0001
	beq $t1,$zero,write
	sw $a0, 12($t0) 	#data	
	jr $ra
	
	
exit4:    

          lw $ra,0($sp)
          addi $sp,$sp,4
          jr $ra
          	

		
	  	  	  	  	  	  
round1:

	  addi $sp,$sp,-4
	  sw $ra,0($sp)
	  add $t2,$0,$0
	  jal echo
	  #add $t2, $0,$0
	  
	 
echo:	addi $t2 , $t2,1
        beq $t2,601, exit1
        jal Read2		# reading and writing using MMIO
	add $a0,$v0,$zero
	
	
	sb $a0,0($a1)
	addi $a1,$a1,1
	
	jal Write2
	move $t0,$a0
	
	
	#addi $t2, $t2,1
	j echo

Read2:  	lui $t0, 0xffff 	#ffff0000
Loop5:	lw $t1, 0($t0) 		#control
	andi $t1,$t1,0x0001
	beq $t1,$zero,Loop5
	lw $v0, 4($t0) 
	
	#the end of text block is reached when the user hit enter
	beq $v0,'\n',exit1
			#data	
	jr $ra

Write2:  lui $t0, 0xffff 	#ffff0000
Loop6: 	lw $t1, 8($t0) 		#control
	andi $t1,$t1,0x0001
	beq $t1,$zero,Loop6
	sw $a0, 12($t0) 	#data	
	jr $ra
	
	
exit1:    

          lw $ra,0($sp)
          addi $sp,$sp,4
          jr $ra
          
          
          
round2 :  


          addi $sp,$sp,-4
          #store main $ra
	  sw $ra,0($sp)
	  jal echo1
	  add $t2, $0,$0
	  
	  
echo1:	addi $t2 , $t2,1
        beq $t2,601, exit2
        jal Read1		# reading and writing using MMIO
	add $a0,$v0,$zero
	
	
	sb $a0,0($a1)
	addi $a1,$a1,1
	#$a2 count word length
	#addi $s0,$s0,1
	
	jal Write1
	move $t0,$a0
	
	
	#addi $t2, $t2,1
	j echo

Read1:  lui $t0, 0xffff 	#ffff0000
Loop3:	lw $t1, 0($t0) 		#control
	andi $t1,$t1,0x0001
	beq $t1,$zero,Loop3
	lw $v0, 4($t0) 
	
	#the end of text block is reached when the user hit enter
	beq $v0,'\n',exit2
				
	jr $ra

Write1:  lui $t0, 0xffff 	#ffff0000
Loop4: 	lw $t1, 8($t0) 		#control
	andi $t1,$t1,0x0001
	beq $t1,$zero,Loop4
	sw $a0, 12($t0) 	#data	
	jr $ra
	
	
exit2:    

         lw $ra,0($sp)
         addi $sp,$sp,4
         jr $ra
          
 
          
match:    
         
         #$t3 count the pointer position in buffer
         #$t2 count the pointer position in word
         add $t3,$t3,$0
         #add $t2,$t2,$0
         #beq $a2,$t2,count
         
         #$a0 is buffer
         #$a1 is word
         lb $t0,0($a0)
         lb $t1,0($a1)
         beq $t1,0,count
         #beq $t3,601,exit3
         beq $t0,0,exit3
         #does not match
         bne $t0,$t1,reset
         #match
         #then keep checking 
         beq $t3,0,first
         #lb $t0,-1($a0)
         #bne $t0,' ',reset
        
         addi $a0,$a0,1
         addi $a1,$a1,1 
         addi $t3,$t3,1   
         j match
         
first:    

         lb $t0,-1($a0)
         bne $t0,' ',reset
        
         addi $a0,$a0,1
         addi $a1,$a1,1 
         addi $t3,$t3,1   
         j match
         
reset: 
          #lb $t4,0($a0)
          #beq $t4, ' ',count
          #lb $t5,0($a1)
          #beq $t5,0,count
          #add $t2,$0,$0
          #addi $t3,$t3,1
          
          la $a1,word
          addi $a0,$a0,1
          j match
          
count: 
          lb $t4,0($a0)
          
          bne $t4, ' ',reset1
          addi $s0,$s0,1
          
                   
          #add $t2,$0,$0
          add $t3,$0,$0
          la $a1,word
          addi $a0,$a0,1
          j match
reset1 :  

          #if the afterward is not ' ' and th end
          #then reset
          lb $t4,0($a0)
          bne $t4,0,reset
          
          addi $s0,$s0,1
         
          #addi $t3,$t3,1
          la $a1,word
          addi $a0,$a0,1
          j match
          
          
exit3: 
          addi $t0,$0,100
          div $s0,$t0
          #la $a2,string
          #t2 is $s0/100
          #$t1 is $s0 %100
          mfhi $t1
          mflo $t2
          bne $t2,$0,threedigits
          
          #la $a2,string
          #sb $t2,0($a2)
          #addi $a2, $a2,1
          
          addi $t0,$0,10
          div $t1,$t0
          #$t2 is $t1/10
          #$t1 is $t1 %10
          mfhi $t1
          mflo $t2
          bne $t2,$0,twodigits
          #addi $t2,$t2,48
          
          #sb $t2,0($a2)
          #addi $a2, $a2,1
          addi $s0,$s0,48
          sb $s0,0($a2)
          
          
          jr $ra

                   
threedigits:  


           #la $a2,string
           addi $t2,$t2,48
           sb $t2,0($a2)
           addi $a2,$a2,1
           
           addi $t0,$0,10
           div $t1,$t0
          #$t2 is $t1/10
          #$t1 is $t1 %10
          mfhi $t1
          mflo $t2
          addi $t2,$t2,48
          
          sb $t2,0($a2)
          addi $a2, $a2,1
          addi $t1,$t1,48
          sb $t1,0($a2)
          
          
          jr $ra
         

          
twodigits:

          addi $t2,$t2,48
          sb $t2,0($a2)
          addi $a2,$a2,1
          
          addi $t1,$t1,48
          sb $t1,0($a2)
           jr $ra

end:

          
          #ending         
          li $v0,10
                    


          
