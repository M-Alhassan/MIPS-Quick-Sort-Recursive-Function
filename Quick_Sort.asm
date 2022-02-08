
#================================data===================================
.data
sizeMsg: .asciiz "Enter array size (n): "
tx: .asciiz "Before sorting: "
tx2: .asciiz "After sorting:  "
split: .asciiz ", "
	
#================================code===================================
.text

# main fuction
main:

jal read_array 
move $s1, $v0
move $s2, $v1

la $a0, tx
li $v0, 4
syscall		#print "Before sorting" message


move $a0, $s1
move $a1, $s2
jal print_array	#jump to print_array function and link to address (before sorting)

move $a0, $s1
move $a1, $s2
jal quick_sort	#jump to quick_sort function and link to this address

la $a0, '\n'
li $v0, 11
syscall

la $a0, tx2
li $v0, 4	#print "After sorting" message
syscall


move $a0, $s1 
move $a1, $s2 
jal print_array	#jump to print_array functiona nd link to this address (after sorting)

#--------------------------terminate program----------------------------
li $v0, 10
syscall 

#==============================functions================================

#------------------------------sorting----------------------------------
# quick sort function:
quick_sort:
move $s3, $a0 
add  $sp, $sp, -16 	#move the stack pointer 16 bytes down (to allocate space for 4 words)
sw   $ra, 0($sp) 	#(push) store the return address
sw   $a0, 4($sp) 	#(push) store the first argument in the stack
sw   $a1, 8($sp) 	#(push) store the second argument in the stack
sw   $t1, 12($sp) 	#(push)
li   $t1, 0 		
add  $t2, $a1, -1	

add  $t3, $t1, $t2 	#middle value (pivot)
srl  $t3, $t3, 1 	#devide by 2

#middle value's address
sll  $t3, $t3, 2	
add  $t4, $s3, $t3 
lw   $t5, 0($t4) 


# While loop:
loop:
bgt  $t1, $t2 , skip 

# i loop:
i_loop:
sll $t6, $t1, 2
add $t9, $t6, $s3
lw  $t6, 0($t9) 
bge $t6, $t5, j_loop 
add $t1, $t1, 1 	#i++
j   i_loop 

# j loop:
j_loop:
sll $t7, $t2, 2
add $t0, $t7, $s3
lw  $t7, 0($t0)  
ble $t7, $t5, if 
add $t2, $t2, -1 	#j--
j   j_loop

if:
bgt $t1, $t2, skip 
sw  $t7, 0($t9) 
sw  $t6, 0($t0) 
add $t1, $t1, 1 
add $t2, $t2, -1 	
j   loop		#jump back to while loop

skip:
sw   $t1, 12($sp) 

recursive_step1:
blez $t2, recursive_step2 
add  $a1, $t2, 1 
move $a0, $s3 
jal  quick_sort		# jump back to quick sort function recursively

recursive_step2:
lw  $a1, 8($sp) 	#(pop)
lw  $t1, 12($sp) 	#(pop)
add $t8, $a1, -1 
bge $t1, $t8, exit 
sll $s6, $t1, 2  
add $a0, $a0, $s6 
sub $a1, $a1, $t1
jal quick_sort 		# jump back to quick sort function recursively

exit:
lw  $ra, 0($sp)		#(pop) return address
lw  $a0, 4($sp) 	#(pop)
lw  $a1, 8($sp)		#(pop)
lw  $t1, 12($sp)
add $sp, $sp, 16	#move the stack pointer 16 bytes up
jr  $ra

#----------------------------read/write array-------------------------

# Read Array Function:
read_array:
la $a0, sizeMsg
li $v0, 4
syscall

li $v0, 5
syscall

move $t2, $v0		#store the size of the array in $t2
ble $t2, 1, read_array
sll $a0, $t2, 2
li $v0, 9
syscall

move $t3, $v0
move $s1, $t3 
li $t1, 0 
L1:
li $v0, 5
syscall

move $t4, $v0

sw   $t4, 0($t3) 
addi $t1, $t1, 1
addi $t3, $t3, 4 
blt  $t1, $t2, L1
move $v0, $s1 
move $v1, $t2 
jr $ra 

# print array function:
print_array:
li   $t1, 0 
move $t2, $a0 
move $t3, $a1 

L2:
lw $t4, 0($t2) 
la $a0, ($t4)
li $v0, 1	#print number
syscall

la $a0, split	#split the numbers with comma ', '
li $v0, 4
syscall

addiu $t1, $t1, 1
addiu $t2, $t2, 4 
blt   $t1, $t3, L2 
jr   $ra 	#return to main function
