	.eqv SIZE, 3
	.data 
str1:   .asciiz "Array"
str2:   .asciiz "de"
str3:   .asciiz "ponteiros"
	.align 2
array:  .word str1, str2, str3
	.text
	.globl main
main:
	#t0 = p
	la $t0, array
	#pultimo = array + SIZE = t1
	addi $t1, $t0, 12 # +12 porque 3*4
	
for:
	bge $t0, $t1, endfor
	
	li $v0, 4
	lw $a0, 0($t0)
	syscall
	
	li $v0,11
	or $a0, $0, '\n'
	syscall
	
	addiu $t0, $t0, 4
	j for
	
endfor:
	jr $ra	
